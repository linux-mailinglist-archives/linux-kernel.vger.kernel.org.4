Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664C36B0CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjCHPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjCHPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:32:25 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0242FD90C3;
        Wed,  8 Mar 2023 07:32:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0361FFF807;
        Wed,  8 Mar 2023 15:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678289537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Fa7z9mAzOMi6AkU7brGc+2TjyQ76RAJaVPkouit7mo=;
        b=P/UTtYGyVisjLPnxSNWkC+juOYc1uO12Iz/PRd8UahgGDTmZs7aX0/5GtH3tECGJq52XN5
        EkamMgQcFrMmEeIbwRiAY/HNktUOduyGl+E5ULbpAReCdxKni8LXR/+/bqUQfYrzZxCoCN
        Z43Jx66ttDQIpSqYl+CRwbhR7kGmimm/QP4/AUaCnfgHfTzzIG+F7+OxzsmE6ZZ/sXqMv7
        mX3TjttNr34EF9n+USydV6B8d8Q5zzxXg70R9bIy7YdVysHuOLPCoyrA5mkbnz9dX58cGG
        yA4QU7FDePP6vDQK2Wxpj/E02L7xseUPAE+qTmrI+aMEYjV2VkgYsSRuKCJGPQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 07/20] of: device: Kill of_device_request_module()
Date:   Wed,  8 Mar 2023 16:31:47 +0100
Message-Id: <20230308153200.682248-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308153200.682248-1-miquel.raynal@bootlin.com>
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new helper has been introduced, of_request_module(). Users have been
converted, this helper can now be deleted.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/device.c       | 9 ---------
 include/linux/of_device.h | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 874a2e1f6308..0f00f1b80708 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -246,15 +246,6 @@ const void *of_device_get_match_data(const struct device *dev)
 }
 EXPORT_SYMBOL(of_device_get_match_data);
 
-int of_device_request_module(struct device *dev)
-{
-	if (!dev)
-		return -ENODEV;
-
-	return of_request_module(dev->of_node);
-}
-EXPORT_SYMBOL_GPL(of_device_request_module);
-
 /**
  * of_device_modalias - Fill buffer with newline terminated modalias string
  * @dev:	Calling device
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index f4b57614979d..ce20d8b00b3e 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -33,7 +33,6 @@ extern void of_device_unregister(struct platform_device *ofdev);
 extern const void *of_device_get_match_data(const struct device *dev);
 
 extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
-extern int of_device_request_module(struct device *dev);
 
 extern void of_device_uevent(const struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *env);
@@ -78,11 +77,6 @@ static inline int of_device_modalias(struct device *dev,
 	return -ENODEV;
 }
 
-static inline int of_device_request_module(struct device *dev)
-{
-	return -ENODEV;
-}
-
 static inline int of_device_uevent_modalias(const struct device *dev,
 				   struct kobj_uevent_env *env)
 {
-- 
2.34.1

