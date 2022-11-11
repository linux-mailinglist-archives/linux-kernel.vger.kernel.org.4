Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D2262548F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiKKHoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiKKHoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:44:02 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031EA6B22E;
        Thu, 10 Nov 2022 23:44:00 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N7rL737r7z15MXT;
        Fri, 11 Nov 2022 15:43:43 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 15:43:58 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 15:43:58 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>
CC:     <james.smart@broadcom.com>, <ram.vegesna@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <christophe.jaillet@wanadoo.fr>, <hare@suse.de>, <dwagner@suse.de>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] scsi: efct: Fix possible memleak in efct_device_init()
Date:   Fri, 11 Nov 2022 15:40:46 +0800
Message-ID: <20221111074046.57061-1-chenzhongjin@huawei.com>
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

In efct_device_init(), when efct_scsi_reg_fc_transport() fails,
efct_scsi_tgt_driver_exit() is not called to release memory for
efct_scsi_tgt_driver_init() and causes memleak:

unreferenced object 0xffff8881020ce000 (size 2048):
  comm "modprobe", pid 465, jiffies 4294928222 (age 55.872s)
  backtrace:
    [<0000000021a1ef1b>] kmalloc_trace+0x27/0x110
    [<000000004c3ed51c>] target_register_template+0x4fd/0x7b0 [target_core_mod]
    [<00000000f3393296>] efct_scsi_tgt_driver_init+0x18/0x50 [efct]
    [<00000000115de533>] 0xffffffffc0d90011
    [<00000000d608f646>] do_one_initcall+0xd0/0x4e0
    [<0000000067828cf1>] do_init_module+0x1cc/0x6a0
    ...

Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/scsi/elx/efct/efct_driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/elx/efct/efct_driver.c b/drivers/scsi/elx/efct/efct_driver.c
index b08fc8839808..49fd2cfed70c 100644
--- a/drivers/scsi/elx/efct/efct_driver.c
+++ b/drivers/scsi/elx/efct/efct_driver.c
@@ -42,6 +42,7 @@ efct_device_init(void)
 
 	rc = efct_scsi_reg_fc_transport();
 	if (rc) {
+		efct_scsi_tgt_driver_exit();
 		pr_err("failed to register to FC host\n");
 		return rc;
 	}
-- 
2.17.1

