Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF3D6A6F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCAPW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCAPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:22:49 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F75C3BD86;
        Wed,  1 Mar 2023 07:22:46 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4B3AC6000A;
        Wed,  1 Mar 2023 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677684165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=20ZNMpm9x0asQsEVva+trdnvABlBWfMLwEchVbLYbKo=;
        b=cRlym06tZywCTPZhMhhv3ejIASwMs5VLbcTsNBcHZ3o0jWWg0M9dCON5Yyx7mCgKEEPUtb
        RWFM72XRkmW45Igkq0jpfvDReypUSHR1o6ArajPEmtayJbqooqqoEucsZRRVBrXt1BbNrE
        dKj71kyVTXwuamyI2hKY2o331MivzHDWKD98BLIvQGjFQDE44ICEziO0vTaa5nbYk3uTNF
        Ht3R5I4MWq4GqVskw9ng7H8XJEO8ZBbvzKJ/cNvXHBMi7cFrgsQ17uY0WcW1+9Ltszx6f3
        2oBlyP8hBNBPSFC80N3wawL/UQb1t4FXHYtzWpwKLPjoKM9Pk1rd2Vvo483buQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        rafal@milecki.pl, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/8] of: Create an of_device_request_module() receiving an OF node
Date:   Wed,  1 Mar 2023 16:22:34 +0100
Message-Id: <20230301152239.531194-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301152239.531194-1-miquel.raynal@bootlin.com>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_device_request_module() currently receives a "struct device" as main
argument, but the only use of this pointer is to access its .of_node
member. In practice, this function only needs a "struct
device_node". Let's move the logic into another helper which would
receive a "struct device_node" instead, and use that new helper from the
ancient of_device_request_module(). Exporting this new function will be
useful to request module loading when the "struct device" is not
available.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/of/device.c       | 17 +++++++++++++----
 include/linux/of_device.h |  6 ++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 3efc17de1d57..7cdf252b9526 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -284,16 +284,16 @@ static ssize_t of_device_get_modalias(struct device_node *np, char *str, ssize_t
 	return tsize;
 }
 
-int of_device_request_module(struct device *dev)
+int of_device_node_request_module(struct device_node *np)
 {
 	char *str;
 	ssize_t size;
 	int ret;
 
-	if (!dev || !dev->of_node)
+	if (!np)
 		return -ENODEV;
 
-	size = of_device_get_modalias(dev->of_node, NULL, 0);
+	size = of_device_get_modalias(np, NULL, 0);
 	if (size < 0)
 		return size;
 
@@ -304,13 +304,22 @@ int of_device_request_module(struct device *dev)
 	if (!str)
 		return -ENOMEM;
 
-	of_device_get_modalias(dev->of_node, str, size);
+	of_device_get_modalias(np, str, size);
 	str[size - 1] = '\0';
 	ret = request_module(str);
 	kfree(str);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(of_device_node_request_module);
+
+int of_device_request_module(struct device *dev)
+{
+	if (!dev)
+		return -ENODEV;
+
+	return of_device_node_request_module(dev->of_node);
+}
 EXPORT_SYMBOL_GPL(of_device_request_module);
 
 /**
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index ab7d557d541d..8918f9071ffb 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -33,6 +33,7 @@ extern void of_device_unregister(struct platform_device *ofdev);
 extern const void *of_device_get_match_data(const struct device *dev);
 
 extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
+extern int of_device_node_request_module(struct device_node *np);
 extern int of_device_request_module(struct device *dev);
 
 extern void of_device_uevent(const struct device *dev, struct kobj_uevent_env *env);
@@ -78,6 +79,11 @@ static inline int of_device_modalias(struct device *dev,
 	return -ENODEV;
 }
 
+static inline int of_device_node_request_module(struct device_node *np)
+{
+	return -ENODEV;
+}
+
 static inline int of_device_request_module(struct device *dev)
 {
 	return -ENODEV;
-- 
2.34.1

