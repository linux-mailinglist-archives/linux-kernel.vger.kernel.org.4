Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2F732AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbjFPJEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjFPJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:03:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1EB44A2;
        Fri, 16 Jun 2023 02:02:09 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:02:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686906125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LU49bcez6wCr9PSZlpeTSPyjPXkpp4vHnRF+CbyLaVs=;
        b=PByfvvvN4HXfCOQ6mZnz0kEFZQYrXe3M+ugt4TunMxUTjVhrMuNRad9HeQgFAqMg9lHZ+y
        MJL+NItG+z2tqMKQb+qes8zshqsRq+VoJuzDrv6XpcNYKkt25ioHmFhejoweSIt45OUpPQ
        fso5i/6e71PFRb5EFsCvK2TPN7f3lDRwT1QrSpyXez8N1RpgATelZ/sXh/1KpwD0QrTbQ+
        onUVlYzEZe+lZ44e7PhXoMhPfzGoq3LaW6PUIvBGvXtTLkitBwHj2XCxX7Vsbb/DDRNZvY
        59D75qC2d2669xzyIR7xUcjOXDtdkAVcao1AXk/4+9raA/qTkh/3u5HE/GCRPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686906125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LU49bcez6wCr9PSZlpeTSPyjPXkpp4vHnRF+CbyLaVs=;
        b=KbRFM+a/3AV9oGdWV0/oSkWExaEZLhFJq5TnmJTmVamxUp3pao3maS2CmXQBkxKPTsgU0W
        9gxAsJiaTDH+UUBQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Remove unused current_untag_mask()
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230614174148.5439-1-bp@alien8.de>
References: <20230614174148.5439-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168690612426.404.7374086470513389742.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     013fdeb07a8fd32bbb3412e5f49d60207a78bf08
Gitweb:        https://git.kernel.org/tip/013fdeb07a8fd32bbb3412e5f49d60207a78bf08
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 14 Jun 2023 19:41:48 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Jun 2023 10:50:16 +02:00

x86/mm: Remove unused current_untag_mask()

e0bddc19ba95 ("x86/mm: Reduce untagged_addr() overhead for systems without LAM")

removed its only usage site so drop it.

Move the tlbstate_untag_mask up in the header and drop the ugly
ifdeffery as the unused declaration should be properly discarded.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20230614174148.5439-1-bp@alien8.de
---
 arch/x86/include/asm/tlbflush.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 75bfaa4..80450e1 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -14,6 +14,8 @@
 #include <asm/processor-flags.h>
 #include <asm/pgtable.h>
 
+DECLARE_PER_CPU(u64, tlbstate_untag_mask);
+
 void __flush_tlb_all(void);
 
 #define TLB_FLUSH_ALL	-1UL
@@ -54,15 +56,6 @@ static inline void cr4_clear_bits(unsigned long mask)
 	local_irq_restore(flags);
 }
 
-#ifdef CONFIG_ADDRESS_MASKING
-DECLARE_PER_CPU(u64, tlbstate_untag_mask);
-
-static inline u64 current_untag_mask(void)
-{
-	return this_cpu_read(tlbstate_untag_mask);
-}
-#endif
-
 #ifndef MODULE
 /*
  * 6 because 6 should be plenty and struct tlb_state will fit in two cache
