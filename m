Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76876FE1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbjEJPsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbjEJPsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:48:14 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4367619B6;
        Wed, 10 May 2023 08:48:12 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 073A0C000C;
        Wed, 10 May 2023 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683733690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8C8MXrqjqKXj0eKsxGXL9GkrBq/7JcKAOeht6U8KtQ=;
        b=jrmGFUr2y+aOVqpJ1iPloWve2lq8N4iHH6SoENv2W/wV94WrcuwK8jOqlG7rPvLt6gckhN
        gvzm94tlydwTS5IAluF6icZG/5auLBEKIUhgJgnsgZCsJseLP8iZ2duxFoPVJ4FFI8itRm
        Qqltvlr4+O7bdd/MMgublxvFBUvHaam1Dyc9gIvpT11ca+1kPdL3p56QFa2XGUC9GDbfWR
        LPr75aieSdqJVFFIkFxE8wtBPDxETpKU28oNQ/9FeOoRq+dpF9Zmn1XihIqsgVtb50GrRw
        xVSkPb4DRopl5PhnUFfgsGAZWDgZdxOS5uNNF0+QR1Ocw0KLQ5Oq3ITr6KVtvA==
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
Subject: [PATCH 5/5] gpu: host1x: Stop open-coding of_device_uevent()
Date:   Wed, 10 May 2023 17:48:03 +0200
Message-Id: <20230510154803.189096-6-miquel.raynal@bootlin.com>
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

There is apparently no reasons to open-code of_device_uevent() besides:
- The helper receives a struct device while we want to use the of_node
  member of the struct device *parent*.
- of_device_uevent() could not be called by modules because of a missing
  EXPORT_SYMBOL*().

In practice, the former point is not very constraining, just calling
of_device_uevent(dev->parent, ...) would have made the trick.

The latter point is more an observation rather than a real blocking
point because nothing prevented of_uevent() (called by the inline
function of_device_uevent()) to be exported to modules. In practice,
this helper is now exported, so nothing prevent us from using
of_device_uevent() anymore.

Let's use the core helper directly instead of open-coding it.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

---

This patch depends on the changes performed earlier in the series under
the drivers/of/ folder.
---
 drivers/gpu/host1x/bus.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 4d16a3396c4a..6434a183fb72 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -338,34 +338,15 @@ static int host1x_device_match(struct device *dev, struct device_driver *drv)
 	return strcmp(dev_name(dev), drv->name) == 0;
 }
 
+/*
+ * Note that this is really only needed for backwards compatibility
+ * with libdrm, which parses this information from sysfs and will
+ * fail if it can't find the OF_FULLNAME, specifically.
+ */
 static int host1x_device_uevent(const struct device *dev,
 				struct kobj_uevent_env *env)
 {
-	struct device_node *np = dev->parent->of_node;
-	unsigned int count = 0;
-	struct property *p;
-	const char *compat;
-
-	/*
-	 * This duplicates most of of_device_uevent(), but the latter cannot
-	 * be called from modules and operates on dev->of_node, which is not
-	 * available in this case.
-	 *
-	 * Note that this is really only needed for backwards compatibility
-	 * with libdrm, which parses this information from sysfs and will
-	 * fail if it can't find the OF_FULLNAME, specifically.
-	 */
-	add_uevent_var(env, "OF_NAME=%pOFn", np);
-	add_uevent_var(env, "OF_FULLNAME=%pOF", np);
-
-	of_property_for_each_string(np, "compatible", p, compat) {
-		add_uevent_var(env, "OF_COMPATIBLE_%u=%s", count, compat);
-		count++;
-	}
-
-	add_uevent_var(env, "OF_COMPATIBLE_N=%u", count);
-
-	return 0;
+	return of_device_uevent((const struct device *)&dev->parent, env);
 }
 
 static int host1x_dma_configure(struct device *dev)
-- 
2.34.1

