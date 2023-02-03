Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FBF6897C8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjBCLfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjBCLes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:34:48 -0500
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B682915A;
        Fri,  3 Feb 2023 03:34:43 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436263|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0714235-0.0146264-0.91395;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.R9hZOV8_1675424079;
Received: from SunxiBot.allwinnertech.com(mailfrom:victor@allwinnertech.com fp:SMTPD_---.R9hZOV8_1675424079)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 19:34:40 +0800
From:   Victor Hassan <victor@allwinnertech.com>
To:     keescook@chromium.org
Cc:     tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pstore/blk: Export a method to implemente panic_write()
Date:   Fri,  3 Feb 2023 19:35:15 +0800
Message-Id: <20230203113515.93540-1-victor@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panic_write() is necessary to write the pstore frontend message
to blk devices when panic. Here is a way to register panic_write when
we use "best_effort" way to register the pstore blk-backend.

Usage:

    xx_register_pstore_panic_write(pstore_blk_notifier_type type,
	    struct pstore_device_info *pdi)
    {
	switch (type) {
	case PSTORE_BLK_BACKEND_REGISTER:
	case PSTORE_BLK_BACKEND_PANIC_DRV_REGISTER:
	    ...

	    pid->zone.panic_write = xxx;

	    ...
	    break;
	case PSTORE_BLK_BACKEND_UNREGISTER:
	case PSTORE_BLK_BACKEND_PANIC_DRV_UNREGISTER:
	    ...

	    pdi->zone.panic_write = NULL;

	    ...
	    break;
	default:
	    break;
	}

    }

    static struct pstore_blk_notifier pbn = {
	.notitifer_call = xx_register_pstore_panic_write;
    }

    use {un,}register_pstore_blk_panic_notifier() to register/unregister
    pstore_blk_notifier

Signed-off-by: Victor Hassan <victor@allwinnertech.com>
---
 fs/pstore/blk.c            | 101 +++++++++++++++++++++++++++++++++++--
 include/linux/pstore_blk.h |  19 +++++++
 2 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 4ae0cfcd15f2..2c70a3bff1ae 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -18,6 +18,7 @@
 #include <linux/file.h>
 #include <linux/init_syscalls.h>
 #include <linux/mount.h>
+#include <linux/notifier.h>
 
 static long kmsg_size = CONFIG_PSTORE_BLK_KMSG_SIZE;
 module_param(kmsg_size, long, 0400);
@@ -72,6 +73,14 @@ static DEFINE_MUTEX(pstore_blk_lock);
 static struct file *psblk_file;
 static struct pstore_device_info *pstore_device_info;
 
+static struct {
+	struct raw_notifier_head chain;
+	struct pstore_blk_notifier *pbn;
+	bool notifier;
+} pstore_blk_panic_notifier = {
+	.chain = RAW_NOTIFIER_INIT(pstore_blk_panic_notifier.chain),
+};
+
 #define check_size(name, alignsize) ({				\
 	long _##name_ = (name);					\
 	_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
@@ -94,6 +103,82 @@ static struct pstore_device_info *pstore_device_info;
 	dev->zone.name = _##name_;				\
 }
 
