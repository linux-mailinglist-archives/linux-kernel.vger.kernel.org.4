Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CB562EFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbiKRIim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiKRIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:38:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B526324;
        Fri, 18 Nov 2022 00:38:26 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ND97b06YGzqSYh;
        Fri, 18 Nov 2022 16:34:35 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:38:19 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:38:18 +0800
From:   Jie Zhan <zhanjie9@hisilicon.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <chenxiang66@hisilicon.com>, <john.g.garry@oracle.com>,
        <damien.lemoal@opensource.wdc.com>, <yanaijie@huawei.com>,
        <johannes.thumshirn@wdc.com>, <duoming@zju.edu.cn>,
        <zhanjie9@hisilicon.com>, <liyihang9@huawei.com>,
        <yangxingui@huawei.com>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH for-next 3/5] scsi: libsas: Add smp_ata_check_ready_type()
Date:   Fri, 18 Nov 2022 16:37:12 +0800
Message-ID: <20221118083714.4034612-4-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221118083714.4034612-1-zhanjie9@hisilicon.com>
References: <20221118083714.4034612-1-zhanjie9@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create function smp_ata_check_ready_type() for lldds to wait for
SATA devices to come up after a link reset.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/scsi/libsas/sas_ata.c      | 25 +++++++++++++++++++++++++
 drivers/scsi/libsas/sas_expander.c |  4 ++--
 drivers/scsi/libsas/sas_internal.h |  2 ++
 include/scsi/sas_ata.h             |  6 ++++++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 78e6046fb55a..4b65cd79150f 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -287,6 +287,31 @@ static int sas_ata_clear_pending(struct domain_device *dev, struct ex_phy *phy)
 		return 1;
 }
 
+int smp_ata_check_ready_type(struct ata_link *link)
+{
+	struct domain_device *dev = link->ap->private_data;
+	struct sas_phy *phy = sas_get_local_phy(dev);
+	struct domain_device *ex_dev = dev->parent;
+	enum sas_device_type type = SAS_PHY_UNUSED;
+	u8 sas_addr[SAS_ADDR_SIZE];
+	int res;
+
+	res = sas_get_phy_attached_dev(ex_dev, phy->number, sas_addr, &type);
+	sas_put_local_phy(phy);
+	if (res)
+		return res;
+
+	switch (type) {
+	case SAS_SATA_PENDING:
+		return 0;
+	case SAS_END_DEVICE:
+		return 1;
+	default:
+		return -ENODEV;
+	}
+}
+EXPORT_SYMBOL_GPL(smp_ata_check_ready_type);
+
 static int smp_ata_check_ready(struct ata_link *link)
 {
 	int res;
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 2907ca5d0ed4..a04cad620e93 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1688,8 +1688,8 @@ static int sas_get_phy_change_count(struct domain_device *dev,
 	return res;
 }
 
-static int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
-				    u8 *sas_addr, enum sas_device_type *type)
+int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
+			     u8 *sas_addr, enum sas_device_type *type)
 {
 	int res;
 	struct smp_disc_resp *disc_resp;
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 6cf190ade35e..6f593fa69b58 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -88,6 +88,8 @@ struct domain_device *sas_ex_to_ata(struct domain_device *ex_dev, int phy_id);
 int sas_ex_phy_discover(struct domain_device *dev, int single);
 int sas_get_report_phy_sata(struct domain_device *dev, int phy_id,
 			    struct smp_rps_resp *rps_resp);
+int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
+			     u8 *sas_addr, enum sas_device_type *type);
 int sas_try_ata_reset(struct asd_sas_phy *phy);
 void sas_hae_reset(struct work_struct *work);
 
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index e47f0aec0722..e7d466df8157 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -36,6 +36,7 @@ void sas_ata_device_link_abort(struct domain_device *dev, bool force_reset);
 int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 			int force_phy_id);
 int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline);
+int smp_ata_check_ready_type(struct ata_link *link);
 #else
 
 
@@ -104,6 +105,11 @@ static inline int sas_ata_wait_after_reset(struct domain_device *dev,
 {
 	return -ETIMEDOUT;
 }
+
+static inline int smp_ata_check_ready_type(struct ata_link *link)
+{
+	return 0;
+}
 #endif
 
 #endif /* _SAS_ATA_H_ */
-- 
2.30.0

