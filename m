Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB23663CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjAJJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbjAJJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:24:52 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84787551DE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:24:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso11281426wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiGeG2pWJxpESvGj47RLxzq7ucQ3N2fre9bCitRo4xg=;
        b=GLG7O8EM8nh8j0ke8ExuUCxC0tBSLVi8oe5BXgEJkqUpxYNWgeq9j9QybkhiOZ9Hd4
         ANOouiGawElwsyFQRZ+Z47x+6fsn4/BFzae6cM8kOxvzB50Js3ed3BFLt62coqATpPSw
         uiW2fjnGmKA99io43ajJuWVJihyA4/E3CqHZN+vm8kJGa2gzIisdPklY84KAINRgJIVI
         ABPyEg0Cx899cH8YA+2lMcK+ffv1og+2IvvCgljBLhDzS8XpU2fboEZDXmglrISvzTON
         muDUlwNdiXanTUQ4ueuI18fhuVK7QYc91Ysvsho/Fzz5eQ46Kqhi0T9kWQ0E1iyESxaa
         MqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiGeG2pWJxpESvGj47RLxzq7ucQ3N2fre9bCitRo4xg=;
        b=vC1csy2cOMW1/nRTE4OYSqhrNjAKCpYM02XxLXKCq+Nc8dkkjKuDcjg2BSroYB/xtx
         YieuUlS1q8sbJTk0kloWWqp4lncbfcqDJevM5CHxSGd/BckUKBAsHdrJQ1LIV7PXBteQ
         6DRD8JYFuPKYTMhOSPkhwtjKwD/sSh4rFCH8anpMVnxYziN0OyW3oYbv4gk0iDGGeStX
         ZuU7js8WSEVIWfVoJAENlnBNeNL7FCJuQYssNKxU+BMnpeGdFjx8FF8rVLRZIZWqZAXA
         DR/Dpb14Def2d1IC4Qo9kfICqYCFnhiH4+IBsZJzcep0LEw4uhBH86LK6TpNz5KQJMbf
         Cf1g==
X-Gm-Message-State: AFqh2krZoc1spB/6N2jKNRdfTa47XkKpCxCNQfbHoQTPrgI9ygv1Rmid
        etDXeCPFNximIUeEJa+wi+IMmw==
X-Google-Smtp-Source: AMrXdXt6GbjstUwEoi/mwh+Fh/TpXinpoQBoFZl+WauCSKoGuP1C6E4Ub9s4ArgWo8jaKj1Dz3ZILA==
X-Received: by 2002:a05:600c:47d1:b0:3d3:496b:de9d with SMTP id l17-20020a05600c47d100b003d3496bde9dmr48696449wmo.34.1673342689012;
        Tue, 10 Jan 2023 01:24:49 -0800 (PST)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id q22-20020a05600c331600b003d9dd62deedsm13149433wmp.30.2023.01.10.01.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:24:48 -0800 (PST)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     krzysztof.kozlowski@linaro.org,
        Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Date:   Tue, 10 Jan 2023 10:23:39 +0100
Message-Id: <20230110092342.24132-2-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230110092342.24132-1-maarten.zanders@mind.be>
References: <20230110092342.24132-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding to configure the internal charge pump for lp55xx.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---
 Documentation/devicetree/bindings/leds/leds-lp55xx.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
index ae607911f1db..40ab3cf597a4 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
@@ -66,6 +66,13 @@ properties:
   '#size-cells':
     const: 0
 
+  ti,charge-pump-mode:
+    description:
+      Set the operating mode of the internal charge pump.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [off, auto, bypass, boost]
+    default: auto
+
 patternProperties:
   '^multi-led@[0-8]$':
     type: object
@@ -164,6 +171,7 @@ examples:
             reg = <0x32>;
             clock-mode = /bits/ 8 <2>;
             pwr-sel = /bits/ 8 <3>;	/* D1~9 connected to VOUT */
+            ti,charge-pump-mode = "bypass";
 
             led@0 {
                 reg = <0>;
-- 
2.37.3

