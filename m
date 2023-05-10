Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C406FE1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbjEJPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbjEJPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:48:09 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D5C10FA;
        Wed, 10 May 2023 08:48:07 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 90E59C0005;
        Wed, 10 May 2023 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683733686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/KSDSRKpLHcB4gpgTZNIsinLN/YQM+hIOrBqkC1k88=;
        b=UyBOIGVDHTkQ8GTasBO0HB+J1Z++0S2Zw1KtqqxmwJ4aGo1ar2Fehj+YzqCd6nS9aiJGk/
        QOiyr4fDBL+t9ntTKIlFiCOfk00S5AjWG/encJ5YI4PUdlSKCTOi15hO6HQjCB5SuTe7Lh
        HQsVgBhuEYVlvDsCJN2/yLuATuL7TI7gSsZo0nBDvUt0hcSkxvutbWZGDPoR8sYKECBzoi
        PhppTuKWj0NcjNng2XItbbpsvkn1N3dXJ367S0donGgt2cQYM3f25bYfyqKFgLGxyNgUY9
        K9+1jyBXd2FOVnxVI2K6WYNswx6HUfUCQK8VyM62nc8x9N0nFQ9ABQ9+Y46jlw==
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
Subject: [PATCH 2/5] of: module: Mutate of_device_uevent() into two helpers
Date:   Wed, 10 May 2023 17:48:00 +0200
Message-Id: <20230510154803.189096-3-miquel.raynal@bootlin.com>
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

Move the OF related logic inside of/module.c and use it from of_device.h
with an inline helper so there is no visible change from the users point
of view.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/of/device.c       | 42 ---------------------------------------
 drivers/of/module.c       | 41 ++++++++++++++++++++++++++++++++++++++
 include/linux/of.h        |  6 ++++++
 include/linux/of_device.h | 17 +++++++++++++---
 4 files changed, 61 insertions(+), 45 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 45ce83a8945f..5e538e1ed623 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -246,48 +246,6 @@ const void *of_device_get_match_data(const struct device *dev)
 }
 EXPORT_SYMBOL(of_device_get_match_data);
 
-/**
- * of_device_uevent - Display OF related uevent information
- * @dev:	Device to display the uevent information for
- * @env:	Kernel object's userspace event reference to fill up
- */
-void of_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
-{
-	const char *compat, *type;
-	struct alias_prop *app;
-	struct property *p;
-	int seen = 0;
-
-	if ((!dev) || (!dev->of_node))
-		return;
-
-	add_uevent_var(env, "OF_NAME=%pOFn", dev->of_node);
-	add_uevent_var(env, "OF_FULLNAME=%pOF", dev->of_node);
-	type = of_node_get_device_type(dev->of_node);
-	if (type)
-		add_uevent_var(env, "OF_TYPE=%s", type);
-
-	/* Since the compatible field can contain pretty much anything
-	 * it's not really legal to split it out with commas. We split it
-	 * up using a number of environment variables instead. */
-	of_property_for_each_string(dev->of_node, "compatible", p, compat) {
-		add_uevent_var(env, "OF_COMPATIBLE_%d=%s", seen, compat);
-		seen++;
-	}
-	add_uevent_var(env, "OF_COMPATIBLE_N=%d", seen);
-
-	seen = 0;
-	mutex_lock(&of_mutex);
-	list_for_each_entry(app, &aliases_lookup, link) {
-		if (dev->of_node == app->np) {
-			add_uevent_var(env, "OF_ALIAS_%d=%s", seen,
-				       app->alias);
-			seen++;
-		}
-	}
-	mutex_unlock(&of_mutex);
-}
-
 int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *env)
 {
 	int sl;
diff --git a/drivers/of/module.c b/drivers/of/module.c
index c05fb8ca575c..c729675fdd04 100644
--- a/drivers/of/module.c
+++ b/drivers/of/module.c
@@ -8,6 +8,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#include "of_private.h"
+
 ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
 {
 	const char *compat;
@@ -91,3 +93,42 @@ int of_request_module(const struct device_node *np)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_request_module);
+
+int of_uevent(struct device_node *np, struct kobj_uevent_env *env)
+{
+	const char *compat, *type;
+	struct alias_prop *app;
+	struct property *p;
+	int seen = 0;
+
+	if (!np)
+		return -ENODEV;
+
+	add_uevent_var(env, "OF_NAME=%pOFn", np);
+	add_uevent_var(env, "OF_FULLNAME=%pOF", np);
+	type = of_node_get_device_type(np);
+	if (type)
+		add_uevent_var(env, "OF_TYPE=%s", type);
+
+	/* Since the compatible field can contain pretty much anything
+	 * it's not really legal to split it out with commas. We split it
+	 * up using a number of environment variables instead. */
+	of_property_for_each_string(np, "compatible", p, compat) {
+		add_uevent_var(env, "OF_COMPATIBLE_%d=%s", seen, compat);
+		seen++;
+	}
+	add_uevent_var(env, "OF_COMPATIBLE_N=%d", seen);
+
+	seen = 0;
+	mutex_lock(&of_mutex);
+	list_for_each_entry(app, &aliases_lookup, link) {
+		if (np == app->np) {
+			add_uevent_var(env, "OF_ALIAS_%d=%s", seen,
+				       app->alias);
+			seen++;
+		}
+	}
+	mutex_unlock(&of_mutex);
+
+	return 0;
+}
diff --git a/include/linux/of.h b/include/linux/of.h
index dcdd9396ac37..d99f33fc25d3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -388,6 +388,7 @@ extern ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
 extern ssize_t of_printable_modalias(const struct device_node *np, char *str,
 				     ssize_t len);
 extern int of_request_module(const struct device_node *np);
+extern int of_uevent(struct device_node *np, struct kobj_uevent_env *env);
 
 /* phandle iterator functions */
 extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
@@ -771,6 +772,11 @@ static inline int of_request_module(const struct device_node *np)
 	return -ENODEV;
 }
 
+static inline int of_uevent(struct device_node *np, struct kobj_uevent_env *env)
+{
+	return -ENODEV;
+}
+
 static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
 					   const struct device_node *np,
 					   const char *list_name,
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index bca66f59814a..af5ee78e0c05 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -35,7 +35,15 @@ static inline ssize_t of_device_modalias(struct device *dev, char *str,
 	return of_printable_modalias(dev->of_node, str, len);
 }
 
-extern void of_device_uevent(const struct device *dev, struct kobj_uevent_env *env);
+static inline int of_device_uevent(const struct device *dev,
+				   struct kobj_uevent_env *env)
+{
+	if (!dev || !dev->of_node)
+		return -ENODEV;
+
+	return of_uevent(dev->of_node, env);
+}
+
 extern int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *env);
 
 int of_dma_configure_id(struct device *dev,
@@ -55,8 +63,11 @@ static inline int of_driver_match_device(struct device *dev,
 	return 0;
 }
 
-static inline void of_device_uevent(const struct device *dev,
-			struct kobj_uevent_env *env) { }
+static inline int of_device_uevent(const struct device *dev,
+				   struct kobj_uevent_env *env)
+{
+	return -ENODEV;
+}
 
 static inline ssize_t of_device_modalias(struct device *dev,
 					 char *str, ssize_t len)
-- 
2.34.1

