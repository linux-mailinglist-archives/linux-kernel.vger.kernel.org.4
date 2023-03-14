Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13FC6B9F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjCNTIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCNTIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:08:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236B64FA94
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91B8EB81B60
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B19C433A1;
        Tue, 14 Mar 2023 19:03:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pc9vS-009tzD-1V;
        Tue, 14 Mar 2023 15:03:10 -0400
Message-ID: <20230314190310.275222361@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 14 Mar 2023 15:02:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [for-linus][PATCH 4/5] ftrace,kcfi: Define ftrace_stub_graph conditionally
References: <20230314190236.203370742@goodmis.org>
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

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_FUNCTION_GRAPH_TRACER is disabled, __kcfi_typeid_ftrace_stub_graph
is missing, causing a link failure:

 ld.lld: error: undefined symbol: __kcfi_typeid_ftrace_stub_graph
 referenced by arch/x86/kernel/ftrace_64.o:(__cfi_ftrace_stub_graph) in archive vmlinux.a

Mark the reference to it as conditional on the same symbol, as
is done on arm64.

Link: https://lore.kernel.org/linux-trace-kernel/20230131093643.3850272-1-arnd@kernel.org

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Fixes: 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()")
See-also: 2598ac6ec493 ("arm64: ftrace: Define ftrace_stub_graph only with FUNCTION_GRAPH_TRACER")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace_64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 1265ad519249..fb4f1e01b64a 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -136,10 +136,12 @@ SYM_TYPED_FUNC_START(ftrace_stub)
 	RET
 SYM_FUNC_END(ftrace_stub)
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_TYPED_FUNC_START(ftrace_stub_graph)
 	CALL_DEPTH_ACCOUNT
 	RET
 SYM_FUNC_END(ftrace_stub_graph)
+#endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-- 
2.39.1
