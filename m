Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94F868E5B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBHB6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjBHB5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:57:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAC93F283
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:57:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B47DCB81B9C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE81C4339E;
        Wed,  8 Feb 2023 01:57:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPZiF-006dOi-1P;
        Tue, 07 Feb 2023 20:57:31 -0500
Message-ID: <20230208015731.258171441@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 20:56:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [for-next][PATCH 05/11] ftrace: sample: avoid open-coded 64-bit division
References: <20230208015633.791198913@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Calculating the average period requires a 64-bit division that leads
to a link failure on 32-bit architectures:

x86_64-linux-ld: samples/ftrace/ftrace-ops.o: in function `ftrace_ops_sample_init':
ftrace-ops.c:(.init.text+0x23b): undefined reference to `__udivdi3'

Use the div_u64() helper to do this instead. Since this is an init function that
is not called frequently, the runtime overhead is going to be acceptable.

Link: https://lore.kernel.org/linux-trace-kernel/20230130130246.247537-1-arnd@kernel.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: b56c68f705ca ("ftrace: Add sample with custom ops")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/ftrace/ftrace-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
index 24deb51c7261..0c8da87ff5c3 100644
--- a/samples/ftrace/ftrace-ops.c
+++ b/samples/ftrace/ftrace-ops.c
@@ -223,7 +223,7 @@ static int __init ftrace_ops_sample_init(void)
 
 	pr_info("Attempted %u calls to %ps in %lluns (%lluns / call)\n",
 		nr_function_calls, tracee_relevant,
-		period, period / nr_function_calls);
+		period, div_u64(period, nr_function_calls));
 
 	if (persist)
 		return 0;
-- 
2.39.1
