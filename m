Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1AD5BED7F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiITTTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiITTTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:19:42 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A52D1903E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663701582; x=1695237582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LNbemxru3L2hFlqgo1T4V9ZdsALhlrWUh7qwjPGj19g=;
  b=P7k/O1DE4z31rvUR+e3RoCidFpivMkXRgmR7STICwRq3kRS5o9hLmXOq
   fpyXprPtaLdd7gp4rZXopZiic9uhLmIbbM807LpaJxkVJi+rrrIqiKB/2
   Btzw6OW/yBAyGojhg4I1RrGOPbaQdCPVhYkZlOofzA3wQKvKa0Ws23fvv
   w=;
X-IronPort-AV: E=Sophos;i="5.93,331,1654560000"; 
   d="scan'208";a="261342312"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-90419278.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 19:19:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-90419278.us-west-2.amazon.com (Postfix) with ESMTPS id 2177645A76;
        Tue, 20 Sep 2022 19:19:40 +0000 (UTC)
Received: from EX19D002UWA002.ant.amazon.com (10.13.138.246) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 20 Sep 2022 19:19:35 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D002UWA002.ant.amazon.com (10.13.138.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 20 Sep 2022 19:19:35 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 20 Sep 2022 19:19:34
 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id 6D6402743; Tue, 20 Sep 2022 19:19:33 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC:     <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>,
        <sagi@grimberg.me>, <mbacco@amazon.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>
Subject: [PATCH] nvme-pci: Set min align mask before calculating max_hw_sectors
Date:   Tue, 20 Sep 2022 19:19:32 +0000
Message-ID: <20220920191932.22797-1-risbhat@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

