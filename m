Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FF962EFB9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiKRIiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbiKRIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:38:31 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955FAE0F7;
        Fri, 18 Nov 2022 00:38:29 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ND97b0wlXzqSYm;
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
Subject: [PATCH for-next 5/5] scsi: libsas: Do not export sas_ata_wait_after_reset()
Date:   Fri, 18 Nov 2022 16:37:14 +0800
Message-ID: <20221118083714.4034612-6-zhanjie9@hisilicon.com>
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

sas_ata_wait_after_reset() does not need to be exported since it is
no longer referenced outside libsas.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_ata.c | 3 +--
 include/scsi/sas_ata.h        | 7 -------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 4b65cd79150f..f7439bf9cdc6 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -383,7 +383,7 @@ static int sas_ata_printk(const char *level, const struct domain_device *ddev,
 	return r;
 }
 
-int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline)
+static int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline)
 {
 	struct sata_device *sata_dev = &dev->sata_dev;
 	int (*check_ready)(struct ata_link *link);
@@ -405,7 +405,6 @@ int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(sas_ata_wait_after_reset);
 
 static int sas_ata_hard_reset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline)
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index e7d466df8157..9c927d46f136 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -35,7 +35,6 @@ void sas_ata_end_eh(struct ata_port *ap);
 void sas_ata_device_link_abort(struct domain_device *dev, bool force_reset);
 int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 			int force_phy_id);
-int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline);
 int smp_ata_check_ready_type(struct ata_link *link);
 #else
 
@@ -100,12 +99,6 @@ static inline int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 	return 0;
 }
 
-static inline int sas_ata_wait_after_reset(struct domain_device *dev,
-					   unsigned long deadline)
-{
-	return -ETIMEDOUT;
-}
-
 static inline int smp_ata_check_ready_type(struct ata_link *link)
 {
 	return 0;
-- 
2.30.0

