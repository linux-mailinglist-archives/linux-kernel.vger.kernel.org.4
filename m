Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF5737367
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjFTSBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjFTSBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:01:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593D51712;
        Tue, 20 Jun 2023 11:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E980F61355;
        Tue, 20 Jun 2023 18:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045A3C433C0;
        Tue, 20 Jun 2023 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687284099;
        bh=HV0EXm2PTPBmuK1pyyW2SD5b0SA8DKNQE3c4Wc9+gZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEaOfD0kafoBD7yYx4EFXHOns4LK47Aa82TSb7lf8vKc/3osmgUWt/T6vejITIrEI
         m6vxiQJ5AA9+4I1n7CrjSpLSnhz9xLCqtUeYGUZpDB/vJHF/GRoNcwr0ugyH+ksN1X
         cLqvFpfVNDdd1aFuURg5jLlX2cdNoroofCDRvTfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Justin Sanders <justin@coraid.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/4] aoe: make aoe_class a static const structure
Date:   Tue, 20 Jun 2023 20:01:31 +0200
Message-ID: <20230620180129.645646-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620180129.645646-5-gregkh@linuxfoundation.org>
References: <20230620180129.645646-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2704; i=gregkh@linuxfoundation.org; h=from:subject; bh=Gr78tCXAeIamp3Zv2PTkxoxZaAkwXTJCd+sAddc+WLo=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTX1aZaAumHN0ZseVeBcv1gj+3mq8eFOFQS/Pl05Avn 8okscejI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACYyYRrD/PrpVXzsyu5z9W6W aS777bzkG/u87QzzPa/GfKjb5u9xxSDDa2b564L5ZcuaAQ==
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
memory, move the aoe_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Justin Sanders <justin@coraid.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/aoe/aoechr.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index 4c666f72203f..a42c4bcc85ba 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -49,7 +49,7 @@ static int emsgs_head_idx, emsgs_tail_idx;
 static struct completion emsgs_comp;
 static spinlock_t emsgs_lock;
 static int nblocked_emsgs_readers;
-static struct class *aoe_class;
+
 static struct aoe_chardev chardevs[] = {
 	{ MINOR_ERR, "err" },
 	{ MINOR_DISCOVER, "discover" },
@@ -58,6 +58,16 @@ static struct aoe_chardev chardevs[] = {
 	{ MINOR_FLUSH, "flush" },
 };
 
+static char *aoe_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "etherd/%s", dev_name(dev));
+}
+
+static const struct class aoe_class = {
+	.name = "aoe",
+	.devnode = aoe_devnode,
+};
+
 static int
 discover(void)
 {
@@ -273,11 +283,6 @@ static const struct file_operations aoe_fops = {
 	.llseek = noop_llseek,
 };
 
-static char *aoe_devnode(const struct device *dev, umode_t *mode)
-{
-	return kasprintf(GFP_KERNEL, "etherd/%s", dev_name(dev));
-}
-
 int __init
 aoechr_init(void)
 {
@@ -290,15 +295,14 @@ aoechr_init(void)
 	}
 	init_completion(&emsgs_comp);
 	spin_lock_init(&emsgs_lock);
-	aoe_class = class_create("aoe");
-	if (IS_ERR(aoe_class)) {
+	n = class_register(&aoe_class);
+	if (n) {
 		unregister_chrdev(AOE_MAJOR, "aoechr");
-		return PTR_ERR(aoe_class);
+		return n;
 	}
-	aoe_class->devnode = aoe_devnode;
 
 	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)
-		device_create(aoe_class, NULL,
+		device_create(&aoe_class, NULL,
 			      MKDEV(AOE_MAJOR, chardevs[i].minor), NULL,
 			      chardevs[i].name);
 
@@ -311,8 +315,8 @@ aoechr_exit(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)
-		device_destroy(aoe_class, MKDEV(AOE_MAJOR, chardevs[i].minor));
-	class_destroy(aoe_class);
+		device_destroy(&aoe_class, MKDEV(AOE_MAJOR, chardevs[i].minor));
+	class_unregister(&aoe_class);
 	unregister_chrdev(AOE_MAJOR, "aoechr");
 }
 
-- 
2.41.0

