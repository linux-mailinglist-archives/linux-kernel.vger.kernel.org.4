Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17574A879
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGGBfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGGBe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:34:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD19D1BDB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688693698; x=1720229698;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JAYSCFUQt9c5CCD8SI1JBKYefNqsH+DVavhBCVsUaR4=;
  b=PcI+FqQelUdgIBWEsmFhaOagisQIdlJFKLMgb41KvcR2TPepqNYw38qi
   BKHVDtS7qC+eCMBaZShKJrNVmSlR1qtk8bV+QlRayJUbhG1nrgX5VTV5X
   V2uYEuclv5DRIobNwIPyqSjmOo99RZAC86348FkJm8RUGFL7Sb6+4LifT
   p1TI9x0Ha6UFVZ4XHRBryL+nPUYKs61eU5FpLXTgpT+MV88+qmlMGIlPd
   eYsnB8fPzwvyRjk4Ee8z2PvwfcJeBvtr8J96ExbbmC38ZxOiD9UvTnHsp
   o5fIa93rAtpGfsQhQ8AauaP8bXKtGoSDEUIQEgki/ibGkGepG2NtQI40l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429832232"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429832232"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893791280"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="893791280"
Received: from fengj-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.254.210.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:34:55 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 0/6] Share sva domain with all devices bound to a mm
Date:   Fri,  7 Jul 2023 09:34:35 +0800
Message-Id: <20230707013441.365583-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a sva domain's life time, which begins with binding a device to a
mm and ends by releasing all the bound devices from that mm, there is only
one PASID assigned for this sva domain. From platform perspective,
supporting 1:1 mapping between mm PASID and sva domain allows a sva domain
to be shared by mm's all bound devices issuing DMA transactions using the
assigned PASID.

To support mm PASID 1:1 with sva domain, each mm needs to keep both a
reference of an allocated sva domain and its corresponding PASID. However,
currently, mm struct only has one pasid field for sva usage, which is used
to keep the info of an assigned PASID. That pasid field cannot provide
sufficient info to build up the 1:1 mapping between sva domain and PASID.

This patch-set fills the gap by adding an mm_iommu field[1], whose type is
mm_iommu_data struct, to replace the old pasid field. The introduced
mm_iommu_data struct keeps info of both a sva domain reference and an
assigned PASID.


[1]: https://lore.kernel.org/linux-iommu/ZIBxPd1%2FJCAle6yP@nvidia.com/

Tina Zhang (6):
  iommu: Add two pasid helper functions
  iommu: Call helper functions to get/set assigned pasid value
  iommu: Introduce struct iommu_mm_data
  mm: Add iommu_mm field to mm_struct
  iommu: Support mm PASID 1:1 with sva domain
  mm: Deprecate pasid field

 arch/x86/kernel/traps.c                       |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 ++--
 drivers/iommu/intel/svm.c                     |  8 +--
 drivers/iommu/iommu-sva.c                     | 68 ++++++++++++-------
 drivers/iommu/iommu.c                         |  3 +
 include/linux/iommu.h                         | 25 ++++++-
 include/linux/mm_types.h                      |  2 +
 mm/init-mm.c                                  |  2 +-
 8 files changed, 84 insertions(+), 38 deletions(-)

-- 
2.34.1

