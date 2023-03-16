Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791E96BD416
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjCPPlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCPPkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:40:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CE427D72;
        Thu, 16 Mar 2023 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981202; x=1710517202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TUgeqE4ATDv399pdRnSJTG3joPFb41oP5Y0X4tbedDE=;
  b=JIZpZcaOCnEA0QqUWZmZA+BehONk7ZEuxkvSllH9raleqbyPo1pvVelK
   Y+Dy+HEWsPHnAVIERH4bKz/lJQmxRGj8yGeHBMYvooEVHIqJWG0LxQe8h
   idkBmM8snEiMWYQGyVDn9ngzCfD5SWLjFJjCoPSUpSI16iCSAbsLD0k4Z
   jM8tdMnEz22392k8FsksSuHgdthqS3CCnmdhc4+O49Mtc3nQt2WnvD6Pz
   f1sL8oKYh3h4c9+k3LpBPxfcY+ZcSwwWjpij3LzQp2z5Qd2wa8ZcpebUB
   R/vohHm65lZaUtfbr8CGnEHsNBBwJynNeGmYqd3luG1i5gvdoRYsSdkGp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339570930"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339570930"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009266961"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009266961"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:38:48 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 0/15] powercap/intel_rapl: Introduce RAPL TPMI support
Date:   Thu, 16 Mar 2023 23:38:26 +0800
Message-Id: <20230316153841.3666-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPMI (Topology Aware Register and PM Capsule Interface) provides a
flexible, extendable and PCIe enumerable MMIO interface for PM features.

The TPMI documentation can be downloaded from:
https://github.com/intel/tpmi_power_management

Intel RAPL (Running Average Power Limit) is one of the features that
benefit from this. Using TPMI Interface has advantage over traditional MSR
(Model Specific Register) interface, where a thread needs to be scheduled
on the target CPU to read or write. Also the RAPL features vary between
CPU models, and hence lot of model specific code. Here TPMI provides an
architectural interface by providing hierarchical tables and fields,
which will not need any model specific implementation.

Given that there are some differences between RAPL TPMI Interface and the
existing RAPL MSR/MMIO Interface, this patch series improves the RAPL
common code to satisfy the new requirements from TPMI interface, and then
introduces the RAPL TPMI Interface driver.

Patch 1-4	cleanups and preparation work.
Patch 5		adds support for per Domain Unit register.
Patch 6-10	improves Power Limits handling, and provides support
		for per Power Limit register, and per Power Limit Lock.
Patch 11-12	support rapl_package without online CPUs. So that TPMI
		rapl_package still works with whole package offlined.
Patch 13-15	introduces RAPL Core support for TPMI Interface and the
		RAPL TPMI Interface driver.

This series depends on the TPMI base driver which has been merged in 6.3-rc1.

thanks,
rui

----------------------------------------------------------------
Zhang Rui (15):
      powercap/intel_rapl: Remove unused field in struct rapl_if_priv
      powercap/intel_rapl: Allow probing without CPUID match
      powercap/intel_rapl: Support per Interface rapl_defaults
      powercap/intel_rapl: Support per Interface primitive information
      powercap/intel_rapl: Support per domain energy/power/time unit
      powercap/intel_rapl: Use index to initialize primitive information
      powercap/intel_rapl: Change primitive order
      powercap/intel_rapl: Use bitmap for Power Limits
      powercap/intel_rapl: Cleanup Power Limits support
      powercap/intel_rapl: Introduce per Power Limit lock
      powercap/intel_rapl: Remove redundant cpu parameter
      powercap/intel_rapl: Make cpu optional for rapl_package
      powercap/intel_rapl: Introduce RAPL I/F type
      powercap/intel_rapl: Introduce core support for TPMI interface
      powercap/intel_rapl_tpmi: Introduce RAPL TPMI interface driver

 drivers/powercap/Kconfig                           |  14 +
 drivers/powercap/Makefile                          |   1 +
 drivers/powercap/intel_rapl_common.c               | 868 ++++++++++++---------
 drivers/powercap/intel_rapl_msr.c                  |  14 +-
 drivers/powercap/intel_rapl_tpmi.c                 | 325 ++++++++
 .../intel/int340x_thermal/processor_thermal_rapl.c |  11 +-
 include/linux/intel_rapl.h                         |  40 +-
 7 files changed, 875 insertions(+), 398 deletions(-)
 create mode 100644 drivers/powercap/intel_rapl_tpmi.c

