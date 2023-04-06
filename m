Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42266D9E53
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbjDFRST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbjDFRSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:18:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45E68A5B;
        Thu,  6 Apr 2023 10:18:15 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4897666031CA;
        Thu,  6 Apr 2023 18:18:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680801494;
        bh=pLRtimAMK8xZZG9VOP5UPhlbV7ruDA4KIYdGHVjscvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKPJUWOyhM28Q1PB7BPsnRaSwoxFXvnqW/JmAEkt4SwM+u+IYSeY40kDgi778ag7F
         sYOhG/R4CT7IrXlqizuXb+cqtNg9sVkp4dmTSxv4K4cJafFpCxZC3S3+5/UHXqqhc3
         em+QicXABp3XhzFVCfffjL/qF0ihFesD5xv83/L0xHJOydo7Qs9xXNwRDuYs7HC9jO
         y0O8g/K5Gnp1E0UMSfXvVy1gfNclIWRKg3o2/W2+eT3LUiosvD9YpmJEBBj2ruktrb
         QLHljNoZ4ssJrWlizmw3b52F0H0Hy4omacx45foTTbJGAZVIA+ay37AjPZJg8MQuaT
         g6erqSzMbibBw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 1/8] regulator: dt-bindings: fcs,fan53555: Add support for RK860X
Date:   Thu,  6 Apr 2023 20:17:59 +0300
Message-Id: <20230406171806.948290-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
References: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles to support Rockchip RK860X regulators.

RK8600/RK8601 are pretty similar to the FAN53555 regulators, while
RK8602/RK8603 are a bit different, having a wider voltage selection
range.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../bindings/regulator/fcs,fan53555.yaml      | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml b/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
index c0dbba843f70..7547c130ff7d 100644
--- a/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
+++ b/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
@@ -14,12 +14,22 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fcs,fan53555
-      - fcs,fan53526
-      - silergy,syr827
-      - silergy,syr828
-      - tcs,tcs4525
+    oneOf:
+      - items:
+          - enum:
+              - fcs,fan53555
+              - fcs,fan53526
+              - rockchip,rk8600
+              - rockchip,rk8602
+              - silergy,syr827
+              - silergy,syr828
+              - tcs,tcs4525
+      - items:
+          - const: rockchip,rk8601
+          - const: rockchip,rk8600
+      - items:
+          - const: rockchip,rk8603
+          - const: rockchip,rk8602
 
   reg:
     maxItems: 1
-- 
2.40.0

