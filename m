Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C596273FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiKNBAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiKNBAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:00:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5752ADEDA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:00:51 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9WFK0BbnzHvqv;
        Mon, 14 Nov 2022 09:00:21 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 14 Nov
 2022 09:00:49 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <akpm@linux-foundation.org>, <paulkf@microgate.com>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH] tty: synclink_gt: release resources when synclink_gt driver open failed
Date:   Mon, 14 Nov 2022 09:07:34 +0800
Message-ID: <20221114010734.314910-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When synclink_gt driver open failed, it doesn't release resources. Compile
tested only.

Fixes: d4c63b7c7450 ("synclink_gt fix module reference")
Fixes: 705b6c7b34f2 ("[PATCH] new driver synclink_gt")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/tty/synclink_gt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 25e9befdda3a..4dea52486410 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1441,14 +1441,15 @@ static int hdlcdev_open(struct net_device *dev)
 	/* generic HDLC layer open processing */
 	rc = hdlc_open(dev);
 	if (rc)
-		return rc;
+		goto err_open;
 
 	/* arbitrate between network and tty opens */
 	spin_lock_irqsave(&info->netlock, flags);
 	if (info->port.count != 0 || info->netcount != 0) {
 		DBGINFO(("%s hdlc_open busy\n", dev->name));
 		spin_unlock_irqrestore(&info->netlock, flags);
-		return -EBUSY;
+		rc = -EBUSY;
+		goto err_open_busy;
 	}
 	info->netcount=1;
 	spin_unlock_irqrestore(&info->netlock, flags);
@@ -1458,7 +1459,7 @@ static int hdlcdev_open(struct net_device *dev)
 		spin_lock_irqsave(&info->netlock, flags);
 		info->netcount=0;
 		spin_unlock_irqrestore(&info->netlock, flags);
-		return rc;
+		goto err_open_busy;
 	}
 
 	/* assert RTS and DTR, apply hardware settings */
@@ -1478,6 +1479,12 @@ static int hdlcdev_open(struct net_device *dev)
 	else
 		netif_carrier_off(dev);
 	return 0;
+
+err_open_busy:
+	hdlc_close(dev);
+err_open:
+	module_put(THIS_MODULE);
+	return rc;
 }
 
 /**
-- 
2.17.1

