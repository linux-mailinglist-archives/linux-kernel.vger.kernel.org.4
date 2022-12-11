Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5487C649224
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLKC50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLKC5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:57:15 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEB113FA2;
        Sat, 10 Dec 2022 18:57:12 -0800 (PST)
Received: by codeconstruct.com.au (Postfix, from userid 10000)
        id 4A10E20354; Sun, 11 Dec 2022 10:57:11 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1670727431;
        bh=oPERloVDACX37C/EgAVnKfvFY7AD1n20mfLsVbn2Wrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MkK/2c2iyP1MybzC0kOXMHe226O5SponW1t/oUZMVXW99ewF1hn4lTcOfdJJ36kf4
         zPyseAjirHZk2G40uqxk44kfnOczYdKR88TbIH8y0TUInk72qF4eObWpP7cxhAaGj4
         cnLH8R6inZ8uJr1Iryf94u2emiB953IM/MucptwWX2i/gSwTMgAuRjCtFkj4Sdx8df
         0bTeKlTTvj2ikxyrFQa4ABK6HGas1fbOtptAITrkkI6ZH9AyL2glfBx5qlKzoH6+TR
         iFQ92JEAvHMS2MdDWraupl/n7oMGWxSoPEXdAa/JuVmx3HJtGKXotMhkyg1QTvjclq
         ClADiaWq5IxSQ==
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>
Subject: [RFC PATCH v3 1/2] dt-bindings: mfd/syscon: Add resets property
Date:   Sun, 11 Dec 2022 10:56:59 +0800
Message-Id: <20221211025700.1180843-2-jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221211025700.1180843-1-jk@codeconstruct.com.au>
References: <20221211025700.1180843-1-jk@codeconstruct.com.au>
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
2.35.1

