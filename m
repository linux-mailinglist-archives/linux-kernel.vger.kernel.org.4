Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42458647B80
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiLIBdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLIBd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:33:29 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DA786F70;
        Thu,  8 Dec 2022 17:33:27 -0800 (PST)
Received: by codeconstruct.com.au (Postfix, from userid 10000)
        id 2F05820203; Fri,  9 Dec 2022 09:33:22 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1670549602;
        bh=oPERloVDACX37C/EgAVnKfvFY7AD1n20mfLsVbn2Wrk=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=RYi4g9RZnovzNqtlqDppYdmbhj54VvJ45Ob+87b7qqkRac2SGPF2fdEdy0P/VIOMz
         5voE2Ph0fkIW13xnZRqIuF4ttPSxDKyzaYdvsILAcn2z0DqyTchIYRH4R91EYhHlJO
         srxdMZ9uOWKE41VYCRG0TJ93KwzcSvWQE0y8CygNN4H+xroQ9eYrea6dgUf51smhxC
         MFdheASfsQgaq5+6qNoj7pf8WAdmHD0fX6o6GxgvXotcvN146zECF1ThOQUUjLyNqE
         e/QbO0TeOoSm1/rR9KMFGcIh1yN264fJ5EU3HVT5LfmKETXMrSTpY8aKAquWpyfh07
         F3FS5qgViMFmw==
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: [RFC PATCH v2 1/3] dt-bindings: mfd/syscon: Add resets property
Date:   Fri,  9 Dec 2022 09:33:07 +0800
Message-Id: <20221209013309.407879-2-jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221209013309.407879-1-jk@codeconstruct.com.au>
References: <20221209013309.407879-1-jk@codeconstruct.com.au>
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

