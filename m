Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819236FE1DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbjEJPsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbjEJPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:48:11 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149DD1BCB;
        Wed, 10 May 2023 08:48:08 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A716FC0004;
        Wed, 10 May 2023 15:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683733687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTzUAUn2/6zCa90roD3BEhvCRbYoR3aMy4PUneIBrPM=;
        b=UkiDwJ6PmmRH+dllni1nZppCO1kMi1iL8f0YSzz6HMHb6cDJPNmwTh8WsvIlDrbl1Ewpml
        JhgPduur1oojt7UZEDpsmRFpFSpSvpaIWASDDMJ5Ve+FT7l/C3A+se09IfN+emu6+OUdLi
        mZyQQ9NdIIYgn+zM3RQqh2WdLt9pnConqmEEEgHJKM1WxXbbl02tV2LlWxw+lWD8ETYa4Y
        rJjaHH7kho1KvYF9c9N1qMAtbWb7RP4uHWKLD8DsyfQuKYcJIJms84KTwMLlvgIHAdKeMM
        KDYkX8tZWSOsfDnSEnL3JVMw6pwKGJelLceNIYpxYqFT9kMWwX3JbWfPl9m3aw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/5] of: module: Mutate of_device_uevent_modalias() into two helpers
Date:   Wed, 10 May 2023 17:48:01 +0200
Message-Id: <20230510154803.189096-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510154803.189096-1-miquel.raynal@bootlin.com>
References: <20230510154803.189096-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the logic of the former helper into module.c and use it from
an inline helper located under of_device.c. This way there is no change
for users while the logic gets moved to an OF-only file.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/of/device.c       | 23 -----------------------
 drivers/of/module.c       | 21 +++++++++++++++++++++
 include/linux/of.h        |  7 +++++++
 include/linux/of_device.h |  9 ++++++++-
 4 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 5e538e1ed623..7909eefc650e 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -245,26 +245,3 @@ const void *of_device_get_match_data(const struct device *dev)
 	return match->data;
 }
 EXPORT_SYMBOL(of_device_get_match_data);
-
-int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *env)
-{
-	int sl;
-
-	if ((!dev) || (!dev->of_node) || dev->of_node_reused)
-		return -ENODEV;
-
-	/* Devicetree modalias is tricky, we add it in 2 steps */
-	if (add_uevent_var(env, "MODALIAS="))
-		return -ENOMEM;
-
-	sl = of_modalias(dev->of_node, &env->buf[env->buflen-1],
-			 sizeof(env->buf) - env->buflen);
-	if (sl < 0)
-		return sl;
-	if (sl >= (sizeof(env->buf) - env->buflen))
-		return -ENOMEM;
-	env->buflen += sl;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
diff --git a/drivers/of/module.c b/drivers/of/module.c
index c729675fdd04..874f3fb8220f 100644
--- a/drivers/of/module.c
+++ b/drivers/of/module.c
@@ -132,3 +132,24 @@ int of_uevent(struct device_node *np, struct kobj_uevent_env *env)
 
 	return 0;
 }
+
+int of_uevent_modalias(const struct device_node *np, struct kobj_uevent_env *env)
+{
+	int sl;
+
+	if (!np)
+		return -ENODEV;
+
+	/* Devicetree modalias is tricky, we add it in 2 steps */
+	if (add_uevent_var(env, "MODALIAS="))
+		return -ENOMEM;
+
+	sl = of_modalias(np, &env->buf[env->buflen-1],
+			 sizeof(env->buf) - env->buflen);
+	if (sl >= (sizeof(env->buf) - env->buflen))
+		return -ENOMEM;
+	env->buflen += sl;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_uevent_modalias);
diff --git a/include/linux/of.h b/include/linux/of.h
index d99f33fc25d3..203bd2895d94 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -389,6 +389,7 @@ extern ssize_t of_printable_modalias(const struct device_node *np, char *str,
 				     ssize_t len);
 extern int of_request_module(const struct device_node *np);
 extern int of_uevent(struct device_node *np, struct kobj_uevent_env *env);
+extern int of_uevent_modalias(const struct device_node *np, struct kobj_uevent_env *env);
 
 /* phandle iterator functions */
 extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
@@ -777,6 +778,12 @@ static inline int of_uevent(struct device_node *np, struct kobj_uevent_env *env)
 	return -ENODEV;
 }
 
+static inline int of_uevent_modalias(const struct device_node *np,
+				     struct kobj_uevent_env *env)
+{
+	return -ENODEV;
+}
+
 static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
 					   const struct device_node *np,
 					   const char *list_name,
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index af5ee78e0c05..5e428bcf3d63 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -44,7 +44,14 @@ static inline int of_device_uevent(const struct device *dev,
 	return of_uevent(dev->of_node, env);
 }
 
-extern int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *env);
+static inline int of_device_uevent_modalias(const struct device *dev,
+					    struct kobj_uevent_env *env)
+{
+	if (!dev || !dev->of_node || dev->of_node_reused)
+		return -ENODEV;
+
+	return of_uevent_modalias(dev->of_node, env);
+}
 
 int of_dma_configure_id(struct device *dev,
 		     struct device_node *np,
-- 
2.34.1

