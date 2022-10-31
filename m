Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D972A6141E3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJaXhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJaXhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:37:23 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9F914090;
        Mon, 31 Oct 2022 16:37:22 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5F4AC38F;
        Mon, 31 Oct 2022 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1667259442;
        bh=mAt3dJv3CrFnTWTFOnC00xngHdYd38jgqzgqlMa3X3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9mxgPoNctOPHVKdqhq+FDTPFhvxVsgcLKfoArULQ/KpFNwT1nJ1ZOmJpVUE1sByd
         nU+fHubbQCe0LdKXnKrCE400swgRu0uuQn55C+Tvu6Qo6z4XaXl5yBm4fbGbSzEzuT
         oBh/WkLVhcc+ldLpZJe/3UgYyztTAgPo1hD8ooLM=
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
Subject: [PATCH v2 2/3] dt-bindings: regulator: Add regulator-output binding
Date:   Mon, 31 Oct 2022 16:37:03 -0700
Message-Id: <20221031233704.22575-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031233704.22575-1-zev@bewilderbeest.net>
References: <20221031233704.22575-1-zev@bewilderbeest.net>
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

Changes since v1:
 - removed 'regulator-leave-on' property

 .../bindings/regulator/regulator-output.yaml  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator-output.yaml

diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
new file mode 100644
index 000000000000..078b37a1a71a
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
@@ -0,0 +1,39 @@
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
+      };
-- 
2.38.1

