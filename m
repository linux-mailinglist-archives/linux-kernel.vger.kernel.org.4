Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0835F7881
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJGNA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJGM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:59:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F92D1D7;
        Fri,  7 Oct 2022 05:59:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a3so7251550wrt.0;
        Fri, 07 Oct 2022 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbkEIuq95eSoiLeUfE84b7FgReJpboo04kC8dJdnn18=;
        b=pocDwKv8mQ2RyT1Czn+1mfjjZDgRESJxNBBluLbxiY5ru0U1ZjxTQb9C2jF754obmT
         LKX8fxJaTsC4LklSmMvGQ1aPaKgWowGEc9QwR/uCxFD3251/oPIxDpzus3LzxUXaBkZO
         lckxv1lQXvMMAN7z2gQFQAM22EFeD9NnCrvX3laG9jhDx32CcwMkEk7VMoRsFApbRMJf
         95CoJghNp4Fta5tKbiMwAn0XpK023Yj8Xktk5N+6AL5+S1uXx/AxYIvtmyVPs3PEJCBS
         Z7Xd7y4UxKzx5oe8psUaiL2QA/Pgdi0UeBw4wwVburOXZ0ewEzj7SmDDWlWXwMxnc6L5
         tpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbkEIuq95eSoiLeUfE84b7FgReJpboo04kC8dJdnn18=;
        b=GrBQBN8N181kBcA7t5aGXPvzhD5hJXnOqiUEsWIqH4sVnRLIeo3Ivr2GOk2cN88bNJ
         +CLgqYzL+og3iKk00WxUZW7sRy45noiMosz91jtDf1TyJn/T91qUrb4BDkLoDpNq7HNW
         QyFpMExAoujJel4M/Mo1NpaOdHXTsOsEBiMLnwuLccECMLWhbRrLd2uN6fNxnTSZE/Fl
         RlF03e+BL1IllR7agaAipeo1fGiMKhBqGV+WgQgZIShFOynjKPAloQz92maDDbI1t6PX
         I+mWqS8iL+QNw9bGj8jbcAHOD+bDwCxwnCdSErAYLcqC1fJZ/6ry0USgDkGuVtsxDgku
         ElnA==
X-Gm-Message-State: ACrzQf0bc0Yg+elulhHg3pEQCp1c5w/EknDKIqv9HgbbXUyWCENGtCQs
        3NVezgW4oa8Oax8sNJidUvI=
X-Google-Smtp-Source: AMsMyM7/Sdm+Nb59dRAKOoMfQ11vSakY4VD9Gt4DdgEouYfafenFOU93NAAtzGchUyp7CZosrjvxfQ==
X-Received: by 2002:a05:6000:16c6:b0:22e:5032:f15b with SMTP id h6-20020a05600016c600b0022e5032f15bmr3152640wrf.104.1665147589374;
        Fri, 07 Oct 2022 05:59:49 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00223b8168b15sm2008243wrs.66.2022.10.07.05.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 05:59:49 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 08/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6765 pin controller
Date:   Fri,  7 Oct 2022 15:59:02 +0300
Message-Id: <20221007125904.55371-9-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007125904.55371-1-y.oudjana@protonmail.com>
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

The MT6765 pin controller has had a driver for a while, but DT
bindings were never documented for it.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index cada3530dd0a..71a9aae2cc8c 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -18,6 +18,7 @@ description:
 properties:
   compatible:
     enum:
+      - mediatek,mt6765-pinctrl
       - mediatek,mt6779-pinctrl
       - mediatek,mt6795-pinctrl
       - mediatek,mt6797-pinctrl
@@ -62,6 +63,28 @@ required:
 
 allOf:
   - $ref: "pinctrl.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6765-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 9
+          maxItems: 9
+
+        reg-names:
+          items:
+            - const: iocfg0
+            - const: iocfg1
+            - const: iocfg2
+            - const: iocfg3
+            - const: iocfg4
+            - const: iocfg5
+            - const: iocfg6
+            - const: iocfg7
+            - const: eint
   - if:
       properties:
         compatible:
-- 
2.38.0

