Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E88723E85
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbjFFJ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbjFFJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:56:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73565E73
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686045394; x=1717581394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7RLFRqvdRV4EeGWD2/bOkXceiG/5lKBnbgdL4IoAVVE=;
  b=ciV7fRbrLWFPhM/KEYth/Vr28YZKwzcAPL6k7UWq14J93o9Zl0Ekpo4C
   Xwbxvv4V1/gyZ0cxgJNBC4j9x/ZNBrYtUbvygNIrRFt0spYfMXFQ9GZJv
   uNumEtDdLWp+q2Ua0igR8cV+2PBw1NLiEUw4tbA7oopeeXq7zF10l+z52
   85x8ljd3socjSIK8QheAdwvUyJ7RpEM0Lt9PDtVto/IiW8xHje67b6uok
   jtaUG1j7515hFrXqsv51mJ1dHrxKUYmocUnWb0G1AK4wDZDPLjgEgYHt2
   DPu6fD17W2tzuSijvfVEC8TjB9uOnirNgDvYWm6kSaJhVHz3USnVfYt26
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422445929"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422445929"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 02:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="738720781"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="738720781"
Received: from rgraefe-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 02:56:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B154A10D02A; Tue,  6 Jun 2023 12:56:26 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 2/3] x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()
Date:   Tue,  6 Jun 2023 12:56:21 +0300
Message-Id: <20230606095622.1939-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Touching privately mapped GPA that is not properly converted to private
with MapGPA and accepted leads to an unrecoverable exit to VMM.

load_unaligned_zeropad() can touch memory that is not owned by the
caller, but just happened to next after the owned memory.
This load_unaligned_zeropad() behaviour makes it important when kernel
asks VMM to convert a GPA from shared to private or back. Kernel must
never have a page mapped into direct mapping (and aliases) as private
when the GPA is already converted to shared or when GPA is not yet
converted to private.

load_unaligned_zeropad() can touch memory that is not owned by the
caller, but just happens to be next after the owned memory. This
load_unaligned_zeropad() behavior makes it important when the kernel
asks VMM to convert a GPA from shared to private or back. The kernel
must never have a page mapped into direct mapping (and aliases) as
private when the GPA is already converted to shared or when the GPA is
not yet converted to private.

guest.enc_status_change_prepare() is called before adjusting direct
mapping and therefore is responsible for converting the memory to
private.

guest.enc_status_change_finish() is called after adjusting direct
mapping and it converts the memory to shared.

It is okay to have a shared mapping of memory that is not properly
converted. handle_mmio() knows how to deal with load_unaligned_zeropad()
stepping on it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 7dbde7631629 ("x86/mm/cpa: Add support for TDX shared memory")
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 64 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e146b599260f..f6213a10de3a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -840,6 +840,30 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
+static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
+					  bool enc)
+{
+	/*
+	 * Only handle shared->private conversion here.
+	 * See the comment in tdx_early_init().
+	 */
+	if (enc)
+		return tdx_enc_status_changed(vaddr, numpages, enc);
+	return true;
+}
+
+static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
+					 bool enc)
+{
+	/*
+	 * Only handle private->shared conversion here.
+	 * See the comment in tdx_early_init().
+	 */
+	if (!enc)
+		return tdx_enc_status_changed(vaddr, numpages, enc);
+	return true;
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
@@ -867,9 +891,43 @@ void __init tdx_early_init(void)
 	 */
 	physical_mask &= cc_mask - 1;
 
-	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
-	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
-	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
+	/*
+	 * Touching privately mapped GPA that is not properly converted to
+	 * private with MapGPA and accepted leads to an unrecoverable exit
+	 * to VMM.
+	 *
+	 * load_unaligned_zeropad() can touch memory that is not owned by the
+	 * caller, but just happened to next after the owned memory.
+	 * This load_unaligned_zeropad() behaviour makes it important when
+	 * kernel asks VMM to convert a GPA from shared to private or back.
+	 * Kernel must never have a page mapped into direct mapping (and
+	 * aliases) as private when the GPA is already converted to shared or
+	 * when GPA is not yet converted to private.
+	 *
+	 * load_unaligned_zeropad() can touch memory that is not owned by the
+	 * caller, but just happens to be next after the owned memory. This
+	 * load_unaligned_zeropad() behavior makes it important when the kernel
+	 * asks VMM to convert a GPA from shared to private or back. The kernel
+	 * must never have a page mapped into direct mapping (and aliases) as
+	 * private when the GPA is already converted to shared or when the GPA
+	 * is not yet converted to private.
+	 *
+	 * guest.enc_status_change_prepare() is called before adjusting direct
+	 * mapping and therefore is responsible for converting the memory to
+	 * private.
+	 *
+	 * guest.enc_status_change_finish() is called after adjusting direct
+	 * mapping and it converts the memory to shared.
+	 *
+	 * It is okay to have a shared mapping of memory that is not properly
+	 * converted. handle_mmio() knows how to deal with
+	 * load_unaligned_zeropad() stepping on it.
+	 */
+	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
+	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
+
+	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
+	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
 	pr_info("Guest detected\n");
 }
-- 
2.39.3

