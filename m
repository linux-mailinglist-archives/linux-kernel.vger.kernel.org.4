Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52DE641521
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 10:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiLCJBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 04:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLCJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 04:01:33 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6781117A81
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 01:01:31 -0800 (PST)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NPP0t1dKvz15MPT;
        Sat,  3 Dec 2022 17:00:46 +0800 (CST)
Received: from ci.huawei.com (10.67.175.89) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 3 Dec
 2022 17:01:29 +0800
From:   Cai Xinchen <caixinchen1@huawei.com>
To:     <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        <akpm@linux-foundation.org>, <jakobkoschel@gmail.com>,
        <wangweiyang2@huawei.com>, <jhubbard@nvidia.com>,
        <yangyingliang@huawei.com>, <error27@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] rapidio: devices: Fix missing put_device in mport_cdev_open
Date:   Sat, 3 Dec 2022 08:57:21 +0000
Message-ID: <20221203085721.13146-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.89]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kfifo_alloc fails, the refcount of chdev->dev is left incremental.
We should use put_device(&chdev->dev) to decrease the ref count of
chdev->dev to avoid refcount leak.

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index fecf523f36d8..43db495f1986 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1912,6 +1912,7 @@ static int mport_cdev_open(struct inode *inode, struct file *filp)
 			  sizeof(struct rio_event) * MPORT_EVENT_DEPTH,
 			  GFP_KERNEL);
 	if (ret < 0) {
+		put_device(&chdev->dev);
 		dev_err(&chdev->dev, DRV_NAME ": kfifo_alloc failed\n");
 		ret = -ENOMEM;
 		goto err_fifo;
-- 
2.17.1

