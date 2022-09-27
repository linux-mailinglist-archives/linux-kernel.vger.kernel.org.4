Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1D5EB782
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiI0CT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiI0CTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:19:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA6E96762;
        Mon, 26 Sep 2022 19:19:08 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mc3Bz5DxfzpVMy;
        Tue, 27 Sep 2022 10:16:11 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 10:19:05 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jack Wang <jinpu.wang@ionos.com>
Subject: [PATCH v3 4/8] scsi: mvsas: use sas_find_attached_phy() instead of open coded
Date:   Tue, 27 Sep 2022 10:29:37 +0800
Message-ID: <20220927022941.4029476-5-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220927022941.4029476-1-yanaijie@huawei.com>
References: <20220927022941.4029476-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The attached phy finding is open coded. Now we can replace it with
sas_find_attached_phy().

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/scsi/mvsas/mv_sas.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index a6867dae0e7c..f6576ffabe9f 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1190,23 +1190,16 @@ static int mvs_dev_found_notify(struct domain_device *dev, int lock)
 	mvi_device->sas_device = dev;
 	if (parent_dev && dev_is_expander(parent_dev->dev_type)) {
 		int phy_id;
-		u8 phy_num = parent_dev->ex_dev.num_phys;
-		struct ex_phy *phy;
-		for (phy_id = 0; phy_id < phy_num; phy_id++) {
-			phy = &parent_dev->ex_dev.ex_phy[phy_id];
-			if (SAS_ADDR(phy->attached_sas_addr) ==
-				SAS_ADDR(dev->sas_addr)) {
-				mvi_device->attached_phy = phy_id;
-				break;
-			}
-		}
 
-		if (phy_id == phy_num) {
+		phy_id = sas_find_attached_phy(&parent_dev->ex_dev, dev);
+		if (phy_id == -ENODEV) {
 			mv_printk("Error: no attached dev:%016llx"
 				"at ex:%016llx.\n",
 				SAS_ADDR(dev->sas_addr),
 				SAS_ADDR(parent_dev->sas_addr));
 			res = -1;
+		} else {
+			mvi_device->attached_phy = phy_id;
 		}
 	}
 
-- 
2.31.1

