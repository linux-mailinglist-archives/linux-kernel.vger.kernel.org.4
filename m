Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1290C6AB4CD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFC7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFC7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:59:16 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1747010419
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678071556; x=1709607556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=frp35F+rukJEyC3hLBZu7cN+WEg26QfBVYPdBkx+1Ew=;
  b=Zfk1MifloVVXZLmPoBin77GrY8NTiGxu5kgoEAXUPdQWPkRWsyhXocLj
   2CV+TdTnUi/cSNdQcDuxWaLsKrZ4xxV7Mi72aKzaoUWaOn68xkyfQn4c3
   YlRicKfZt7/ASWiILgJrZFDu4E1791EJP+uu7+9HmR5nL1PA5ady9yQOJ
   rqmdA3OYn/mwX6h48ic294j2Ed1hLzxfo5qrZwSLPt7eOfwqNwoHzdkEn
   xZrU5jra5oSdoA8DF+DSN3HJxsQ8hGYY4JQgQZ4aprWWByvGEJOzkvjKH
   FThWmyFMm4VoWlVifpHi8y4ZVqaDebwnv5A/YBwTBiB+Hg4Z3yi48WRZG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="363071469"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="363071469"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 18:59:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="765072466"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="765072466"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Mar 2023 18:59:13 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/6] iommu: Extend changing default domain to normal group
Date:   Mon,  6 Mar 2023 10:57:58 +0800
Message-Id: <20230306025804.13912-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

This series is based on v6.3-rc1 with below series from Robin applied,
https://lore.kernel.org/linux-iommu/cover.1674753627.git.robin.murphy@arm.com/

The whole series is also available on github:
https://github.com/LuBaolu/intel-iommu/commits/iommu-sysfs-default-domain-extension-v3

Please help to review and suggest.

Change log:
v3:
 - "arm_iommu_detach_device() is a noop" is not entirely right. It is
   used to to make the iommu driver stop using the domain that it is
   about to free. It cannot be a NOP or it is a UAF. [Jason]
 - Use Jason's new arm_iommu_release_device() proposal instead.

v2:
 - https://lore.kernel.org/linux-iommu/20230217094736.159005-1-baolu.lu@linux.intel.com/
 - Use group->mutex instead of an additional rw lock.

v1: initial post
 - https://lore.kernel.org/linux-iommu/20230213074941.919324-1-baolu.lu@linux.intel.com/

Lu Baolu (6):
  ARM/dma-mapping: Add arm_iommu_release_device()
  iommu: Split iommu_group_remove_device() into helpers
  iommu: Same critical region for device release and removal
  iommu: Move lock from iommu_change_dev_def_domain() to its caller
  iommu: Replace device_lock() with group->mutex
  iommu: Cleanup iommu_change_dev_def_domain()

 arch/arm/include/asm/dma-iommu.h              |   1 +
 arch/arm/mm/dma-mapping.c                     |  25 ++
 drivers/iommu/iommu.c                         | 270 ++++++++----------
 drivers/iommu/ipmmu-vmsa.c                    |  15 +-
 .../ABI/testing/sysfs-kernel-iommu_groups     |   1 -
 5 files changed, 156 insertions(+), 156 deletions(-)

-- 
2.34.1

