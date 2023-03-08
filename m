Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC96AFF6D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCHHG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCHHGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:06:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89534A2F00;
        Tue,  7 Mar 2023 23:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678259204; x=1709795204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qf4M9O3j3uFMxU8uFTT5U/Z0SLo4bxSiuHk1vznyQkU=;
  b=LCJEQKBoVTwQz8lWP3xjrBEoBYx/2Ijufb1sc6znm3WBenaSxghD1b/i
   VmJVGULkmJUfP7gg/GvkgtbWPramY4bBv85nKVeMj/gSrK+raHRo91yJQ
   auatAHaxepy62C0RmsHuLCjpbteRx7zoRC8emIbuBqm7/7pV/HfvbR/5s
   5kQorNWGeQiJlR9ioO3fv7vIQtmZCBO0TmpgzZWdL6UdKfCk2XCyVB4cK
   7HrwjFrytcH/WLSuTag7hM3j6hxrNCwh0K7ch5ENVkJyiJJXJTUD1Waum
   K5jtM9n7EFvwNmmpbzddKW2GKg7b+mBC6aqMq1T0yljB0A5of8GlOzC4d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333553961"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="333553961"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:06:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="850986373"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="850986373"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2023 23:06:43 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/8] platform/x86: ISST: Use TPMI interface
Date:   Tue,  7 Mar 2023 23:06:34 -0800
Message-Id: <20230308070642.1727167-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements TPMI as Intel Speed Select Technology (Intel SST)
HW interface. TPMI has several advantages for Intel SST. This replaces
legacy mailbox and MMIO with architectural interface over TPMI.

This improves performance for HPC type applications. One single IOCTL command
replaces 10s of IOCTLs for mailboxes. This allowed to offer many more
performance levels and SST configurations.

This series depends on previously posted series:
- platform/x86/intel: Intel TPMI enumeration driver

Change History
v2
- Rebased on top of review-hans branch of platform-drivers-x86
- Removed patches which are already present in this branch from the last review
So number of patches are reduced from 12 to 8.
- Rework patch for MSR 0x54 support
- Use suggestion from Hans for suspend/resume callbacks
- Add Reviewed-by and Test-by tags


Srinivas Pandruvada (8):
  platform/x86: ISST: Add support for MSR 0x54
  platform/x86: ISST: Enumerate TPMI SST and create framework
  platform/x86: ISST: Parse SST MMIO and update instance
  platform/x86: ISST: Add SST-CP support via TPMI
  platform/x86: ISST: Add SST-PP support via TPMI
  platform/x86: ISST: Add SST-BF support via TPMI
  platform/x86: ISST: Add SST-TF support via TPMI
  platform/x86: ISST: Add suspend/resume callbacks

 .../x86/intel/speed_select_if/Kconfig         |    4 +
 .../x86/intel/speed_select_if/Makefile        |    2 +
 .../intel/speed_select_if/isst_if_common.c    |   28 +
 .../x86/intel/speed_select_if/isst_tpmi.c     |   72 +
 .../intel/speed_select_if/isst_tpmi_core.c    | 1438 +++++++++++++++++
 .../intel/speed_select_if/isst_tpmi_core.h    |   18 +
 include/uapi/linux/isst_if.h                  |  303 ++++
 7 files changed, 1865 insertions(+)
 create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
 create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
 create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h

-- 
2.34.1

