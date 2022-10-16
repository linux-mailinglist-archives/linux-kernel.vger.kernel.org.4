Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50C860043A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJPXmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJPXmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3BB13D68;
        Sun, 16 Oct 2022 16:42:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so8787292wmb.3;
        Sun, 16 Oct 2022 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=713k9A6cCfEIb7eNKGVtq1FKwXEY5zby7RrWVPQyY24=;
        b=eyEdwym3MlKxaLg0tiz1H3ve/wbTs4RV4XzkFJNZJVv1fllfY8wrWlh0jYb0y3vu/l
         M+RLxXsdbJLQFmM//ovIlh0CdXukS2tK8NFtebCP4tuYKRWPkDZVXOOK51B+Dn4qPNQQ
         fYkVqUjYULqN6P9z9U8hs2wXmH5OFESfYiswlXEltv579j2KyRl20Om7SBLKf86ucJFa
         5TCmOh72mIB3lqHqez1cNw2xPdPdFD8Cn0ivAQCIYruAqjpQj7axnqBBCD6+kOiOpUs3
         ElBee8n0672BldpXi7tEESuaqXue0LbUdH8mp0kJWe1IbZoPt/2XU68p8WVoEx1+XpmB
         KDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=713k9A6cCfEIb7eNKGVtq1FKwXEY5zby7RrWVPQyY24=;
        b=wb8m9xZ8SxVvr310WdrrSCE2aZYpWl0Pj4ki/mG7FiyYMunXDrxvNxtqwlZjNJrA/W
         jYcwkDYOlfVtXVBmrM3AGlgt9lbuo9qiwcX4JmevJ1WDnq/9MnI3fxHuuFZ9x0ZBa3pw
         52CAkDQLeF/YnXnoPCrjrLu1jXsVoGN9XiXSI1nU+BJtiQW9Q/tVJyktetPg3l3gFSeY
         punEfB2wE7Eyk1tYixVGtqWRXrbfOcDC+qvlev9Gfs4FbAsOniaNiDkZH3v545HhtdB+
         9DEA2PjeKUIOE9fCt4p4C84XmvamqTDYpfkB9W02YjQ6G/IVkeS05yQd/+K+yNu933OH
         vYuQ==
X-Gm-Message-State: ACrzQf1OEbkzuaG7raqoMM6/XmX1o//TQCXUhfrgY608Wg0hDGtJApCJ
        /LlaO/J2uTT3dSM/t/x9uio=
X-Google-Smtp-Source: AMsMyM6O6jGsOLeRVyzvYrXzNe4Ie/G9bJPjaPPjTIwbs/TuN4dCR/yLgqmoEVgj93JNs2EZP/HndQ==
X-Received: by 2002:a05:600c:2f9a:b0:3b4:9bd5:1472 with SMTP id t26-20020a05600c2f9a00b003b49bd51472mr16858598wmn.171.1665963737658;
        Sun, 16 Oct 2022 16:42:17 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b003b47b80cec3sm13781642wmq.42.2022.10.16.16.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:17 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 02/13] dt-bindings: iio: adc: axp209: Add AXP192 compatible
Date:   Mon, 17 Oct 2022 00:43:24 +0100
Message-Id: <20221016234335.904212-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192 is identical to the AXP20x, except for two additional
GPIO ADC channels.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../bindings/iio/adc/x-powers,axp209-adc.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
index d6d3d8590171..1a68e650ac7d 100644
--- a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
@@ -14,6 +14,23 @@ description: |
   Device is a child of an axp209 multifunction device
   ADC channels and their indexes per variant:
 
+  AXP192
+  ------
+   0 | acin_v
+   1 | acin_i
+   2 | vbus_v
+   3 | vbus_i
+   4 | pmic_temp
+   5 | gpio0_v
+   6 | gpio1_v
+   7 | gpio2_v
+   8 | gpio3_v
+   9 | ipsout_v
+  10 | batt_v
+  11 | batt_chrg_i
+  12 | batt_dischrg_i
+  13 | ts_v
+
   AXP209
   ------
    0 | acin_v
@@ -50,6 +67,7 @@ description: |
 properties:
   compatible:
     oneOf:
+      - const: x-powers,axp192-adc
       - const: x-powers,axp209-adc
       - const: x-powers,axp221-adc
       - const: x-powers,axp813-adc
-- 
2.38.0

