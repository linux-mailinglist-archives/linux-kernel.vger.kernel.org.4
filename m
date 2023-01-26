Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD0B67D871
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjAZWdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjAZWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:32:40 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B856E413
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772341; x=1706308341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lh5mHGy5KSUz8htxVu1g6Z5VsceNbf4gO76efsRQF7M=;
  b=GllqQlYCxcAj/7uAbFqIel3ulnzSOBL7rbXo2ZPsFab7pfWeOctSIgY9
   ctwCwyBUq7yDo9k5fWjFGEo3AJzl8Keb4ww+MJQFvzKAa0mMuO2HLJIQs
   CH90FXaiAvLMrECRXEInam9BBFw6IeLbIamlHDrz9BJm3/66cx1KMZi1K
   C+Zq0UN3XXgFC4Dz5VrPPwnli/vhNkqtOCtifzcnfYeTUcwzoucSesd/K
   weYlrUOKMsQ7VzyzM5Y5/KYXdyuJwOtZ0iLBL/F/CLPl2tc13URo9CJfP
   G/29Fy6ZKTR+QOcLDX/Pr+7wbFu10LJQgOtJPJZoOj0vDqFH64OLfqKfg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391516409"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="391516409"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:12:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="908411171"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="908411171"
Received: from smadjatx-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.210.179])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:12:05 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 533E110DBDE; Fri, 27 Jan 2023 01:12:03 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2, RESEND 2/7] x86/tdx: Add more registers to struct tdx_hypercall_args
Date:   Fri, 27 Jan 2023 01:11:54 +0300
Message-Id: <20230126221159.8635-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126221159.8635-1-kirill.shutemov@linux.intel.com>
References: <20230126221159.8635-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct tdx_hypercall_args is used to pass down hypercall arguments to
__tdx_hypercall() assembly routine.

Currently __tdx_hypercall() handles up to 6 arguments. In preparation to
changes in __tdx_hypercall(), expand the structure to 6 more registers
and generate asm offsets for them.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/shared/tdx.h | 6 ++++++
 arch/x86/kernel/asm-offsets.c     | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index e53f26228fbb..8068faa52de1 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -22,12 +22,18 @@
  * This is a software only structure and not part of the TDX module/VMM ABI.
  */
 struct tdx_hypercall_args {
+	u64 r8;
+	u64 r9;
 	u64 r10;
 	u64 r11;
 	u64 r12;
 	u64 r13;
 	u64 r14;
 	u64 r15;
+	u64 rdi;
+	u64 rsi;
+	u64 rbx;
+	u64 rdx;
 };
 
 /* Used to request services from the VMM */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 82c783da16a8..8650f29387e0 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -75,12 +75,18 @@ static void __used common(void)
 	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
 
 	BLANK();
+	OFFSET(TDX_HYPERCALL_r8,  tdx_hypercall_args, r8);
+	OFFSET(TDX_HYPERCALL_r9,  tdx_hypercall_args, r9);
 	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_args, r10);
 	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_args, r11);
 	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_args, r12);
 	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
 	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
 	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
+	OFFSET(TDX_HYPERCALL_rdi, tdx_hypercall_args, rdi);
+	OFFSET(TDX_HYPERCALL_rsi, tdx_hypercall_args, rsi);
+	OFFSET(TDX_HYPERCALL_rbx, tdx_hypercall_args, rbx);
+	OFFSET(TDX_HYPERCALL_rdx, tdx_hypercall_args, rdx);
 
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
-- 
2.39.1

