Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA06DD35C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjDKGtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjDKGso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:48:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE99D3C16
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195700; x=1712731700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZpgBJnJOIEMCQ5fkecKmHR/Jc+ND/1NNnUwHTFQSc34=;
  b=UwxdtZEpFqnZ3t4T2I41yiiwRxiSfw081wkfCbpYjj+44i0rAbbvIQca
   aXs8cEOErJYgxu3r3S1lSXkLm8xbZlMezuJBiJbkwck9f5cFuABNv8xpD
   SDFuEGconSq/EfHZZ73orFX6p22j2jLyyu/4I1Ifwq0mSmlPQ3Q2Caale
   FlxrrbCH+z3dg3AkVWoVO+uO/CGlD/NGNzan8HYlNAoa0y4I0u0HYvqqb
   LDRfBYzxkn3XBK7DgidecY+1Bo5LJonWsRxX2h1oBToC1hwafrLOINz9G
   imTGQk/C4h9ZaDfCKAjFKwqMNBcdu7hDclIGOphB6MqZsCq9ajWswZgp2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028487"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028487"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256482"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256482"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:09 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] [PULL REQUEST] Intel IOMMU updates for Linux v6.4
Date:   Tue, 11 Apr 2023 14:47:58 +0800
Message-Id: <20230411064815.31456-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

This includes patches queued for v6.4. They are:

 - Allow the VT-d driver to support non-PRI IOPF
 - Remove PASID supervisor request support
 - Various small and misc cleanups

This series also includes an idxd patch to avoid driver regression after
changes in the IOMMU driver. It has been reviewed by the driver's
maintainers. Please feel free to let me know if it's inappropriate to
route it through the iommu tree.

The whole series is based on v6.3-rc6 and also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.4

Please pull them for x86/vt-d branch.

Best regards,
Baolu

Christophe JAILLET (1):
  iommu/vt-d: Do not use GFP_ATOMIC when not needed

Jacob Pan (2):
  iommu/vt-d: Use non-privileged mode for all PASIDs
  iommu/vt-d: Remove PASID supervisor request support

Lu Baolu (7):
  dmaengine: idxd: Add enable/disable device IOPF feature
  iommu/vt-d: Allow SVA with device-specific IOPF
  iommu/vt-d: Move iopf code from SVA to IOPF enabling path
  iommu/vt-d: Move pfsid and ats_qdep calculation to device probe path
  iommu/vt-d: Move PRI handling to IOPF feature path
  iommu/vt-d: Remove unnecessary checks in iopf disabling path
  iommu/vt-d: Remove extern from function prototypes

Tina Zhang (7):
  iommu/vt-d: Fix operand size in bitwise operation
  iommu/vt-d: Remove BUG_ON on checking valid pfn range
  iommu/vt-d: Remove BUG_ON in handling iotlb cache invalidation
  iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
  iommu/vt-d: Remove BUG_ON in map/unmap()
  iommu/vt-d: Remove a useless BUG_ON(dev->is_virtfn)
  iommu/vt-d: Remove BUG_ON in dmar_insert_dev_scope()

 drivers/iommu/intel/iommu.h         |  36 +++---
 drivers/iommu/intel/pasid.h         |   7 --
 drivers/dma/idxd/init.c             |  31 ++++-
 drivers/iommu/intel/dmar.c          |   7 +-
 drivers/iommu/intel/iommu.c         | 173 +++++++++++++++++-----------
 drivers/iommu/intel/irq_remapping.c |   2 +-
 drivers/iommu/intel/pasid.c         |  43 -------
 7 files changed, 155 insertions(+), 144 deletions(-)

-- 
2.34.1

