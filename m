Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0BD637534
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiKXJb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiKXJb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:31:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED911E714;
        Thu, 24 Nov 2022 01:31:55 -0800 (PST)
Received: from frapeml100006.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NHt3l18nJz6HJbZ;
        Thu, 24 Nov 2022 17:29:07 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (7.191.163.9) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 10:31:53 +0100
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 09:31:52 +0000
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <jejb@linux.ibm.com>
CC:     <martin.petersen@oracle.com>, <damien.lemoal@wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <hukeping@huawei.com>,
        <artem.kuzin@huawei.com>
Subject: [PATCH] scsi:aic94xx: Fix self assignment
Date:   Thu, 24 Nov 2022 17:31:41 +0800
Message-ID: <20221124093141.1677633-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml100001.china.huawei.com (7.188.26.227) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes self assignment of scb->ssp_task.retry_count
in asd_build_ssp_asc() function.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index ed119a3f6f2e..5a588e9f7d0a 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -493,7 +493,7 @@ static int asd_build_ssp_ascb(struct asd_ascb *ascb, struct sas_task *task,
 	scb->ssp_task.conn_handle = cpu_to_le16(
 		(u16)(unsigned long)dev->lldd_dev);
 	scb->ssp_task.data_dir = data_dir_flags[task->data_dir];
-	scb->ssp_task.retry_count = scb->ssp_task.retry_count;
+	scb->ssp_task.retry_count = task->ssp_task.retry_count;
 
 	ascb->tasklet_complete = asd_task_tasklet_complete;
 
-- 
2.25.1

