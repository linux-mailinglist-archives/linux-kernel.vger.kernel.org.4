Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A6F682901
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjAaJg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjAaJg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:36:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D292ED7C;
        Tue, 31 Jan 2023 01:36:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D500DCE1BDB;
        Tue, 31 Jan 2023 09:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44056C433D2;
        Tue, 31 Jan 2023 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675157808;
        bh=GavFmW+1c8ztCVeGwDutDoxHL37vN4T5JEoOXRXcG/c=;
        h=From:To:Cc:Subject:Date:From;
        b=MYUxqJEHhG2PVvygty4+eT+DQJwk+ibpguGCqWoCRG4+eOid1YCReeKvC8mKIZQhk
         5FJXELMy6JtDWeOmUrNvevujG0i7RRlSzsyY+9wP6Qm8mbNGGsqWXxi3Qxna6enJ/b
         J1l2t2uf97D0dFgE6DrGpv9Wa5PlwOm6rr647iD0acBP3Hhco5WMI6/c4TiR/xQ/7J
         ZB6Eh2OhV5hW8sLCVuZiJzEHO8Y4YPCZBbNzkzFYIq5gi9VEjV3JBPh1IJaFrJjpY9
         Kxjoyl1Iw7QI8BrT3l5JdFSi2BBiwuoUooBKwhn8ZOtQzDGlp44vA3FrWU3iL8+Yba
         Bny4Al+KU+xOA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace,kcfi: Define ftrace_stub_graph conditionally
Date:   Tue, 31 Jan 2023 10:36:30 +0100
Message-Id: <20230131093643.3850272-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()")
See-also: 2598ac6ec493 ("arm64: ftrace: Define ftrace_stub_graph only with FUNCTION_GRAPH_TRACER")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.39.0

