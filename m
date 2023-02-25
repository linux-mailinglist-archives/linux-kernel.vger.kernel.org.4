Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6A96A289E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 10:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBYJpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 04:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBYJpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 04:45:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C4816891;
        Sat, 25 Feb 2023 01:45:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id d30so6777326eda.4;
        Sat, 25 Feb 2023 01:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyT0nXBKIBFtnMODtiBRknbDY/YQ7mPKIuKNpiMYykM=;
        b=haBe2r+6cqqz7cdxGut21qhQ4ej8l7X6PedtFvQ6ihepcDoYL6cqUGEZE/scXhlmYf
         YdSHIbbDksPISFrqnZzMx0dBXA0ySgo3XZJUW4fix1p1n6/I66WCTBZhbd4Pnhhpr2Jy
         eXNwVdlQ3uFItI0+0B6/Q/RJVkHdy0deZHpGVw7LfMJbMp543E1NRNEAIdCLwzvpb7mv
         2a4Pb57en9Uxt/nKdxNXjWdbVphX78EkQGHCKEj8S2FtVCfOran8Kmn9PKUoVqntPFk7
         g3u5tY5+Y7dc2LsilMVXw+XGDaSBbJTyW62eOGQ4321J8nt3/wI+D4MsBnatPhMkgino
         IykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyT0nXBKIBFtnMODtiBRknbDY/YQ7mPKIuKNpiMYykM=;
        b=1UQd0tpm/IDmqDEpexwPod/V+XKciO5vBYAyX0V9zVOIDN0sMnj/1cIwDPk5aPmWgC
         XB0ym5F5ITztbtSjZ7KNrJn7PmY04S0JFVkFHq9Zc+0Exd60ZyDF5NEOqB99LhTDiZIY
         PyKWMRzdMKn8mPUyFa9uK15mt2s0Y1WMNM+EVkx3lnmeOPfu0I7HxioU02QdNUz9tMG6
         +LnOVOatftSlUInCn8LfyD987hnHR5IbalygP137fzn0fZl1hFIP3nqCfuuBntreArNy
         io9Ap2hem3EgWgGUFruZMNQKtbiavDFj+VT/LwcB4Tp6IISFuyJSHMJo6Lr4TzOCoGLa
         m4FA==
X-Gm-Message-State: AO0yUKX00AlXLOG8gFmGlkDWeeS65rB1dOuMaiZt6iUIhbOztnl3AtdT
        1HCYlp3y7EcGFr5L8EIaPgs=
X-Google-Smtp-Source: AK7set+yaEaPmbZ7PxDA3LgD/6UTZtURnBlrzxTTsl98vXPWKuLRNSj2D1mb+tf/KJffjHrQRkxnzQ==
X-Received: by 2002:a17:906:e10e:b0:8b1:7569:b51a with SMTP id gj14-20020a170906e10e00b008b17569b51amr31147105ejb.53.1677318304642;
        Sat, 25 Feb 2023 01:45:04 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id va13-20020a17090711cd00b008b23b22b062sm653649ejb.114.2023.02.25.01.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 01:45:04 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/4] dt-bindings: arm: mediatek: Add MT6735 clock controller compatibles
Date:   Sat, 25 Feb 2023 12:42:45 +0300
Message-Id: <20230225094246.261697-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225094246.261697-1-y.oudjana@protonmail.com>
References: <20230225094246.261697-1-y.oudjana@protonmail.com>
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

Add compatible strings for MT6735 apmixedsys, topckgen, infracfg
and pericfg.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/mediatek/mediatek,infracfg.yaml          | 8 +++++---
 .../bindings/arm/mediatek/mediatek,pericfg.yaml           | 1 +
 .../devicetree/bindings/clock/mediatek,apmixedsys.yaml    | 4 +++-
 .../devicetree/bindings/clock/mediatek,topckgen.yaml      | 4 +++-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
index e997635e4fe4..715e24a4ddda 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
@@ -11,9 +11,10 @@ maintainers:
 
 description:
   The Mediatek infracfg controller provides various clocks and reset outputs
-  to the system. The clock values can be found in <dt-bindings/clock/mt*-clk.h>,
-  and reset values in <dt-bindings/reset/mt*-reset.h> and
-  <dt-bindings/reset/mt*-resets.h>.
+  to the system. The clock values can be found in <dt-bindings/clock/mt*-clk.h>
+  and <dt-bindings/clock/mediatek,mt*-infracfg.h>, and reset values in
+  <dt-bindings/reset/mt*-reset.h>, <dt-bindings/reset/mt*-resets.h> and
+  <dt-bindings/reset/mediatek,mt*-infracfg.h>.
 
 properties:
   compatible:
@@ -22,6 +23,7 @@ properties:
           - enum:
               - mediatek,mt2701-infracfg
               - mediatek,mt2712-infracfg
+              - mediatek,mt6735-infracfg
               - mediatek,mt6765-infracfg
               - mediatek,mt6795-infracfg
               - mediatek,mt6779-infracfg_ao
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
index ef62cbb13590..fd2f97973264 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
@@ -20,6 +20,7 @@ properties:
           - enum:
               - mediatek,mt2701-pericfg
               - mediatek,mt2712-pericfg
+              - mediatek,mt6735-pericfg
               - mediatek,mt6765-pericfg
               - mediatek,mt6795-pericfg
               - mediatek,mt7622-pericfg
diff --git a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
index dae25dba4ba6..73512038b27c 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
@@ -12,7 +12,8 @@ maintainers:
 
 description:
   The Mediatek apmixedsys controller provides PLLs to the system.
-  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h>
+  and <dt-bindings/clock/mediatek,mt*-apmixedsys.h>.
 
 properties:
   compatible:
@@ -33,6 +34,7 @@ properties:
           - enum:
               - mediatek,mt2701-apmixedsys
               - mediatek,mt2712-apmixedsys
+              - mediatek,mt6735-apmixedsys
               - mediatek,mt6765-apmixedsys
               - mediatek,mt6779-apmixedsys
               - mediatek,mt6795-apmixedsys
diff --git a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
index 0fdf56414833..a580ad03a5bf 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
@@ -12,7 +12,8 @@ maintainers:
 
 description:
   The Mediatek topckgen controller provides various clocks to the system.
-  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h> and
+  <dt-bindings/clock/mediatek,mt*-topckgen.h>.
 
 properties:
   compatible:
@@ -31,6 +32,7 @@ properties:
           - enum:
               - mediatek,mt2701-topckgen
               - mediatek,mt2712-topckgen
+              - mediatek,mt6735-topckgen
               - mediatek,mt6765-topckgen
               - mediatek,mt6779-topckgen
               - mediatek,mt6795-topckgen
-- 
2.39.2

