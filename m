Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23131725BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbjFGKkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjFGKkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:40:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFD7172E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686134406; x=1717670406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dXhQhpr65an843mzNgpNM3BfoFY8RKpdX33oWWzOawE=;
  b=db+7+peq40D+OYIa2jLF0KzNm69hpHCr+e68GD1h1h8t9AqOrU586YJR
   n9VPqX1sPNoeq0N7hB+2A23ZkfKKdAhAtteTZi6r5UmCcM98TOmyra5R6
   yM8oqJI5TyYExOg3jeRKL1r14nvChk9Ac8suHa2XY5hEo4VjS359EbJWD
   XILkJGh0TI2XEmbgaXOHS2OH8HeDq0Ohzis7b4DoFzOiz8t/h/k83ycWy
   fH2lJcgk+r0E6Hn00jtu1Gu2iU63slyP7u6L8DmRMfTYCenN9Hqg4fMv8
   1EAhu8AumEEgayQtfurQzOArr1q6Nu3INdsgCKkM2Z2n+UdEBolbOA1zY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="341602003"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="341602003"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 03:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="1039561362"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="1039561362"
Received: from byng-mobl.gar.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.159.27])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 03:40:03 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com, konrad.wilk@oracle.com,
        rostedt@goodmis.org, jpoimboe@kernel.org,
        Kai Huang <kai.huang@intel.com>
Subject: [PATCH] x86/kexec: Add a comment to relocate_kernel() for better readability
Date:   Wed,  7 Jun 2023 22:39:10 +1200
Message-Id: <20230607103910.407779-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason to save %rcx to %r11 before calling swap_pages isn't that
obvious w/o looking into the swap_pages itself.  Add a comment to
improve the readability.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..97deae3c5e6c 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -169,6 +169,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	wbinvd
 1:
 
+	/*
+	 * Save the preserve_context to %r11 as
+	 * swap_pages clobbers %rcx.
+	 */
 	movq	%rcx, %r11
 	call	swap_pages
 

base-commit: 409bf2895d71bb68bc5b8589036e5ed1ca30bada
-- 
2.40.1

