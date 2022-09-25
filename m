Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930095E9698
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 00:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiIYWLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 18:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiIYWKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 18:10:52 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844C624BFA;
        Sun, 25 Sep 2022 15:10:50 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 83FCC72C;
        Sun, 25 Sep 2022 15:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1664143472;
        bh=szDrpMqpfTmd0bTtV19FrnGKTXelxS1H2D5cEIKOuFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFPGAf/qPA0PJjjaVSDRzpu0I92XjBaDPXzKaAznxrBuAyrK/ljD2JK71va+W5Zve
         inJnZ1p0tufMh6dJExFcnwCw3eQG1xwYTh8xwo62kF3Sk5AQ4POeJcYKVbuyWc9af5
         cVKFTw2NTwkYhmHQyeOtoAeEOc0Oyz3Tg8dykseQ=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        openbmc@lists.ozlabs.org
Subject: [PATCH 2/3] dt-bindings: regulator: Add regulator-output binding
Date:   Sun, 25 Sep 2022 15:03:18 -0700
Message-Id: <20220925220319.12572-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220925220319.12572-1-zev@bewilderbeest.net>
References: <20220925220319.12572-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes a power output supplied by a regulator, such as a
power outlet on a power distribution unit (PDU).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../bindings/regulator/regulator-output.yaml  | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator-output.yaml

diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
new file mode 100644
index 000000000000..40953ec48e9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/regulator/regulator-output.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator output connector
+
+maintainers:
+  - Zev Weiss <zev@bewilderbeest.net>
+
+description: |
+  This describes a power output connector supplied by a regulator,
+  such as a power outlet on a power distribution unit (PDU).  The
+  connector may be standalone or merely one channel or set of pins
+  within a ganged physical connector carrying multiple independent
+  power outputs.
+
+properties:
+  compatible:
+    const: regulator-output
+
+  vout-supply:
+    description:
+      Phandle of the regulator supplying the output.
+
+  regulator-leave-on:
+    description: |
+      If the regulator is enabled when software relinquishes control
+      of it (such as when shutting down) it should be left enabled
+      instead of being turned off.
+    type: boolean
+
+required:
+  - compatible
+  - vout-supply
+
+additionalProperties: false
+
+examples:
+  - |
+      output {
+          compatible = "regulator-output";
+          vout-supply = <&output_reg>;
+          regulator-leave-on;
+      };
-- 
2.37.3

