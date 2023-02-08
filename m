Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3DA68E5AF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBHB5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBHB5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:57:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A983D901
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 414776147D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4E2C4339B;
        Wed,  8 Feb 2023 01:57:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPZiE-006dMV-20;
        Tue, 07 Feb 2023 20:57:30 -0500
Message-ID: <20230208015730.437670637@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 20:56:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 01/11] tracing/osnoise: No need for schedule_hrtimeout range
References: <20230208015633.791198913@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

No slack time is being passed, just use schedule_hrtimeout().

Link: https://lore.kernel.org/linux-trace-kernel/20230123234649.17968-1-dave@stgolabs.net

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 210e1f168392..04f0fdae19a1 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1539,7 +1539,7 @@ static void osnoise_sleep(void)
 	wake_time = ktime_add_us(ktime_get(), interval);
 	__set_current_state(TASK_INTERRUPTIBLE);
 
-	while (schedule_hrtimeout_range(&wake_time, 0, HRTIMER_MODE_ABS)) {
+	while (schedule_hrtimeout(&wake_time, HRTIMER_MODE_ABS)) {
 		if (kthread_should_stop())
 			break;
 	}
-- 
2.39.1
