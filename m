Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E726179EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiKCJ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiKCJ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:28:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D07010B64;
        Thu,  3 Nov 2022 02:27:22 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N2z1H2Q1jzmVcR;
        Thu,  3 Nov 2022 17:27:15 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 17:27:20 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 17:27:20 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <MPT-FusionLinux.pdl@broadcom.com>,
        <linux-scsi@vger.kernel.org>
CC:     <sathya.prakash@broadcom.com>, <sreekanth.reddy@broadcom.com>,
        <suganath-prabu.subramani@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] mpt3sas: Fix leaked raid template in _mpt3sas_init()
Date:   Thu, 3 Nov 2022 17:24:04 +0800
Message-ID: <20221103092404.192621-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In _mpt3sas_init(), when attaching mpt2sas raid functions template and
fails, mpt3sas template is not released.

raid_class_attach() calls attribute_container_register() and add list
node to attribute_container_list. If it is not unregistered and removed,
when iterating the list in other modules, already released memory
&mpt3sas_raid_functions will be accessed and cause kernel panic:

BUG: unable to handle page fault for address: fffffbfff80dd520
CPU: 0 PID: 390 Comm: modprobe
Hardware name: QEMU Standard PC
RIP: 0010:raid_match+0x65/0x150 [raid_class]
...
Call Trace:
 <TASK>
 attribute_container_add_device+0x124/0x320
 scsi_sysfs_device_initialize+0x421/0x9b0
 scsi_alloc_sdev+0x98b/0xcc0
 scsi_probe_and_add_lun+0x18bf/0x29b0
 ...

Fix it by calling raid_class_release() to release mpt3sas template in
mpt2sas register error path.

Fixes: c84b06a48c4d ("mpt3sas: Single driver module which supports both SAS 2.0 & SAS 3.0 HBAs")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 8e24ebcebfe5..e20929bc3766 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12900,6 +12900,8 @@ _mpt3sas_init(void)
 		mpt2sas_raid_template =
 				raid_class_attach(&mpt2sas_raid_functions);
 		if (!mpt2sas_raid_template) {
+			if (hbas_to_enumerate != 1)
+				raid_class_release(mpt3sas_raid_template);
 			sas_release_transport(mpt3sas_transport_template);
 			return -ENODEV;
 		}
-- 
2.17.1

