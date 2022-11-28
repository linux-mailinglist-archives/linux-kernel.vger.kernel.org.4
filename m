Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779B763A195
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiK1GyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiK1GyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:54:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E2A657B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618447; x=1701154447;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vvz9N9MRNenweKI1afeT3TpfbkZc8HEz36MNBKq2e00=;
  b=PcsdSCsIGn58vGqexakYLlKl/X+cE1B+QX2DJEzZfedaQQC/39uD8Qpt
   z1y1UlctXbln3WD/jL1coVmWN+P6oDw/n+FHiOkIfdd8hizARK61oUsBG
   GGoS0bN8xXisECBxcLUVChapLRdzulNNQDT2F3/Jy94FTREYD/DIYOFrN
   BtLqW6a2ojQsDsjy8tZcJmnzwCzQSSzoX/CBll1zOhOtTvuS6nVAasb/N
   nLAY/0xhmFkru+9dTE4PGOmVDZ6scsbz7FPCMUZmh59D18Cj4g4rHvUx3
   GB/MUaOyG1cLNVMNSLw6vAa1wIXyG1J7glHFaIdjqQbR3lChxP9ykp2OC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401050151"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="401050151"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:54:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674120577"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674120577"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:54:00 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 00/20] iommu: Retire detach_dev callback
Date:   Mon, 28 Nov 2022 14:46:28 +0800
Message-Id: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
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

Hi folks,

The iommu core calls the driver's detach_dev domain op callback only when
a device is finished assigning to user space and
iommu_group_release_dma_owner() is called to return the device to the
kernel, where iommu core wants to set the default domain to the device but
the driver didn't provide one. The code looks like:

        /*
         * New drivers should support default domains and so the detach_dev() op
         * will never be called. Otherwise the NULL domain represents some
         * platform specific behavior.
         */
        if (!new_domain) {
                if (WARN_ON(!group->domain->ops->detach_dev))
                        return -EINVAL;
                __iommu_group_for_each_dev(group, group->domain,
                                           iommu_group_do_detach_device);
                group->domain = NULL;
                return 0;
        }

In other words, if the iommu driver provides default domains, the
.detach_dev callback will never be called; Otherwise, the .detach_dev
callback is actually called to return control back to the platform DMA
ops, other than detaching the domain from device.

This series cleanups this by:

- If the IOMMU driver provides default domains, remove .detach_dev
  callback.
- Adds a new set_platform_dma iommu op. Any IOMMU driver that doesn't
  provide default domain should implement set_platform_dma callback
  instead.
- Retire .detach_dev callback and rename .attach_dev to .set_dev.

This series originates from various discussion in the community. Thank
Jason, Robin and all others for their ideas. This series looks very
long. It is necessary because I hope that change in each driver has a
confirmation from its stakeholder. I will then be able to merge some of
them to make the series cute.

The whole series is available on github:
https://github.com/LuBaolu/intel-iommu/commits/iommu-retire-detach_dev-v3

Please review and suggest.

Best regards,
baolu

Change log:
v3:
 - Setting blocking domain is not conceptually equal to detach_dev.
   Dropped all blocking domain related staffs in the previous version.

v2:
 - https://lore.kernel.org/linux-iommu/20220826123014.52709-1-baolu.lu@linux.intel.com/
 - Replace .detach_dev callback with static block domain ops;
 - Rename .attach_dev to .set_dev.

v1:
 - https://lore.kernel.org/linux-iommu/20220516015759.2952771-1-baolu.lu@linux.intel.com/

Lu Baolu (20):
  iommu/amd: Remove detach_dev callback
  iommu/apple-dart: Remove detach_dev callback
  iommu/qcom: Remove detach_dev callback
  iommu/exynos: Remove detach_dev callback
  iommu/ipmmu: Remove detach_dev callback
  iommu/mtk: Remove detach_dev callback
  iommu/rockchip: Remove detach_dev callback
  iommu/sprd: Remove detach_dev callback
  iommu/sun50i: Remove detach_dev callback
  iommu: Add set_platform_dma iommu ops
  iommu/fsl_pamu: Add set_platform_dma callback
  iommu/msm: Add set_platform_dma callback
  iommu/mtk_v1: Add set_platform_dma callback
  iommu/omap: Add set_platform_dma callback
  iommu/s390: Add set_platform_dma callback
  iommu/gart: Add set_platform_dma callback
  iommu/tegra: Add set_platform_dma callback
  iommu: Call set_platform_dma if default domain is unavailable
  iommu: Retire detach_dev callback
  iommu: Rename attach_dev to set_dev

 include/linux/iommu.h                       | 10 ++++---
 drivers/iommu/amd/iommu.c                   | 28 +-----------------
 drivers/iommu/apple-dart.c                  | 19 +-----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 25 +---------------
 drivers/iommu/exynos-iommu.c                |  3 +-
 drivers/iommu/fsl_pamu_domain.c             | 12 ++++++--
 drivers/iommu/intel/iommu.c                 |  4 +--
 drivers/iommu/iommu.c                       | 32 +++++++--------------
 drivers/iommu/ipmmu-vmsa.c                  | 18 +-----------
 drivers/iommu/msm_iommu.c                   | 12 ++++++--
 drivers/iommu/mtk_iommu.c                   | 11 +------
 drivers/iommu/mtk_iommu_v1.c                | 12 ++++++--
 drivers/iommu/omap-iommu.c                  | 12 ++++++--
 drivers/iommu/rockchip-iommu.c              |  3 +-
 drivers/iommu/s390-iommu.c                  | 12 ++++++--
 drivers/iommu/sprd-iommu.c                  | 18 +-----------
 drivers/iommu/sun50i-iommu.c                |  3 +-
 drivers/iommu/tegra-gart.c                  | 12 ++++++--
 drivers/iommu/tegra-smmu.c                  | 12 ++++++--
 drivers/iommu/virtio-iommu.c                |  2 +-
 22 files changed, 100 insertions(+), 164 deletions(-)

-- 
2.34.1

