Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0538737409
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFTSZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFTSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934E4118
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25AF461376
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 18:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FA0C433C0;
        Tue, 20 Jun 2023 18:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687285533;
        bh=EPwimtMP7nDGIxbklJS1+hTWPF8+TPX2BCGsg+nTXqA=;
        h=From:To:Cc:Subject:Date:From;
        b=R+AlMVHyD3J2hx8v13pXKFPuiO7Pbddf8xh5NqDRx2mInqrF8M/KGBZsFtevYRbgb
         iqgKNQQPiEttjseNm7RN31u+/9+XtPVks5RmR9dYppWGJObQQ99Rr5Uuutu2srbTIo
         sxuO71QBUv7B6UrcnaBRm2eR+gIBVheeCmvGD8hU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] accel: make accel_class a static const structure
Date:   Tue, 20 Jun 2023 20:25:29 +0200
Message-ID: <20230620182528.669526-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128; i=gregkh@linuxfoundation.org; h=from:subject; bh=2cla2+UmxOIoIy0GsaibJ/gp5KSQn9pg8L8YJJT0aZ0=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkT30uYLo/3M10b0fPkecAELvPGAmuH3Mi7n0+cCcxoW fP7oceEjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIpzCGWczTQj9/UCrnvrpa 3yyn7Rbf1PPZnxgWtOf/LmFUTi9Z90Nztuert0Wcry6vAAA=
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
memory, move the accel_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/drm_accel.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
index 4a9baf02439e..2dc187e1ee41 100644
--- a/drivers/accel/drm_accel.c
+++ b/drivers/accel/drm_accel.c
@@ -21,7 +21,6 @@ static DEFINE_SPINLOCK(accel_minor_lock);
 static struct idr accel_minors_idr;
 
 static struct dentry *accel_debugfs_root;
-static struct class *accel_class;
 
 static struct device_type accel_sysfs_device_minor = {
 	.name = "accel_minor"
@@ -32,23 +31,19 @@ static char *accel_devnode(const struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "accel/%s", dev_name(dev));
 }
 
+static const struct class accel_class = {
+	.name = "accel",
+	.devnode = accel_devnode,
+};
+
 static int accel_sysfs_init(void)
 {
-	accel_class = class_create("accel");
-	if (IS_ERR(accel_class))
-		return PTR_ERR(accel_class);
-
-	accel_class->devnode = accel_devnode;
-
-	return 0;
+	return class_register(&accel_class);
 }
 
 static void accel_sysfs_destroy(void)
 {
-	if (IS_ERR_OR_NULL(accel_class))
-		return;
-	class_destroy(accel_class);
-	accel_class = NULL;
+	class_unregister(&accel_class);
 }
 
 static int accel_name_info(struct seq_file *m, void *data)
@@ -116,7 +111,7 @@ void accel_debugfs_init(struct drm_minor *minor, int minor_id)
 void accel_set_device_instance_params(struct device *kdev, int index)
 {
 	kdev->devt = MKDEV(ACCEL_MAJOR, index);
-	kdev->class = accel_class;
+	kdev->class = &accel_class;
 	kdev->type = &accel_sysfs_device_minor;
 }
 
-- 
2.41.0

