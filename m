Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45645EB888
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiI0DQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiI0DQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:16:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEE352DC3;
        Mon, 26 Sep 2022 20:15:37 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mc4Qd0bZkz1P6m9;
        Tue, 27 Sep 2022 11:11:21 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 11:15:29 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jack Wang <jinpu.wang@ionos.com>
Subject: [PATCH v4 2/8] scsi: libsas: introduce sas_find_attached_phy() helper
Date:   Tue, 27 Sep 2022 11:25:59 +0800
Message-ID: <20220927032605.78103-3-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220927032605.78103-1-yanaijie@huawei.com>
References: <20220927032605.78103-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLDDs are implementing their own attached phy finding code repeatedly.
Factor it out to libsas.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/libsas/sas_expander.c | 16 ++++++++++++++++
 include/scsi/libsas.h              |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index fa2209080cc2..df5a64ad902f 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -2107,6 +2107,22 @@ int sas_ex_revalidate_domain(struct domain_device *port_dev)
 	return res;
 }
 
+int sas_find_attached_phy(struct expander_device *ex_dev,
+			  struct domain_device *dev)
+{
+	struct ex_phy *phy;
+	int phy_id;
+
+	for (phy_id = 0; phy_id < ex_dev->num_phys; phy_id++) {
+		phy = &ex_dev->ex_phy[phy_id];
+		if (sas_phy_match_dev_addr(dev, phy))
+			return phy_id;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(sas_find_attached_phy);
+
 void sas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 		struct sas_rphy *rphy)
 {
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 2dbead74a2af..75faf2308eae 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -750,6 +750,8 @@ int sas_clear_task_set(struct domain_device *dev, u8 *lun);
 int sas_lu_reset(struct domain_device *dev, u8 *lun);
 int sas_query_task(struct sas_task *task, u16 tag);
 int sas_abort_task(struct sas_task *task, u16 tag);
+int sas_find_attached_phy(struct expander_device *ex_dev,
+			  struct domain_device *dev);
 
 void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 			   gfp_t gfp_flags);
-- 
2.31.1

