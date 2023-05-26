Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DF571262E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbjEZMDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjEZMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:03:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2DFE46;
        Fri, 26 May 2023 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685102579; x=1716638579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rT7cwEP37q2mK0/mhhF1SbjEW1zoGpi7jl7FkWAvvT4=;
  b=JwmBl1k464CcRfIFxUknh6/UqKNaTJZoAOxw/kF+yZ8hT5Zn3DNx+7jv
   Csb8x0YI5kFU/swerh+pdXuyRMYuFnX4zSLx55sLOHnluzVCAPQXW/gLc
   iCRaw1mcr2xxlecRqIu7lD5H2YvGYP38mvIYDY5uGpHqCkCRI5ywca0bi
   SdttbM3FdD3fJO6WzxrZ2rar8eRjYYZ+1Llp1uhlQz95q9UUWT2TXSjn9
   YWhl1O1kcI+EqusRgdxJaFvdkNQEY+YhXjZgMf5drrjQYTyKWh+AxwRlU
   oLzfqm655ljtwyNxgMC/SD1ORwjDeUNRiQZvx0txeK7BNdbJYHfkCZ6u1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="354201705"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="354201705"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="735987427"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="735987427"
Received: from fgarrona-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:02:34 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3C48510DC17; Fri, 26 May 2023 15:02:32 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCHv2 2/3] x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()
Date:   Fri, 26 May 2023 15:02:24 +0300
Message-Id: <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
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
with MapGPA and accepted leads to unrecoverable exit to VMM.

load_unaligned_zeropad() can touch memory that is not owned by the
caller, but just happened to next after the owned memory.
This load_unaligned_zeropad() behaviour makes it important when kernel
asks VMM to convert a GPA from shared to private or back. Kernel must
never have a page mapped into direct mapping (and aliases) as private
when the GPA is already converted to shared or when GPA is not yet
converted to private.

guest.enc_status_change_prepare() called before adjusting direct mapping
and therefore it is responsible for converting the memory to private.

guest.enc_status_change_finish() called after adjusting direct mapping
and it converts the memory to shared.

It is okay to have a shared mapping of memory that is not converted
properly. handle_mmio() knows how to deal with load_unaligned_zeropad()
stepping on it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 7dbde7631629 ("x86/mm/cpa: Add support for TDX shared memory")
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 56 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e146b599260f..59cc13e41aa6 100644
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
@@ -867,9 +891,35 @@ void __init tdx_early_init(void)
 	 */
 	physical_mask &= cc_mask - 1;
 
-	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
-	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
-	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
+	/*
+	 * Touching privately mapped GPA that is not properly converted to
+	 * private with MapGPA and accepted leads to unrecoverable exit
+	 * to VMM.
+	 *
+	 * load_unaligned_zeropad() can touch memory that is not owned by
+	 * the caller, but just happened to next after the owned memory.
+	 * This load_unaligned_zeropad() behaviour makes it important when
+	 * kernel asks VMM to convert a GPA from shared to private or back.
+	 * Kernel must never have a page mapped into direct mapping (and
+	 * aliases) as private when the GPA is already converted to shared or
+	 * when GPA is not yet converted to private.
+	 *
+	 * guest.enc_status_change_prepare() called before adjusting direct
+	 * mapping and therefore it is responsible for converting the memory
+	 * to private.
+	 *
+	 * guest.enc_status_change_finish() called after adjusting direct
+	 * mapping and it converts the memory to shared.
+	 *
+	 * It is okay to have a shared mapping of memory that is not converted
+	 * properly. handle_mmio() knows how to deal with load_unaligned_zeropad()
+	 * stepping on it.
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

