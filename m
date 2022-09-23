Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF315E70D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiIWAsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIWAsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:48:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39601129CB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663894084; x=1695430084;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D66fqEUBroJKd+9d6VDZZucMlLgMXnXc4WPgDREMliU=;
  b=VsCRYDGASuerarmsSBkjxY8Gcvwgi9mEyBtd8/wDxu+HOIguHMCX2zeF
   dRpXKsATQInrtJ8babKO+znC+PPfuPtBpN6aVl12rDV9YYcYZK5SQw7a2
   u23Y9NzRIjGrB9yV2t0H7uvMc4kPn3HGQyD0h25oSeRlPaDZWY4NpNiOq
   ew5OaPbT+swMWZU4nUiQcYbYu3KLd5tfoNDJ3YcG08yLSdw44Ap5XakSP
   dj9srF4/Esr2I/xhq14Ly4CevixKOS0DO2UFA7Rwg7uCXBp5A/omdSXZr
   15cROeHvumklb5lgY7iyq+UaIIBaz/URAx140z+hxgtwfuNMO0oHqSzqo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362278837"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362278837"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650759929"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 17:48:02 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for Linux v6.1
Date:   Fri, 23 Sep 2022 08:42:00 +0800
Message-Id: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
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

Hi Joerg,

This includes patches queued for v6.1. It includes:

 - Decouple PASID and PRI from SVA
 - Add ESRTPS & ESIRTPS capability check
 - Cleanups

The whole series is also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.1

Please consider them for next.

Best regards,
Baolu

Lu Baolu (5):
  iommu/vt-d: Remove unnecessary SVA data accesses in page fault path
  iommu/vt-d: Decouple PASID & PRI enabling from SVA
  iommu/vt-d: Remove pasid_set_eafe()
  iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
  iommu/vt-d: Avoid unnecessary global DMA cache invalidation

Yi Liu (1):
  iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support

 drivers/iommu/intel/iommu.h         |  7 ++-
 drivers/iommu/intel/cap_audit.c     |  4 +-
 drivers/iommu/intel/iommu.c         | 87 ++++++++---------------------
 drivers/iommu/intel/irq_remapping.c |  6 +-
 drivers/iommu/intel/pasid.c         | 12 +---
 drivers/iommu/intel/svm.c           | 62 +++-----------------
 drivers/iommu/intel/Kconfig         |  5 +-
 7 files changed, 45 insertions(+), 138 deletions(-)

-- 
2.34.1

