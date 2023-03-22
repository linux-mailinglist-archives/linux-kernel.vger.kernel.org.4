Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA26C4387
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCVGtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCVGti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:49:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86324BC1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679467777; x=1711003777;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gRhStfg9t6nkENeHZY+SE3iSs1PqWpgT2M5EEBCNGo8=;
  b=G1AHZcJy0sn+EKAZQlU0kRSGxby0PyYUZ3kglF8lFc4XU0eSAiJgd1BT
   MdhfsC2ktvJoFu/6iQhsdS0/PzUnIvZZfde+218UwVMAkTFtVQ5+lsWe1
   SlVLTWQoH+M4NBvhyWK8wRsnMb/BjrTgwwM0UqQwvQohuGL38P5xWwZH3
   Fzxg0RPMxOlg+Ljyn04HOkJT54ZmJQz8h5Vua6hPcBnRAxsba2aVT3f6J
   6sw/BmWWcupRH8yT5WmzBtu7wan0CC17TPoLTQ/hleSrgjeZ3qbLfpQLF
   DvrtKpPGsS1KvOqBz9FBUXwzRJSR4viNPN+j8h68s1P9KmtnHhuNMKcXK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="337866717"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="337866717"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="659080360"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="659080360"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2023 23:49:34 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 0/6] iommu: Extend changing default domain to normal group
Date:   Wed, 22 Mar 2023 14:49:50 +0800
Message-Id: <20230322064956.263419-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
iommu ops of the device are always valid during the process of changing
default domain.

With above replacement and enhancement, the device_lock() could be
removed and the singleton-group-only limitation could be removed.

This series is based on v6.3-rc3, and I also have it on github:
https://github.com/LuBaolu/intel-iommu/commits/iommu-sysfs-default-domain-extension-v4

Change log:
v4:
 - Whole series reviewed by Jason.
 - Robin suggested further simplification of using
   arm_iommu_release_mapping() directly.
   https://lore.kernel.org/linux-iommu/7b248ba1-3967-5cd8-82e9-0268c706d320@arm.com/
 - Rebase the whole series to v6.3-rc3.

v3:
 - https://lore.kernel.org/linux-iommu/20230306025804.13912-1-baolu.lu@linux.intel.com/
 - "arm_iommu_detach_device() is a noop" is not entirely right. It is
   used to make the iommu driver stop using the domain that it is
   about to free. It cannot be a NOP or it is a UAF. [Jason]
 - Use Jason's new arm_iommu_release_device() proposal instead.

v2:
 - https://lore.kernel.org/linux-iommu/20230217094736.159005-1-baolu.lu@linux.intel.com/
 - Use group->mutex instead of an additional rw lock.

v1: initial post
 - https://lore.kernel.org/linux-iommu/20230213074941.919324-1-baolu.lu@linux.intel.com/

Lu Baolu (6):
  iommu/ipmmu-vmsa: Call arm_iommu_release_mapping() in release path
  iommu: Split iommu_group_remove_device() into helpers
  iommu: Same critical region for device release and removal
  iommu: Move lock from iommu_change_dev_def_domain() to its caller
  iommu: Replace device_lock() with group->mutex
  iommu: Cleanup iommu_change_dev_def_domain()

 drivers/iommu/iommu.c                         | 273 ++++++++----------
 drivers/iommu/ipmmu-vmsa.c                    |  14 +-
 .../ABI/testing/sysfs-kernel-iommu_groups     |   1 -
 3 files changed, 130 insertions(+), 158 deletions(-)

-- 
2.34.1

