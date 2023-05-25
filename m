Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9087711A68
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjEYXAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEYXAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:00:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5602C1A4;
        Thu, 25 May 2023 16:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685055629; x=1716591629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h2+VFs78zM5hSi1cfMqUT06G+rYbm2kFes9haAPQVuw=;
  b=cqRUXBBjb63SJJmn8igmdSehy07ho/a9Mt41eqBCGUbE0iUxOQP+xZNZ
   U2veR+y53Jom6HLWQxQeBdhvIq2i+fraaORiAVrBAqmGVtsIzo7k7POci
   hIMXXIbKrJbcY5fxGEik4BZCEg78RmGsxbWFJXDo8NEfcOoARrfz7cNrW
   z/m8G2ETAOsHi4xgXvW/TiLOHb3UP7SXg3WRIJypwK8AGkaLk07maMvG8
   KfT+V9mr7HMACAOyGRwITP4r1kriC3IbB35IYc5xr/3hfEXO2e4wJFjMm
   hsngfhtrpd88k20/OERjXd23lJ0yEHtHWjkCncSyRjJRwUXnf1uzW/Tp4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="440404189"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="440404189"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 15:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="737995684"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="737995684"
Received: from daubin-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.249.39.107])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 15:59:00 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C2DA710DC17; Fri, 26 May 2023 01:58:57 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()
Date:   Fri, 26 May 2023 01:58:47 +0300
Message-Id: <20230525225847.28592-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
References: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
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

guest.enc_tlb_flush_required() called after adjusting direct mapping and
it converts the memory to shared.

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
index e146b599260f..84525df750d4 100644
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
+	 * guest.enc_tlb_flush_required() called after adjusting direct mapping
+	 * and it converts the memory to shared.
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

