Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4C36AE796
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCGQ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjCGQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:07 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720D90B58;
        Tue,  7 Mar 2023 08:54:30 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DD194C0004;
        Tue,  7 Mar 2023 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678208069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CRuE9PZJiPz9C7EOf+r9GXYwrEDm26qK5kWdG2+8fH0=;
        b=YKylPxBHewvat29H7KiU18pRcwwvmatUyI/Z7li4zy9cZLuQtYNzjt0pIXdK0lTl+nHxyR
        +HfcYx9t96EZ7tfy9h3/Ygn8SjJMRvHs2NtQPFOho4VVjj5NkqsNpOvbA5dZAwRUGH27C6
        NbA+L+4EChs3unJiDxP8keLuA3wkhXVSlR+CspBRQir50Lgpy/qisIripInOdZTo25UgIU
        xnEDnYuz3XTDEafiDx0OVIWRMPDRUjXtdMv9o19jG2JlgR4GLYlTlJbMlu4OzGDjCmATKM
        9jXeZnqLSOEH3Btn/M9RLSvKwm4MPbaGjBpoYLI2B+2Tp8d2ucJJyoHc7SeMKg==
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
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 07/21] of: device: Kill of_device_request_module()
Date:   Tue,  7 Mar 2023 17:53:45 +0100
Message-Id: <20230307165359.225361-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307165359.225361-1-miquel.raynal@bootlin.com>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
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
---
 drivers/of/device.c       | 9 ---------
 include/linux/of_device.h | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 4bbb6e6388a9..717392cd416b 100644
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
index ab7d557d541d..40c6c8d5299e 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -33,7 +33,6 @@ extern void of_device_unregister(struct platform_device *ofdev);
 extern const void *of_device_get_match_data(const struct device *dev);
 
 extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
-extern int of_device_request_module(struct device *dev);
 
 extern void of_device_uevent(const struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
@@ -78,11 +77,6 @@ static inline int of_device_modalias(struct device *dev,
 	return -ENODEV;
 }
 
-static inline int of_device_request_module(struct device *dev)
-{
-	return -ENODEV;
-}
-
 static inline int of_device_uevent_modalias(struct device *dev,
 				   struct kobj_uevent_env *env)
 {
-- 
2.34.1

