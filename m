Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A576485F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiLIPxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiLIPxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:53:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65822BFD;
        Fri,  9 Dec 2022 07:52:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 769A862292;
        Fri,  9 Dec 2022 15:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7550C433F0;
        Fri,  9 Dec 2022 15:52:48 +0000 (UTC)
Date:   Fri, 9 Dec 2022 10:52:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] ftrace/x86: Add back ftrace_expected for ftrace bug reports
Message-ID: <20221209105247.01d4e51d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

After someone reported a bug report with a failed modification due to the
expected value not matching what was found, it came to my attention that
the ftrace_expected is no longer set when that happens. This makes for
debugging the issue a bit more difficult.

Set ftrace_expected to the expected code before calling ftrace_bug, so
that it shows what was expected and why it failed.

Link: https://lore.kernel.org/all/CA+wXwBQ-VhK+hpBtYtyZP-NiX4g8fqRRWithFOHQW-0coQ3vLg@mail.gmail.com/

Cc: stable@vger.kernel.org
Fixes: 768ae4406a5c ("x86/ftrace: Use text_poke()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index bd165004776d..e07234ec7e23 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -217,7 +217,9 @@ void ftrace_replace_code(int enable)
 
 		ret = ftrace_verify_code(rec->ip, old);
 		if (ret) {
+			ftrace_expected = old;
 			ftrace_bug(ret, rec);
+			ftrace_expected = NULL;
 			return;
 		}
 	}
-- 
2.35.1

