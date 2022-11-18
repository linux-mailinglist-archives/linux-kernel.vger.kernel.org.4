Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A162EFB6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbiKRIij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiKRIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:38:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F396323;
        Fri, 18 Nov 2022 00:38:26 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ND97Z6pq9zqSYf;
        Fri, 18 Nov 2022 16:34:34 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:38:18 +0800
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
Subject: [PATCH for-next 2/5] Revert "scsi: hisi_sas: Don't send bcast events from HW during nexus HA reset"
Date:   Fri, 18 Nov 2022 16:37:11 +0800
Message-ID: <20221118083714.4034612-3-zhanjie9@hisilicon.com>
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

This reverts commit f5f2a2716055ad8c0c4ff83e51d667646c6c5d8a.

This is now unnecessary to solve the SATA devices missing issue in
hisi_sas_clear_nexus_ha(). Hence, we should not ignore bcast events during
sas_eh_handle_sas_errors() in case of missing bcast events, unless a
justified need is found and a mechanism to defer (but not ignore) bcast
events in sas_eh_handle_sas_errors() is provided.

Also, in hisi_sas_clear_nexus_ha(), there is nothing further to handle in
"out: " other than return, so that part can be reverted.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 4527ac266bb6..62080d0fad6f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1812,14 +1812,12 @@ static int hisi_sas_clear_nexus_ha(struct sas_ha_struct *sas_ha)
 	struct hisi_hba *hisi_hba = sas_ha->lldd_ha;
 	HISI_SAS_DECLARE_RST_WORK_ON_STACK(r);
 	ASYNC_DOMAIN_EXCLUSIVE(async);
-	int i, ret;
+	int i;
 
 	queue_work(hisi_hba->wq, &r.work);
 	wait_for_completion(r.completion);
-	if (!r.done) {
-		ret = TMF_RESP_FUNC_FAILED;
-		goto out;
-	}
+	if (!r.done)
+		return TMF_RESP_FUNC_FAILED;
 
 	for (i = 0; i < HISI_SAS_MAX_DEVICES; i++) {
 		struct hisi_sas_device *sas_dev = &hisi_hba->devices[i];
@@ -1836,9 +1834,7 @@ static int hisi_sas_clear_nexus_ha(struct sas_ha_struct *sas_ha)
 	async_synchronize_full_domain(&async);
 	hisi_sas_release_tasks(hisi_hba);
 
-	ret = TMF_RESP_FUNC_COMPLETE;
-out:
-	return ret;
+	return TMF_RESP_FUNC_COMPLETE;
 }
 
 static int hisi_sas_query_task(struct sas_task *task)
@@ -1986,14 +1982,10 @@ void hisi_sas_phy_bcast(struct hisi_sas_phy *phy)
 {
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
 	struct hisi_hba	*hisi_hba = phy->hisi_hba;
-	struct sas_ha_struct *sha = &hisi_hba->sha;
 
 	if (test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags))
 		return;
 
-	if (test_bit(SAS_HA_FROZEN, &sha->state))
-		return;
-
 	sas_notify_port_event(sas_phy, PORTE_BROADCAST_RCVD, GFP_ATOMIC);
 }
 EXPORT_SYMBOL_GPL(hisi_sas_phy_bcast);
-- 
2.30.0

