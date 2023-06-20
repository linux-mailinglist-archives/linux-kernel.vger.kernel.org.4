Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286E5736ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjFTOi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjFTOiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7865173D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4008F612B3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2A2C433C8;
        Tue, 20 Jun 2023 14:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687271889;
        bh=FaRHF/PB6BaxjUrk6iOOUUMOLqCwhxs44CVBkR4qXXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tst5jiLN6vj8fr8QPDWxGEklptuv3PDZpGxPZWiZxTJV69xLVRRxXjAdaTyXjwrfF
         Fuky1vpBLLPI1Qgp2BkXaSX1BMjyaJnFFA30S5vIVDHTGpjz5BxHZaFJ5CXgpjbXos
         bcrhRndB8TbQjBTY80OBbnfn4H/7ESf/wjxrM+TI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/9] char: misc: make misc_class a static const structure
Date:   Tue, 20 Jun 2023 16:37:56 +0200
Message-ID: <20230620143751.578239-14-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620143751.578239-10-gregkh@linuxfoundation.org>
References: <20230620143751.578239-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2970; i=gregkh@linuxfoundation.org; h=from:subject; bh=Wq5JfVJAtqzIAMM6fxfToBhPJeNVfiJOSPUBrqoxF3Q=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTdx5448erO6+BjTVJwSjiq+1Ghr6Npd6bddPZRJ9Nu zWZdadtRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwkWJNhfggbr8rlwOPqE1dU tLfuuSO4bc255QwLpn5bX+G+w2L+4WyvW/GJMVv1PJnsAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, move the misc_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/misc.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 1c44c29a666e..541edc26ec89 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -168,7 +168,21 @@ static int misc_open(struct inode *inode, struct file *file)
 	return err;
 }
 
-static struct class *misc_class;
+static char *misc_devnode(const struct device *dev, umode_t *mode)
+{
+	const struct miscdevice *c = dev_get_drvdata(dev);
+
+	if (mode && c->mode)
+		*mode = c->mode;
+	if (c->nodename)
+		return kstrdup(c->nodename, GFP_KERNEL);
+	return NULL;
+}
+
+static const struct class misc_class = {
+	.name		= "misc",
+	.devnode	= misc_devnode,
+};
 
 static const struct file_operations misc_fops = {
 	.owner		= THIS_MODULE,
@@ -226,7 +240,7 @@ int misc_register(struct miscdevice *misc)
 	dev = MKDEV(MISC_MAJOR, misc->minor);
 
 	misc->this_device =
-		device_create_with_groups(misc_class, misc->parent, dev,
+		device_create_with_groups(&misc_class, misc->parent, dev,
 					  misc, misc->groups, "%s", misc->name);
 	if (IS_ERR(misc->this_device)) {
 		if (is_dynamic) {
@@ -263,43 +277,30 @@ void misc_deregister(struct miscdevice *misc)
 
 	mutex_lock(&misc_mtx);
 	list_del(&misc->list);
-	device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
+	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
 	misc_minor_free(misc->minor);
 	mutex_unlock(&misc_mtx);
 }
 EXPORT_SYMBOL(misc_deregister);
 
-static char *misc_devnode(const struct device *dev, umode_t *mode)
-{
-	const struct miscdevice *c = dev_get_drvdata(dev);
-
-	if (mode && c->mode)
-		*mode = c->mode;
-	if (c->nodename)
-		return kstrdup(c->nodename, GFP_KERNEL);
-	return NULL;
-}
-
 static int __init misc_init(void)
 {
 	int err;
 	struct proc_dir_entry *ret;
 
 	ret = proc_create_seq("misc", 0, NULL, &misc_seq_ops);
-	misc_class = class_create("misc");
-	err = PTR_ERR(misc_class);
-	if (IS_ERR(misc_class))
+	err = class_register(&misc_class);
+	if (err)
 		goto fail_remove;
 
 	err = -EIO;
 	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
 		goto fail_printk;
-	misc_class->devnode = misc_devnode;
 	return 0;
 
 fail_printk:
 	pr_err("unable to get major %d for misc devices\n", MISC_MAJOR);
-	class_destroy(misc_class);
+	class_unregister(&misc_class);
 fail_remove:
 	if (ret)
 		remove_proc_entry("misc", NULL);
-- 
2.41.0

