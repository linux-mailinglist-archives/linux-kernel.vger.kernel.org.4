Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C78572A0F7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjFIRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFIRKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7323598
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686330591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXfuy13isQUH9meYMWRMilnarujeOibtxjp5Z2EnlHc=;
        b=QueaOLzfaq011vSgiz156s3ulnthgprx2xESQE3VEgagBGxtKEyruk3Gn9LAuS92KseXnD
        15acIupvEoqFZHtDRtu1aCL80+WMwnn9Wyb5ICDDLdHZSsoCmGBQqkMxOpNFcqfOfO4hDk
        yCMxxMHjYzFVlgkGum34ecoQtV5EVXw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-SnrMtooqNIqdV3lWPxTuTA-1; Fri, 09 Jun 2023 13:09:49 -0400
X-MC-Unique: SnrMtooqNIqdV3lWPxTuTA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f725f64b46so32544525e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686330588; x=1688922588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXfuy13isQUH9meYMWRMilnarujeOibtxjp5Z2EnlHc=;
        b=hWLN7r8dAEL+cDS2WsLC4l7nCvV3exEOb9eSK1urleI29aV1QqG3gAxO6g2EGUXGxq
         HK9TDLVojQAlBamfMNvNox15x3CG6E/dchIjqL5i2HXjF0dx4LQhTa4Ykk2t+fgdPYaz
         y75fdzrm/6X3O3OG3zvRJ094tedfbVNTvpsuzf13nBsn+ofNJtwJ9TfDJWno8C+UT9V1
         keqWSFe7V6tYxnnrDQ1m1kYKcvGtxK/Av1loY9bmYtmCB2fyam2Gw605oFyRwFIDSO/W
         b9koocOlPTf/HSKWZAPoGIMmrZdm3psZVrqkFTmKILzHZFpFE3N+R4N6Z6yVJMlRRr40
         dDsQ==
X-Gm-Message-State: AC+VfDzCzlQaxfBLHTieuw8l+PegAPcGXkI1K8+1BAv0myeoUy1rrZiU
        NLFE2Pf6TVYOxrfoVLxEjcIM6nMj91x7L2qzCaMa7/SlHuWwzjd25BxKwL6SVs0yo6C0ZsqxnBt
        0VZTkYqejNrtMaDwfNNf+sC0ay8sJnFBp8phVj4z21XWx0NgZfTV/mI3JSmFzvlK4YjQc1cl9SE
        lbR9LNP/E=
X-Received: by 2002:a05:600c:2297:b0:3f7:f544:4993 with SMTP id 23-20020a05600c229700b003f7f5444993mr1713202wmf.20.1686330588102;
        Fri, 09 Jun 2023 10:09:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6STR4rSMJ97Fa6ojZrAiLQzs8ABi6NesLIiXyu3/dui4psE2W6fWMsDJ7gQ5OE2xe5JNQ5zQ==
X-Received: by 2002:a05:600c:2297:b0:3f7:f544:4993 with SMTP id 23-20020a05600c229700b003f7f5444993mr1713180wmf.20.1686330587766;
        Fri, 09 Jun 2023 10:09:47 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm3265526wmr.2.2023.06.09.10.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:09:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/5] dt-bindings: display: ssd1307fb: Remove default width and height values
Date:   Fri,  9 Jun 2023 19:09:37 +0200
Message-Id: <20230609170941.1150941-3-javierm@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609170941.1150941-1-javierm@redhat.com>
References: <20230609170941.1150941-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A default resolution in the ssd130x driver isn't set to an arbitrary 96x16
anymore. Instead is set to a width and height that's controller dependent.

The datasheets for the chips describes the following display resolutions:

 - SH1106:  132 x 64 Dot Matrix OLED/PLED
 - SSD1305: 132 x 64 Dot Matrix OLED/PLED
 - SSD1306: 128 x 64 Dot Matrix OLED/PLED
 - SSD1307: 128 x 39 Dot Matrix OLED/PLED
 - SSD1309: 128 x 64 Dot Matrix OLED/PLED

Update DT schema to reflect what the driver does and make its users aware.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

Changes in v2:
- List per controller default width/height values in DT schema (Maxime Ripard).

 .../bindings/display/solomon,ssd1307fb.yaml   | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 94bb5ef567c6..20e2bd15d4d2 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -49,15 +49,15 @@ properties:
 
   solomon,height:
     $ref: /schemas/types.yaml#/definitions/uint32
-    default: 16
     description:
-      Height in pixel of the screen driven by the controller
+      Height in pixel of the screen driven by the controller.
+      The default value is controller-dependent.
 
   solomon,width:
     $ref: /schemas/types.yaml#/definitions/uint32
-    default: 96
     description:
-      Width in pixel of the screen driven by the controller
+      Width in pixel of the screen driven by the controller.
+      The default value is controller-dependent.
 
   solomon,page-offset:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -157,6 +157,10 @@ allOf:
             const: sinowealth,sh1106
     then:
       properties:
+        width:
+          default: 132
+        height:
+          default: 64
         solomon,dclk-div:
           default: 1
         solomon,dclk-frq:
@@ -171,6 +175,10 @@ allOf:
               - solomon,ssd1305
     then:
       properties:
+        width:
+          default: 132
+        height:
+          default: 64
         solomon,dclk-div:
           default: 1
         solomon,dclk-frq:
@@ -185,6 +193,10 @@ allOf:
               - solomon,ssd1306
     then:
       properties:
+        width:
+          default: 128
+        height:
+          default: 64
         solomon,dclk-div:
           default: 1
         solomon,dclk-frq:
@@ -199,6 +211,10 @@ allOf:
               - solomon,ssd1307
     then:
       properties:
+        width:
+          default: 128
+        height:
+          default: 39
         solomon,dclk-div:
           default: 2
         solomon,dclk-frq:
@@ -215,6 +231,10 @@ allOf:
               - solomon,ssd1309
     then:
       properties:
+        width:
+          default: 128
+        height:
+          default: 64
         solomon,dclk-div:
           default: 1
         solomon,dclk-frq:
-- 
2.40.1

