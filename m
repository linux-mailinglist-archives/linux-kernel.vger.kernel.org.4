Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27002666F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjALKQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbjALKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:14:59 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2795FE9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673518461; x=1705054461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W8YJlqpgpyrIFdBluBlo3KeuiQWVU3Fxn6IGrBsufUk=;
  b=aay5pgjK9JHyw1h1AD4mCJ8pbGnJw8qCB6CaBsRv6hlPipFZvWTeyfwQ
   LfH7EjrzXMAGb5SaVxmkpJtuouxWiIq/qb1vd498FhYNNIxDDayoSSkIe
   sp+FrU54JI/TxNoCEZ5yI+xhtG4W2Vn10bZsoreN9HO5+wxAk0aQs92nA
   igrR3c1TNuZusKoSjBCQh3oWb5VW21TxTELdkfUia9hoSW6RQmgaveLxl
   qInfRWethwYyIMaqJ8TYpg157TR2E3cMFxTYvoQf4rcP3xzG6aUuRluRv
   dyycAbmFrbWZHPj+ATYoQC5cZ/yBFhmFORvdQJWXb1XlfNVoqYXILdbwQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350892153"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="350892153"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659722888"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="659722888"
Received: from glieseu-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.52.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:16 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 872FE109AF2; Thu, 12 Jan 2023 13:14:13 +0300 (+03)
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
Subject: [PATCHv2 2/7] x86/tdx: Add more registers to struct tdx_hypercall_args
Date:   Thu, 12 Jan 2023 13:14:02 +0300
Message-Id: <20230112101407.24327-3-kirill.shutemov@linux.intel.com>
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
2.38.2

