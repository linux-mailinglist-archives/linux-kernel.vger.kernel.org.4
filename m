Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9AF6B0CC4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjCHPcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjCHPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:32:10 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBADD00BB;
        Wed,  8 Mar 2023 07:32:08 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 92C2EFF811;
        Wed,  8 Mar 2023 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678289527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d7F2M8VnDDXmy9O162M9BQ7Ae5cMRG6sexpSbXAe5/s=;
        b=K5yRydIedYdQ7/AlZQzh/LnhSX7R0EnGUcHlKj8ANFe1L3+s7ZSEuoVY34sDhCrNCe7LA1
        tzZ3cx+gKgM3z5zflDmxJ3zJQDGHUG1b0mXfIyPBSvYhtbmrnegnydxZ58fTNOVbKdfH4Q
        +FFVIeGLta5TA29rym45xbKWMMaZxDXd+5/vTdgbNsndmmQaMZDhCwLpUC6LJTvEyo38u1
        7W+tarQNhvOh/xK85+oLKi4QuxAdUnqCIEc1t7jNoUjOL5ukWX69VNHPgrMIDlj2n+Lygx
        NY7uteHJnSlJSNbtlUPa9FMA/TqM06ZeEnXDQ8Xh0FahlD3p1/P76SQKDPspRg==
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
Subject: [PATCH v3 02/20] of: Update of_device_get_modalias()
Date:   Wed,  8 Mar 2023 16:31:42 +0100
Message-Id: <20230308153200.682248-3-miquel.raynal@bootlin.com>
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

This function only needs a "struct device_node" to work, but for
convenience the author (and only user) of this helper did use a "struct
device" and put it in device.c.

Let's convert this helper to take a "struct device node" instead. This
change asks for two additional changes: renaming it "of_modalias()"
to fit the current naming, and moving it outside of device.c which will
be done in a follow-up commit.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Hello, please mind that I am on purpose dropping the check for
of_node_reused in the request_module helper because I believe
this check simply does not apply here. If I am misunderstanding
something please let me know.
Thanks!
---
 drivers/of/device.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index c91bb5899256..351c505ecb50 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -248,7 +248,7 @@ const void *of_device_get_match_data(const struct device *dev)
 }
 EXPORT_SYMBOL(of_device_get_match_data);
 
-static ssize_t of_device_get_modalias(const struct device *dev, char *str, ssize_t len)
+static ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
 {
 	const char *compat;
 	char *c;
@@ -256,19 +256,16 @@ static ssize_t of_device_get_modalias(const struct device *dev, char *str, ssize
 	ssize_t csize;
 	ssize_t tsize;
 
-	if ((!dev) || (!dev->of_node) || dev->of_node_reused)
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
+	size = of_modalias(dev->of_node, NULL, 0);
 	if (size < 0)
 		return size;
 
@@ -304,7 +304,7 @@ int of_device_request_module(struct device *dev)
 	if (!str)
 		return -ENOMEM;
 
-	of_device_get_modalias(dev, str, size);
+	of_modalias(dev->of_node, str, size);
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
+	if (!dev || !dev->of_node || dev->of_node_reused)
+		return -ENODEV;
+
+	sl = of_modalias(dev->of_node, str, len - 2);
 	if (sl < 0)
 		return sl;
 	if (sl > len - 2)
@@ -386,8 +391,8 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
 	if (add_uevent_var(env, "MODALIAS="))
 		return -ENOMEM;
 
-	sl = of_device_get_modalias(dev, &env->buf[env->buflen-1],
-				    sizeof(env->buf) - env->buflen);
+	sl = of_modalias(dev->of_node, &env->buf[env->buflen-1],
+			 sizeof(env->buf) - env->buflen);
 	if (sl < 0)
 		return sl;
 	if (sl >= (sizeof(env->buf) - env->buflen))
-- 
2.34.1

