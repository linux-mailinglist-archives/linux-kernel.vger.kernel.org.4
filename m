Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105A6665A40
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbjAKLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjAKLbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:31:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4952B3884
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:31:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE6F0B81B8D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28793C433D2;
        Wed, 11 Jan 2023 11:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436660;
        bh=PUodvLzyboiiTwDvvOkvPeOcnFY8YPv39Q5FU+hy6Nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mvjux6f392wzL/QzluvGE3BmPKwvBLoh40iIF1KrSrua9J+CorAK3WySMiA3jMOMw
         DzrY7BigHuYZ7GH9GbGigGmJS4a6vGUWXyl0oV6jGsbVuZgUZUykYTwc83OIrhCrZT
         BIryhBwUAIo53/RsZeGrTKhCduZz4Qb1f2z0GZAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org
Subject: [PATCH v2 02/16] i3c: move dev_to_i3cdev() to use container_of_const()
Date:   Wed, 11 Jan 2023 12:30:04 +0100
Message-Id: <20230111113018.459199-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; i=gregkh@linuxfoundation.org; h=from:subject; bh=PUodvLzyboiiTwDvvOkvPeOcnFY8YPv39Q5FU+hy6Nk=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75h5f+eHO+RleNy/2PJ7s5lasfKaFTdjwRe9WkQmsPzwe XYv51xHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATeXecYUFT6oco2U8syyPndM7nWh fZkr5bUoFhfu1s3/pMQcPSCV9u6CZveu33ebX+SgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core is changing to pass some pointers as const, so move
dev_to_i3cdev() to use container_of_const() to handle this change.
dev_to_i3cdev() now properly keeps the const-ness of the pointer passed
into it, while as before it could be lost.

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i3c/device.c       | 12 ------------
 include/linux/i3c/device.h |  9 ++++++++-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 9762630b917e..d111499061b2 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -208,18 +208,6 @@ struct device *i3cdev_to_dev(struct i3c_device *i3cdev)
 }
 EXPORT_SYMBOL_GPL(i3cdev_to_dev);
 
-/**
- * dev_to_i3cdev() - Returns the I3C device containing @dev
- * @dev: device object
- *
- * Return: a pointer to an I3C device object.
- */
-struct i3c_device *dev_to_i3cdev(struct device *dev)
-{
-	return container_of(dev, struct i3c_device, dev);
-}
-EXPORT_SYMBOL_GPL(dev_to_i3cdev);
-
 /**
  * i3c_device_match_id() - Returns the i3c_device_id entry matching @i3cdev
  * @i3cdev: I3C device
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 1c997abe868c..68b558929aec 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -186,7 +186,14 @@ static inline struct i3c_driver *drv_to_i3cdrv(struct device_driver *drv)
 }
 
 struct device *i3cdev_to_dev(struct i3c_device *i3cdev);
-struct i3c_device *dev_to_i3cdev(struct device *dev);
+
+/**
+ * dev_to_i3cdev() - Returns the I3C device containing @dev
+ * @dev: device object
+ *
+ * Return: a pointer to an I3C device object.
+ */
+#define dev_to_i3cdev(__dev)	container_of_const(__dev, struct i3c_device, dev)
 
 const struct i3c_device_id *
 i3c_device_match_id(struct i3c_device *i3cdev,
-- 
2.39.0

