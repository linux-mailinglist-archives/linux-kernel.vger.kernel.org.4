Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB6F72E4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242851AbjFMOGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbjFMOFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:05:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260151726
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:04:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso2401498a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686665052; x=1689257052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wV1ZBCQjYQHvbeHi8yLp3xmcTHgw1kfbgJnzsS6tlZo=;
        b=H8J5ul4PsRZcJmgBe7iCXSLoFpCYGhsNk4GLdmK1Xn99j8m++RJzRzeQHBisfcYkKW
         0k2gvVhPYWZYS4TPS3sWH1ZzJ8B/iz1Em0rZZLsSpPPnvNU6fQO/E1897mbZcQydhYl7
         7/HOTMIW3+YhQCOovwaUh+EZQZJ62/R1UoITg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665052; x=1689257052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wV1ZBCQjYQHvbeHi8yLp3xmcTHgw1kfbgJnzsS6tlZo=;
        b=SOXw4ylH/RR65EUWU4wiVu+FaBs1JKqt6CpbpnP6+2sV1QFGzvbweVDqWgMt05XmaK
         he9tjdDqk9FUsUyhp39A0Cx1oOEIgA/Xrb5aUT0sAuu02f6tzGkdJ3u72610uYnOzdl/
         1GDqYRu6UcAg8o/a/83295VFCRRv4pDslyW4Nwih0pqWZhzA0nw9Wo5GukKLu/eLFNdh
         G3I/Su/6I/9NIf77+CyqnBE+HParZ7ItzKEIa5ywNas3Tfhq5UHqMlifP00PgNAhaSX5
         cpc2CfB1tFOfbXSfEDP9QtqLZhwBM8zEmDZ6gZBy99ZxkORizE2vN+bVuB6vn/UY63/n
         OIlA==
X-Gm-Message-State: AC+VfDwV/rnZXzrWsfF+tfQEf+PxHV9W8ylT+v1acI8J16eR9DL54h8N
        hJxXuO02Qp8iZxTfuaOMOcXDaw==
X-Google-Smtp-Source: ACHHUZ5VvQYmTmmIQqWjBevrcuv0PqFAFA2sN0IEpIr8oW0LWuYdqhdjUi7u9PR3BVPRxpCxdUTN4Q==
X-Received: by 2002:a17:90a:d304:b0:25b:e081:54e6 with SMTP id p4-20020a17090ad30400b0025be08154e6mr5037015pju.37.1686665051648;
        Tue, 13 Jun 2023 07:04:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:1995:7db0:daf3:2c2a])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a1a5200b0025c058be940sm2259230pjl.0.2023.06.13.07.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:04:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime
Date:   Tue, 13 Jun 2023 06:58:13 -0700
Message-ID: <20230613065812.v2.1.I24b838a5b4151fb32bccd6f36397998ea2df9fbb@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory for the "struct device" for any given device isn't supposed to
be released until the device's release() is called. This is important
because someone might be holding a kobject reference to the "struct
device" and might try to access one of its members even after any
other cleanup/uninitialization has happened.

Code analysis of ti-sn65dsi86 shows that this isn't quite right. When
the code was written, it was believed that we could rely on the fact
that the child devices would all be freed before the parent devices
and thus we didn't need to worry about a release() function. While I
still believe that the parent's "struct device" is guaranteed to
outlive the child's "struct device" (because the child holds a kobject
reference to the parent), the parent's "devm" allocated memory is a
different story. That appears to be freed much earlier.

Let's make this better for ti-sn65dsi86 by allocating each auxiliary
with kzalloc and then free that memory in the release().

Fixes: bf73537f411b ("drm/bridge: ti-sn65dsi86: Break GPIO and MIPI-to-eDP bridge into sub-drivers")
Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Check for allocation failure.
- Delete a blank line.

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 35 +++++++++++++++++----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 597ceb7024e0..e3de68f226e8 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -170,10 +170,10 @@
  * @pwm_refclk_freq: Cache for the reference clock input to the PWM.
  */
 struct ti_sn65dsi86 {
-	struct auxiliary_device		bridge_aux;
-	struct auxiliary_device		gpio_aux;
-	struct auxiliary_device		aux_aux;
-	struct auxiliary_device		pwm_aux;
+	struct auxiliary_device		*bridge_aux;
+	struct auxiliary_device		*gpio_aux;
+	struct auxiliary_device		*aux_aux;
+	struct auxiliary_device		*pwm_aux;
 
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -464,27 +464,34 @@ static void ti_sn65dsi86_delete_aux(void *data)
 	auxiliary_device_delete(data);
 }
 
-/*
- * AUX bus docs say that a non-NULL release is mandatory, but it makes no
- * sense for the model used here where all of the aux devices are allocated
- * in the single shared structure. We'll use this noop as a workaround.
- */
-static void ti_sn65dsi86_noop(struct device *dev) {}
+static void ti_sn65dsi86_aux_device_release(struct device *dev)
+{
+	struct auxiliary_device *aux = container_of(dev, struct auxiliary_device, dev);
+
+	kfree(aux);
+}
 
 static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
-				       struct auxiliary_device *aux,
+				       struct auxiliary_device **aux_out,
 				       const char *name)
 {
 	struct device *dev = pdata->dev;
+	struct auxiliary_device *aux;
 	int ret;
 
+	aux = kzalloc(sizeof(*aux), GFP_KERNEL);
+	if (!aux)
+		return -ENOMEM;
+
 	aux->name = name;
 	aux->dev.parent = dev;
-	aux->dev.release = ti_sn65dsi86_noop;
+	aux->dev.release = ti_sn65dsi86_aux_device_release;
 	device_set_of_node_from_dev(&aux->dev, dev);
 	ret = auxiliary_device_init(aux);
-	if (ret)
+	if (ret) {
+		kfree(aux);
 		return ret;
+	}
 	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_uninit_aux, aux);
 	if (ret)
 		return ret;
@@ -493,6 +500,8 @@ static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
 	if (ret)
 		return ret;
 	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_delete_aux, aux);
+	if (!ret)
+		*aux_out = aux;
 
 	return ret;
 }
-- 
2.41.0.162.gfafddb0af9-goog

