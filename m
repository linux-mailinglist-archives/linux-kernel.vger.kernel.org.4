Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6E465E211
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjAEAzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjAEAyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:54:37 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3714D701;
        Wed,  4 Jan 2023 16:51:16 -0800 (PST)
Received: by codeconstruct.com.au (Postfix, from userid 10000)
        id 190672009B; Thu,  5 Jan 2023 08:51:13 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1672879873;
        bh=adaPG21LWF9KYARFKo+io9g1sMsGa7P4yZ1kIRb0M64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KZQagnkHgmxQydGGTXtq2J8RFLX5lYyQOOYNo62WuH3oPBh7P4tNBcUPzfBzJhx/P
         VvtzsTaAq8NlVRzKbqHAY1fpu/X6f9ukwKjyO9ND7YBtlpJdBMddC+lZqJejdfgOgv
         Y89wOkCOe5heYXdyNN+n2zArq6l/1qMKYAGsbkMLr3M/gymM5w4WEKOkIb/Q5rPH73
         0whgAU8fyHBUC3C32uYLU3QXAN2fYFt3xGo3iKmAFCNzHygNgPd/wT+o6KQYJuvyRh
         SZtQP9H3f/y3FFz9Jce/UhuqOz+NNykpnc9CfnkQi96Pq7nu0JM9I8njO+PTV01mAN
         g0wWcH/fzWmyw==
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: mfd/syscon: Add resets property
Date:   Thu,  5 Jan 2023 08:50:09 +0800
Message-Id: <20230105005010.124948-2-jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230105005010.124948-1-jk@codeconstruct.com.au>
References: <20230105005010.124948-1-jk@codeconstruct.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple syscon devices may require deassertion of a reset signal in order
to access their register set. This change adds the `resets` property from
reset.yaml#/properties/resets (referenced through core.yaml), specifying
a maxItems of 1 for a single (optional) reset descriptor.

This will allow a future change to the syscon driver to implement reset
control.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 4e4baf53796d..9dc5984d9147 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -86,6 +86,9 @@ properties:
       on the device.
     enum: [1, 2, 4, 8]
 
+  resets:
+    maxItems: 1
+
   hwlocks:
     maxItems: 1
     description:
-- 
2.38.1