+static int pstore_blk_panic_notifier_call(struct notifier_block *nb,
+			     unsigned long action, void *data)
+{
+	int ret = 0;
+	struct pstore_blk_notifier *pbn =
+				container_of(nb, struct pstore_blk_notifier, nb);
+
+	if (pbn)
+		ret = pbn->notifier_call(action, data);
+
+	return ret;
+}
+
+int register_pstore_blk_panic_notifier(struct pstore_blk_notifier *pbn)
+{
+	int err = 0;
+	struct notifier_block *nb;
+
+	mutex_lock(&pstore_blk_lock);
+
+	if (pstore_blk_panic_notifier.notifier) {
+		pr_info("had register panic\n");
+		goto unlock;
+	}
+
+	nb = &pbn->nb;
+	nb->notifier_call = pstore_blk_panic_notifier_call;
+
+	err = raw_notifier_chain_register(&pstore_blk_panic_notifier.chain, nb);
+	if (err)
+		goto unlock;
+
+	if (pstore_device_info)
+		err = nb->notifier_call(nb, PSTORE_BLK_BACKEND_PANIC_DRV_REGISTER,
+				pstore_device_info);
+
+	if (!err)
+		pstore_blk_panic_notifier.notifier = true;
+
+unlock:
+	mutex_unlock(&pstore_blk_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(register_pstore_blk_panic_notifier);
+
+void unregister_pstore_blk_panic_notifier(struct pstore_blk_notifier *pbn)
+{
+	struct notifier_block *nb = &pbn->nb;
+
+	mutex_lock(&pstore_blk_lock);
+
+	raw_notifier_chain_unregister(&pstore_blk_panic_notifier.chain, nb);
+
+	if (pstore_device_info)
+		nb->notifier_call(nb, PSTORE_BLK_BACKEND_PANIC_DRV_UNREGISTER,
+				pstore_device_info);
+
+	pstore_blk_panic_notifier.notifier = false;
+
+	mutex_unlock(&pstore_blk_lock);
+}
+EXPORT_SYMBOL_GPL(unregister_pstore_blk_panic_notifier);
+
+static int pstore_blk_panic_notifier_init_call(struct pstore_device_info *pdi)
+{
+	return raw_notifier_call_chain(&pstore_blk_panic_notifier.chain,
+			PSTORE_BLK_BACKEND_REGISTER, pdi);
+}
+
+static int pstore_blk_panic_notifier_exit_call(struct pstore_device_info *pdi)
+{
+	return raw_notifier_call_chain(&pstore_blk_panic_notifier.chain,
+			PSTORE_BLK_BACKEND_UNREGISTER, pdi);
+}
+
 static int __register_pstore_device(struct pstore_device_info *dev)
 {
 	int ret;
@@ -301,16 +386,22 @@ static int __init __best_effort_init(void)
 	if (!best_effort_dev)
 		return -ENOMEM;
 
+	strcpy(best_effort_dev->path, blkdev);
 	best_effort_dev->zone.read = psblk_generic_blk_read;
 	best_effort_dev->zone.write = psblk_generic_blk_write;
 
 	ret = __register_pstore_blk(best_effort_dev,
 				    early_boot_devpath(blkdev));
-	if (ret)
+	if (ret) {
 		kfree(best_effort_dev);
-	else
-		pr_info("attached %s (%lu) (no dedicated panic_write!)\n",
-			blkdev, best_effort_dev->zone.total_size);
+	} else {
+		if (pstore_blk_panic_notifier_init_call(best_effort_dev) == NOTIFY_OK)
+			pr_info("attached %s (%lu) (dedicated panic_write!)\n",
+				    blkdev, best_effort_dev->zone.total_size);
+		else
+			pr_info("attached %s (%lu) (no dedicated panic_write!)\n",
+				    blkdev, best_effort_dev->zone.total_size);
+	}
 
 	return ret;
 }
@@ -326,6 +417,8 @@ static void __exit __best_effort_exit(void)
 	if (psblk_file) {
 		struct pstore_device_info *dev = pstore_device_info;
 
+		pstore_blk_panic_notifier_exit_call(dev);
+
 		__unregister_pstore_device(dev);
 		kfree(dev);
 		fput(psblk_file);
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 924ca07aafbd..4c1fc8debdc7 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -17,13 +17,32 @@
  *
  */
 struct pstore_device_info {
+	char path[80];
 	unsigned int flags;
 	struct pstore_zone_info zone;
 };
 
+enum pstore_blk_notifier_type {
+	PSTORE_BLK_BACKEND_REGISTER = 1,
+	PSTORE_BLK_BACKEND_PANIC_DRV_REGISTER,
+	PSTORE_BLK_BACKEND_UNREGISTER,
+	PSTORE_BLK_BACKEND_PANIC_DRV_UNREGISTER,
+};
+
+typedef	int (*pstore_blk_notifier_fn_t)(pstore_blk_notifier_type type,
+		struct pstore_device_info *dev);
+
+struct pstore_blk_notifier {
+	struct notifier_block nb;
+	pstore_blk_notifier_fn_t notifier_call;
+};
+
 int  register_pstore_device(struct pstore_device_info *dev);
 void unregister_pstore_device(struct pstore_device_info *dev);
 
+int register_pstore_blk_panic_notifier(struct pstore_blk_notifier *pbn);
+void unregister_pstore_blk_panic_notifier(struct pstore_blk_notifier *nb);
+
 /**
  * struct pstore_blk_config - the pstore_blk backend configuration
  *
-- 
2.29.0

