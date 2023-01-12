Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A585D666F55
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjALKQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjALKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:14:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C502640
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673518459; x=1705054459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7DqRv8Yg6e6tLhs+ztrt2ocPkjLI6upwYnCAtIxC5R0=;
  b=UezXzceVkzK0H9uIP7Y+sdMryiFv7xGFoZktq1stbnNYGm1bPMcqVp7B
   dX/pclL6S64XOEVXSaVd2A4GWLcmfM/1kb/d5MHUJE6JITtwGEu4RNaxS
   FlD1/mPk71/rlORQw66iWkBDq7Jtfhx9AcaUsNCgRqXnlNqg8P+IOFT+J
   LXfQenv8fUWqiODC5X4Bq7E+iA0HqW7OzRcTXTeXrVjJPtFlibYKdS251
   cyz5PU4Kn/fEAVv5EDIpOGWhCD7A0xiRp6yqGGSk/si7dcjYYoNoMSTiV
   CygjV9zj2TvKyRi4amKcFvi9HD7LYrUpeu1opTGfA0o1bTLKDOvw4Yfcx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350892143"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="350892143"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659722887"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="659722887"
Received: from glieseu-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.52.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:16 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7CD2F109AF1; Thu, 12 Jan 2023 13:14:13 +0300 (+03)
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
Subject: [PATCHv2 1/7] x86/tdx: Fix typo in comment in __tdx_hypercall()
Date:   Thu, 12 Jan 2023 13:14:01 +0300
Message-Id: <20230112101407.24327-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230112101407.24327-1-kirill.shutemov@linux.intel.com>
References: <20230112101407.24327-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment in __tdx_hypercall() points that RAX==0 indicates TDVMCALL
failure which is opposite of the truth: RAX==0 is success.

Fix the comment. No functional changes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdcall.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index f9eb1134f22d..74b108e94a0d 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -155,7 +155,7 @@ SYM_FUNC_START(__tdx_hypercall)
 	tdcall
 
 	/*
-	 * RAX==0 indicates a failure of the TDVMCALL mechanism itself and that
+	 * RAX!=0 indicates a failure of the TDVMCALL mechanism itself and that
 	 * something has gone horribly wrong with the TDX module.
 	 *
 	 * The return status of the hypercall operation is in a separate
-- 
2.38.2

