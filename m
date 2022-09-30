Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121155F0723
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiI3JE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiI3JEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:04:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8432EFEE52;
        Fri, 30 Sep 2022 02:04:03 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mf45z3JZnz6HJG8;
        Fri, 30 Sep 2022 17:03:51 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 11:04:01 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:03:57 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>,
        <yanaijie@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 5/6] scsi: mvsas: Delete mvs_tag_init()
Date:   Fri, 30 Sep 2022 16:56:23 +0800
Message-ID: <1664528184-162714-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
References: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
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

All mvs_tag_init() does is zero the tag bitmap, but this is already done
with the kzalloc() call to alloc the tags, so delete this unneeded
function.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/mvsas/mv_init.c | 2 --
 drivers/scsi/mvsas/mv_sas.c  | 7 -------
 drivers/scsi/mvsas/mv_sas.h  | 1 -
 3 files changed, 10 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 2fde496fff5f..c85fb812ad43 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -286,8 +286,6 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
 	}
 	mvi->tags_num = slot_nr;
 
-	/* Initialize tags */
-	mvs_tag_init(mvi);
 	return 0;
 err_out:
 	return 1;
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index a6867dae0e7c..0810e6c930e1 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -51,13 +51,6 @@ inline int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out)
 	return 0;
 }
 
-void mvs_tag_init(struct mvs_info *mvi)
-{
-	int i;
-	for (i = 0; i < mvi->tags_num; ++i)
-		mvs_tag_clear(mvi, i);
-}
-
 static struct mvs_info *mvs_find_dev_mvi(struct domain_device *dev)
 {
 	unsigned long i = 0, j = 0, hi = 0;
diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
index 509d8f32a04f..fe57665bdb50 100644
--- a/drivers/scsi/mvsas/mv_sas.h
+++ b/drivers/scsi/mvsas/mv_sas.h
@@ -428,7 +428,6 @@ void mvs_tag_clear(struct mvs_info *mvi, u32 tag);
 void mvs_tag_free(struct mvs_info *mvi, u32 tag);
 void mvs_tag_set(struct mvs_info *mvi, unsigned int tag);
 int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out);
-void mvs_tag_init(struct mvs_info *mvi);
 void mvs_iounmap(void __iomem *regs);
 int mvs_ioremap(struct mvs_info *mvi, int bar, int bar_ex);
 void mvs_phys_reset(struct mvs_info *mvi, u32 phy_mask, int hard);
-- 
2.35.3

