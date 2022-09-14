Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801395B872C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiINLWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiINLV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:21:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0F15282C;
        Wed, 14 Sep 2022 04:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2BC6B81A56;
        Wed, 14 Sep 2022 11:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1239EC43470;
        Wed, 14 Sep 2022 11:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663154514;
        bh=NDeIrvAGzQB35u8/vo9amOwg2PRBtNRJ+6o05BpVR/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWhbxAUla8/f5Cceny+h0DeJHMbnzCloDlnodU8ArKhxzJm26qCoaKfM290UQHlOL
         Bm8SaFqPuAH8F8gPGXjpH/1CTvrETbOf/ZcSUp71fu9r1J3NjfUwJB8KHhQaFapiW3
         ZFurclqOd3VWB3wgI+Whdu2qxdnIcaE6CfQM8X1pLmyv1hV5tg64yBg2otvrTJfCDh
         qwL9aWp3kxyGR5fYEy8Lhyq7c+cfgaE1mmtRD8ZtT8IikAj4rX4T1hzayJcCscKHSj
         7yqpsA82ahhyGwA9es+dBzckq9zioS/btHqq+mCX4/5HpB3UEFfxTuamm1I2ULMgbd
         +B9EkpcEC2Oxw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: spmi: Add qcom,bus-id
Date:   Wed, 14 Sep 2022 16:51:38 +0530
Message-Id: <20220914112139.3680354-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914112139.3680354-1-vkoul@kernel.org>
References: <20220914112139.3680354-1-vkoul@kernel.org>
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
 .../devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
index fee4f0eb4665..aa8e891b2bb4 100644
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
@@ -113,5 +121,8 @@ examples:
 
         interrupt-controller;
         #interrupt-cells = <4>;
+
+        qcom,bus-id = <0>;
+
     };
 
-- 
2.37.3

