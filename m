Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C995EB9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiI0Fhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiI0Fhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:37:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F2D80E81
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 22:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664257055; x=1695793055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q/Y1+fWAykwz5hhA2gaUjad2dAwBHe4vhPbOrljnxJg=;
  b=VejkLn0oULAkAYQWMWmjXo40Coutg/CjSp4vV12zDRQLXT5VTTRHr7f6
   N+s9/SzJFaaHCAXxX5ZkZqVVzV84QWgqaxuGsfjMvmLUYu44OU+vMZ69L
   B8kXLYneFUXAwLKx86DoH6n5lT8ljtpFs7NY/V/U6Dq5nHsGb2INC8exE
   wQDOVqbXUBkuBgcRFH6ztbAOCVxFp0dmQTDiOpAA9vqw2Sci3Yg9JBdbL
   /0HZAsFgt+kybhZfTWMcTTNuH8kayKWBmfU3yBCZ7Fp2ttqIZ9aoRXMTO
   aCOAGeItOe488THMz4izlWhZB2H4k0ljyhd6JiTmf/8xxhLCALeIvHawi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302706770"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="302706770"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 22:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="623633335"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="623633335"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2022 22:37:13 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] iommu/vt-d: Fix lockdep splat in intel_iommu_init()
Date:   Tue, 27 Sep 2022 13:31:07 +0800
Message-Id: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

As commit c919739ce472 ("iommu/vt-d: Handle race between registration
and device probe") highlights, a lockdep splat issue happens after
moving iommu probing device process into iommu_device_register().

This is due to a conflict that get_resv_regions wants hold the
dmar_global_lock, but it's also possible to be called from within a
section where intel_iommu_init() already holds the lock.

Historically, before commit 5f64ce5411b46 ("iommu/vt-d: Duplicate
iommu_resv_region objects per device list"), the rcu_lock is used in
get_resv_regions. This commit converted it to dmar_global_lock in order
to allowing sleeping in iommu_alloc_resv_region().

This aims to fix the lockdep issue by making iommu_alloc_resv_region()
available in critical section and rolling dmar_global_lock back to rcu
lock in get_resv_regions of the Intel IOMMU driver.

Best regards,
baolu

Lu Baolu (2):
  iommu: Add gfp parameter to iommu_alloc_resv_region
  iommu/vt-d: Use rcu_lock in get_resv_regions

 include/linux/iommu.h                       |  2 +-
 drivers/acpi/arm64/iort.c                   |  3 ++-
 drivers/iommu/amd/iommu.c                   |  7 ++++---
 drivers/iommu/apple-dart.c                  |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
 drivers/iommu/intel/iommu.c                 | 12 +++++++-----
 drivers/iommu/iommu.c                       |  7 ++++---
 drivers/iommu/mtk_iommu.c                   |  3 ++-
 drivers/iommu/virtio-iommu.c                |  9 ++++++---
 10 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.34.1

