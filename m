Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004DE6729B0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjARUue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjARUu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:50:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1FB5F380
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674075027; x=1705611027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NPMhzzz0RKilWU/5JQolES+uiAaNFvLIHnBZFC8yZxM=;
  b=ks/ArLw3b2pEG0E6bJMbqVjpN1SipGnD3JN6n3lGDJeo4rfwuAtLP+HL
   xZ2xekIDVz+Iavz/2AVUl17f3mqGnj1GOoBpqr+KASC3/7ugIDb+6dpx+
   SOyEtxCAecC1+QkX+oD0U2Yrsz7zyvZqIQ6YbcnuoyKPcM6JrVyg/hWT1
   t+Ns6u8DZx7akgv7xJrrqZ49rjq7Yn7APBZcZ1vDR7fr92RzVp5Uwm/px
   9l+8zLaQ1UxW1yOQOvQZf3aYoSDltPQEgkn7t/me2S2oJjIoZNREh8/CX
   DY/VYzfXrFox2ADSIwamZ/+zh4lBOx53w48T5P1mU9cS6Wz5TGWmrnUyj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323784126"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="323784126"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:50:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="833739565"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="833739565"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2023 12:50:26 -0800
From:   kan.liang@linux.intel.com
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/7] iommu/vt-d: Support performance monitoring for IOMMU
Date:   Wed, 18 Jan 2023 12:49:59 -0800
Message-Id: <20230118205006.3182907-1-kan.liang@linux.intel.com>
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

 $ perf stat -e dmar0/iommu_requests,filter_ats=0/ -a sleep 1

 Performance counter stats for 'system wide':

              2135      dmar0/iommu_requests,filter_ats=0/

       1.001087695 seconds time elapsed

The IOMMU PMUs can be found under /sys/bus/event_source/devices/dmar*

The available filters and event format can be found at the format folder
 $ ls /sys/bus/event_source/devices/dmar0/format/
event  event_group  filter_ats  filter_page_table

The supported events can be found at the events folder

 $ ls /sys/bus/event_source/devices/dmar0/events/
ats_blocked        int_cache_hit_nonposted  iommu_mrds
pasid_cache_lookup
ctxt_cache_hit     int_cache_hit_posted     iommu_requests
pg_req_posted
ctxt_cache_lookup  int_cache_lookup         iotlb_hit
pw_occupancy
fs_nonleaf_hit     iommu_clocks             iotlb_lookup
ss_nonleaf_hit
fs_nonleaf_lookup  iommu_mem_blocked        pasid_cache_hit
ss_nonleaf_lookup

Kan Liang (7):
  iommu/vt-d: Support size of the register set in DRHD
  iommu/vt-d: Retrieve IOMMU perfmon capability information
  iommu/vt-d: Support Enhanced Command Interface
  iommu/vt-d: Add IOMMU perfmon support
  iommu/vt-d: Support cpumask for IOMMU perfmon
  iommu/vt-d: Add IOMMU perfmon overflow handler support
  iommu/vt-d: Enable IOMMU perfmon support

 .../sysfs-bus-event_source-devices-iommu      |  32 +
 drivers/iommu/intel/Kconfig                   |   9 +
 drivers/iommu/intel/Makefile                  |   1 +
 drivers/iommu/intel/dmar.c                    |  91 +-
 drivers/iommu/intel/iommu.c                   |   3 +
 drivers/iommu/intel/iommu.h                   | 101 ++-
 drivers/iommu/intel/perfmon.c                 | 850 ++++++++++++++++++
 drivers/iommu/intel/perfmon.h                 |  65 ++
 drivers/iommu/intel/svm.c                     |   2 +-
 include/acpi/actbl1.h                         |   2 +-
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/dmar.h                          |   1 +
 12 files changed, 1151 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
 create mode 100644 drivers/iommu/intel/perfmon.c
 create mode 100644 drivers/iommu/intel/perfmon.h

-- 
2.35.1

