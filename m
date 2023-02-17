Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0569A8A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBQJ4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBQJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:56:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541A55FBC9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676627771; x=1708163771;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v7fPf3BNhgtE+OypyeS+0CwqA2fiPt7yhI/fNtOINPE=;
  b=PFBthvqDBOxIljMvmllTMEEpHvJCjt5JYqHSWmPDvEKuABeeMCPJcyG5
   V3K6GI2U5PYs4+ysfCflEkoNlQ1tL31e6E29qf206X3Hzdyy2EwPM8OwH
   2cMbgOWW0EmeqH6J4S5aFyW6p3GiUdlDs7R5XaxfccNWmAdcc9h8Kv3Xn
   NJAUDJ/ylE2PfrHWRL2QXVYuz/ApkGXmT+/DlYrY+LnsB4Nj6MXnKfieA
   mqGZ8j70SYVMHlcvaBb9UroECElOZJI+1S+o7l1XkBxg//CyA/f+EI2CT
   xOzwZaKHRINWIZdT9hCiZZFzWV7WmZHMqIVY3p48istej8y2aJzHPgNmA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331955155"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="331955155"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 01:56:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999391203"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="999391203"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2023 01:56:06 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/6] iommu: Extend changing default domain to normal group
Date:   Fri, 17 Feb 2023 17:47:30 +0800
Message-Id: <20230217094736.159005-1-baolu.lu@linux.intel.com>
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

The IOMMU group sysfs interface allows users to change the default
domain of a group. The current implementation uses device_lock() to make
sure that the devices in the group are not bound to any driver and won't
be bound during the process of changing the default domain. In order to
avoid a possible deadlock caused by lock order of device_lock and
group->mutex, it limits the functionality to singleton groups only.

The recently implemented DMA ownership framework can be applied here to
replace device_lock(). In addition, use group->mutex to ensure that the
iommu ops of the devices is always valid during the process of changing
default domain.

With above replacement and enhancement, the device_lock() could be
removed and the singleton-group-only limitation could be removed.

The whole series is also available on github:
https://github.com/LuBaolu/intel-iommu/commits/iommu-sysfs-default-domain-extension-v2

This series is on top of below series from Robin,
https://lore.kernel.org/linux-iommu/cover.1674753627.git.robin.murphy@arm.com/

Please help to review and suggest.

Change log:
v2:
 - Use group->mutex instead of an additional rw lock.

v1: initial post
 - https://lore.kernel.org/linux-iommu/20230213074941.919324-1-baolu.lu@linux.intel.com/

Lu Baolu (6):
  ARM/dma-mapping: Remove iommu_detach_device()
  iommu: Split iommu_group_remove_device() into helpers
  iommu: Same critical region for device release and removal
  iommu: Move lock from iommu_change_dev_def_domain() to its caller
  iommu: Replace device_lock() with group->mutex
  iommu: Cleanup iommu_change_dev_def_domain()

 arch/arm/mm/dma-mapping.c                     |   1 -
 drivers/iommu/iommu.c                         | 255 +++++++-----------
 .../ABI/testing/sysfs-kernel-iommu_groups     |   1 -
 3 files changed, 102 insertions(+), 155 deletions(-)

-- 
2.34.1

