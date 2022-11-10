Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DAE623F76
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiKJKIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKJKIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:08:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3456B3B2;
        Thu, 10 Nov 2022 02:08:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 19396CE21CB;
        Thu, 10 Nov 2022 10:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73512C43142;
        Thu, 10 Nov 2022 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668074889;
        bh=cO7MvZAFboqc+cy0W63vgXFYG+tP3ioVNkMJAPRxT6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snxztglUfCtPaJaOSyhWk/p0mXsIOkq5cSJPsvDAyutqBeMt5RiLfDa4dHOV7u0gq
         zhitqU7YaAxUeFijh/EPjrKlvfE1bvn2dU/CXBBxTvPOaOPaZGYrZCxzxrZa/Ap+7C
         d4L5CnNWyyqKpcCVJVap3ZeITDAzCA4Uu0c4bkIg2uWA2dc2I4UmAjzsU5hO+lTs9h
         YIqTi9gtxVrs1ut/8PngOnR8uaesioSHHn+D/BSafzVP3XCIALS2DHBTa9Ra6lCV4u
         EU4vXrz4QGeIVBi2ltWg9sl8S2uSPQmyE3RHrZOsd2yWgYcjxIXUNRKoF4vIrlKxS2
         LIAy2WKiObfvg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: spmi: Add qcom,bus-id
Date:   Thu, 10 Nov 2022 15:37:54 +0530
Message-Id: <20221110100755.4032505-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221110100755.4032505-1-vkoul@kernel.org>
References: <20221110100755.4032505-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PMIC arbiter version 7 and beyond we need to define if we are using
primary or secondary bus, so add a new property of qcom,bus-id

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
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

