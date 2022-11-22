Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4AA6331F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiKVBJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiKVBJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:09:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB53924BEA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:08:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e13so18605556edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dAFpXKIv4puqT755UmrarGTxUh3Es/8fltMsnQhNuw=;
        b=OoAvwrY7aemhhCyOJ9zQyu3xRAr62IjaFsmbLb3fhhmH+xw8SG9fVcwZKDhk2dVyiH
         qGK0hUbZ1vbtWqMiU87Kl7du7cyN7qxXi+f5sMP+2tLCthMcvSqwIkIiUSF5r0aLyk9y
         P+rLandzlleGuR/xZ2MHheYFu+VH+3AcQrKEp+Tdr1yr0F7nrpo+py4BVMA/G5jy+kah
         rmjBihFvkwg9DaPgynNHvsj0DUvIA2WZ8vBalDIef7sOG2bdn0teap8OsSqCGfvrG8M5
         7z+vsuW83jb1yBrInRXoUWigvsJiVR46DnaRWoXyJSxV6KCFm8vPkuYvQ66zl4BvTerz
         o16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dAFpXKIv4puqT755UmrarGTxUh3Es/8fltMsnQhNuw=;
        b=Vhe1K6axhHygBkbS183/p33t30uOZsSi1GFu/k5Nen6fgQOjul/TVZErr6E3ZrTPfK
         XsHnesgLQFkXklThdcU2FwHEhKzjdCd0a7nEO3eEMrCyxaktRVNhq2fC5GZYRKPpQDwP
         ztjqE5S8zuTfUVpxQy6MwTJGCmoFVab/9RkuGI+qYhZGSFNgNQT/OzVwKETRczPC5sxi
         5hfmpYLgz7OJyPtk3i7l5lW7DHyJQc9mxZVTqUgBgOeX4d8c3G4AcS11v+d3qI1GZBVH
         lFTNDslVMEkiALhR5D6sfNlthkYZ7uGx1XVKN58e3Fy9tmTyHjtAq80rgPCNXk8zJY40
         k6AA==
X-Gm-Message-State: ANoB5pnvhTwmdYfqpx5F8hDQhOU3yp/BdEZxn1CZhI/1kxk2aFUTBxRf
        nRYIaRC55uh5jRS+0nFqSVTKxw==
X-Google-Smtp-Source: AA0mqf6g+E2Xe8Q5GHhLbNsGIt7qeLTBsdEBE9OD1a0hhvSG2woUFOOuUnVrId7WZa7SPT0HgCLPFg==
X-Received: by 2002:aa7:dc0c:0:b0:461:6f87:20bb with SMTP id b12-20020aa7dc0c000000b004616f8720bbmr18692156edu.300.1669079290461;
        Mon, 21 Nov 2022 17:08:10 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709064dcd00b007030c97ae62sm5514683ejw.191.2022.11.21.17.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:08:10 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v2 3/7] dt-bindings: pinctrl: mediatek,mt65xx: Deprecate pins-are-numbered
Date:   Tue, 22 Nov 2022 02:07:49 +0100
Message-Id: <20221122010753.3126828-4-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122010753.3126828-1-bero@baylibre.com>
References: <20221122010753.3126828-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make pins-are-numbered optional and deprecate it

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 .../devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
index 33b5f79e741ab..1b44335b1e947 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
@@ -31,7 +31,8 @@ properties:
   pins-are-numbered:
     $ref: /schemas/types.yaml#/definitions/flag
     description: |
-      Specify the subnodes are using numbered pinmux to specify pins.
+      Specify the subnodes are using numbered pinmux to specify pins. (UNUSED)
+    deprecated: true
 
   gpio-controller: true
 
@@ -62,7 +63,6 @@ properties:
 
 required:
   - compatible
-  - pins-are-numbered
   - gpio-controller
   - "#gpio-cells"
 
@@ -150,7 +150,6 @@ examples:
           compatible = "mediatek,mt8135-pinctrl";
           reg = <0 0x1000B000 0 0x1000>;
           mediatek,pctl-regmap = <&syscfg_pctl_a>, <&syscfg_pctl_b>;
-          pins-are-numbered;
           gpio-controller;
           #gpio-cells = <2>;
           interrupt-controller;
-- 
2.38.1

