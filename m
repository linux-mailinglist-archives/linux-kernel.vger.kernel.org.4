Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512C06E05AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDMEGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDMEGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:06:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0C15B88
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358804; x=1712894804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s73Dwcw/j+M9Z+7wT2sD+XtVqUA+ffONLeb/NudPzz8=;
  b=gF431WTOQLtv4icy0snUZ0/hjeZBM7/y57UWJKLJfF9iNxLh/xaFCWpq
   8qW9cDaoSOQ5br/zR/qKqRZXuca8hDNjtt0VeBbo468CyW+mShePTIPVE
   4DKOObgY5w5fPKENDm1fgBro8Pkn8aldBVogk+Nr58iErcMcM4iYOqo6Z
   OD+rKmhnfuF2eks5tGqCXnNgBJXUbmniIn+vTnOXkYZWQoeFeyIq8hXKy
   8nfBMJxxN0FLI2SakeXV+IPxhMt89hGlI8SZd/bv5CITqQDD7P8vSwIuD
   jtJjHkAmm/w+JgR8zkXHzngXKHBB3gSekdC1niDX/ZojyF7WO7L0UvAIw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323702318"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323702318"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935360955"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935360955"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:06:42 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/17] [PULL REQUEST] Intel IOMMU updates for Linux v6.4
Date:   Thu, 13 Apr 2023 12:06:28 +0800
Message-Id: <20230413040645.46157-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
changes in the IOMMU driver. It has been reviewed and acked by the
maintainers.

The whole series is based on v6.3-rc6 and also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.4

Please pull them for x86/vt-d branch.

Best regards,
Baolu

Change log:
 - v2:
   - Avoid using "fix" wording in the commit message of a cleanup patch,
     no functional change. [David Laight]
   - Add Acked-by from Vinod Koul to the idxd patch.

 - v1: https://lore.kernel.org/linux-iommu/20230411064815.31456-1-baolu.lu@linux.intel.com/

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
  iommu/vt-d: Make size of operands same in bitwise operations
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

