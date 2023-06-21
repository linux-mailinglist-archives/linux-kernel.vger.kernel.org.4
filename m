Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68C27391DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjFUVzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjFUVzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:55:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0183E19A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:55:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so7577896a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1687384506; x=1689976506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRUDsn4e6Ks8YzmKCfn5h1mpk0f1GA6PVcpiiIMFAtA=;
        b=ryqDqOAnnAJv9G8ZbZBMXI5Qf+NLTe4Z9G/CWY3yA0+dio5cKumyowL69kJfe4FSZ4
         3/YwzXdHBxwfWqgXBexKcev4SCbeY75p0+Quq+Bsmx0dkRqAKi2foN/NHk93KSSNpt2G
         9valT+R/D0YupatdQ9mJ8e5ogQnivBeohbZwy6luFduk0m0SvbuZiIrjiL16lPrlLM2U
         MfxFXJLqzPuZB48nubuzvOwBk/aLqDI2j+FKXY3iB8oBsDhng/Hr87OGMFObUMd0MQdI
         SedfW0L6q9PhuH+pS1qiEl/qbActqTHvoDcdHM/LKVs+o4yDOGpAUSke/eC4IuFGqaGh
         C7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687384506; x=1689976506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRUDsn4e6Ks8YzmKCfn5h1mpk0f1GA6PVcpiiIMFAtA=;
        b=RpwyFefBjy6tsyw0r/kchsS8MxsU8/qCl0avN7xdPDKxn8XRu3CfdYR1/XjsGdNGkN
         VD5byJWfHiO62IOjk0Go0699cGNH+Lh4SAgS4sfZZPW8I6LdtJNkQV+u/0pcgfqJQ4ly
         VICe2/nmjqpTbOcsJC/LyX2h38/KDvus0K0KawgsqYIapCUZIAz1PKQ6fVeHNMn0UMu4
         WobJL02blgscEQI+AH+0B/R7yGww4Xy6at4oOvLDBmcJ1JM28NDMPGNTI+QW+4QXykak
         YQbbbxowm+s6B3FJpCG2lBYn2j2R0+es/gZXzk09/EYXNMk9NG26QT/da32KgSCOVsLD
         EHHQ==
X-Gm-Message-State: AC+VfDx0tMHe5ybYDwqjNR81sd/EPgiVsrSEjQm7cqh3a/e6PW+F+5Ww
        fQOHmbhadlq5O1i/exZKvoUaFw==
X-Google-Smtp-Source: ACHHUZ68KU6zeF4KhP/4rSB+WCwcso3Hz0SCmqZuTCSqxgmUfmsCgyUVJ5ghWnoL72nCuOtxLztz5A==
X-Received: by 2002:aa7:c3cc:0:b0:51a:4b53:e3f9 with SMTP id l12-20020aa7c3cc000000b0051a4b53e3f9mr7987253edr.31.1687384506197;
        Wed, 21 Jun 2023 14:55:06 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.2])
        by smtp.gmail.com with ESMTPSA id d16-20020aa7d5d0000000b0051a358a76c9sm3115417eds.72.2023.06.21.14.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:55:05 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        deller@gmx.de, Yannick Fertre <yannick.fertre@foss.st.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH v2 2/2] backlight: gpio_backlight: add new property default-brightness-level
Date:   Thu, 22 Jun 2023 00:54:57 +0300
Message-Id: <20230621215457.11297-2-alex@shruggie.ro>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621215457.11297-1-alex@shruggie.ro>
References: <20230621215457.11297-1-alex@shruggie.ro>
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

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---

Link to original patch:
  https://github.com/STMicroelectronics/linux/commit/c4067d7bd883c6fa14ffd49892c4ce663cdafe98

Changelog v1 -> v2:
* https://lore.kernel.org/dri-devel/20230519200520.10657-1-alex@shruggie.ro/
* removed 'Reviewed-by: Philippe CORNU <philippe.cornu@foss.st.com>' as
  requested
* patch is now second patch of 2 (was first in series)
* added 'Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>'

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

