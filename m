Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC908689B4F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjBCOQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjBCOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:16:03 -0500
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2891F5F5;
        Fri,  3 Feb 2023 06:15:19 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 3 Feb
 2023 17:15:17 +0300
Received: from KANASHIN1.fintech.ru (10.0.253.125) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 3 Feb 2023
 17:15:17 +0300
From:   Natalia Petrova <n.petrova@fintech.ru>
To:     Ilya Dryomov <idryomov@gmail.com>
CC:     Natalia Petrova <n.petrova@fintech.ru>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, <ceph-devel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>
Subject: [PATCH] rbd: avoid double free memory on error path in rbd_dev_create()
Date:   Fri, 3 Feb 2023 17:15:15 +0300
Message-ID: <20230203141515.125205-1-n.petrova@fintech.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.125]
X-ClientProxiedBy: Ex16-01.fintech.ru (10.0.10.18) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rbd_dev_create() fails after assignment 'opts' to 'rbd_dev->opts',
double free of 'rbd_options' happens:
one is in rbd_dev_free() and another one is in do_rbd_add().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1643dfa4c2c8 ("rbd: introduce a per-device ordered workqueue")
Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 04453f4a319c..ab6bfc352cde 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5357,7 +5357,6 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 	if (!rbd_dev)
 		return NULL;
 
-	rbd_dev->opts = opts;
 
 	/* get an id and fill in device name */
 	rbd_dev->dev_id = ida_simple_get(&rbd_dev_id_ida, 0,
@@ -5372,6 +5371,7 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 	if (!rbd_dev->task_wq)
 		goto fail_dev_id;
 
+	rbd_dev->opts = opts;
 	/* we have a ref from do_rbd_add() */
 	__module_get(THIS_MODULE);
 
-- 
2.34.1

