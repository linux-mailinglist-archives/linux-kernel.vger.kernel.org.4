Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDEA7391DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjFUVzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjFUVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:55:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6A61AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:55:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso8537248a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1687384505; x=1689976505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn/Beteqm9A/LN1S7WLvnvRia249hgTE4o7LFlD5jW8=;
        b=npbSrNQ6pLZxRDO4iQBtGYduK/HsPHl+AGKV9spEmgzGe0BpEo+C3nRotLaWy5cKU2
         VpuVo+RZWhplXLWA9+t6OXb5TqnmIofJayaBIISKDeuIovO2ASqIwHJiRnT1gz9/w7tL
         nYmMtq+gWD7SopokiNjxfwbSnVIo1hWxLUGjw1+Iz4hb6anmNCrEutXimGHEapRdFbXG
         1GIuA0MMS/g9fvDFsIZxGIqADMyO2Fgmuh3Pm2X6dr4eq6IyBKusoHNU+vA9KXodvBFp
         Lscod8GaAQkGDsdJWsu2ruEcOls1KzAzn/HoDe9dd6+Y4UNQyBmD2XjnoxtwzyzcyBAo
         f4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687384505; x=1689976505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jn/Beteqm9A/LN1S7WLvnvRia249hgTE4o7LFlD5jW8=;
        b=F6ZYVY24x1G3+w7REedbTaK86Lgw6PJozUCF2jY3ua2Oi6yNBnxO0p0eEJrLaIUHLU
         BG0phKh4VyuW70OnAVExUGDN+/++4nYczk9hwP3Tep+AyBaP23iPPBXB6nSKDLMk+EUS
         f1tYm5/WnObrxBEhDnJw5Y7TkFNdSSxRAj76Dz9p2p3kMZ4/rH3D6VQel1cWsd2c+//M
         wg4T81i+7+Q/+qr2wMNVy9cCnbrM9zTlq62ZNY8yaQ4xW00ua5nGD2uMTup4pJZjfekk
         Bh1TqiP1LeQv7kjNm7wQC6dvRBo7BIFjY9peAl9PJFt8uJlkwdUirRPJaWQ9R/e4/6Z+
         neIw==
X-Gm-Message-State: AC+VfDwWYmhfWn+8M7sRqCjjbSSizj/rLGdSRSz0QrKP6hCvk65vJRqA
        pTcetSHSuvbCvDpxz+dPPqXLfg==
X-Google-Smtp-Source: ACHHUZ6A/T43INsBruKaaE+va76RJMnbtzFL7HfR52IyaTewoA0XaNKUwjNnTX5qkrnskkylIa+1vw==
X-Received: by 2002:aa7:d404:0:b0:51b:dcb7:9b45 with SMTP id z4-20020aa7d404000000b0051bdcb79b45mr2164807edq.10.1687384504976;
        Wed, 21 Jun 2023 14:55:04 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.2])
        by smtp.gmail.com with ESMTPSA id d16-20020aa7d5d0000000b0051a358a76c9sm3115417eds.72.2023.06.21.14.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:55:04 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        deller@gmx.de, Yannick Fertre <yannick.fertre@foss.st.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH v2 1/2] dt-bindings: backlight: document new property default-brightness-level
Date:   Thu, 22 Jun 2023 00:54:56 +0300
Message-Id: <20230621215457.11297-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertre <yannick.fertre@foss.st.com>

Add documentation for new default-brightness-level property.

Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---

Link to original patch:
  https://github.com/STMicroelectronics/linux/commit/c4067d7bd883c6fa14ffd49892c4ce663cdafe98

Changelog v1 -> v2:
* https://lore.kernel.org/dri-devel/20230519200520.10657-2-alex@shruggie.ro/
* removed 'brightness-levels' reference
* updated doc-text for 'default-brightness-level'
* updated doc-text for 'default-on'
* added 'minimum' & 'maximum' to 'default-brightness-level' property
* removed 'Reviewed-by: Philippe CORNU <philippe.cornu@foss.st.com>' as
  requested
* patch is first in series of 2 patches (was second patch)

 .../bindings/leds/backlight/gpio-backlight.yaml    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
index 584030b6b0b9..2da6552a207c 100644
--- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
@@ -20,9 +20,21 @@ properties:
     maxItems: 1
 
   default-on:
-    description: enable the backlight at boot.
+    description:
+      The default power state of the backlight at boot.
     type: boolean
 
+  default-brightness-level:
+    description:
+      The default brightness level on device init. The value can be 0 or 1.
+      If omitted, the value is 1. In the context of the "gpio-backlight" driver
+      the effect of this setting will be that the backlight is on/off.
+      The difference between this setting and "default-on" is that this handles
+      brightness, while "default-on" handles the power setting of the device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 1
+
 required:
   - compatible
   - gpios
-- 
2.40.1

