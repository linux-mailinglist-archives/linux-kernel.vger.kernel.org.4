Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128D970A047
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjESUFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjESUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:05:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AB8102
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:05:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f4ad71b00eso23352795e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1684526734; x=1687118734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=unGGcWMXSxlIkISO/XPChAGC5INeHx+xymr7hphOHTk=;
        b=k5Guw/07AnhDpxjKB8UcXAAmZWcQ5O3JowQVJ8laPyua71EN/rsYssN/IFPaFpkVpI
         TNQ3Unj6O43cAdOO+OlJb/KWDnruigOlVvcsww9kNmV0PUazy0v2IbPDWbOOOPXT46IK
         gb2tn8Hf/7Bg0Lu5ehkHUxiwM3yKMAO1UQ2MwV2DKEkEB946eY0I3G1Gxks2hY+Ydn7W
         ecXUt3qg+NzSrGI0M2vHUQcH7ryHNXhU1MzhxtbmTvYxXhHlz6txRv/tGxamizDCnjzp
         i2DRuPB/RPO5+nSINoDpkwQxIm/dOb0kmar0qY5Mm/EYGnDK2PDeXlgtmjuPcYIxJN/+
         M8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684526734; x=1687118734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unGGcWMXSxlIkISO/XPChAGC5INeHx+xymr7hphOHTk=;
        b=kxDAAPqjFFJbA1aj4psyu5SR1i5zSA1rHoEgSohZ7KbiXfvXHUMdR/8X4Uq9Dg8f36
         s5TIv6VYov8LN/MwaJORVioPhs4RBDi4cJipJVwFUmPk+OJKfWN9UssskTAU8NpCAr7q
         NDQhQHjGIw0ML4PkNi1kXPsddrvUR4b9gCSBdsNhHvKLeklAnN00X/PTrvHSllYxyJSp
         6ZqAHVJPUs5IoKrP5N9hjTPNhcDPfpD9jxpGNgihZKC14jIhM15pA8fcDG9DenMqS+wR
         L4zz3aHxcfZygpYq4+CbWulmCGu7vkJPLuJrIff3WA4nTh01ZMr4oF9z39h+YIBs2sVH
         P/eg==
X-Gm-Message-State: AC+VfDwwBO4gvZYCsAt3TXoDuTIjWKpqmMtv7epQv0V5JMr6wxI9/QFQ
        i2r3vJaSH4al5BZPqHYwX/BdTw==
X-Google-Smtp-Source: ACHHUZ7ga4CZxLiQQKfdmi4Xqh4DykUfMWEgzKKffEXW7eHm0kD86vFODcQqOLeT733JRNm32EOAfA==
X-Received: by 2002:a1c:7303:0:b0:3f1:9acf:8682 with SMTP id d3-20020a1c7303000000b003f19acf8682mr2044341wmb.17.1684526733947;
        Fri, 19 May 2023 13:05:33 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.2])
        by smtp.gmail.com with ESMTPSA id q3-20020adfea03000000b002fe96f0b3acsm6220329wrm.63.2023.05.19.13.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:05:33 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        deller@gmx.de, Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH 1/2] backlight: gpio_backlight: add new property default-brightness-level
Date:   Fri, 19 May 2023 23:05:19 +0300
Message-Id: <20230519200520.10657-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertre <yannick.fertre@foss.st.com>

Add new property to set a brightness by default at probe.

Reviewed-by: Philippe CORNU <philippe.cornu@foss.st.com>
Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---

Link to original patch:
  https://github.com/STMicroelectronics/linux/commit/c4067d7bd883c6fa14ffd49892c4ce663cdafe98

 drivers/video/backlight/gpio_backlight.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 6f78d928f054..d3fa3a8bef4d 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -53,6 +53,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
 	int ret, init_brightness, def_value;
+	u32 value;
 
 	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
 	if (gbl == NULL)
@@ -93,7 +94,11 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	else
 		bl->props.power = FB_BLANK_UNBLANK;
 
-	bl->props.brightness = 1;
+	ret = device_property_read_u32(dev, "default-brightness-level", &value);
+	if (!ret && value <= props.max_brightness)
+		bl->props.brightness = value;
+	else
+		bl->props.brightness = 1;
 
 	init_brightness = backlight_get_brightness(bl);
 	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
-- 
2.40.1

