Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2BC666F44
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbjALKQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjALKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:14:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE555FE3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673518460; x=1705054460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lSP+h+laxvUqeKdHg46PtrH3Xip8ADgfReT4ZBovqNw=;
  b=fVC+WnOkbE0Ucu0MePlvGszyS+4KBforEPcCrrfqReoS0G8ew+hKASoa
   +SLsRwQyl0Hylno+dEOyuswJeJj+WS3Tdr6grYLiVgQUo+XkH97kUbMvZ
   LPbeymaN2NCgO8d/s6C7N12dzrm6FSjcDWdOWJRYN0j9hP5REPPY9EwCB
   xzuYyMKUe7OlmBY23Ftc1dnDgc4XpKHc4Qd3qi7mvg82b1ihd7vSV05II
   Ils/VKRs5BYR0p7g8lKrDQ7/DDu6D85UdjrPShpCia3X93x+X/TMBBGeR
   A+PzHRKSTjwGNgl/Xs6djUrkjTOCV0FC3YfcsUqbx4UR6cEDUHBWNxjP6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350892148"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="350892148"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659722891"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="659722891"
Received: from glieseu-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.52.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:16 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 76330109AF0; Thu, 12 Jan 2023 13:14:13 +0300 (+03)
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
Subject: [PATCHv2 0/7] x86/tdx: Changes for TDX guest initialization
Date:   Thu, 12 Jan 2023 13:14:00 +0300
Message-Id: <20230112101407.24327-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
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

Several changes to TDX initialization:

- Make early panic message visible to user;

- Relax SEPT_VE_DISABLE for debug TD. It helps to investigate bugs
  resulting in access of unaccepted memory.

- Make sure NOTIFY_ENABLES is off to eliminate possible source of random
  #VE.

The patchset makes use of ReportFatalError TDVMCALL. The definition of
the TDVMCALL has changed in recent GHCI update[1]. It now requires more
arguments handled by __tdx_hypercall(). The patch that expands
__tdx_hypercall() is the same as the patch included in TDX guest
enabling for Hyper-V.

[1] https://cdrdv2.intel.com/v1/dl/getContent/726790

v2:
 - Split the first patch;
 - Intoduce is_private_gpa();
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
2.38.2

