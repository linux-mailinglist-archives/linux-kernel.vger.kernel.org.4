Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E4A626883
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 10:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiKLJbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 04:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiKLJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 04:31:03 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8314A14D1F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 01:31:02 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N8Vg85Vfcz15MY3;
        Sat, 12 Nov 2022 17:30:44 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 17:31:01 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 17:31:00 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux@dominikbrodowski.net>
Subject: [PATCH 2/2] pcmcia: ds: fix possible name leak in error path in pcmcia_device_add()
Date:   Sat, 12 Nov 2022 17:29:24 +0800
Message-ID: <20221112092924.3608240-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221112092924.3608240-1-yangyingliang@huawei.com>
References: <20221112092924.3608240-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Afer commit 1fa5ae857bb1 ("driver core: get rid of struct device's
bus_id string array"), the name of device is allocated dynamically,
it need bee freed.

As comment of device_register() says, it should use put_device() to
give up the reference in the error path, some resources is going to
freed in pcmcia_release_dev(), so don't use error label, just return
NULL after calling put_device().

Before device_initialize(), it can not call put_device(), so move the
dev_set_name() before device_register().

Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pcmcia/ds.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 7d3258a1f8f8..a249d9a0457b 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -513,9 +513,6 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 	/* by default don't allow DMA */
 	p_dev->dma_mask = 0;
 	p_dev->dev.dma_mask = &p_dev->dma_mask;
-	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
-	if (!dev_name(&p_dev->dev))
-		goto err_free;
 	p_dev->devname = kasprintf(GFP_KERNEL, "pcmcia%s", dev_name(&p_dev->dev));
 	if (!p_dev->devname)
 		goto err_free;
@@ -573,8 +570,17 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 
 	pcmcia_device_query(p_dev);
 
-	if (device_register(&p_dev->dev))
+	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
+	if (!dev_name(&p_dev->dev))
 		goto err_put_ref;
+	if (device_register(&p_dev->dev)) {
+		mutex_lock(&s->ops_mutex);
+		list_del(&p_dev->socket_device_list);
+		s->device_count--;
+		mutex_unlock(&s->ops_mutex);
+		put_device(&p_dev->dev);
+		return NULL;
+	}
 
 	return p_dev;
 
-- 
2.25.1

