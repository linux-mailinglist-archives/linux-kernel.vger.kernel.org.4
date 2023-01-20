Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9617674DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjATHRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjATHR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:17:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135177DFB3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:17:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b5so4049712wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJ5Lz6E4vUSph11X435KYTnTHMIJgrYfJQAxDMT6T8U=;
        b=WHngMJqZPGXn/kPlo1zd3gMcwvi684yWjm/tP3fkjNJn/mmBWVz601FGhbXcgSV8P9
         WFXE6BQLxcQgsp4+xjMiIHF+IG13cT/Ex9YQMnah5POEoKLbAGRB0xWWXOqpZfbKrKgg
         HN6jBeXuiS3SQNRGYj8nynbk1Fi+Fd0z8Bw2xXdqumVtfrmUeUk2BroFfDCD5kQh/1Bw
         pEUfBSmFIQj6rp1wGtv6VhjGfjfXh4Gamjmqzz5vd/vCbKYxDX78CkHu6O3c4q8z1Ixg
         Ha3zfhpG6MMlel5mZsKeTdcmD7GGnM76iItUsgh+y1X1w6ICotHPAsouvNgw/5xKG2C2
         0ANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJ5Lz6E4vUSph11X435KYTnTHMIJgrYfJQAxDMT6T8U=;
        b=rjJkDpgSUCngcXA9hhFeppG1fFGyXQEsGO0Fg6ZaPN38Df3bHZs7gfe0fD7p6FNa8K
         6bL04MOWr9W6hK+ntJJymaZEth5dj7S9APYlGPjJO3qozWEh9joVrm8G4bsdRzEM+75M
         nwIJ2V3YoCVIEZCWOy3+3hcYrsmd6tVrzuDTLdhHuDYjTUSaIlhimzgBlSZ7zEud04/d
         E0Y6x5046Na3raEeJIQhX7Eoq/9lrTqIRnxh9rOJVbD6igtJxtsIqPJ8Ij9BUcfAKWVc
         FPImjnr63bKWG+VHNYNVEOcmutND3nSWaaTIMIFaMQQhdvOg7/YD3HPUrVoagSgXV3nZ
         iH2w==
X-Gm-Message-State: AFqh2kqsoWAzM+P2n2S4Seu6blIwldeaYzJHwaTuY7kOCB3g8OLBpFG2
        9r3Ga7ju7flAl1X9rc1S9GTQtQ==
X-Google-Smtp-Source: AMrXdXtz7X+ubzP2smBaBnfC09d8J91mJuS5cHl9Wt0tyKmycfKXtaF96j7XG4YjTy8vNa/n9QF4zw==
X-Received: by 2002:adf:de04:0:b0:2a9:89e:2b53 with SMTP id b4-20020adfde04000000b002a9089e2b53mr11857780wrm.45.1674199041511;
        Thu, 19 Jan 2023 23:17:21 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6152000000b002425be3c9e2sm34642789wrt.60.2023.01.19.23.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:17:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: power: fsl,imx-gpc: document fsl,imx6ul-gpc compatible
Date:   Fri, 20 Jan 2023 08:17:15 +0100
Message-Id: <20230120071717.138188-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document existing fsl,imx6ul-gpc compatible used with fsl,imx6q-gpc
fallback:

  imx6sl-evk.dtb: gpc@20dc000: compatible: ['fsl,imx6sl-gpc', 'fsl,imx6q-gpc'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/power/fsl,imx-gpc.yaml    | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
index 777e1d852ddd..85658da3672f 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
@@ -23,11 +23,16 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - fsl,imx6q-gpc
-      - fsl,imx6qp-gpc
-      - fsl,imx6sl-gpc
-      - fsl,imx6sx-gpc
+    oneOf:
+      - enum:
+          - fsl,imx6q-gpc
+          - fsl,imx6qp-gpc
+          - fsl,imx6sl-gpc
+          - fsl,imx6sx-gpc
+      - items:
+          - enum:
+              - fsl,imx6ul-gpc
+          - const: fsl,imx6q-gpc
 
   reg:
     maxItems: 1
-- 
2.34.1

