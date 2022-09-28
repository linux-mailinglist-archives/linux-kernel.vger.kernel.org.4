Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC445EDCD3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiI1MeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiI1MeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:34:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179A9C7C4;
        Wed, 28 Sep 2022 05:33:58 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mcwpt1crfz67MLY;
        Wed, 28 Sep 2022 20:31:50 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:33:56 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 13:33:53 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/6] scsi: pm8001: Remove pm8001_tag_init()
Date:   Wed, 28 Sep 2022 20:27:11 +0800
Message-ID: <1664368034-114991-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

From: Igor Pylypiv <ipylypiv@google.com>

In commit 5a141315ed7c ("scsi: pm80xx: Increase the number of outstanding
I/O supported to 1024") the pm8001_ha->tags allocation was moved into
pm8001_init_ccb_tag(). This changed the execution order of allocation.
pm8001_tag_init() used to be called after the pm8001_ha->tags allocation
and now it is called before the allocation.

Before:

pm8001_pci_probe()
`--> pm8001_pci_alloc()
     `--> pm8001_alloc()
          `--> pm8001_ha->tags = kzalloc(...)
          `--> pm8001_tag_init(pm8001_ha); // OK: tags are allocated

After:

pm8001_pci_probe()
`--> pm8001_pci_alloc()
|    `--> pm8001_alloc()
|         `--> pm8001_tag_init(pm8001_ha); // NOK: tags are not allocated
|
`--> pm8001_init_ccb_tag()
     `-->  pm8001_ha->tags = kzalloc(...) // today it is bitmap_zalloc()

Since pm8001_ha->tags_num is zero when pm8001_tag_init() is called it does
nothing. Tags memory is allocated with bitmap_zalloc() so there is no need
to manually clear each bit with pm8001_tag_free().

Reviewed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 2 --
 drivers/scsi/pm8001/pm8001_sas.c  | 7 -------
 drivers/scsi/pm8001/pm8001_sas.h  | 1 -
 3 files changed, 10 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index a0028e130a7e..0edc9857a8bd 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -436,8 +436,6 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
 		atomic_set(&pm8001_ha->devices[i].running_req, 0);
 	}
 	pm8001_ha->flags = PM8001F_INIT_TIME;
-	/* Initialize tags */
-	pm8001_tag_init(pm8001_ha);
 	return 0;
 
 err_out_nodev:
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index d5ec29f69be3..066dfa9f4683 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -96,13 +96,6 @@ int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
 	return 0;
 }
 
-void pm8001_tag_init(struct pm8001_hba_info *pm8001_ha)
-{
-	int i;
-	for (i = 0; i < pm8001_ha->tags_num; ++i)
-		pm8001_tag_free(pm8001_ha, i);
-}
-
 /**
  * pm8001_mem_alloc - allocate memory for pm8001.
  * @pdev: pci device.
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 8ab0654327f9..9acaadf02150 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -632,7 +632,6 @@ extern struct workqueue_struct *pm8001_wq;
 
 /******************** function prototype *********************/
 int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out);
-void pm8001_tag_init(struct pm8001_hba_info *pm8001_ha);
 u32 pm8001_get_ncq_tag(struct sas_task *task, u32 *tag);
 void pm8001_ccb_task_free(struct pm8001_hba_info *pm8001_ha,
 			  struct pm8001_ccb_info *ccb);
-- 
2.35.3

