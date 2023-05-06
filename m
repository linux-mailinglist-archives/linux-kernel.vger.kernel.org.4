Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC36F8F5B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 08:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjEFGlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjEFGld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 02:41:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C99EC8
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 23:41:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-95369921f8eso422064466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 23:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683355290; x=1685947290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+3W/krS7+7HCt+hhOvVVT5dCD6XlosgO/zqhN2oCo4=;
        b=WcJg7Jg40vWuV6hdu3V1rT7XqiMzV4X4kPIe1BK4RNvydYPIBauTlLGAGDiphHNi82
         49nCctvMCtvkJUwNUPNsBpY3DVt3wKyQX+YNd0rHS9AoUrrhV00A/PPgIsL3Q9ucu3pJ
         D6t4tpAnT+/wBl2jK8eiELqBizb1nB0V8r0dxczU7dTPmFjppIBNdj6GeaCqiftfnNpF
         nDYpaj7vjuBTM1a61fuxGULkm63Y9g/RKSWruBeElOcsMIaiTfK9MyGHK2AwHq+6UOpm
         9QExdfOlxMg58kkt+3YwtXTlalCjjZXTZv/47mNWhM8f50iyfnQQjRpohFQPtSLm09LN
         Qnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683355290; x=1685947290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+3W/krS7+7HCt+hhOvVVT5dCD6XlosgO/zqhN2oCo4=;
        b=K9TwHaugB1Vu1ebuqwdO5YryCF2p6q7sKtJqnsj9TfSchcAT+tdm9TRfn2ZKWhkdzt
         s75RdElQfERbzH/JC8f4tNKiP2yQPaSAtffFCQknKm/8ySloPgiGIVycEZicF8EX8CTY
         uGi7ZAyAivwWmX/1Apj974j8K5Sb1LNbJQNf+9R/js4yUVVJgTgTA/NYuweOGsuMo9xn
         s02N8y6N6If/4j3grApty6We4QB0xb3UWt/hDorAHYZTtuex5r7BQg8ibETifKTm0CU5
         cg72Gof0xTKu2z52iGQ81ZCSNEgpAKMY1LlxWtcFIp/nTqFjdqJBkPJ2QMI7Safa5Tr/
         JYhw==
X-Gm-Message-State: AC+VfDw38XS/Bj1jih/VVlB97WSwvPi7Mhj73kiztDf7CdKquZmQjrGd
        iYSI7oEHOPYoI6gR+4F2rDuQ6A==
X-Google-Smtp-Source: ACHHUZ4p9HaFQiMxoKs1RjvLHWsGmFwJ0RZX41ScSDiSCgzgX83Db52T52Rhi7KIJr+pReJ+MQkcig==
X-Received: by 2002:a17:906:7943:b0:93f:9b4a:12f3 with SMTP id l3-20020a170906794300b0093f9b4a12f3mr3412206ejo.10.1683355290321;
        Fri, 05 May 2023 23:41:30 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:efe5:7c03:a10a:7a40])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906348400b009659cdb2f98sm1879453ejb.23.2023.05.05.23.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 23:41:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: nvmem: imx-ocotp: drop unneeded address/size-cells and children
Date:   Sat,  6 May 2023 08:41:28 +0200
Message-Id: <20230506064128.34005-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Referenced nvmem.yaml schema already defines address/size-cells and its
children, so remove redundant entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index 9876243ff1e8..0784d71ae8f9 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -46,12 +46,6 @@ properties:
   reg:
     maxItems: 1
 
-  "#address-cells":
-    const: 1
-
-  "#size-cells":
-    const: 1
-
   clocks:
     maxItems: 1
 
@@ -61,21 +55,6 @@ required:
   - compatible
   - reg
 
-patternProperties:
-  "^.*@[0-9a-f]+$":
-    type: object
-
-    properties:
-      reg:
-        maxItems: 1
-        description:
-          Offset and size in bytes within the storage device.
-
-    required:
-      - reg
-
-    additionalProperties: false
-
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

