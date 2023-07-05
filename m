Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09F5747F30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjGEIQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjGEIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:16:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3918B;
        Wed,  5 Jul 2023 01:16:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98DCF22759;
        Wed,  5 Jul 2023 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688544975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/QzpkL3eR+kFPIlxO/QnNZXPq02PnM7/83/wB+Buqo=;
        b=FAZFennVRgNkYCRDDJU9ZhrrAp82fkJ2zEP01TDygpvCy8slWxBMR+EyBGjKYnyajVvSL3
        MjGsr8ArVQPdVltVmQOmVfYkpvhBiaK9lCNrmSDdgGONonbdH6zAAp32LBYxvXGSq45lpU
        WH34QBGfpHsEdryD9d1HjVKTuKUH9uw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 684FE13460;
        Wed,  5 Jul 2023 08:16:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0CKkGM8mpWRkRwAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Wed, 05 Jul 2023 08:16:15 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mhiramat@kernel.org
Cc:     peterz@infradead.org, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 1/2] x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG
Date:   Wed,  5 Jul 2023 10:15:46 +0200
Message-Id: <20230705081547.25130-2-petr.pavlu@suse.com>
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

Linker script arch/x86/kernel/vmlinux.lds.S matches the thunk sections
".text.__x86.*" from arch/x86/lib/retpoline.S as follows:

.text {
  [...]
  TEXT_TEXT
  [...]
  __indirect_thunk_start = .;
  *(.text.__x86.*)
  __indirect_thunk_end = .;
  [...]
}

Macro TEXT_TEXT references TEXT_MAIN which normally expands to only
".text". However, with CONFIG_LTO_CLANG, TEXT_MAIN becomes
".text .text.[0-9a-zA-Z_]*" which wrongly matches also the thunk
sections. The range [__indirect_thunk_start, __indirect_thunk_end] is
then empty.

A visible result is that function insn_is_indirect_jump() misbehaves and
optprobes become allowed in functions where they are not potentially
safe.

Fix the problem by using ".." as the first separator, for instance,
".text..__x86.indirect_thunk". This pattern is utilized by other
explicit section names which start with one of the standard prefixes,
such as ".text" or ".data", and that need to be individually selected in
the linker script.

Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/x86/kernel/vmlinux.lds.S | 2 +-
 arch/x86/lib/retpoline.S      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 03c885d3640f..a4cd04c458df 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -134,7 +134,7 @@ SECTIONS
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
-		*(.text.__x86.*)
+		*(.text..__x86.*)
 		__indirect_thunk_end = .;
 #endif
 		STATIC_CALL_TEXT
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 3fd066d42ec0..3bea96341d00 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -12,7 +12,7 @@
 #include <asm/percpu.h>
 #include <asm/frame.h>
 
-	.section .text.__x86.indirect_thunk
+	.section .text..__x86.indirect_thunk
 
 
 .macro POLINE reg
@@ -131,7 +131,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  */
 #ifdef CONFIG_RETHUNK
 
-	.section .text.__x86.return_thunk
+	.section .text..__x86.return_thunk
 
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
-- 
2.35.3

