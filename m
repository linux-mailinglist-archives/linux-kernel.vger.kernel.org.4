Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1663E8BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiLAEIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLAEIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:08:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ECD77422
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669867729; x=1701403729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r8ZxO0P+bgikDq55sQqKBRK6c8+nVfCJ+RSELC/xG0I=;
  b=j8CeyG5KAt9cIa5U7ewGh2jzdk9c6AcHHl/jvLGs3CSI2rswVfLix09x
   G7h/gUvh+xy56BYbP6+dwUooftNutv0wwhU80p3loMqFaPWLah5Pwp1Ox
   kxGRfWnIO0JlH92NMbzRpUTvvn5PIFfYWyJE9kSL9WJEacRv7S5GI87yc
   Umb38AlQABx97Sh0t/wHve8WeKFW8t9aIZVnQd/ASslshQYn1an+gDuCh
   D+0IGB7SH1qG1Lbzuy7rwAPwtg+P0FGVPUbdUnejII/ON9UJ8AZhAmEY9
   Y0PPwdAgT5nUSggCjPtmFiNRlbkTL5tmNC0zdN+4AbhkvWyKq7+3F9c3E
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="377745747"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="377745747"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707911656"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="707911656"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2022 20:08:44 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/vt-d: Fix PCI device refcount leak in prq_event_thread()
Date:   Thu,  1 Dec 2022 12:01:25 +0800
Message-Id: <20221201040127.1962750-3-baolu.lu@linux.intel.com>
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

From: Yang Yingliang <yangyingliang@huawei.com>

As comment of pci_get_domain_bus_and_slot() says, it returns a pci device
with refcount increment, when finish using it, the caller must decrease
the reference count by calling pci_dev_put(). So call pci_dev_put() after
using the 'pdev' to avoid refcount leak.

Besides, if the 'pdev' is null or intel_svm_prq_report() returns error,
there is no need to trace this fault.

Fixes: 06f4b8d09dba ("iommu/vt-d: Remove unnecessary SVA data accesses in page fault path")
Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20221119144028.2452731-1-yangyingliang@huawei.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index fe615c53479c..03b25358946c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -748,12 +748,16 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
-		if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, req))
-			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+		if (!pdev)
+			goto bad_req;
 
-		trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
-				 req->priv_data[0], req->priv_data[1],
-				 iommu->prq_seq_number++);
+		if (intel_svm_prq_report(iommu, &pdev->dev, req))
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+		else
+			trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
+					 req->priv_data[0], req->priv_data[1],
+					 iommu->prq_seq_number++);
+		pci_dev_put(pdev);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.34.1

