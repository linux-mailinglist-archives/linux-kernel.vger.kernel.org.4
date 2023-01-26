Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5667067D85F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjAZWa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjAZWaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:30:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3522359F2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772221; x=1706308221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YX8QAiiXUItRHweILuMEEYUWmvws790j6lQ7xYB5yyE=;
  b=kL1oUOJQOMLXR3huc9DxmJx6tqcg48sf2tU8tq1Gcny9J+P61lXlPOrN
   VUPKahOMiiJ7xSICgJO2pu7LuY6YofJ/t9qsO4cPaMCnfcLTNIG+rNpmz
   4ths9YkaDqk5EhKxPdzW9bt3ae04QC6dlHJy3qR7okVZjM/It/Xtt27lT
   akMeEhBEIckMbrUTzwNGuSCdRM8oFxJJWxK7fU4GKvYPplfv0DurELTLO
   X4lyEZcwRsP6TRq1spS+RSwp+npQ5lbstI6izjeBAHD0gBcLz6PXrI9wG
   ey3kCI1GUsdosxJMlGhUZiV7Qlv6bWF+19psqpkKQr2/Zwi2W41yCZr2n
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="389342071"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="389342071"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:12:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="751770915"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="751770915"
Received: from smadjatx-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.210.179])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:12:06 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4241610DB5B; Fri, 27 Jan 2023 01:12:03 +0300 (+03)
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
Subject: [PATCHv2, RESEND 0/7] x86/tdx: Changes for TDX guest initialization
Date:   Fri, 27 Jan 2023 01:11:52 +0300
Message-Id: <20230126221159.8635-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

Resend v2 of the patchset. I believe it is ready to be applied. Changes
are pretty straight-forward and got tested properly (famous last words).

Changes to __tdx_hypercall() are also required for Hyper-V TDX guest
enabling.

Several changes to TDX initialization:

- Make early panic message visible to user;

- Relax SEPT_VE_DISABLE for debug TD. It helps to investigate bugs
  resulting in access of unaccepted memory.

- Make sure NOTIFY_ENABLES is off to eliminate possible source of random
  #VE.

The patchset makes use of ReportFatalError TDVMCALL. The definition of
the TDVMCALL has changed in recent GHCI update[1].

v2:
 - Split the first patch;
 - Introduce is_private_gpa();
 - Apply Reviewed-by from Dave;

Kirill A. Shutemov (7):
  x86/tdx: Fix typo in comment in __tdx_hypercall()
  x86/tdx: Add more registers to struct tdx_hypercall_args
  x86/tdx: Refactor __tdx_hypercall() to allow pass down more arguments
  x86/tdx: Expand __tdx_hypercall() to handle more arguments
  x86/tdx: Use ReportFatalError to report missing SEPT_VE_DISABLE
  x86/tdx: Relax SEPT_VE_DISABLE check for debug TD
  x86/tdx: Disable NOTIFY_ENABLES

 arch/x86/coco/tdx/tdcall.S        | 83 ++++++++++++++++++++++---------
 arch/x86/coco/tdx/tdx.c           | 62 ++++++++++++++++++++++-
 arch/x86/include/asm/shared/tdx.h |  6 +++
 arch/x86/kernel/asm-offsets.c     |  6 +++
 4 files changed, 131 insertions(+), 26 deletions(-)

-- 
2.39.1

