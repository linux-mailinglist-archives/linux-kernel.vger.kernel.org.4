Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55946646CF0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiLHKde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiLHKcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:32:06 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D48813A6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:31:33 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x28so1365713lfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftjSB9JJ8yBkXE+8vCPq7doIFKzD/Pbisdda5DVy8ec=;
        b=dbfh3g3XU/oJm/3BLec2LP+qdKfwx3FxgxohCpre6Ghy/mZbm681ARz0qOr+DO9taR
         9CRIzs33N0WRZuTnzWLQJ3cPZoRfoCnzVkgwHIS/HwZpYdFOw7RlpP2MOBJWgEx8XGIt
         qDOxAzSs8lOFyeP1vp3kETNwQSg0ZjkvQi+LzXcfh0oiqQ9zZkFz+OaQNVlNjQNckQ/3
         1P9Z87L/E3KnjRGP9hO612DdRCn4R41dqucH4woOZZr5DiBXaaIxUUb1ClsUkVoxSsp2
         M8UwR8CrF5sKT6QaMtDTU/3Ecl5SKGcfgg6ZV7uwnZ5l0iP4N5IkLmyPWZYrMMCMvaQ1
         PGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftjSB9JJ8yBkXE+8vCPq7doIFKzD/Pbisdda5DVy8ec=;
        b=05G0Lcfy3D0ngpRNQh0JlNbf9JgMcPa9A5QYTkZAQ6uobsbNKpAyB0mH4unU4RiAJt
         zNvTqkIybERIfedD+ts3zu3D8+rfnEtIcysBxsnopBF9sxM1qBSJeRexpZ7FqLNkCIUC
         wsWYxEgwSzAm9hmj2Ff8VS6NA6OH/ltHNTsAUqze4zJAZHtyDUPX+9s0Z9y4gBTFvOWz
         I6n3b0CER+HQzAU0ccgN+wY12WuSQhMyCOH/1x8HUQcBgQGzLd/K9p+Cyha7dGTFWMoU
         02rcNz202mp6jPIVvvwLc/G3P2JCF/pgCZ7I8cQ4u4XUjjv17JSbuzAxBKoCGpW7DRLO
         PNng==
X-Gm-Message-State: ANoB5pl9OS7juJ23dXDM1tVs+U2NdSX6vU16BZE28i62J2XnY/ajGt/O
        y+pW/a2dZnp/RqcCl9wybIyDuQ==
X-Google-Smtp-Source: AA0mqf7mJ7hPTjTyDYOTCN/aOz4Q4Nmpm1b3/sJOmvJy3YMAcQdtmB8QWjRiPE44lHuTnqxw5QeA2A==
X-Received: by 2002:ac2:4219:0:b0:4a2:2701:7d29 with SMTP id y25-20020ac24219000000b004a227017d29mr33808284lfh.322.1670495492059;
        Thu, 08 Dec 2022 02:31:32 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h18-20020a2eb0f2000000b00279e5247dabsm1699580ljl.18.2022.12.08.02.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 02:31:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Joe Tessler <jrt@google.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Jeff Chase <jnchase@google.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/9] media: dt-bindings: cec: convert common CEC properties to DT schema
Date:   Thu,  8 Dec 2022 11:31:09 +0100
Message-Id: <20221208103115.25512-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208103115.25512-1-krzysztof.kozlowski@linaro.org>
References: <20221208103115.25512-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert common HDMI CEC adapter bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/cec.txt         |  8 ------
 .../bindings/media/cec/cec-common.yaml        | 28 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 29 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/cec.txt
 create mode 100644 Documentation/devicetree/bindings/media/cec/cec-common.yaml

diff --git a/Documentation/devicetree/bindings/media/cec.txt b/Documentation/devicetree/bindings/media/cec.txt
deleted file mode 100644
index 22d7aae3d3d7..000000000000
--- a/Documentation/devicetree/bindings/media/cec.txt
+++ /dev/null
@@ -1,8 +0,0 @@
-Common bindings for HDMI CEC adapters
-
-- hdmi-phandle: phandle to the HDMI controller.
-
-- needs-hpd: if present the CEC support is only available when the HPD
-  is high. Some boards only let the CEC pin through if the HPD is high,
-  for example if there is a level converter that uses the HPD to power
-  up or down.
diff --git a/Documentation/devicetree/bindings/media/cec/cec-common.yaml b/Documentation/devicetree/bindings/media/cec/cec-common.yaml
new file mode 100644
index 000000000000..af6ee5f1c73f
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/cec/cec-common.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/cec/cec-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HDMI CEC Adapters Common Properties
+
+maintainers:
+  - Hans Verkuil <hverkuil@xs4all.nl>
+
+properties:
+  $nodename:
+    pattern: "^cec(@[0-9a-f]+|-[0-9]+)?$"
+
+  hdmi-phandle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the HDMI controller.
+
+  needs-hpd:
+    type: boolean
+    description:
+      The CEC support is only available when the HPD is high. Some boards only
+      let the CEC pin through if the HPD is high, for example if there is a
+      level converter that uses the HPD to power up or down.
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index 07cb85cac4c3..45402e03cda5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4832,7 +4832,7 @@ S:	Supported
 W:	http://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/ABI/testing/debugfs-cec-error-inj
-F:	Documentation/devicetree/bindings/media/cec.txt
+F:	Documentation/devicetree/bindings/media/cec/cec-common.yaml
 F:	Documentation/driver-api/media/cec-core.rst
 F:	Documentation/userspace-api/media/cec
 F:	drivers/media/cec/
-- 
2.34.1

