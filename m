Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E75711A65
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjEYW7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjEYW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:59:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F86E6;
        Thu, 25 May 2023 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685055566; x=1716591566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nR46GYpJqRolBfY/YICB4Ng3v+nWMwewiHqSaXESjks=;
  b=liPXCuMirnk0bH/EmfXb5qArW5TU7apsIrhtih0AIclpK05DQ2OzELM3
   Jp2EC+5zYV2cgrMzt8ABL1RB6TqKf5JFU10A8cS5rlQlaSiBVOlGS3DBp
   VgMlR6aYwpzl3DYipgv/wSe2z1A0O07lO0cUPIy8jT9PaXId1nMl7TTEg
   CewNyiOCi4ur4OhsXE7KMuPLVj3CBoSCPLeKhzyM+Nd8fXZT8CBdKpeeM
   ZCcnrQBRc/83tcVlrp/AgdtPc4cp/BrB85BEco2ZgHIceH8C2IexYGVzX
   CULTM+y2MLzsGZELz3YyIixOtxji39oxIsBiPgsQqBrosArkUvBtkjVH7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="356434731"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="356434731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 15:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="849363625"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="849363625"
Received: from daubin-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.249.39.107])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 15:59:00 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id BA29810DC16; Fri, 26 May 2023 01:58:57 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] x86/mm: Allow guest.enc_status_change_prepare() to fail
Date:   Fri, 26 May 2023 01:58:46 +0300
Message-Id: <20230525225847.28592-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
References: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX code is going to provide guest.enc_status_change_prepare() that is
able to fail.

Add a way to return an error from the callback.

While there, fix enc_status_change_finish_noop(). It is defined as
always-fail now which doesn't make sense for noop.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/x86_init.h | 2 +-
 arch/x86/kernel/x86_init.c      | 4 ++--
 arch/x86/mm/mem_encrypt_amd.c   | 4 +++-
 arch/x86/mm/pat/set_memory.c    | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

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
index d82f4fa2f1bf..64664311ac2b 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -130,8 +130,8 @@ struct x86_cpuinit_ops x86_cpuinit = {
 
 static void default_nmi_init(void) { };
 
-static void enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { }
-static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
+static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
+static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
 static bool is_private_mmio_noop(u64 addr) {return false; }
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

