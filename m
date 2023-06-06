Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8AD723E82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjFFJ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbjFFJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:56:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999E4E55
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686045392; x=1717581392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lsSlrIZGg5tq5EdHS+s864ysGMsAzauBzAwak0CSiJ0=;
  b=RTn9U/AzAh71uZSMf6DhJoSYWTXFI6wgJllrBTXbo9aofhD8xqCO18xW
   GqCdQlTdMG/FLw2U7sKTLqnmvoEmiJVrjz66EtMeYjwMBzbcQtA//81TL
   nfEbjNEeismNafVumsotTvY9tT3X8SoOl0pDaoi93ZBBS/xQIbkDxSJ9Q
   yKWxm+Z0HHm9MgRxO1/f4Z2xdqWkIC8+iP8d/V20RNfHsHG7oaE8ZuNQF
   9NbAtzRDs9HhEZoHTiEP8vszy1psEMwHuFWrDb1/wqmbX0grm7wl4iCeD
   oOZz9jishd7jUX/qjTd7UdmWspv1tQeXjanBDypg+RNvgdJV4t2gm6Yq+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336249099"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="336249099"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 02:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="853348527"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="853348527"
Received: from rgraefe-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.173])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 02:56:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A64D710CFD2; Tue,  6 Jun 2023 12:56:26 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 1/3] x86/mm: Allow guest.enc_status_change_prepare() to fail
Date:   Tue,  6 Jun 2023 12:56:20 +0300
Message-Id: <20230606095622.1939-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX code is going to provide guest.enc_status_change_prepare() that is
able to fail. TDX will use the call to convert the GPA range from shared
to private. This operation can fail.

Add a way to return an error from the callback.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/x86_init.h | 2 +-
 arch/x86/kernel/x86_init.c      | 2 +-
 arch/x86/mm/mem_encrypt_amd.c   | 4 +++-
 arch/x86/mm/pat/set_memory.c    | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 88085f369ff6..1ca9701917c5 100644
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
index d82f4fa2f1bf..f230d4d7d8eb 100644
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
index e0b51c09109f..4f95c449a406 100644
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
index 7159cf787613..b8f48ebe753c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2151,7 +2151,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
-	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
+	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
+		return -EIO;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
-- 
2.39.3

