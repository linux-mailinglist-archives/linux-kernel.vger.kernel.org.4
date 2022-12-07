Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EFD645EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLGQYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLGQYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:24:46 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15A928E04;
        Wed,  7 Dec 2022 08:24:44 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id D829340005;
        Wed,  7 Dec 2022 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670430283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFK6AOeENQ1uANcJv+R12Fnypco6L8enVtc9IJTWm00=;
        b=P0orn2Lv9JNQJJe7+lWZGgHK/k2G39eaNPn+ItuddzLi7mNZ/ITdIRZgAydOu9rsvQqEbd
        lX6xbyt8Y2axGl2afrc12ATZr3i0HcCptB8/4EhNYp7auQRX4dKBxgUlxJQnpyUpKJ0f+1
        keFzyfrdit4jY3FzVg8yOKpifYspeeLs+Cy/SWKzSKBrupAh8T1pN2DooR/emLQoAKDLhs
        mcMOm4X6oZkZW76adsBg5g2bmjvRolWTdlZVZ5Pdl9QSNBaGN4vG0T2HyXXLP4JoJfFtiK
        TEkkbZFLuaYfZI5QC/tTj28ed3zVo5tmhFNrv+yOCPUiNZuHccnQB+5A71R1dg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 1/9] dt-bindings: PCI: renesas,pci-rcar-gen2: Add depends-on for RZ/N1 SoC family
Date:   Wed,  7 Dec 2022 17:24:27 +0100
Message-Id: <20221207162435.1001782-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207162435.1001782-1-herve.codina@bootlin.com>
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RZ/N1 SoC family, a h2mode setting is available to change the
USB configuration from one host and one device to two hosts.
This change will be done at sysctrl level and must not be done
while USB host or device are running.

In order to express this dependency (probe order dependency),
introduce 'depends-on' property at PCI bridge level.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
index 0f18cceba3d5..e1221ad68465 100644
--- a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
@@ -130,6 +130,12 @@ allOf:
             - const: hclkh
             - const: hclkpm
             - const: pciclk
+        depends-on:
+          $ref: /schemas/types.yaml#/definitions/phandle
+          description:
+            Phandle to the node (sysctrl node) that set the 'h2mode' value in
+            order to express the fact that sysctrl must set the 'h2mode' before
+            the underlying USB hosts start.
       required:
         - clock-names
     else:
-- 
2.38.1

