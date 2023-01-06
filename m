Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A8660821
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjAFUTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbjAFUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:18:59 -0500
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3AB3C700;
        Fri,  6 Jan 2023 12:18:26 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id AB68DC0003C8;
        Fri,  6 Jan 2023 12:09:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com AB68DC0003C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1673035770;
        bh=z13ASkxUuc4fajnr4hl+GEimGjj6wHKe2iHsFsjdvoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQXhfdoeh6FAHyJia1sRh/e8Gz5cVwMKFPtQy282HYXI70iHn9AkT1F3c/dIymVzi
         +XgOKmH1psWI3PZRJ0DGkSh2dEieVrcEyYEYhXiY0W6l+d8Rn501rWqkr1SyN6PK5b
         8npFKA5EYhA87JjmE9xJg3H36qBQj9ArV58g5E0c=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 73E4C18041CAC6;
        Fri,  6 Jan 2023 12:09:30 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id BB1E2101B33; Fri,  6 Jan 2023 12:09:20 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        William Zhang <william.zhang@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/16] dt-bindings: spi: Add spi peripheral specific property
Date:   Fri,  6 Jan 2023 12:07:55 -0800
Message-Id: <20230106200809.330769-4-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230106200809.330769-1-william.zhang@broadcom.com>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

brcm,no-clk-gate is a Broadcom Broadband HS SPI controller specific
property for certain SPI device such as Broadcom ISI voice daughtercard
to work properly. It disables the clock gating feature when the chip
select is deasserted for any device that wants to keep the clock
running.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

 .../brcm,bcm63xx-hsspi-peripheral-props.yaml  | 27 +++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml    |  1 +
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi-peripheral-props.yaml

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi-peripheral-props.yaml
new file mode 100644
index 000000000000..81884e2cc42d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi-peripheral-props.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Peripheral-specific properties for Broadcom Broadband SoC HSSPI controller
+
+description:
+  See spi-peripheral-props.yaml for more info.
+
+maintainers:
+  - William Zhang <william.zhang@broadcom.com>
+  - Kursad Oney <kursad.oney@broadcom.com>
+  - Jonas Gorski <jonas.gorski@gmail.com>
+
+properties:
+  brcm,no-clk-gate:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Some SPI device such as Broadcom ISI based voice daughtercard requires SPI
+      clock running even when chip select is deasserted. By default the
+      controller turns off or gate the clock when cs is not active to save
+      power. This flag tells the controller driver to keep the clock running
+      when chip select is not active.
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index ead2cccf658f..f85d777c7b67 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -108,5 +108,6 @@ allOf:
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
   - $ref: samsung,spi-peripheral-props.yaml#
   - $ref: nvidia,tegra210-quad-peripheral-props.yaml#
+  - $ref: brcm,bcm63xx-hsspi-peripheral-props.yaml#
 
 additionalProperties: true
-- 
2.37.3

