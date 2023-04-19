Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222616E7135
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjDSCof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDSCoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:44:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C897659E;
        Tue, 18 Apr 2023 19:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681872273; x=1713408273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qldKoJM4AGx8vqmn/0nos/tMETtTEEXNp8+yBseZt3U=;
  b=WreNRaIrkJ7iM1t7iSOD1N6k4DFgixclpz+VKxj12ZKKj8Bzb9d31VPC
   c5wILTMgP/k2gzA9wE6834jR+M0rUUWmwmxyyv4xFxdBTB7iBoXJ3AcYn
   gwEVvaaDR6Dan+ROgg1TAbuZFmt5FTFbFbcUFXmSuzlSqMNKZtUU8Tkkf
   z7d8smyudx7KymcOUkZIZWVg2eNO9snHE0t7FYW5z/luMxM7XddKkx76/
   RrzKiSGF+4akWNlcxaUUkaariTDuBgaIGUoFEsT0HMzP+XSoTXy1K5TxY
   R85gaL8cjz6bgN/6n1lov9SBl5sgXr6VoalyuKfWlJDHaYsbULUHzcRSK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373215266"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373215266"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937478002"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="937478002"
Received: from hanboyu-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.29.76])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:31 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH v2 0/15] powercap/intel_rapl: Introduce RAPL TPMI support
Date:   Wed, 19 Apr 2023 10:44:04 +0800
Message-Id: <20230419024419.324436-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
---
Changes since v1:
   - use set_defaults() and variable name 'defaults' for rapl_defaults
     structure.
   - use 'rpi_default' instead of 'rpis' for the default rapl primitive
     information of MSR/MMIO Interface.
   - rephase the changelog of patch 7/15.
   - change the subject of patch 10/15 and use a helper for getting the
     primitive for power limit LOCK bit control.

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

