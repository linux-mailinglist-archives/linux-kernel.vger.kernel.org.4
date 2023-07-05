Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B7D747F31
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjGEIQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjGEIQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:16:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD71713;
        Wed,  5 Jul 2023 01:16:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E347A1F889;
        Wed,  5 Jul 2023 08:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688544978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hOZkiaa9JnI0suGAuM3VsHzueMi03hVGM0FgOVv79Y=;
        b=nM+FWWBATWfL2hWk4s7nl9bgt0kePDEsoiGbUXhKk9CFM/eYKnBdKBrs8aSKPQ9Xyo5pG5
        YZ/zhzhVo7AHSK8+LgsO1KivA2aD2aoGDx1nExx8RhdsqnXNmiX0qmEfXxLCqUywVQrQYc
        9/mzjKLIWsGmO6ITFENaPw/5Kou4Pbo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF7BC13460;
        Wed,  5 Jul 2023 08:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2CIcKtImpWRkRwAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Wed, 05 Jul 2023 08:16:18 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mhiramat@kernel.org
Cc:     peterz@infradead.org, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an indirect jump
Date:   Wed,  5 Jul 2023 10:15:47 +0200
Message-Id: <20230705081547.25130-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230705081547.25130-1-petr.pavlu@suse.com>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions can_optimize() and insn_is_indirect_jump() consider jumps to
the range [__indirect_thunk_start, __indirect_thunk_end] as indirect
jumps and prevent use of optprobes in functions containing them.

Linker script arch/x86/kernel/vmlinux.lds.S places into this range also
the special section .text.__x86.return_thunk which contains the return
thunk. It causes that machines which use the return thunk as
a mitigation and don't have it patched by any alternative then end up
not being able to use optprobes in any regular function.

The return thunk doesn't need to be treated as an indirect jump from the
perspective of insn_is_indirect_jump(). It returns to a caller and
cannot land into an optprobe jump operand which is the purpose of the
insn_is_indirect_jump() check.

Fix the problem by defining the symbols __indirect_thunk_start and
__indirect_thunk_end directly in arch/x86/lib/retpoline.S. This is
possible because commit 9bc0bb50727c ("objtool/x86: Rewrite retpoline
thunk calls") made all indirect thunks present in a single section.

Fixes: 0b53c374b9ef ("x86/retpoline: Use -mfunction-return")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/x86/kernel/vmlinux.lds.S | 2 --
 arch/x86/lib/retpoline.S      | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a4cd04c458df..dd5b0a68cf84 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -133,9 +133,7 @@ SECTIONS
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_RETPOLINE
-		__indirect_thunk_start = .;
 		*(.text..__x86.*)
-		__indirect_thunk_end = .;
 #endif
 		STATIC_CALL_TEXT
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 3bea96341d00..f45a3e7f776f 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -14,6 +14,7 @@
 
 	.section .text..__x86.indirect_thunk
 
+SYM_ENTRY(__indirect_thunk_start, SYM_L_GLOBAL, SYM_A_NONE)
 
 .macro POLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
@@ -125,6 +126,9 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 #endif
+
+SYM_ENTRY(__indirect_thunk_end, SYM_L_GLOBAL, SYM_A_NONE)
+
 /*
  * This function name is magical and is used by -mfunction-return=thunk-extern
  * for the compiler to generate JMPs to it.
-- 
2.35.3

