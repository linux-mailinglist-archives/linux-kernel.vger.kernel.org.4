Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EBE635CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiKWMWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbiKWMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:21:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D77C3FB89;
        Wed, 23 Nov 2022 04:21:53 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHKrz6K9TzqSX5;
        Wed, 23 Nov 2022 20:17:55 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 20:21:51 +0800
Received: from build.huawei.com (10.175.101.6) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 20:21:50 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "Mike Christie" <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH v3 1/2] scsi: increase scsi device's iodone_cnt in scsi_timeout()
Date:   Wed, 23 Nov 2022 20:21:36 +0800
Message-ID: <20221123122137.150776-2-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221123122137.150776-1-haowenchao@huawei.com>
References: <20221123122137.150776-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an scsi command time out and going to be aborted, we should
increase the iodone_cnt of the related scsi device, or the
iodone_cnt would be less than iorequest_cnt

Increase iodone_cnt in scsi_timeout() would not cause double
accounting issue, briefly analysed as following:

 - we add the iodone_cnt when BLK_EH_DONE would be returned in
   scsi_timeout(), so the related scsi command's timeout event
   would not happened

 - if the abort succeed and do not retry, the command would be done
   with scsi_finish_command() which would not increase iodone_cnt;

 - if the abort succeed and retry the command, it would be requeue,
   a scsi_dispatch_cmd() would be called and iorequest_cnt would be
   increased again

 - if the abort failed, the error handler successfully recover the
   device, do not retry this command, the command would be done
   with scsi_finish_command() which would not increase iodone_cnt;

 - if the abort failed, the error handler successfully recover the
   device, and retry this command, the iorequest_cnt would be
   increased again

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/scsi/scsi_error.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index be2a70c5ac6d..613d5aeb1e3c 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -354,6 +354,7 @@ enum blk_eh_timer_return scsi_timeout(struct request *req)
 	 */
 	if (test_and_set_bit(SCMD_STATE_COMPLETE, &scmd->state))
 		return BLK_EH_DONE;
+	atomic_inc(&scmd->device->iodone_cnt);
 	if (scsi_abort_command(scmd) != SUCCESS) {
 		set_host_byte(scmd, DID_TIME_OUT);
 		scsi_eh_scmd_add(scmd);
-- 
2.32.0

