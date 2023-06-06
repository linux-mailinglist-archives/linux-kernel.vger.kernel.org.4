Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776AB7250E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbjFFXiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbjFFXi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:38:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C38A1726;
        Tue,  6 Jun 2023 16:38:21 -0700 (PDT)
Date:   Tue, 06 Jun 2023 23:38:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686094700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UZMBFT2ZGkoR+A8EYCo4fXYymX1TmQr8ltryd3paVwU=;
        b=fToi/f/ckXUNlDzDb1qezuVMh5W0AbZFFsrUji9AKA3SYyy4xbf8g+q+HN4YyQe9Yg+KK6
        UH0Um0MSUMgekW2kCKgNdpDw4ORiUjjZ8PcUbd7M3dgmhl6a+rGtUuqwTB2CbI4cjTPimm
        a3/rLwIZX+eTMO6frf9gF9UIti7CV8evticVz3Lji9pjqn0eljRJ2up9d400AjTqV+8UUm
        CGSfU2ACpSco+vokpl2jtla52Kcvp3dcczyjzG930x8TbOe4g5y+BnbdBQBM6YeIhJNh8l
        R3C1J8iCBpbsjQ6bfi8AjVmBUs3aIeLQU1wnU+kCU4wimIw+JzyQ4L//eNkXoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686094700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UZMBFT2ZGkoR+A8EYCo4fXYymX1TmQr8ltryd3paVwU=;
        b=9nx+aI+k7kcC2Dmt5A1kPtN593UgKIb3pBJoaKxg34nY4HbJs/0iKlCyTitXnc5zZt9mHp
        aNtpYJm5Gzv9lTCw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/mm: Allow guest.enc_status_change_prepare() to fail
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168609469953.404.12091382332231450052.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     3f6819dd192ef4f0c568ec3e9d6d408b3fa1ad3d
Gitweb:        https://git.kernel.org/tip/3f6819dd192ef4f0c568ec3e9d6d408b3fa1ad3d
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 06 Jun 2023 12:56:20 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 06 Jun 2023 11:07:01 -07:00

x86/mm: Allow guest.enc_status_change_prepare() to fail

TDX code is going to provide guest.enc_status_change_prepare() that is
able to fail. TDX will use the call to convert the GPA range from shared
to private. This operation can fail.

Add a way to return an error from the callback.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://lore.kernel.org/all/20230606095622.1939-2-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/x86_init.h | 2 +-
 arch/x86/kernel/x86_init.c      | 2 +-
 arch/x86/mm/mem_encrypt_amd.c   | 4 +++-
 arch/x86/mm/pat/set_memory.c    | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 88085f3..1ca9701 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -150,7 +150,7 @@ struct x86_init_acpi {
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
  */
 struct x86_guest {
-	void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
+	bool (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index d82f4fa..f230d4d 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -130,7 +130,7 @@ struct x86_cpuinit_ops x86_cpuinit = {
 
 static void default_nmi_init(void) { };
 
-static void enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { }
+static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
 static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index e0b51c0..4f95c44 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -319,7 +319,7 @@ static void enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
 #endif
 }
 
-static void amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
+static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
 {
 	/*
 	 * To maintain the security guarantees of SEV-SNP guests, make sure
@@ -327,6 +327,8 @@ static void amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool 
 	 */
 	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
 		snp_set_memory_shared(vaddr, npages);
+
+	return true;
 }
 
 /* Return true unconditionally: return value doesn't matter for the SEV side */
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 7159cf7..b8f48eb 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2151,7 +2151,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
-	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
+	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
+		return -EIO;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
