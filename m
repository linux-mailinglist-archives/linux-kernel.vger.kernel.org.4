Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB655ECAB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiI0RYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiI0RYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:24:09 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368BF1D1A73
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1664299448; x=1695835448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e5iFuezd9EwC5nzUcR7QkonorsFzawfkU1PKWLkLgfQ=;
  b=GF804fr8ybFfp1Cn91xJFCCnFIsjfTBpCcJzNEplw9S2IgtQsWjew7f5
   46O5jAPw/lg1wjdop0AqY6aIekwjq4joJEh1BaXOB5CxMLwd01Dnq4XmQ
   2aA8d2o0kYe3LQ1X7qBCTVZvXzOF34tHwK1RBeA0jfNjlOwK3pt9cL3eK
   k=;
X-IronPort-AV: E=Sophos;i="5.93,350,1654560000"; 
   d="scan'208";a="228990471"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-4213ea4c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 17:24:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-4213ea4c.us-west-2.amazon.com (Postfix) with ESMTPS id 757A08143E;
        Tue, 27 Sep 2022 17:24:05 +0000 (UTC)
Received: from EX19D021UWA004.ant.amazon.com (10.13.139.67) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 27 Sep 2022 17:24:05 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D021UWA004.ant.amazon.com (10.13.139.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Tue, 27 Sep 2022 17:24:05 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 27 Sep 2022 17:24:05
 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id EBD5C26F8; Tue, 27 Sep 2022 17:24:04 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC:     <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
        <kbusch@kernel.org>, <mbacco@amazon.com>, <benh@amazon.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>
Subject: [PATCH] nvme-pci: Set min align mask before calculating max_hw_sectors
Date:   Tue, 27 Sep 2022 17:23:54 +0000
Message-ID: <20220927172354.18283-1-risbhat@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If swiotlb is force enabled dma_max_mapping_size ends up calling
swiotlb_max_mapping_size which takes into account the min align
mask for the device.
Set the min align mask for nvme driver before calling
dma_max_mapping_size while calculating max hw sectors.

Fixes: 7637de311bd2 ("nvme-pci: limit max_hw_sectors based on the DMA max
mapping size")
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 98864b853eef..30e71e41a0a2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2834,6 +2834,8 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_start_admin_queue(&dev->ctrl);
 	}
 
+	dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
+
 	/*
 	 * Limit the max command size to prevent iod->sg allocations going
 	 * over a single page.
@@ -2846,7 +2848,6 @@ static void nvme_reset_work(struct work_struct *work)
 	 * Don't limit the IOMMU merged segment size.
 	 */
 	dma_set_max_seg_size(dev->dev, 0xffffffff);
-	dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
 
 	mutex_unlock(&dev->shutdown_lock);
 
-- 
2.37.1

