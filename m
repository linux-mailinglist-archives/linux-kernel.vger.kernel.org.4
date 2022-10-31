Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794A3612E75
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 02:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiJaBGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 21:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaBF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 21:05:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304709FD6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667178359; x=1698714359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1X73YfmmQUgPVTkMfmgPhQcDPYrWQJ589ttQkEztbCE=;
  b=DwxChNKOpXLmnYru/VD1uP2+/DQpXRHuQvPAWLhhqNnl56kgCor4hb49
   c1tNCJInODzYV884dvqVCEOXz6J7ByewDmC9i7BNYRMnazsIq1uUfm1Ga
   XZyBM2MAn90MOg5qc2OD7xXtKhfcBz/PhVYy/I43yc31WVvkB+i1WKXMX
   9G7hJLRk+2KXMPE4uY+IweyNBm0V4/7I+f3hgW36IxHM7wZk5WaFnkK9A
   /6RmjKQw3P2JyFEsVCOmdgDNzpxqaGeLX1lf4OoiVKK7F+WGKX0apyPW4
   yXFySEXOx73uK+0GM4Uv0c3j+E+phkpSl+CHlulOgoBNdCUJ8bwpUbeNm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="373001653"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="373001653"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:05:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="584496108"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="584496108"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2022 18:05:56 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v14 00/13] iommu: SVA and IOPF refactoring
Date:   Mon, 31 Oct 2022 08:59:04 +0800
Message-Id: <20221031005917.45690-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

This is a resent version of v14 which was posted here:
https://lore.kernel.org/linux-iommu/20220924001204.4005613-1-baolu.lu@linux.intel.com/

No further comments since the last post. So I rebased it on the top of
v6.1-rc3 so that you can easily take it for v6.2 if you have interest.

It's purely a rebased version, no functional change. Please refer to
the original post for series description and change history.

This series is also available on github:

https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v14-resend

Please consider it for your iommu tree.

Best regards,
baolu

Lu Baolu (13):
  iommu: Add max_pasids field in struct iommu_device
  iommu: Add max_pasids field in struct dev_iommu
  iommu: Remove SVM_FLAG_SUPERVISOR_MODE support
  PCI: Enable PASID only when ACS RR & UF enabled on upstream path
  iommu: Add attach/detach_dev_pasid iommu interfaces
  iommu: Add IOMMU SVA domain support
  iommu/vt-d: Add SVA domain support
  arm-smmu-v3/sva: Add SVA domain support
  iommu/sva: Refactoring iommu_sva_bind/unbind_device()
  iommu: Remove SVA related callbacks from iommu ops
  iommu: Prepare IOMMU domain for IOPF
  iommu: Per-domain I/O page fault handling
  iommu: Rename iommu-sva-lib.{c,h}

 include/linux/intel-svm.h                     |  13 -
 include/linux/iommu.h                         | 116 ++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  23 +-
 drivers/iommu/intel/iommu.h                   |  18 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |  14 +-
 drivers/dma/idxd/cdev.c                       |   3 +-
 drivers/dma/idxd/init.c                       |  25 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 104 ++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  21 +-
 drivers/iommu/intel/dmar.c                    |   7 +
 drivers/iommu/intel/iommu.c                   |  30 +-
 drivers/iommu/intel/svm.c                     | 145 ++++-----
 drivers/iommu/io-pgfault.c                    |  77 ++---
 drivers/iommu/iommu-sva-lib.c                 |  71 -----
 drivers/iommu/iommu-sva.c                     | 240 +++++++++++++++
 drivers/iommu/iommu.c                         | 277 ++++++++++++------
 drivers/misc/uacce/uacce.c                    |   2 +-
 drivers/pci/ats.c                             |   3 +
 drivers/iommu/Makefile                        |   2 +-
 19 files changed, 732 insertions(+), 459 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (83%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.34.1

