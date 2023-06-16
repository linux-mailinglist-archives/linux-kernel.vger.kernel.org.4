Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD39F733AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjFPUc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjFPUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:32:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D3F3A91;
        Fri, 16 Jun 2023 13:32:25 -0700 (PDT)
Date:   Fri, 16 Jun 2023 20:32:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686947543;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BqamN30uwioVV9z8bqlQUd/bYGXRjuLvuHgCeh9Wjmg=;
        b=IyQDwPs/kz5HH35ns2xrQPYA3CiHmBcnLmCM2r/LCT86yc/OQQViC3DktI1fvjTpGfV356
        LNhYKrxxNwl1CBABNlKzxP+RS0tskznyQ75pxj6RI1WxFqeX7Q5DNJiMQn5U/5ccMDXPme
        SsnncOoKK1g1Q+f975i68zBmnDdVmdgjCiYCgIDI4QLq0M2ULl/2dkm4dSShEqrhvZcrKA
        TjNsCbIWr9J4rjPoGIvjdGHSlP/zfpvOQapY7n92RgRCEWxKbF8g1YI/syiWj1TV3QhvU+
        R8Rqsi1+9+wxZi7wZZ3Mea0nlDgMp+669tuAPU5BUo+VVl3lIQfxfFFrD+YS3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686947543;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BqamN30uwioVV9z8bqlQUd/bYGXRjuLvuHgCeh9Wjmg=;
        b=QaDl2b13pXjmTE57VQ/vFnQICyRQJaP23kXX/pTMPYES/JzPS6XkYuS4JOAIjVlVztFIus
        tCHsa4yQmMCOE7DQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/mem_encrypt: Unbreak the AMD_MEM_ENCRYPT=n build
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694754244.404.18209616336431541908.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     0a9567ac5e6a40cdd9c8cd15b19a62a15250f450
Gitweb:        https://git.kernel.org/tip/0a9567ac5e6a40cdd9c8cd15b19a62a15250f450
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 16 Jun 2023 22:15:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 22:23:27 +02:00

x86/mem_encrypt: Unbreak the AMD_MEM_ENCRYPT=n build

Moving mem_encrypt_init() broke the AMD_MEM_ENCRYPT=n because the
declaration of that function was under #ifdef CONFIG_AMD_MEM_ENCRYPT and
the obvious placement for the inline stub was the #else path.

This is a leftover of commit 20f07a044a76 ("x86/sev: Move common memory
encryption code to mem_encrypt.c") which made mem_encrypt_init() depend on
X86_MEM_ENCRYPT without moving the prototype. That did not fail back then
because there was no stub inline as the core init code had a weak function.

Move both the declaration and the stub out of the CONFIG_AMD_MEM_ENCRYPT
section and guard it with CONFIG_X86_MEM_ENCRYPT.

Fixes: 439e17576eb4 ("init, x86: Move mem_encrypt_init() into arch_cpu_finalize_init()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/oe-kbuild-all/202306170247.eQtCJPE8-lkp@intel.com/
---
 arch/x86/include/asm/mem_encrypt.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 98ce265..7f97a8a 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -17,6 +17,12 @@
 
 #include <asm/bootparam.h>
 
+#ifdef CONFIG_X86_MEM_ENCRYPT
+void __init mem_encrypt_init(void);
+#else
+static inline void mem_encrypt_init(void) { }
+#endif
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u64 sme_me_mask;
@@ -51,8 +57,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 
 void __init sev_es_init_vc_handling(void);
 
-void __init mem_encrypt_init(void);
-
 #define __bss_decrypted __section(".bss..decrypted")
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
@@ -85,8 +89,6 @@ early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc) {}
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
-static inline void mem_encrypt_init(void) { }
-
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
