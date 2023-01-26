Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A54767D86D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjAZWdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjAZWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:32:40 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A806DFF6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772341; x=1706308341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJ60TuZ/WAThDiZfd1xgtqkLBDwCMemAxdyGLVSzJlk=;
  b=Aa3FF7gA9+RqijlcJJtV8cvQQBK4Ha7eqjcjWKnm8GJWnVwF3cwimOS8
   hLoZ829q40U2WFYXel2GbQzu+b0f0dzfSsAlZzMgPczx68rij0N1BzDfC
   dm9q506osoe/4iOJZ+hA8A20Do9QzUuvA2kxFys5mn3zYCvW1cXiyiZYX
   5BeJZevGA8Op0Z/NjYCpLB3PzPGxQm/hwudsXL4tWcRFq0pS/jU+X5HoT
   1JIjbzELSrx4uByHcRg9tpT/naM9dTDZFfD24VIVbdsKgx8un9iyb2Lqx
   RB+UXaxRLYK8QmUfJVBWOOCmxt2PRbj9OZXQwQ2DQ/yzWr3fxZhowb0Se
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391516403"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="391516403"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:12:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="908411169"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="908411169"
Received: from smadjatx-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.210.179])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:12:05 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4945410DB5C; Fri, 27 Jan 2023 01:12:03 +0300 (+03)
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
Subject: [PATCHv2, RESEND 1/7] x86/tdx: Fix typo in comment in __tdx_hypercall()
Date:   Fri, 27 Jan 2023 01:11:53 +0300
Message-Id: <20230126221159.8635-2-kirill.shutemov@linux.intel.com>
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
2.39.1

