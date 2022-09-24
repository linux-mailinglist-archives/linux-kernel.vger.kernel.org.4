Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC035E890C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiIXHY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiIXHYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:24:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BBD13D87A;
        Sat, 24 Sep 2022 00:24:18 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MZL521l0sz1P6vJ;
        Sat, 24 Sep 2022 15:20:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 15:24:16 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 2/8] scsi: pm8001: use sas_find_attached_phy() instead of open coded
Date:   Sat, 24 Sep 2022 15:34:49 +0800
Message-ID: <20220924073455.2186805-3-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220924073455.2186805-1-yanaijie@huawei.com>
References: <20220924073455.2186805-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
---
 drivers/scsi/pm8001/pm8001_sas.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 8e3f2f9ddaac..d15a824bcea6 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -645,22 +645,16 @@ static int pm8001_dev_found_notify(struct domain_device *dev)
 	pm8001_device->dcompletion = &completion;
 	if (parent_dev && dev_is_expander(parent_dev->dev_type)) {
 		int phy_id;
-		struct ex_phy *phy;
-		for (phy_id = 0; phy_id < parent_dev->ex_dev.num_phys;
-		phy_id++) {
-			phy = &parent_dev->ex_dev.ex_phy[phy_id];
-			if (SAS_ADDR(phy->attached_sas_addr)
-				== SAS_ADDR(dev->sas_addr)) {
-				pm8001_device->attached_phy = phy_id;
-				break;
-			}
-		}
-		if (phy_id == parent_dev->ex_dev.num_phys) {
+
+		phy_id = sas_find_attached_phy(&parent_dev->ex_dev, dev);
+		if (phy_id == -ENODEV) {
 			pm8001_dbg(pm8001_ha, FAIL,
 				   "Error: no attached dev:%016llx at ex:%016llx.\n",
 				   SAS_ADDR(dev->sas_addr),
 				   SAS_ADDR(parent_dev->sas_addr));
 			res = -1;
+		} else {
+			pm8001_device->attached_phy = phy_id;
 		}
 	} else {
 		if (dev->dev_type == SAS_SATA_DEV) {
-- 
2.31.1

