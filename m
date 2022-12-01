Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E03E63E8C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLAEJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiLAEIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:08:52 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8885E77422
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669867731; x=1701403731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yXwiYNvS9neESZJSKR531+MusOXMqiOrzDRp1zDx7kM=;
  b=aZZq9ES/lwJnKG8Rm8qMtCMnO8l/9QX5s/8rrHCf/1UiQmOJNGTUs3nh
   GWvJLfRE3QpQDdJHIGw9PrMsIoOrHvHmQbkjJbzbB3IjyeQTTlHrnpyu3
   a6musvFkqH/jmAkDaaJ3hpOToAz5vUMSXXOrDS1BW5xmMpQXJYao/ORXF
   PMVb0c5Pn/7Xj1WJpv0AIST/iakYUvSeU4sDOnPlnYunLcjTWXH3hTk22
   MfmHJ8rMl5AFmD5Oew6eSFNMmUT7XDTTPqTM5p/qDTmgmnrOy9nMA1R//
   buRmTK5X0IqamNmMrBx+jceKtxKU2nB8htH/NhcSXku435wMz25S03dT8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="377745765"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="377745765"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:08:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707911661"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="707911661"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2022 20:08:48 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iommu/vt-d: Fix PCI device refcount leak in dmar_dev_scope_init()
Date:   Thu,  1 Dec 2022 12:01:27 +0800
Message-Id: <20221201040127.1962750-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
References: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
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

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

for_each_pci_dev() is implemented by pci_get_device(). The comment of
pci_get_device() says that it will increase the reference count for the
returned pci_dev and also decrease the reference count for the input
pci_dev @from if it is not NULL.

If we break for_each_pci_dev() loop with pdev not NULL, we need to call
pci_dev_put() to decrease the reference count. Add the missing
pci_dev_put() for the error path to avoid reference count leak.

Fixes: 2e4552893038 ("iommu/vt-d: Unify the way to process DMAR device scope array")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Link: https://lore.kernel.org/r/20221121113649.190393-3-wangxiongfeng2@huawei.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 5a8f780e7ffd..bc94059a5b87 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -820,6 +820,7 @@ int __init dmar_dev_scope_init(void)
 			info = dmar_alloc_pci_notify_info(dev,
 					BUS_NOTIFY_ADD_DEVICE);
 			if (!info) {
+				pci_dev_put(dev);
 				return dmar_dev_scope_status;
 			} else {
 				dmar_pci_bus_add_dev(info);
-- 
2.34.1

