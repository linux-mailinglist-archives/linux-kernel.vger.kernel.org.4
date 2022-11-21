Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29207632882
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiKUPpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiKUPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:44:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D43DCD97D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:44:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0490C612CB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAACDC433D6;
        Mon, 21 Nov 2022 15:44:04 +0000 (UTC)
Date:   Mon, 21 Nov 2022 10:44:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>, Chris Mason <clm@meta.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] error-injection: Add prompt for function error injection
Message-ID: <20221121104403.1545f9b5@gandalf.local.home>
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

The config to be able to inject error codes into any function annotated
with ALLOW_ERROR_INJECTION() is enabled when CONFIG_FUNCTION_ERROR_INJECTION
is enabled. But unfortunately, this is always enabled on x86 when KPROBES
is enabled, and there's no way to turn it off.

As kprobes is useful for observability of the kernel, it is useful to have
it enabled in production environments. But error injection should be
avoided. Add a prompt to the config to allow it to be disabled even when
kprobes is enabled, and get rid of the "def_bool y".

This is a kernel debug feature (it's in Kconfig.debug), and should have
never been something enabled by default.

Cc: stable@vger.kernel.org
Fixes: 540adea3809f6 ("error-injection: Separate error-injection from kprobe")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 lib/Kconfig.debug | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c3c0b077ade3..9ee72d8860c3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1874,8 +1874,14 @@ config NETDEV_NOTIFIER_ERROR_INJECT
 	  If unsure, say N.
 
 config FUNCTION_ERROR_INJECTION
-	def_bool y
+	bool "Fault-injections of functions"
 	depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
+	help
+	  Add fault injections into various functions that are annotated with
+	  ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
+	  value of theses functions. This is useful to test error paths of code.
+
+	  If unsure, say N
 
 config FAULT_INJECTION
 	bool "Fault-injection framework"
-- 
2.35.1

