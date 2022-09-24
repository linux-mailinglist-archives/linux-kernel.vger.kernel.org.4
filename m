Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA025E8912
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiIXHYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiIXHYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:24:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3253013D867;
        Sat, 24 Sep 2022 00:24:18 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MZL514Ts0z1P6mK;
        Sat, 24 Sep 2022 15:20:05 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 15:24:15 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 1/8] scsi: libsas: introduce sas_find_attached_phy() helper
Date:   Sat, 24 Sep 2022 15:34:48 +0800
Message-ID: <20220924073455.2186805-2-yanaijie@huawei.com>
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

LLDDs are implementing their own attached phy finding code repeatedly.
Factor it out to libsas.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 17 +++++++++++++++++
 include/scsi/libsas.h              |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index fa2209080cc2..a5effff3d1c3 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -2107,6 +2107,23 @@ int sas_ex_revalidate_domain(struct domain_device *port_dev)
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
+		if (SAS_ADDR(phy->attached_sas_addr)
+			== SAS_ADDR(dev->sas_addr))
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

