Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9705F65D3BF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbjADNFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbjADNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:05:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398D0FADF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837524; x=1704373524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rdI/oJ9HW+kmCjRVi5jemUFp00YfbT8GRbCeKCMZrnI=;
  b=bWvIbuLgpKfTYzZneyjzFSzVrYngInKbVq97403KFnehqeNBfCKEZE4u
   pNbCvJ8G4CfK5Qi4BiV0oxdf2vMd7Jo9KYApNCtP4+XJy+Oxd07H5dJSV
   KjvfFtvUl0wzsyNkx53bft/8UJ5KVumedyLOpcEQJ/loOLOU4LWWIzFNm
   dPE+f97OnbeqA0I2aIvtDfpvGTk9szI4Dpz/fnWt7c++vbvoxanmWO0a4
   htmUut570ZQIWkyp4VizMXmUSB9TcJYmpecd/dA6mfqAOzOCR+KV74OdV
   oapgGHf5/RC34KY35ZmS29jcwmgrxRjLzxX656E4+Qi6btmLkt/UACBtq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320639544"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320639544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797528992"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797528992"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:05:15 -0800
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
Subject: [PATCH v4 00/19] iommu: Retire detach_dev callback
Date:   Wed,  4 Jan 2023 20:57:06 +0800
Message-Id: <20230104125725.271850-1-baolu.lu@linux.intel.com>
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
- Retire .detach_dev callback.

This series originates from various discussion in the community. Thank
Jason, Robin and all others for their ideas. This series looks very
long. It is necessary because I hope that change in each driver has a
confirmation from its stakeholder. I will then be able to merge some of
them to make the series cute.

The whole series is available on github:
https://github.com/LuBaolu/intel-iommu/commits/iommu-retire-detach_dev-v4

Please review and suggest.

Change log:
v4:
 - Drop the patch which renamed .attach_dev to .set_dev. As Robin said,
   "... I also wouldn't say that "attach" loses its meaning in a context
   where an equivalent "detach" operation is only ever implicit in 
   reattaching to something else...". If we have a better name in the
   future, we can do it in other series.
 - Adjust the patch of "iommu: Add set_platform_dma_ops iommu ops"
   according to Jason's following suggestion " ... This is a bit ugly,
   it would be better to make the previous patch call set_platform_dma
   if it is set instead of detach_dev and then these patches should just
   rename the driver's fsl_pamu_detach_device to
   fsl_pamu_set_platform_dma ..."
 - Add a new patch to remove deferred attach check from
   __iommu_detach_domain() path. Make it a separate patch as the
   prerequisite to remove __iommu_detach_device() helper.
 - Rename set_platform_dma to set_platform_dma_ops to make it more
   meaningful.

v3:
 - https://lore.kernel.org/linux-iommu/20221128064648.1934720-1-baolu.lu@linux.intel.com/
 - Setting blocking domain is not conceptually equal to detach_dev.
   Dropped all blocking domain related staffs in the previous version.

v2:
 - https://lore.kernel.org/linux-iommu/20220826123014.52709-1-baolu.lu@linux.intel.com/
 - Replace .detach_dev callback with static block domain ops;
 - Rename .attach_dev to .set_dev.

v1:
 - https://lore.kernel.org/linux-iommu/20220516015759.2952771-1-baolu.lu@linux.intel.com/

Jason Gunthorpe (1):
  iommu: Remove deferred attach check from __iommu_detach_device()

Lu Baolu (18):
  iommu/amd: Remove detach_dev callback
  iommu/apple-dart: Remove detach_dev callback
  iommu/qcom: Remove detach_dev callback
  iommu/exynos: Remove detach_dev callback
  iommu/ipmmu: Remove detach_dev callback
  iommu/mtk: Remove detach_dev callback
  iommu/rockchip: Remove detach_dev callback
  iommu/sprd: Remove detach_dev callback
  iommu/sun50i: Remove detach_dev callback
  iommu: Add set_platform_dma_ops iommu ops
  iommu/fsl_pamu: Add set_platform_dma_ops callback
  iommu/msm: Add set_platform_dma_ops callback
  iommu/mtk_v1: Add set_platform_dma_ops callback
  iommu/omap: Add set_platform_dma_ops callback
  iommu/s390: Add set_platform_dma_ops callback
  iommu/gart: Add set_platform_dma_ops callback
  iommu/tegra: Add set_platform_dma_ops callback
  iommu: Remove detach_dev callback

 include/linux/iommu.h                   |  8 +-
 include/trace/events/iommu.h            |  7 --
 drivers/iommu/amd/iommu.c               | 26 -------
 drivers/iommu/apple-dart.c              | 24 ------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 23 ------
 drivers/iommu/exynos-iommu.c            |  1 -
 drivers/iommu/fsl_pamu_domain.c         |  6 +-
 drivers/iommu/iommu-traces.c            |  1 -
 drivers/iommu/iommu.c                   | 98 ++++++++++++-------------
 drivers/iommu/ipmmu-vmsa.c              | 16 ----
 drivers/iommu/msm_iommu.c               |  6 +-
 drivers/iommu/mtk_iommu.c               |  9 ---
 drivers/iommu/mtk_iommu_v1.c            |  4 +-
 drivers/iommu/omap-iommu.c              |  6 +-
 drivers/iommu/rockchip-iommu.c          |  1 -
 drivers/iommu/s390-iommu.c              |  7 +-
 drivers/iommu/sprd-iommu.c              | 16 ----
 drivers/iommu/sun50i-iommu.c            |  1 -
 drivers/iommu/tegra-gart.c              |  6 +-
 drivers/iommu/tegra-smmu.c              |  5 +-
 20 files changed, 73 insertions(+), 198 deletions(-)

-- 
2.34.1

