Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7AD69085D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBIMMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjBIMLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:11:18 -0500
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E4161B4;
        Thu,  9 Feb 2023 04:09:29 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 9 Feb
 2023 15:09:26 +0300
Received: from KANASHIN1.fintech.ru (10.0.253.125) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 9 Feb 2023
 15:09:25 +0300
From:   Natalia Petrova <n.petrova@fintech.ru>
To:     Ilya Dryomov <idryomov@gmail.com>
CC:     Natalia Petrova <n.petrova@fintech.ru>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, <ceph-devel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Subject: [PATCH v2] rbd: fix freeing memory of 'rbd_dev->opts', 'rbd_dev->spec', 'rbd_dev->rbd_client'
Date:   Thu, 9 Feb 2023 15:09:23 +0300
Message-ID: <20230209120923.331111-1-n.petrova@fintech.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <06f51bab-42e1-975a-ad4f-6815c2063adb@redhat.com>
References: 
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

If the rbd_dev_create() fails after assignment 'opts' to 'rbd_dev->opts',
double free of 'rbd_options' happens:
one is in rbd_dev_free() and another one is in do_rbd_add().

If the rbd_dev_create() fails, for 'spec' it will be freed in
rbd_dev_create()->rbd_spec_put() first and then in do_rbd_add()
it will call rbd_spec_put() again. The same for 'rbd_client'.
Unlike 'rbd_dev->opts', 'rbd_dev->spec' and 'rbd_dev->rbd_client'
are ref-counted, that's why the ref-count underflow warning
should be generated in rbd_spec_put() and rbd_put_client()
to handle the return values of kref_put().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1643dfa4c2c8 ("rbd: introduce a per-device ordered workqueue")
Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v2: Remarks on the processing of 'rbd_dev->spec' and 'rbd_dev->rbd_client' 
by Ilya Dryomov <idryomov@gmail.com> and Xiubo Li <xiubli@redhat.com> 
were taken into account.
 drivers/block/rbd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 04453f4a319c..f3f253febe0f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -889,8 +889,10 @@ static void rbd_client_release(struct kref *kref)
  */
 static void rbd_put_client(struct rbd_client *rbdc)
 {
-	if (rbdc)
-		kref_put(&rbdc->kref, rbd_client_release);
+	if (rbdc) {
+		if (!kref_put(&rbdc->kref, rbd_client_release))
+			pr_warn("The reference count underflow\n");
+	}
 }
 
 /*
@@ -5225,8 +5227,10 @@ static struct rbd_spec *rbd_spec_get(struct rbd_spec *spec)
 static void rbd_spec_free(struct kref *kref);
 static void rbd_spec_put(struct rbd_spec *spec)
 {
-	if (spec)
-		kref_put(&spec->kref, rbd_spec_free);
+	if (spec) {
+		if (!kref_put(&spec->kref, rbd_spec_free))
+			pr_warn("The reference count underflow\n");
+	}
 }
 
 static struct rbd_spec *rbd_spec_alloc(void)
@@ -5357,7 +5361,6 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 	if (!rbd_dev)
 		return NULL;
 
-	rbd_dev->opts = opts;
 
 	/* get an id and fill in device name */
 	rbd_dev->dev_id = ida_simple_get(&rbd_dev_id_ida, 0,
@@ -5372,6 +5375,7 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 	if (!rbd_dev->task_wq)
 		goto fail_dev_id;
 
+	rbd_dev->opts = opts;
 	/* we have a ref from do_rbd_add() */
 	__module_get(THIS_MODULE);
 
-- 
2.34.1

