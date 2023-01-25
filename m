Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AD467AAD8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjAYH0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbjAYH0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:26:47 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1719F42DD0;
        Tue, 24 Jan 2023 23:26:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id j5so3952272pjn.5;
        Tue, 24 Jan 2023 23:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq3YLnLVdkwJ+hnndTnVXYO2IvsFe7R/GdMhEuzT5j4=;
        b=eXrMPHaKJJACcgNbFqY2MDAunrGJohcSX0+b/zZxdECntrVwymZjD+yOT6pSbC9HqI
         7qSpSKQWfJUvWCfG5mkvrnOPcsf7NsPVW0BFPd2UVWjfJk7g2fTbzt8El0BmAfHDmgMH
         AXv7eJuaagz8LUGm/uHJMqIEKdLhkERxNkq3+YMtBLA4t4zg8MIYlEL8pxxC3i5tayCH
         OYdhUL3ybK/mnER140UZB9853TdZ8J8aIXHe1GFqP0cZfK48qXnGzM9On6PVMuvnXMH4
         +gavM0ogR2a/Rtzj/G4pgVsSYWWSgXqFw5Vfod4SsO0i5WQ/hIhFjnmFOh02f0Cm/JXG
         mIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hq3YLnLVdkwJ+hnndTnVXYO2IvsFe7R/GdMhEuzT5j4=;
        b=PltIWEBK2/+A+l0TP1yInK39oXNa2m5zTfUK2WmewmGMUKGQ6gskZ1cWEMV+QkG5K+
         neP9PBzbRGgnzz4xp9mVAFILhXxacZz+4neb5b34ndmoQ/4Lr8U43ww/hFZHcl57gxMv
         Aay+TcxavnU7BvCi6imc3FZD/a/AXkOAdRrK14mkAVPlrR5CCiRSEkLsHGL36YeHn8QU
         V+tAeikT44/WOxWNnpsqFUmtwh8C3Om2ONTzx3RsM6WzQGDSBuO4nFgFmkH51DHlMyky
         DbKwyepQ5O/VzLnJ5ne/tRF1wVOTxZ/k6jyPgZPB7T7kAiZieFjTsowfJOB7kSsKqYbF
         553g==
X-Gm-Message-State: AFqh2kpCFZmYG0IyiDsEHSufTaMQq8QSeRsVE6LEWH5DzoffcBIm7qtu
        dWQxb3ktoI1TdV6Q0WeJvgM=
X-Google-Smtp-Source: AMrXdXstAyLpMzWAC60MRIw9AG6QXdX7KPpnlpPM+JvyeDaY19pGDE6gRaLGJiCKZwcMgWfTDsZ/Ig==
X-Received: by 2002:a17:903:2289:b0:194:9290:fa6f with SMTP id b9-20020a170903228900b001949290fa6fmr43429571plh.25.1674631603605;
        Tue, 24 Jan 2023 23:26:43 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001769e6d4fafsm2902500plf.57.2023.01.24.23.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:26:43 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND linux-next v4 4/4] dt-bindings: usb: Fix properties for VL817 hub controller
Date:   Wed, 25 Jan 2023 07:26:04 +0000
Message-Id: <20230125072605.1121-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230125072605.1121-1-linux.amoon@gmail.com>
References: <20230125072605.1121-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup by removing unneeded quotes from refs and
add maxItems to reset-gpios and fix the required list.

Fixes: 31360c28dfdd ("dt-bindings: usb: Add binding for Via lab VL817 hub controller")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../devicetree/bindings/usb/vialab,vl817.yaml  | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
index 5f9771e22058..23a13e1d5c7a 100644
--- a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
+++ b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
@@ -14,29 +14,32 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - usb2109,2817
-          - usb2109,817
+    enum:
+      - usb2109,2817
+      - usb2109,817
 
   reg: true
 
   reset-gpios:
-    description: GPIO controlling the RESET# pin.
+    maxItems: 1
+    description:
+      GPIO controlling the RESET# pin.
 
   vdd-supply:
     description:
       phandle to the regulator that provides power to the hub.
 
   peer-hub:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       phandle to the peer hub on the controller.
 
 required:
-  - peer-hub
   - compatible
   - reg
+  - reset-gpios
+  - vdd-supply
+  - peer-hub
 
 additionalProperties: false
 
@@ -45,7 +48,6 @@ examples:
     #include <dt-bindings/gpio/gpio.h>
 
     usb {
-        dr_mode = "host";
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.38.1

