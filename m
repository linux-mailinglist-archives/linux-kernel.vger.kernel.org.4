Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D72A67FAAF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 21:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjA1UEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 15:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjA1UEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 15:04:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABCC24C89
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 12:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674936270; x=1706472270;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2mmFy3LVygpRkwWTSVvzettbUV4gF4wIiSThu2j5Nak=;
  b=lxdluZj8hfAzbahFVxnxzxaf9pAfFj+UfqAq48PukqLVy2ZtxDHuq0FF
   6o498nunWWmpMnUM3Kh9yLE17jdtNckAvgF7tMYanceECnlHkcum9O22E
   adV0YxTjF+J+e/7dsxE7JQbY0n4c7RmcJuL3yrOKqJ5oX0rTJLGKAL2gq
   53mmgvobNOB7Evq4DKrEdMxUEuPZbcFnCkxZ1JA0MMal8YxbVrpoIc5xB
   rC7B1xZTajcoQ6ZZzhhJNc0BU4fvVOy9qmWKFf8qDe0ql19wCJwU+VzPF
   KPuwY2yVR5Ev9OoI/MBdi+OUt/Fc7gzVHfVLhf8UiZMA4a0xVGLVvaqr7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325022486"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325022486"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 12:04:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="909038357"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="909038357"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2023 12:04:29 -0800
From:   kan.liang@linux.intel.com
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     yu-cheng.yu@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 0/7] iommu/vt-d: Support performance monitoring for IOMMU
Date:   Sat, 28 Jan 2023 12:04:21 -0800
Message-Id: <20230128200428.1459118-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V3:
- Fix issues found by "./scripts/checkpatch.pl --strict" scripts
  Doesn't fix the "macros should not use a trailing semicolon" warning,
  since the macros has to include several struct and functions to
  further reduce the code duplication.
- To fix the 0 value filter issue, introduce new "*_filter_en" attrs
  for each filter. The end user must set both filter_en and filter
  to utilize a filter.
- Re-organize the layout of config1 and config2.

Changes since V2:
- Move ecmd_submit_sync() to iommu.c to avoid #ifdef CONFIG_INTEL_IOMMU

Changes since V1:
- The cap and ecap registers are always in the first page. It's not
  necessary to use the reg size in dmar_validate_one_drhd(). (Patch 1)
- Move reg_size up and pair it with reg_base_addr in struct
  dmar_drhd_unit (Patch 1)
- Update the year of Copyright (Patch 2)
- Return 0 if PMS is not supported (Patch 2)
- Refine the comments and add a pr_warn for per-counter capabilities
  check (Patch 2)
- Remove unnecessary iommu_pmu->num_cntr = i (Patch 2)
- Remove has_ob of ecmd_submit_sync() (Patch 3)
- Remove the helpers from non-INTEL_IOMMU. (Patch 3)
- Still keep #ifdef CONFIG_INTEL_IOMMU for ecmd_submit_sync() to
  avoid compile warning with non-INTEL_IOMMU config.
- Use pr_warn_once() to replace WARN_ONCE() (Patch 4 & 6)
- Free iommu PMU if it fails to be registered. (Patch 4)
- Remove unnecessary 'handled' variable. (Patch 6)

A performance monitoring infrastructure, perfmon, is introduced with
the VT-d Spec 4.0. The purpose of perfmon is to support collection of
information about key events occurring during operation of the remapping
hardware, to aid performance tuning and debug. The patch series is to
support the perfmon for IOMMU.

To facilitate the perfmon support, the patch series also supports two
new generic features of VT-d Spec 4.0.
- Support the 'size' field to retrieve the accurate size of the register
  set for each dmar device from DRHD. (Patch 1)
- Support the new Enhanced Command Interface. (Patch 3)

With the patch series, users can collect the performance data of IOMMU
via Linux perf tool. For example,

 $ perf stat -e dmar1/iommu_requests,filter_ats_en=0x1,filter_ats=0x1/
   -a sleep 1

 Performance counter stats for 'system wide':

   368,947      dmar1/iommu_requests,filter_ats_en=0x1,filter_ats=0x1/

 1.002592074 seconds time elapsed

Kan Liang (7):
  iommu/vt-d: Support size of the register set in DRHD
  iommu/vt-d: Retrieve IOMMU perfmon capability information
  iommu/vt-d: Support Enhanced Command Interface
  iommu/vt-d: Add IOMMU perfmon support
  iommu/vt-d: Support cpumask for IOMMU perfmon
  iommu/vt-d: Add IOMMU perfmon overflow handler support
  iommu/vt-d: Enable IOMMU perfmon support

 .../sysfs-bus-event_source-devices-iommu      |  37 +
 drivers/iommu/intel/Kconfig                   |  11 +
 drivers/iommu/intel/Makefile                  |   1 +
 drivers/iommu/intel/dmar.c                    |  33 +-
 drivers/iommu/intel/iommu.c                   |  59 ++
 drivers/iommu/intel/iommu.h                   | 102 +-
 drivers/iommu/intel/perfmon.c                 | 877 ++++++++++++++++++
 drivers/iommu/intel/perfmon.h                 |  64 ++
 drivers/iommu/intel/svm.c                     |   2 +-
 include/acpi/actbl1.h                         |   2 +-
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/dmar.h                          |   1 +
 12 files changed, 1182 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
 create mode 100644 drivers/iommu/intel/perfmon.c
 create mode 100644 drivers/iommu/intel/perfmon.h

-- 
2.35.1

