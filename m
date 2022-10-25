Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A160C8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiJYJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiJYJtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:49:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC114D1CC;
        Tue, 25 Oct 2022 02:48:24 -0700 (PDT)
Received: from frapeml500008.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRtF5LLwz67vyB;
        Tue, 25 Oct 2022 17:47:01 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:48:22 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:48:18 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 07/22] scsi: libsas: Notify LLDD expander found before calling sas_rphy_add()
Date:   Tue, 25 Oct 2022 18:18:01 +0800
Message-ID: <1666693096-180008-8-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that we notify the LLDD of the expander being found before calling
sas_rphy_add() as this function will require the LLDD be notified when
we alloc a scsi device for an expander.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 9e33014ec412..e7cb95683522 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -976,9 +976,12 @@ static struct domain_device *sas_ex_discover_expander(
 					   edev->level);
 	sas_init_dev(child);
 
+	if (!sas_notify_lldd_dev_found(child))
+		goto err_rphy_free;
+
 	sas_fill_in_rphy(child, rphy);
 	if (!sas_rphy_add(rphy))
-		goto err_rphy_free;
+		goto err_dev_gone;
 
 	spin_lock_irq(&parent->port->dev_list_lock);
 	list_add_tail(&child->dev_list_node, &parent->port->dev_list);
@@ -995,6 +998,8 @@ static struct domain_device *sas_ex_discover_expander(
 	list_del(&child->dev_list_node);
 	spin_unlock_irq(&parent->port->dev_list_lock);
 	sas_rphy_remove(rphy);
+err_dev_gone:
+	sas_notify_lldd_dev_gone(child);
 err_rphy_free:
 	sas_rphy_free(rphy);
 err_free_port:
@@ -1575,32 +1580,22 @@ static int sas_discover_expander(struct domain_device *dev)
 {
 	int res;
 
-	res = sas_notify_lldd_dev_found(dev);
-	if (res)
-		return res;
-
 	res = sas_ex_general(dev);
 	if (res)
-		goto out_err;
+		return res;
 	res = sas_ex_manuf_info(dev);
 	if (res)
-		goto out_err;
+		return res;
 
 	res = sas_expander_discover(dev);
 	if (res) {
 		pr_warn("expander %016llx discovery failed(0x%x)\n",
 			SAS_ADDR(dev->sas_addr), res);
-		goto out_err;
+		return res;
 	}
 
 	sas_check_ex_subtractive_boundary(dev);
-	res = sas_check_parent_topology(dev);
-	if (res)
-		goto out_err;
-	return 0;
-out_err:
-	sas_notify_lldd_dev_gone(dev);
-	return res;
+	return sas_check_parent_topology(dev);
 }
 
 static int sas_ex_level_discovery(struct asd_sas_port *port, const int level)
@@ -1643,6 +1638,10 @@ int sas_discover_root_expander(struct domain_device *dev)
 	int res;
 	struct sas_expander_device *ex = rphy_to_expander_device(dev->rphy);
 
+	res = sas_notify_lldd_dev_found(dev);
+	if (res)
+		return res;
+
 	res = sas_rphy_add(dev->rphy);
 	if (res)
 		goto out_err;
@@ -1659,6 +1658,7 @@ int sas_discover_root_expander(struct domain_device *dev)
 out_err2:
 	sas_rphy_remove(dev->rphy);
 out_err:
+	sas_notify_lldd_dev_gone(dev);
 	return res;
 }
 
-- 
2.35.3

