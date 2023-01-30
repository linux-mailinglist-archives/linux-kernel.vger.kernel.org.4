Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0EE680E65
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjA3NDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjA3NDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:03:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4335AF;
        Mon, 30 Jan 2023 05:02:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF4160F17;
        Mon, 30 Jan 2023 13:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D57CC433EF;
        Mon, 30 Jan 2023 13:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675083777;
        bh=VxL2bjQW8m7T81W4f7nNF2r5l8IfbO/VL9g3wOK2I8c=;
        h=From:To:Cc:Subject:Date:From;
        b=bBjjiDc5M9JcXGIWoEMxouNwg1+oguZkfgDvk1SHnjyOV/QXs3x5/yoCkriIXVY1b
         mY9LL7rtYez19AM8yUawIYJjxfxluvA7Nq1SMpN7WWj7XF2SVZVYhMJMYmXUy/0YyM
         vOe/UYjg/CBhA5L6O04cFjoZ8bQ2vz6pK4CSUVPMYO37yIw+TupFEGUcuOlUNW1EQ5
         JWgqKqiwfJT3bu0kPoNTB8uzcXOcoKPYD26fvt80lbBm59Ev6N3dAIZXlv55RNaBNb
         Q+6fKMp+43xPF5QXQfkxNQ+RrzTYemgobX31a0x66W7tdgYvO63cforYoeRHw9LvCl
         XcrweCX7TlrXg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace: sample: avoid open-coded 64-bit division
Date:   Mon, 30 Jan 2023 14:02:37 +0100
Message-Id: <20230130130246.247537-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: b56c68f705ca ("ftrace: Add sample with custom ops")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.39.0

