Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEBB62D0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiKQBvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiKQBvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:51:10 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CBF6A77D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:51:06 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NCND15620zmW3c;
        Thu, 17 Nov 2022 09:50:41 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 09:51:04 +0800
Received: from octopus.huawei.com (10.67.174.191) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 09:51:04 +0800
From:   Wang Weiyang <wangweiyang2@huawei.com>
To:     <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        <akpm@linux-foundation.org>, <yangyingliang@huawei.com>,
        <jakobkoschel@gmail.com>, <jhubbard@nvidia.com>,
        <error27@gmail.com>, <wangweiyang2@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] rapidio: fix possible UAF when kfifo_alloc() fails
Date:   Thu, 17 Nov 2022 10:18:02 +0800
Message-ID: <20221117021802.46872-1-wangweiyang2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kfifo_alloc() fails in mport_cdev_open(), goto err_fifo and just free
priv. But priv is still in the chdev->file_list, then list traversal
may cause UAF. This fixes the following smatch warning:

drivers/rapidio/devices/rio_mport_cdev.c:1930 mport_cdev_open() warn: '&priv->list' not removed from list

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 3cc83997a1f8..c66b2c552b38 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1930,6 +1930,9 @@ static int mport_cdev_open(struct inode *inode, struct file *filp)
 	filp->private_data = priv;
 	goto out;
 err_fifo:
+	mutex_lock(&chdev->file_mutex);
+	list_del(&priv->list);
+	mutex_unlock(&chdev->file_mutex);
 	kfree(priv);
 out:
 	return ret;
-- 
2.17.1

