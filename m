Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFFF6BBC24
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjCOSeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCOSeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA87A2885E;
        Wed, 15 Mar 2023 11:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905247; x=1710441247;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7buWurkLx342j2qkufbK81+uMROemN3Q2MWKAyW03JA=;
  b=W4qTyo5+fe68lSRgPHQuVb3c+WxJaBoFD98dbwjwaeqQ4+q+eFxBiU1g
   LAOmQ/aybTwj+mi5TRIg4JhBnbuPE9Pz2G3cNzG07U5UIsDGcoC0q5B1u
   6r+LSPRX3JQTnejCLXXjElNK+vMpxbPW/x93yiqI/SlfOJQpwa+yY1Pit
   NRBpdenYeB4vVcedZxOTvlA5hDe6n+tcdTKhSsMjxEmZIJ9Z7HS/jFxMJ
   KWYYcAyhnpqoA7yLVqJvV7vVRN0SGHWLsZZqKcLF8G1ZFblJOKhjKIE+F
   wXMEjs38h5MzXeAxkYXJse9neoqzjYrQmrxCNqTt28z4SERL8LGS6XOdF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154517"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154517"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435195"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435195"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:06 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id 2BF5D580BF6;
        Wed, 15 Mar 2023 11:34:06 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 00/11] Intel pmc_core: Enable telemetry
Date:   Wed, 15 Mar 2023 11:33:54 -0700
Message-Id: <20230315183405.2465630-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel SoCs, registers for the Power Management Controller are available
in the PCI BAR of the SSRAM device, 0000:14.2. On Meteor Lake, these
registers are structured in Intel PMT Telemetry regions which could be
handled by the pmt_telemetry driver. This series adds APIs to the
intel_vsec and pmt_telemetry drivers so that pmc_core driver can both
create the telemetry instance from the SSRAM device and register for a
handle to read the telemetry which contains the low power mode requirements
for the S0ix states supported by Meteor Lake. The series also adds some
fixes.

David E. Box (6):
  platform/x86/intel/vsec: Explicitly enable capabilities
  platform/x86/intel/vsec: Add base address field
  platform/x86/intel/pmt: Add INTEL_PMT module namespace
  platform/x86/intel/pmt: telemetry: Add telemetry read functions
  platform/x86/intel/pmt/telemetry: Add driver version
  platform/x86/intel/pmc: Add Intel PMT support for MTL PMC

Gayatri Kammela (1):
  platform/x86/intel/vsec: Add intel_vsec_register

Rajvi Jingar (1):
  platform/x86/intel/pmc: Alder Lake slp_s0_residency fix

Xi Pardee (3):
  platform/x86:intel/pmc: Combine core_init and core_configure function
  platform/x86:intel/pmc: Move get_low_power_modes function
  platform/x86/intel/pmc/mtl: get LPM information using Intel PMT

 drivers/platform/x86/intel/pmc/Kconfig     |   1 +
 drivers/platform/x86/intel/pmc/adl.c       |  17 +-
 drivers/platform/x86/intel/pmc/cnp.c       |  17 +-
 drivers/platform/x86/intel/pmc/core.c      |  71 +++++---
 drivers/platform/x86/intel/pmc/core.h      |  24 +--
 drivers/platform/x86/intel/pmc/icl.c       |  11 +-
 drivers/platform/x86/intel/pmc/mtl.c       | 187 ++++++++++++++++++-
 drivers/platform/x86/intel/pmc/spt.c       |  11 +-
 drivers/platform/x86/intel/pmc/tgl.c       |  17 +-
 drivers/platform/x86/intel/pmt/class.c     |  48 +++--
 drivers/platform/x86/intel/pmt/class.h     |  35 ++--
 drivers/platform/x86/intel/pmt/crashlog.c  |   3 +-
 drivers/platform/x86/intel/pmt/telemetry.c | 199 ++++++++++++++++++++-
 drivers/platform/x86/intel/pmt/telemetry.h | 120 +++++++++++++
 drivers/platform/x86/intel/vsec.c          | 131 ++++++--------
 drivers/platform/x86/intel/vsec.h          |  64 ++++++-
 16 files changed, 790 insertions(+), 166 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmt/telemetry.h


base-commit: 02c464b73645404654359ad21f368a13735e2850
-- 
2.34.1

