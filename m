Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960EF70653D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjEQKaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjEQKaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:30:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AF13593;
        Wed, 17 May 2023 03:30:05 -0700 (PDT)
Date:   Wed, 17 May 2023 10:30:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684319403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F22RJkxJI1b+I5i2VjSwwVk+cR/vRtmgdQGDjBJl8+E=;
        b=vh6KVmOVFhmKJDa42ZIqnWSSGLjL/+EJnrt8m2e6nE0crl935+evN1p1+IVH5zF61lnKB2
        AAeJtZPBiDrapQ30NFT8mYKnq5PYTUYa6XQKMFFNDbDlKQfm4bAdACPetk4g9bUXaHkiFV
        9RShdmzpX0gHswJwwoUgI6mVSZldzpoosHOJqc3vrMa6dKuP/toP489P0LckppyIxU5/vo
        IR7+Bfr26Rt+cBDFiW5pKgT+GywZExq3PRUk3W6r3GgHWoQoZFumWbxOM102pF2Rtb73lz
        NH6lBK/SlKkCeWhoPglP5ozo4dPrWqmdKXb5CJDjIWCeRNFRJuLWDcNMzDJcKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684319403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F22RJkxJI1b+I5i2VjSwwVk+cR/vRtmgdQGDjBJl8+E=;
        b=O7+KbNlw/TX60LnXJR9m95XutrpkvfMq+Eti4/9xvRDcTcw/aJE2NhyzIlf4STxVq8yjNp
        uZ+V9EApo7tY/vAQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/retbleed: Add __x86_return_thunk alignment checks
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515140726.28689-1-bp@alien8.de>
References: <20230515140726.28689-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168431940157.404.1281647175804224989.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f220125b999b2c9694149c6bda2798d8096f47ed
Gitweb:        https://git.kernel.org/tip/f220125b999b2c9694149c6bda2798d8096f47ed
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 15 May 2023 16:07:26 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 17 May 2023 12:14:21 +02:00

x86/retbleed: Add __x86_return_thunk alignment checks

Add a linker assertion and compute the 0xcc padding dynamically so that
__x86_return_thunk is always cacheline-aligned. Leave the SYM_START()
macro in as the untraining doesn't need ENDBR annotations anyway.

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lore.kernel.org/r/20230515140726.28689-1-bp@alien8.de
---
 arch/x86/kernel/vmlinux.lds.S | 4 ++++
 arch/x86/lib/retpoline.S      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 25f1552..03c885d 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -508,4 +508,8 @@ INIT_PER_CPU(irq_stack_backing_store);
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
+#ifdef CONFIG_RETHUNK
+. = ASSERT((__x86_return_thunk & 0x3f) == 0, "__x86_return_thunk not cacheline-aligned");
+#endif
+
 #endif /* CONFIG_X86_64 */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index b3b1e37..3fd066d 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -143,7 +143,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 63, 0xcc
+	.skip 64 - (__x86_return_thunk - zen_untrain_ret), 0xcc
 SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	/*
