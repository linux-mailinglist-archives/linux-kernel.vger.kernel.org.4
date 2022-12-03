Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A016412CD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiLCAyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiLCAyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:54:05 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665472E0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670028617; x=1701564617;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9vIXaYbbqArKlbNUcGZT4O2VFsT2UZnPQbUk/fLylKA=;
  b=P6komMzgbJ6EE+TCdD8dNX87ykh7stt9YIltvJhgnfAZZe39duArx24o
   nCybUDPnvE7UVc+0xDeSqcVhMO/Gf6bKlj1psR0vBjQCUvJjSjfj0jUCE
   5Uwp8hEe6Z9HyQ/zogqDHhiKv+dwHqGbUIwf8R+BzPQggC0B0LsuCYy6S
   8KRt6/ykLeiKAQlNWXex1eGe/Nzubz3g2LCDZjtbu4b2A8QwlMKv8ott3
   Vcq7iuo5zuX5dfQjKAMoHwDe1qnRas+B8wMnbGsxJ4b7cC4ieb1+AICHs
   4sGVGcUJscdfvlsz1DevdHlxthtWHdXggXmEqe61sUE/c9ZWtQMM9LUGs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="295769886"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="295769886"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:50:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="708670328"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="708670328"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:50:11 -0800
Date:   Fri, 2 Dec 2022 16:54:05 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.1-rc8
Message-ID: <20221202165405.50be86a6@jacob-builder>
In-Reply-To: <Y4nXu9uBwXZFwjq2@8bytes.org>
References: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
        <Y4nXu9uBwXZFwjq2@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Fri, 2 Dec 2022 11:47:23 +0100, Joerg Roedel <joro@8bytes.org> wrote:

> On Thu, Dec 01, 2022 at 12:01:23PM +0800, Lu Baolu wrote:
> > Jacob Pan (1):
> >   iommu/vt-d: Add a fix for devices need extra dtlb flush
There is a bug in this patch, I will send a fix patch. Or can you squash the
fix below?


From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Date: Fri, 2 Dec 2022 16:22:42 -0800
Subject: [PATCH] iommu/vt-d: Fix buggy QAT device mask

Impacted QAT device IDs that need extra dtlb flush quirk is ranging
from 0x4940 to 0x4943. After bitwise AND device ID with 0xfffc the
result should be 0x4940 instead of 0x494c to identify these devices.

Reported-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d8759f445aff..0b10104c4b99 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1401,7 +1401,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
  * This quirk is exempted from risky_device() check because it applies only
  * to the built-in QAT devices and it doesn't grant additional privileges.
  */
-#define BUGGY_QAT_DEVID_MASK 0x494c
+#define BUGGY_QAT_DEVID_MASK 0x4940
 static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
 {
        if (pdev->vendor != PCI_VENDOR_ID_INTEL)

sorry about that,


Thanks,

Jacob
