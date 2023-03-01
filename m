Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6496A6F4E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCAPXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCAPWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:22:48 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C801A43913;
        Wed,  1 Mar 2023 07:22:45 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 195366000E;
        Wed,  1 Mar 2023 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677684164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7AJrEMliVgBGap4LkX/HwlJ+8DgiboSpzHjInCtEXM=;
        b=IQjaQf6SnB4xzp2ZcsKZdwwmYbgP6zO+qx9MDcHhTY3LB0uttv5GFdaJ10fIpeEOkXtuxc
        O8iwOHhZFYR0+rdGC2DcMefWDub/i3h1R059kyct7yg8dNOUphv8MGq9S7RMF0v18AkUXR
        3ABsklzeBxg6psCn/3Q+akkRUFSjd0Lyp4+uaB9opG6Up6/IKSNv+OUGjR6KuPQHhW65Wu
        rmkqR4GiSQanxQqvGs683wK8blJec9eqdlSNM6K+GJKL2Z1EeOuU1w2v78H8PADr/C5Kej
        m8BHqEp5TdUtujborz+WU5IJ/NuiZrHaHYLMvvIkqI1hbh62YNL1yVHz6F/GqQ==
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
Subject: [PATCH 2/8] of: Change of_device_get_modalias() main argument
Date:   Wed,  1 Mar 2023 16:22:33 +0100
Message-Id: <20230301152239.531194-3-miquel.raynal@bootlin.com>
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

This function needs "struct device_node" to work, but for convenience
the author and only user of this helper did use a "struct device". As
this helper is a static helper, let's keep the "struct device" for
exported methods and use the OF structure internally.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/of/device.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 877f50379fab..3efc17de1d57 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -248,7 +248,7 @@ const void *of_device_get_match_data(const struct device *dev)
 }
 EXPORT_SYMBOL(of_device_get_match_data);
 
-static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
+static ssize_t of_device_get_modalias(struct device_node *np, char *str, ssize_t len)
 {
 	const char *compat;
 	char *c;
@@ -256,19 +256,16 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
 	ssize_t csize;
 	ssize_t tsize;
 
-	if ((!dev) || (!dev->of_node))
-		return -ENODEV;
-
 	/* Name & Type */
 	/* %p eats all alphanum characters, so %c must be used here */
-	csize = snprintf(str, len, "of:N%pOFn%c%s", dev->of_node, 'T',
-			 of_node_get_device_type(dev->of_node));
+	csize = snprintf(str, len, "of:N%pOFn%c%s", np, 'T',
+			 of_node_get_device_type(np));
 	tsize = csize;
 	len -= csize;
 	if (str)
 		str += csize;
 
-	of_property_for_each_string(dev->of_node, "compatible", p, compat) {
+	of_property_for_each_string(np, "compatible", p, compat) {
 		csize = strlen(compat) + 1;
 		tsize += csize;
 		if (csize > len)
@@ -293,7 +290,10 @@ int of_device_request_module(struct device *dev)
 	ssize_t size;
 	int ret;
 
-	size = of_device_get_modalias(dev, NULL, 0);
+	if (!dev || !dev->of_node)
+		return -ENODEV;
+
+	size = of_device_get_modalias(dev->of_node, NULL, 0);
 	if (size < 0)
 		return size;
 
@@ -304,7 +304,7 @@ int of_device_request_module(struct device *dev)
 	if (!str)
 		return -ENOMEM;
 
-	of_device_get_modalias(dev, str, size);
+	of_device_get_modalias(dev->of_node, str, size);
 	str[size - 1] = '\0';
 	ret = request_module(str);
 	kfree(str);
@@ -321,7 +321,12 @@ EXPORT_SYMBOL_GPL(of_device_request_module);
  */
 ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
 {
-	ssize_t sl = of_device_get_modalias(dev, str, len - 2);
+	ssize_t sl;
+
+	if ((!dev) || (!dev->of_node))
+		return -ENODEV;
+
+	sl = of_device_get_modalias(dev->of_node, str, len - 2);
 	if (sl < 0)
 		return sl;
 	if (sl > len - 2)
@@ -386,7 +391,7 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
 	if (add_uevent_var(env, "MODALIAS="))
 		return -ENOMEM;
 
-	sl = of_device_get_modalias(dev, &env->buf[env->buflen-1],
+	sl = of_device_get_modalias(dev->of_node, &env->buf[env->buflen-1],
 				    sizeof(env->buf) - env->buflen);
 	if (sl >= (sizeof(env->buf) - env->buflen))
 		return -ENOMEM;
-- 
2.34.1

