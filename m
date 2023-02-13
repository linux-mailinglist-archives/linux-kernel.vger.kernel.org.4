Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341F16954FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjBMXtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjBMXtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:49:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B6D193DC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676332143; x=1707868143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0x8prcfOkEmACeYEiOgHUm+WyjDXkIRz6t1uNF7BUGU=;
  b=DEU4gkRe/LLVPz4mbmoDkRzEjfxFbx3I8SLNirxLNL96qdWaDD15dR26
   lkOcvo9DsLQEL09c7WQdokTlK3piGVyHkYW8iQreseYHUnBrjt85LtUCS
   fQDksFjPUHK5tEtSPPMRj42RwY3I/Fb5BdFmopd2plqZ/bKHuOt+Pcu3Z
   9WmOx09Em9RfwgCtJHM33EyyvQWtQcaK4r5DrGUru1h6WCMDLyPpKcrz7
   Q0585VAobnBCGTTm/xwZrgn9gwVHC5fvRxUEwjMosn+HwK2Z6pyZimU0M
   1fFa63JS+f3I/qrdhd/F/3HFpfpYpGVFMGMUaQEcmAPVaq3IAc7QDAr1c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="395645603"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="395645603"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:48:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="732672802"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="732672802"
Received: from iannetti-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.49.216])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:48:46 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 62E0010CA34; Tue, 14 Feb 2023 02:48:43 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] x86/kexec: Preserve CR4.MCE during kexec
Date:   Tue, 14 Feb 2023 02:48:35 +0300
Message-Id: <20230213234836.3683-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
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

TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
to #VE.

Preserve the flag during kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 4a73351f87f8..18f19dcc40e9 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -145,8 +145,12 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Preserve MCE, if it was set. Clearing MCE may fault in some
+	 *    environments.
 	 */
-	movl	$X86_CR4_PAE, %eax
+	movq	%cr4, %rax
+	andl	$X86_CR4_MCE, %eax
+	orl	$X86_CR4_PAE, %eax
 	testq	$X86_CR4_LA57, %r13
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
-- 
2.39.1

