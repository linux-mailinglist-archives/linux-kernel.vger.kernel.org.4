Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337CA6742A0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjASTUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjASTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:20:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35DC095177
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:19:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80BC01516;
        Thu, 19 Jan 2023 11:19:22 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9C603F67D;
        Thu, 19 Jan 2023 11:18:39 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     hch@lst.de, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        gregkh@linuxfoundation.org
Subject: [PATCH 0/8] iommu: The early demise of bus ops
Date:   Thu, 19 Jan 2023 19:18:18 +0000
Message-Id: <cover.1673978700.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

[ Christoph, Greg, Rafael; feel free to ignore all the IOMMU details,
 just a heads-up for some pretty trivial header motion in patch #6 ]

This is sort of an RFC, in the sense that the patches are functionally
ready but I don't expect that we necessarily want to merge all them
right away; at this point it's more for the sake of visibility and
checking if anyone strongly objects to the direction I'm taking. As such
I've based these patches on 6.2-rc3 and made no effort to integrate them
with the IOMMUFD-related work going on in parallel and/or already
queued, even though there is some functional intersection and almost
certain conflicts. If we reach a consensus that we would like any of
this for 6.3 I'll rebase as appropriate.

Patches #1-6 here work up to what I originally expected to be the
triumphant finale of the whole mission, but as it turns out is actually
feasible and convenient to get out of the way *before* getting into the
really fiddly bits of refactoring the DT/ACPI of_xlate stuff, ARM DMA
ops, and the iommu_domain_alloc() interface. Patch #8 is included here
as the precursor to another cleanup series for drivers that currently
have an awkward domain_finalise step in their .attach_dev op, but I'm
unlikely to start writing those patches for a while yet. Patch #7 is
also here nominally, but in fact I think it could already go anywhere
since the last rework of iommu_device_register().

Thanks,
Robin.


Robin Murphy (8):
  iommu: Decouple iommu_present() from bus ops
  iommu: Validate that devices match domains
  iommu: Factor out a "first device in group" helper
  iommu: Switch __iommu_domain_alloc() to device ops
  iommu/arm-smmu: Don't register fwnode for legacy binding
  iommu: Retire bus ops
  iommu: Clean up open-coded ownership checks
  iommu: Pass device through ops->domain_alloc

 drivers/iommu/amd/iommu.c                   |   3 +-
 drivers/iommu/apple-dart.c                  |   3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   6 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  15 +--
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  19 +--
 drivers/iommu/exynos-iommu.c                |   3 +-
 drivers/iommu/fsl_pamu_domain.c             |   3 +-
 drivers/iommu/intel/iommu.c                 |   3 +-
 drivers/iommu/iommu.c                       | 130 +++++++++++++-------
 drivers/iommu/ipmmu-vmsa.c                  |   3 +-
 drivers/iommu/msm_iommu.c                   |   3 +-
 drivers/iommu/mtk_iommu.c                   |  10 +-
 drivers/iommu/mtk_iommu_v1.c                |   6 +-
 drivers/iommu/omap-iommu.c                  |   3 +-
 drivers/iommu/rockchip-iommu.c              |   3 +-
 drivers/iommu/s390-iommu.c                  |   3 +-
 drivers/iommu/sprd-iommu.c                  |  11 +-
 drivers/iommu/sun50i-iommu.c                |   3 +-
 drivers/iommu/tegra-gart.c                  |   3 +-
 drivers/iommu/tegra-smmu.c                  |   3 +-
 drivers/iommu/virtio-iommu.c                |   6 +-
 include/acpi/acpi_bus.h                     |   2 +
 include/linux/device.h                      |   1 -
 include/linux/device/bus.h                  |   5 -
 include/linux/dma-map-ops.h                 |   1 +
 include/linux/iommu.h                       |   4 +-
 26 files changed, 139 insertions(+), 116 deletions(-)

-- 
2.36.1.dirty

