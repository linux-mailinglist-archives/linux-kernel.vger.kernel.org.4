Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666506B473F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjCJOtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjCJOr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:56 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD699122397;
        Fri, 10 Mar 2023 06:47:28 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id t5-20020a4ac885000000b005251f70a740so813463ooq.8;
        Fri, 10 Mar 2023 06:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hwy37whypJJxvCg5xXOf1fAsBsyJNE4bTOGuf7mwrkI=;
        b=BKr1UbtbLtPZ+QS6ZhwTwzAQV8t93xA28Xstx1Ah67w5Lb5pKYHXKzaAX1h9kieMw1
         Z34+4B9ZPEA9NtYDTM/eKSZsDmBJNbqoWHcEN/1YEmeXUdmD0ZcFWJmkzi8uKhcaUamP
         GtmTqV/LmaaQ2MOSulqynlrZ5UQ3/cD7ppFUFUAA/1uHi/MQDrQtwe0uSH62nth3AWNW
         uyo89GGYDiGL8WoFbE8BLaZb3pOlp6fPiHnvkE+NcbePSCos7uoAWzT7HwYKyQTTQqql
         CejlYKzO1M5PcQfA/+Otgh0iyNLKunMC//lpMxdyd8ifbydvV5sbEXW8DdewqTMsiltT
         nCKQ==
X-Gm-Message-State: AO0yUKUKussJ9xjrm6ZGD4naTCy4ThrPpK4EGUryGbY7drJ2Q3t7Ot4Z
        TBKVJLodLEr8bd582aIMlA==
X-Google-Smtp-Source: AK7set9UyS6Pa/vr1iG/QWJLY79BI/y2Y2ahlCo8e8H/dL1H6Q3t+yK0hLAnsjyOAfPJQVp7v8Q5Zg==
X-Received: by 2002:a4a:d498:0:b0:51a:48f4:75de with SMTP id o24-20020a4ad498000000b0051a48f475demr1425202oos.0.1678459648090;
        Fri, 10 Mar 2023 06:47:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s25-20020a4adb99000000b00525240c6149sm837812oou.31.2023.03.10.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:27 -0800 (PST)
Received: (nullmailer pid 1542322 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:05 -0600
Message-Id: <20230310144706.1542295-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 2 +-
 drivers/gpu/drm/tiny/ofdrm.c           | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 530ee6a19e7e..efa80e309b98 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -496,7 +496,7 @@ static int ps8622_probe(struct i2c_client *client)
 		ps8622->lane_count = ps8622->max_lane_count;
 	}
 
-	if (!of_find_property(dev->of_node, "use-external-pwm", NULL)) {
+	if (!of_property_read_bool(dev->of_node, "use-external-pwm")) {
 		ps8622->bl = backlight_device_register("ps8622-backlight",
 				dev, ps8622, &ps8622_backlight_ops,
 				NULL);
diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
index 6e349ca42485..76cd7f515bab 100644
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -162,13 +162,9 @@ static bool display_get_big_endian_of(struct drm_device *dev, struct device_node
 	bool big_endian;
 
 #ifdef __BIG_ENDIAN
-	big_endian = true;
-	if (of_get_property(of_node, "little-endian", NULL))
-		big_endian = false;
+	big_endian = !of_property_read_bool(of_node, "little-endian");
 #else
-	big_endian = false;
-	if (of_get_property(of_node, "big-endian", NULL))
-		big_endian = true;
+	big_endian = of_property_read_bool(of_node, "big-endian");
 #endif
 
 	return big_endian;
-- 
2.39.2

