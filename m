Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604417326E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbjFPFxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbjFPFxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:53:06 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703E82D59
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:53:03 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8532E1A068F;
        Fri, 16 Jun 2023 07:43:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 234031A249B;
        Fri, 16 Jun 2023 07:43:09 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BC8CF181D0C0;
        Fri, 16 Jun 2023 13:43:07 +0800 (+08)
From:   Alison Wang <alison.wang@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com, Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 8/8] ethosu: Add rwlock when alloc and remove msg id
Date:   Fri, 16 Jun 2023 13:59:13 +0800
Message-Id: <20230616055913.2360-9-alison.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616055913.2360-1-alison.wang@nxp.com>
References: <20230616055913.2360-1-alison.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msg id will be removed unpredictable when one thread calls
ethosu_rpmsg_register and another thread calls ethosu_rpmsg_deregister
at the same time. This patch adds write_lock in
ethosu_rpmsg_register/ethosu_rpmsg_deregister and adds read_lcok in
ethosu_rpmsg_find.

Signed-off-by: Feng Guo <feng.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/ethosu/ethosu_driver.c |  2 +-
 drivers/firmware/ethosu/ethosu_rpmsg.c  | 20 ++++++++++++++------
 drivers/firmware/ethosu/ethosu_rpmsg.h  |  1 +
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/ethosu/ethosu_driver.c b/drivers/firmware/ethosu/ethosu_driver.c
index 59ae79256564..0742564cfaf2 100644
--- a/drivers/firmware/ethosu/ethosu_driver.c
+++ b/drivers/firmware/ethosu/ethosu_driver.c
@@ -155,7 +155,7 @@ static int __init ethosu_init(void)
 {
 	int ret;
 
-	ethosu_class = class_create(THIS_MODULE, ETHOSU_DRIVER_NAME);
+	ethosu_class = class_create(ETHOSU_DRIVER_NAME);
 	if (IS_ERR(ethosu_class)) {
 		printk("Failed to create class '%s'.\n", ETHOSU_DRIVER_NAME);
 
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.c b/drivers/firmware/ethosu/ethosu_rpmsg.c
index 351a1046e65e..d3e597e82762 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.c
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.c
@@ -35,7 +35,9 @@ static void ethosu_core_set_capacity(struct ethosu_buffer *buf,
 int ethosu_rpmsg_register(struct ethosu_rpmsg *erp,
 			  struct ethosu_rpmsg_msg *msg)
 {
+	write_lock(&erp->lock);
 	msg->id = idr_alloc_cyclic(&erp->msg_idr, msg, 0, INT_MAX, GFP_KERNEL);
+	write_unlock(&erp->lock);
 	if (msg->id < 0)
 		return msg->id;
 
@@ -45,14 +47,19 @@ int ethosu_rpmsg_register(struct ethosu_rpmsg *erp,
 void ethosu_rpmsg_deregister(struct ethosu_rpmsg *erp,
 			     struct ethosu_rpmsg_msg *msg)
 {
+	write_lock(&erp->lock);
 	idr_remove(&erp->msg_idr, msg->id);
+	write_unlock(&erp->lock);
 }
 
 struct ethosu_rpmsg_msg *ethosu_rpmsg_find(struct ethosu_rpmsg *erp,
 					   int msg_id)
 {
-	struct ethosu_rpmsg_msg *ptr =
-		(struct ethosu_rpmsg_msg *)idr_find(&erp->msg_idr, msg_id);
+	struct ethosu_rpmsg_msg *ptr;
+
+	read_lock(&erp->lock);
+	ptr = (struct ethosu_rpmsg_msg *)idr_find(&erp->msg_idr, msg_id);
+	read_unlock(&erp->lock);
 
 	if (!ptr)
 		return ERR_PTR(-EINVAL);
@@ -97,8 +104,8 @@ static int ethosu_rpmsg_send(struct ethosu_rpmsg *erp, uint32_t type)
 	msg.type = type;
 	msg.length = 0;
 
-	print_hex_dump(KERN_DEBUG, __func__, DUMP_PREFIX_NONE, 16, 1,
-			(void *)&msg, sizeof(msg),  true);
+	print_hex_dump_debug(__func__, DUMP_PREFIX_NONE, 16, 1, (void *)&msg,
+			     sizeof(msg), true);
 
 	ret = rpmsg_send(rpdev->ept, (void *)&msg, sizeof(msg));
 	if (ret) {
@@ -337,8 +344,8 @@ static int rpmsg_ethosu_cb(struct rpmsg_device *rpdev,
 
 	dev_dbg(&rpdev->dev, "msg(<- src 0x%x) len %d\n", src, len);
 
-	print_hex_dump(KERN_DEBUG, __func__, DUMP_PREFIX_NONE, 16, 1,
-			data, len,  true);
+	print_hex_dump_debug(__func__, DUMP_PREFIX_NONE, 16, 1, data,
+			     len, true);
 
 	rpmsg->callback(rpmsg->user_arg, data);
 
@@ -391,6 +398,7 @@ int ethosu_rpmsg_init(struct ethosu_rpmsg *erp,
 	erp->user_arg = user_arg;
 	erp->ping_count = 0;
 	idr_init(&erp->msg_idr);
+        rwlock_init(&erp->lock);
 
 	return register_rpmsg_driver(&ethosu_rpmsg_driver);
 }
diff --git a/drivers/firmware/ethosu/ethosu_rpmsg.h b/drivers/firmware/ethosu/ethosu_rpmsg.h
index 283d401a0dbf..a4b879e9ef6c 100644
--- a/drivers/firmware/ethosu/ethosu_rpmsg.h
+++ b/drivers/firmware/ethosu/ethosu_rpmsg.h
@@ -21,6 +21,7 @@ struct ethosu_core_msg;
 typedef void (*ethosu_rpmsg_cb)(void *user_arg, void *data);
 
 struct ethosu_rpmsg {
+	rwlock_t		lock;
 	struct rpmsg_device	*rpdev;
 	ethosu_rpmsg_cb		callback;
 	void			*user_arg;
-- 
2.17.1

