Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F3273736E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjFTSCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFTSBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E7812C;
        Tue, 20 Jun 2023 11:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EB5961344;
        Tue, 20 Jun 2023 18:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A2FC433C0;
        Tue, 20 Jun 2023 18:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687284107;
        bh=Llf/Ned9bWpyUTNIfPeCq9J4fpBpz1vG2VKuVCLRwac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ns+nAnC4eMK5h5ZIz6RjMrmSOWY80bGcgQooJ1EyFVs3c0vbd8t5a1A3pAExv4IPR
         8rbTypyZQ1jMkTayjKdlg/6APp+1IRhEnIMxC2/3LRAxuQYAlMFmplKiQku5B6M1aq
         KVGtDAkwXoOzFQxIG5Qn0kDGylBn0vmqjppcKtcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/4] ublk: make ublk_chr_class a static const structure
Date:   Tue, 20 Jun 2023 20:01:32 +0200
Message-ID: <20230620180129.645646-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620180129.645646-5-gregkh@linuxfoundation.org>
References: <20230620180129.645646-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=gregkh@linuxfoundation.org; h=from:subject; bh=hLzPZz0rmzh84KgaQgMKacJTL3bxIGNFuZVcbSsrVZE=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTX1btfqTzUDKi+PEs1czAv1JPi8IEP6ya+y/OXm/u8 Tm9hTPNOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiztYM87MOhog8OjxdQP4g v//nzr+WE3wNbzLML72UWhy4llXr0WY19/9N22IT1n24AwA=
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
memory, move the ublk_chr_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/ublk_drv.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 33d3298a0da1..f25d93365701 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -183,7 +183,9 @@ struct ublk_params_header {
 };
 
 static dev_t ublk_chr_devt;
-static struct class *ublk_chr_class;
+static const struct class ublk_chr_class = {
+	.name = "ublk-char",
+};
 
 static DEFINE_IDR(ublk_index_idr);
 static DEFINE_SPINLOCK(ublk_idr_lock);
@@ -1547,7 +1549,7 @@ static int ublk_add_chdev(struct ublk_device *ub)
 
 	dev->parent = ublk_misc.this_device;
 	dev->devt = MKDEV(MAJOR(ublk_chr_devt), minor);
-	dev->class = ublk_chr_class;
+	dev->class = &ublk_chr_class;
 	dev->release = ublk_cdev_rel;
 	device_initialize(dev);
 
@@ -2347,11 +2349,10 @@ static int __init ublk_init(void)
 	if (ret)
 		goto unregister_mis;
 
-	ublk_chr_class = class_create("ublk-char");
-	if (IS_ERR(ublk_chr_class)) {
-		ret = PTR_ERR(ublk_chr_class);
+	ret = class_register(&ublk_chr_class);
+	if (ret)
 		goto free_chrdev_region;
-	}
+
 	return 0;
 
 free_chrdev_region:
@@ -2369,7 +2370,7 @@ static void __exit ublk_exit(void)
 	idr_for_each_entry(&ublk_index_idr, ub, id)
 		ublk_remove(ub);
 
-	class_destroy(ublk_chr_class);
+	class_unregister(&ublk_chr_class);
 	misc_deregister(&ublk_misc);
 
 	idr_destroy(&ublk_index_idr);
-- 
2.41.0

