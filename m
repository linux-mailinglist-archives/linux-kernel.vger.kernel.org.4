Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5E6283D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiKNP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbiKNP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:28:12 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4F721833
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:28:08 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N9tQz3x3pzJnj3;
        Mon, 14 Nov 2022 23:24:59 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 23:28:06 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 14 Nov
 2022 23:28:05 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        <akpm@linux-foundation.org>
Subject: [PATCH 1/2] rapidio: fix possible name leaks when rio_add_device() fails
Date:   Mon, 14 Nov 2022 23:26:35 +0800
Message-ID: <20221114152636.2939035-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114152636.2939035-1-yangyingliang@huawei.com>
References: <20221114152636.2939035-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rio_add_device() returns error, the name allocated by
dev_set_name() need be freed. It should use put_device()
to give up the reference in the error path, so that the
name can be freed in kobject_cleanup(), and the 'rdev' can
be freed in rio_release_dev().

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 7 +++++--
 drivers/rapidio/rio-scan.c               | 8 ++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 683457d8cb65..1170c0a66d21 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1804,8 +1804,11 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
 		rio_init_dbell_res(&rdev->riores[RIO_DOORBELL_RESOURCE],
 				   0, 0xffff);
 	err = rio_add_device(rdev);
-	if (err)
-		goto cleanup;
+	if (err) {
+		put_device(&rdev->dev);
+		return err;
+	}
+
 	rio_dev_get(rdev);
 
 	return 0;
diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 2350c0cb2329..03615eb2d3d7 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -454,8 +454,12 @@ static struct rio_dev *rio_setup_device(struct rio_net *net,
 				   0, 0xffff);
 
 	ret = rio_add_device(rdev);
-	if (ret)
-		goto cleanup;
+	if (ret) {
+		if (rswitch)
+			kfree(rswitch->route_table);
+		put_device(&rdev->dev);
+		return NULL;
+	}
 
 	rio_dev_get(rdev);
 
-- 
2.25.1

