Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D311F736EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjFTOiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjFTOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E39CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7B836126D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4725C433C0;
        Tue, 20 Jun 2023 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687271879;
        bh=3fWYPMoqAonGHfIfPasWqIxbONyFbWO7titQ4tLBhMw=;
        h=From:To:Cc:Subject:Date:From;
        b=1G5CQ36VA5qcAjBTSQ37XBv0908Z/pZYRHtgMOdc5z5QdLyQzw0SQWLulkVVUd1Tv
         ntpKIMQ14JEOOlcbBrr4KjMA5agaZgTbbkUXE0NgyE8nr3Uj6IqHdkg4lqweViureo
         bcwhQk8iE50bbL1CEaLHURvR4OM5MmnwkMw0/blg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/9] bsr: make bsr_class a static const structure
Date:   Tue, 20 Jun 2023 16:37:52 +0200
Message-ID: <20230620143751.578239-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513; i=gregkh@linuxfoundation.org; h=from:subject; bh=jBaioBMdJILdqbcL7HIiRWuT7uBmiwx111FL5lEuQq0=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTd+4PjlOf1PwmxE2u4xFn7WfNM/172q2+uIuLrvzyW CF7d65LRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEyEOZ1hwfljH/yPJ3k/nv9X 7p/vm/XHtxwwX8ww32mutlViZYbqBndbu856x7f+DO07AQ==
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
memory, move the bsr_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/bsr.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index ff429ba02fa4..0654f0e6b320 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -61,7 +61,6 @@ struct bsr_dev {
 
 static unsigned total_bsr_devs;
 static LIST_HEAD(bsr_devs);
-static struct class *bsr_class;
 static int bsr_major;
 
 enum {
@@ -108,6 +107,11 @@ static struct attribute *bsr_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(bsr_dev);
 
+static const struct class bsr_class = {
+	.name		= "bsr",
+	.dev_groups	= bsr_dev_groups,
+};
+
 static int bsr_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	unsigned long size   = vma->vm_end - vma->vm_start;
@@ -244,7 +248,7 @@ static int bsr_add_node(struct device_node *bn)
 			goto out_err;
 		}
 
-		cur->bsr_device = device_create(bsr_class, NULL, cur->bsr_dev,
+		cur->bsr_device = device_create(&bsr_class, NULL, cur->bsr_dev,
 						cur, "%s", cur->bsr_name);
 		if (IS_ERR(cur->bsr_device)) {
 			printk(KERN_ERR "device_create failed for %s\n",
@@ -293,13 +297,9 @@ static int __init bsr_init(void)
 	if (!np)
 		goto out_err;
 
-	bsr_class = class_create("bsr");
-	if (IS_ERR(bsr_class)) {
-		printk(KERN_ERR "class_create() failed for bsr_class\n");
-		ret = PTR_ERR(bsr_class);
+	ret = class_register(&bsr_class);
+	if (err)
 		goto out_err_1;
-	}
-	bsr_class->dev_groups = bsr_dev_groups;
 
 	ret = alloc_chrdev_region(&bsr_dev, 0, BSR_MAX_DEVS, "bsr");
 	bsr_major = MAJOR(bsr_dev);
@@ -320,7 +320,7 @@ static int __init bsr_init(void)
 	unregister_chrdev_region(bsr_dev, BSR_MAX_DEVS);
 
  out_err_2:
-	class_destroy(bsr_class);
+	class_unregister(&bsr_class);
 
  out_err_1:
 	of_node_put(np);
@@ -335,8 +335,7 @@ static void __exit  bsr_exit(void)
 
 	bsr_cleanup_devs();
 
-	if (bsr_class)
-		class_destroy(bsr_class);
+	class_unregister(&bsr_class);
 
 	if (bsr_major)
 		unregister_chrdev_region(MKDEV(bsr_major, 0), BSR_MAX_DEVS);
-- 
2.41.0

