Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA1620A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiKHHln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiKHHlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508F811173
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893268; x=1699429268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6qOtZq4rvrJXcgDLPt2P44yk74yMTtt98uYccFxHG8k=;
  b=Cdzu5fNjC+1p42wWkEkkCsDvLTmambzA/s7zlWT/Bm17pCJNRwzulml8
   ArmHo95R4z6oODh5gXQgjcdIvws6EuNN0FcgNrmNADO9x2qys3p6LC9LB
   tbGOP2ouLhaSN6PvG3dNLoYVLF+/DEI+LoTbyuFfLZqjTAdGvwG9uvNe7
   9Vo1/KE0uuZNJb7BFZ9JBswTwpGEmzcKXw3StkgicWASAW4lPrajEw66t
   +tLHrcosn+/mOq93/X8c852jBpmFie4igKqAiuxXRjSlP7YSQXSQsM4nM
   OCqadalDOhF0RaCy+hYq/1wFIi4paSozx9SQ2u5OiQG0k/AcDJU5PVlF3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="309339824"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="309339824"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:41:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699821790"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="699821790"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 23:40:59 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/8] iommu/vt-d: Some cleanups
Date:   Tue,  8 Nov 2022 15:34:00 +0800
Message-Id: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
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

Hi,

This series includes some cleanups in the Intel IOMMU implementation
after the IOMMU core implemented the blocking domain. The cleanup work
is mainly in the attach_dev/device_probe/device_release paths.

Please help to review.

Best regards,
baolu

Change log:
v2:
 - Reorder the patches to make the device_block_translation() work with
   the existing path first.
 - Add a new patch to improve iommu_enable_pci_caps().

v1:
 - https://lore.kernel.org/linux-iommu/20221103055329.633052-1-baolu.lu@linux.intel.com/

Lu Baolu (8):
  iommu/vt-d: Allocate pasid table in device probe path
  iommu/vt-d: Improve iommu_enable_pci_caps()
  iommu/vt-d: Add device_block_translation() helper
  iommu/vt-d: Add blocking domain support
  iommu/vt-d: Fold dmar_remove_one_dev_info() into its caller
  iommu/vt-d: Rename domain_add_dev_info()
  iommu/vt-d: Remove unnecessary domain_context_mapped()
  iommu/vt-d: Use real field for indication of first level

 drivers/iommu/intel/iommu.h |  15 +--
 drivers/iommu/intel/iommu.c | 252 +++++++++++++++++++-----------------
 2 files changed, 138 insertions(+), 129 deletions(-)

-- 
2.34.1

