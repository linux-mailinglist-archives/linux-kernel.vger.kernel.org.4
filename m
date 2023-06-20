Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E0E73736F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjFTSCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjFTSBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:01:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018961A8;
        Tue, 20 Jun 2023 11:01:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B22E61359;
        Tue, 20 Jun 2023 18:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA5AC433C8;
        Tue, 20 Jun 2023 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687284110;
        bh=mLWzIkB9n6b+IgFjY2oTg9W4Iuvar0Rst5HENnLsKCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1OHtgxwIb4ubKzxNV8Ad7uLkzco2kcDk0cCN7fqyXOg71+MYBgDqy5RrSz68BqwJm
         tMhqCal5n1WhBt1r8en07b9aNXQe/G8x0fXr+rghqJrinhPT2VaDHyJZRjfFyHhiMV
         InokhMPviNjv72pi4kAXnOUgCB7kdCmlHSwz7umQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/4] bsg: make bsg_class a static const structure
Date:   Tue, 20 Jun 2023 20:01:33 +0200
Message-ID: <20230620180129.645646-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620180129.645646-5-gregkh@linuxfoundation.org>
References: <20230620180129.645646-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2239; i=gregkh@linuxfoundation.org; h=from:subject; bh=fnHpjCymBCx207w0QsVqcrjVrGR4TQ1EajvXa247ZDU=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTX1aZuMV9Uo01aZ9zpf7GpkNn1hzxWFobOfWfZH5jQ NSR0rWpHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRaBaG+bnKJ2VNc/cumjQl +2+I3YePdV8fT2JYcEh+u2jVrB7NfE/9AzG1PW7xTmbbAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, move the bsg_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/bsg.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 7eca43f33d7f..e04fb075d604 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -39,7 +39,7 @@ static inline struct bsg_device *to_bsg_device(struct inode *inode)
 #define BSG_MAX_DEVS		32768
 
 static DEFINE_IDA(bsg_minor_ida);
-static struct class *bsg_class;
+static const struct class bsg_class;
 static int bsg_major;
 
 static unsigned int bsg_timeout(struct bsg_device *bd, struct sg_io_v4 *hdr)
@@ -206,7 +206,7 @@ struct bsg_device *bsg_register_queue(struct request_queue *q,
 		return ERR_PTR(ret);
 	}
 	bd->device.devt = MKDEV(bsg_major, ret);
-	bd->device.class = bsg_class;
+	bd->device.class = &bsg_class;
 	bd->device.parent = parent;
 	bd->device.release = bsg_device_release;
 	dev_set_name(&bd->device, "%s", name);
@@ -240,15 +240,19 @@ static char *bsg_devnode(const struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "bsg/%s", dev_name(dev));
 }
 
+static const struct class bsg_class = {
+	.name		= "bsg",
+	.devnode	= bsg_devnode,
+};
+
 static int __init bsg_init(void)
 {
 	dev_t devid;
 	int ret;
 
-	bsg_class = class_create("bsg");
-	if (IS_ERR(bsg_class))
-		return PTR_ERR(bsg_class);
-	bsg_class->devnode = bsg_devnode;
+	ret = class_register(&bsg_class);
+	if (ret)
+		return ret;
 
 	ret = alloc_chrdev_region(&devid, 0, BSG_MAX_DEVS, "bsg");
 	if (ret)
@@ -260,7 +264,7 @@ static int __init bsg_init(void)
 	return 0;
 
 destroy_bsg_class:
-	class_destroy(bsg_class);
+	class_unregister(&bsg_class);
 	return ret;
 }
 
-- 
2.41.0

