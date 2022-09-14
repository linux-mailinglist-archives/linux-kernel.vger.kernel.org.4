Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F24E5B8D89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiINQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiINQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:52:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65605816A1;
        Wed, 14 Sep 2022 09:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C48F561A33;
        Wed, 14 Sep 2022 16:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81369C433C1;
        Wed, 14 Sep 2022 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663174346;
        bh=7cDV77aAUHsDOCpaptUAFN+6T3wnkqPji4nInaZ3JxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMIp+jXhg9YTg7bO0Z1A1JJ6tNw7AKyDwg7u4bjMlpfDjiBpkDVBYg/2kyDLoQbAV
         INYOBtvZ3tPCxFF+lhzLWozrMWzr9WbDVNqgD3N7wxW5Zomyk5pdD04cSyqKH4u7If
         FfSD6m7iIttmgH2hDzgGXDnTlpcrFfbGqZROSN6jQjuPllp2RPlAwktnoUy3FVMVNT
         E02yYT5rgml/Y6y4oND4W/denR2+l9XKUvPtj6dyKThU0qd7BHjxRjn/u7GCA/dy1h
         cKI+OfXxQ8Of5BiXPcWPt4fmYEpFUs0y+BPg7JWDh8cyAA1wJ4zKHfUpM1jcuxzlq5
         mr9R8euKLl6og==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: spmi: Add qcom,bus-id
Date:   Wed, 14 Sep 2022 22:22:11 +0530
Message-Id: <20220914165212.3705892-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914165212.3705892-1-vkoul@kernel.org>
References: <20220914165212.3705892-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PMIC arbiter version 7 and beyond we need to define if we are using
primary or secondary bus, so add a new property of qcom,bus-id

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
index fee4f0eb4665..f983b4af6db9 100644
--- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
@@ -85,6 +85,14 @@ properties:
     description: >
       which of the PMIC Arb provided channels to use for accesses
 
+  qcom,bus-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 1
+    description: >
+      SPMI bus instance. only applicable to PMIC arbiter version 7 and beyond.
+      Supported values, 0 = primary bus, 1 = secondary bus
+
 required:
   - compatible
   - reg-names
@@ -113,5 +121,7 @@ examples:
 
         interrupt-controller;
         #interrupt-cells = <4>;
+
+        qcom,bus-id = <0>;
     };
 
-- 
2.37.3

