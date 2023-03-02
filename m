Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA026A8223
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCBM1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjCBM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:27:31 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BD247425;
        Thu,  2 Mar 2023 04:27:30 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u9so17395102edd.2;
        Thu, 02 Mar 2023 04:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677760048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaMxf79DO1CQ15GwbjLqNx3nQuf5cG/QHn3WlZsqaEo=;
        b=JWQNsh3+31Tt7qB7PNgYAQWcgUPJrfYp9gpYmeh9aDdpnjXrCH86wNNA1uOOg6HMpJ
         Cx/2Rfgw1qEinj5wcrH5WVW6UOjguGMfDIJwUGsfNSnW9sL55kjLQyzFGItGedUmEUyj
         GkH++vbp9y9P8EbBTToGqgJ25ShBysUpkg7Ta4oIB5yWBRh8+T9k/3PhxDS2OTWZb4a4
         xLGb0SrXjLspD2HiRrPodyXQoI3nST0iWveorQu4l1QqfN8VNQGKP+FqG6sXksWqP7ej
         748GU4nT3+RC5Zo17tZNCy480PstybSX5yqwclTeQ6P7LpH9kEzm+dKj9u5RU9nNJRWM
         BKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677760048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaMxf79DO1CQ15GwbjLqNx3nQuf5cG/QHn3WlZsqaEo=;
        b=FxoVjSMx490VXm076xtRwl1VLqTGlGBngqIMX8Xv9EXAjDjIYaaUan8zkeuTfBU3gg
         CAGZoiwokp3LGYCkZrotydeHEhhN+5SoEx5uha1q91/4bdXJblW6Z9bj2Vtk6bs7fPbd
         Ui5UaIonvfDQt/3Q1A8G7a4B7MCCfqgXTTLZHknC9f6Yl0sVWz71HVss6NjKk4O5f6kn
         Pfugude7s6iq/f1H65sMKNKTZsvAwablTfORpk2dhG5jR7K0fceuN8CleX2U43mNuNvj
         DDRyPDl9/DgICEbabMGLkEKGQtrY/cbl6KJ4GADr2wtnVy7+xhzLHFDd8tO4ftuuubJD
         ayaQ==
X-Gm-Message-State: AO0yUKVgG9IezbKp9XTns1P/0pRDpYqvg5cUYOJVS7xewDH+HiqOk4sB
        ESkEjxlr5dOGVqSk69mF1yM=
X-Google-Smtp-Source: AK7set/OHR5ThPdEqYI5LeAp7bLBO3qP3XVmRG3sqzE6cxO85Tq56+/eE87yq48Q4LsornEOmNRpRA==
X-Received: by 2002:a17:906:4d87:b0:878:72d0:2817 with SMTP id s7-20020a1709064d8700b0087872d02817mr10773308eju.29.1677760048812;
        Thu, 02 Mar 2023 04:27:28 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id qc17-20020a170906d8b100b008ca37f3eae9sm7038375ejb.131.2023.03.02.04.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:27:28 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: power: Add binding for MediaTek MT6735 power controller
Date:   Thu,  2 Mar 2023 15:27:07 +0300
Message-Id: <20230302122708.73848-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302122708.73848-1-y.oudjana@protonmail.com>
References: <20230302122708.73848-1-y.oudjana@protonmail.com>
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

Add DT binding for MediaTek MT6735 SCPSYS power controller.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/power/mediatek,power-controller.yaml  |  2 ++
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  1 +
 include/dt-bindings/power/mt6735-power.h           | 14 ++++++++++++++
 3 files changed, 17 insertions(+)
 create mode 100644 include/dt-bindings/power/mt6735-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index c9acef80f452..710db61cab53 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -23,6 +23,7 @@ properties:
 
   compatible:
     enum:
+      - mediatek,mt6735-power-controller
       - mediatek,mt6795-power-controller
       - mediatek,mt8167-power-controller
       - mediatek,mt8173-power-controller
@@ -81,6 +82,7 @@ $defs:
       reg:
         description: |
           Power domain index. Valid values are defined in:
+              "include/dt-bindings/power/mt6735-power.h" - for MT6735 type power domain.
               "include/dt-bindings/power/mt6795-power.h" - for MT8167 type power domain.
               "include/dt-bindings/power/mt8167-power.h" - for MT8167 type power domain.
               "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index 2bc367793aec..3530a6668b48 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -20,6 +20,7 @@ Required properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-scpsys"
 	- "mediatek,mt2712-scpsys"
+	- "mediatek,mt6735-scpsys"
 	- "mediatek,mt6765-scpsys"
 	- "mediatek,mt6797-scpsys"
 	- "mediatek,mt7622-scpsys"
diff --git a/include/dt-bindings/power/mt6735-power.h b/include/dt-bindings/power/mt6735-power.h
new file mode 100644
index 000000000000..782b49a88773
--- /dev/null
+++ b/include/dt-bindings/power/mt6735-power.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_POWER_MT6735_POWER_H
+#define _DT_BINDINGS_POWER_MT6735_POWER_H
+
+#define MT6735_POWER_DOMAIN_MD1		0
+#define MT6735_POWER_DOMAIN_CONN	1
+#define MT6735_POWER_DOMAIN_DIS		2
+#define MT6735_POWER_DOMAIN_MFG		3
+#define MT6735_POWER_DOMAIN_ISP		4
+#define MT6735_POWER_DOMAIN_VDE		5
+#define MT6735_POWER_DOMAIN_VEN		6
+
+#endif
-- 
2.39.2

