Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A8D6287FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbiKNSMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiKNSM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:12:29 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175C3240A6;
        Mon, 14 Nov 2022 10:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668449549; x=1699985549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C9JkdgcZ6oJqdaiwSAPD8B5Fij9Dk4WNXIkI/cGB8X4=;
  b=A/TK+u97GFBFprAR48YhNqw6ooSDm3c87EBIWiiO72iLTzJDlvXsblnN
   cA8aN18fRwevWKnVexphOIfYWUEGHt72IJtG+lEXjdVCROJ/igtSYLzHv
   kL2HVjLmZ3P5EZTJoE2VcMCeepkcD0jYpge27NXsIUT2BIBjRH803fddp
   FozxbV0din7lQOZ5PiC/bdvdvL1+mwekWmJZj7qRu8rBWy6/15y0bCYeW
   l+ML86oxy9U8A2PGFM0xHhUTwxFSkg1VvhVjPLorTL6yW11YBo998ztg/
   5TSiv/ZxRG6X6Zuxjl5hqmRxwdnD05DkH4Qdtob3rVMDLoAa71lzy5+8Z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398332755"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="398332755"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:12:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="640874254"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="640874254"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 14 Nov 2022 10:12:28 -0800
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.21])
        by linux.intel.com (Postfix) with ESMTP id 79AC258097C;
        Mon, 14 Nov 2022 10:12:28 -0800 (PST)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sukumar.ghorai@intel.com, xi.pardee@intel.com,
        rajvi.jingar@intel.com,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        David E Box <david.e.box@linux.intel.com>
Subject: [PATCH v3 0/8] Redesign the pmc core driver
Date:   Mon, 14 Nov 2022 10:11:59 -0800
Message-Id: <20221114181207.2062901-1-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

This patch series focuses on redesigning the PMC core driver for
maintainability and readability. Moving PCH specific structures and
functions to separate c files, simplifies core.c file and makes it
easier to add new platforms in future. The series includes two
preparatory patches that lays the ground work for the redesign. The
patch series also adds legacy support for Meteor Lake.

This redesign adds following c files to support different PCHs. There
are no functional changes involved for the already supported platforms.

spt.c: Sunrise Point PCH supports: Sky Lake, Sky Lake L, Kaby Lake,
Kaby Lake L
cnp.c: Cannon Lake Point PCH supports: Cannon Lake L, Comet Lake,
Comet Lake L
icl.c: Ice Lake PCH supports: Ice Lake L, Ice Lake NNPI, Jasper Lake
tgl.c: Tiger Lake PCH supports: Tiger Lake, Tiger Lake L, Alder Lake L,
Alder Lake N, Rocket Lake, Raptor Lake P, Elkhart Lake
adl.c: Alder Lake PCH supports: Alder Lake, Raptor Lake, Raptor Lake S
mtl.c: Meteor Lake PCH supports: Meteor Lake

Patch 1: platform/x86: intel/pmc: Replace all the reg_map with init
functions
Patch 2: platform/x86: intel/pmc: Move variable declarations and
definitions to header and core.c
Patch 3: platform/x86: intel/pmc: Relocate Sunrise Point PCH support
Patch 4: platform/x86: intel/pmc: Relocate Cannon Lake Point PCH
support
Patch 5: platform/x86: intel/pmc: Relocate Ice Lake PCH support
Patch 6: platform/x86: intel/pmc: Relocate Tiger Lake PCH support
Patch 7: platform/x86: intel/pmc: Relocate Alder Lake PCH support
Patch 8: platform/x86: intel/pmc: Add Meteor Lake support to pmc core
driver 

Gayatri Kammela (4):
  platform/x86: intel/pmc: Replace all the reg_map with init functions
  platform/x86: intel/pmc: Relocate Tiger Lake PCH support
  platform/x86: intel/pmc: Relocate Alder Lake PCH support
  platform/x86: intel/pmc/core: Add Meteor Lake support to pmc core
    driver

Rajvi Jingar (1):
  platform/x86: intel/pmc: Relocate Sunrise Point PCH support

Xi Pardee (3):
  platform/x86: intel/pmc: Move variable declarations and definitions to
    header and core.c
  platform/x86: intel/pmc: Relocate Cannon Lake Point PCH support
  platform/x86: intel/pmc: Relocate Ice Lake PCH support

 drivers/platform/x86/intel/pmc/Makefile |   3 +-
 drivers/platform/x86/intel/pmc/adl.c    | 325 ++++++++
 drivers/platform/x86/intel/pmc/cnp.c    | 210 +++++
 drivers/platform/x86/intel/pmc/core.c   | 994 ++----------------------
 drivers/platform/x86/intel/pmc/core.h   |  89 ++-
 drivers/platform/x86/intel/pmc/icl.c    |  56 ++
 drivers/platform/x86/intel/pmc/mtl.c    |  52 ++
 drivers/platform/x86/intel/pmc/spt.c    | 140 ++++
 drivers/platform/x86/intel/pmc/tgl.c    | 269 +++++++
 9 files changed, 1183 insertions(+), 955 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/adl.c
 create mode 100644 drivers/platform/x86/intel/pmc/cnp.c
 create mode 100644 drivers/platform/x86/intel/pmc/icl.c
 create mode 100644 drivers/platform/x86/intel/pmc/mtl.c
 create mode 100644 drivers/platform/x86/intel/pmc/spt.c
 create mode 100644 drivers/platform/x86/intel/pmc/tgl.c


base-commit: 309e0a6ed6e3fdb4febacc3e91aeb268500b90c6

Cc: Xi Pardee <xi.pardee@intel.com>
Cc: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Cc: David E Box <david.e.box@linux.intel.com>
-- 
2.25.1

