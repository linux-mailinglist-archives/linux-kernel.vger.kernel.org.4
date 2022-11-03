Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A361361767B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKCGAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKCGAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:00:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAF311145
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667455216; x=1698991216;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=41UGF6hDUeNPtHtZtPwjudFO4XGRlRdnfr3EiAL7P6c=;
  b=Dn8O6sczAnzCm0pq4qKvBEZnTmW8qqVATAFOAUniudlKnAy8sh66xAqe
   m+KMRn2IJKWywpt1tJ5gKFBI5SOXktk78aSGu/F3kDoFrj1Kx4EswtWXM
   gFVgZ8e8rAAfmss0hIaE2ugjFopD2qiKBjwB8t5zQ4KQ4ft9AFCUWXlkk
   Kot6XQSKuG33bPfqvJp1svAYNmCht7NYEAxB3Xpd0WoSmLBlxltDskllq
   wJ0DSm2iXiv4DeZtkdUm3GjhYUqV26bGZVe2aur/4PoFHqUz+GcmitKoC
   gTQGxMXa0aurrJi6bGDfm15QTxt12cwdqxnw0jJYP6HIKxdlRSMXSnGxS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="311322478"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="311322478"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 23:00:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723819276"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723819276"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2022 23:00:13 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/7] iommu/vt-d: Some cleanups
Date:   Thu,  3 Nov 2022 13:53:22 +0800
Message-Id: <20221103055329.633052-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Lu Baolu (7):
  iommu/vt-d: Allocate pasid table in device probe path
  iommu/vt-d: Add blocking domain support
  iommu/vt-d: Use device_block_translation() in dev_attach error path
  iommu/vt-d: Fold dmar_remove_one_dev_info() into its caller
  iommu/vt-d: Rename domain_add_dev_info()
  iommu/vt-d: Remove unnecessary domain_context_mapped()
  iommu/vt-d: Use real field for indication of first level

 drivers/iommu/intel/iommu.h |  15 +--
 drivers/iommu/intel/iommu.c | 190 ++++++++++++++++--------------------
 2 files changed, 89 insertions(+), 116 deletions(-)

-- 
2.34.1

