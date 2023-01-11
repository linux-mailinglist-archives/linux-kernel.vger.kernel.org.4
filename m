Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6D6664CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjAKUZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjAKUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:25:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153F4E0D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673468729; x=1705004729;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7MZnlEJDfzM9tFXk3t/JI8vRdaKz3XlWgX6G+VI6Vqs=;
  b=ABb4OautgO47gZulY7k/5O8dMUpWyhoawu9MxKbDqTeQ1vtO2cbxPe4G
   n790tfXYtg4PW2FhM+QB9WiEw0vq/Rpv5p6ulbUgNqGB4wpxSc4age5ey
   lkn9ds+Qbnbc0sDEts4K5iWWg8Vdp/oUow2FGgqNSdOWByUCd5e/g5p1m
   hYmbmFVThyx2v1eyFtyzTcPAXJG1B9T20ZYOeqxAuX8O4szOoFJVG72f5
   GtbIZAvLJFiaxcG1hTM51ZkBu7mDP44r/4SEC96JbXGhdyJFeHe4va0hK
   Mk2wmEygB8yE6M2A9Q0wAmp9iKaz3gPfgfsHcYny4I6ONcg+c2FSZ9Ffx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350754970"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="350754970"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 12:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="781518059"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="781518059"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2023 12:25:28 -0800
From:   kan.liang@linux.intel.com
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/7] iommu/vt-d: Support performance monitoring for IOMMU
Date:   Wed, 11 Jan 2023 12:24:57 -0800
Message-Id: <20230111202504.378258-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

From: Kan Liang <kan.liang@linux.intel.com>

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
 drivers/iommu/intel/dmar.c                    | 100 ++-
 drivers/iommu/intel/iommu.c                   |   3 +
 drivers/iommu/intel/iommu.h                   | 113 ++-
 drivers/iommu/intel/perfmon.c                 | 836 ++++++++++++++++++
 drivers/iommu/intel/perfmon.h                 |  65 ++
 drivers/iommu/intel/svm.c                     |   2 +-
 include/acpi/actbl1.h                         |   2 +-
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/dmar.h                          |   1 +
 12 files changed, 1155 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
 create mode 100644 drivers/iommu/intel/perfmon.c
 create mode 100644 drivers/iommu/intel/perfmon.h

-- 
2.35.1

