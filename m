Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9764F685FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBAGwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjBAGwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:52:32 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56836A26A;
        Tue, 31 Jan 2023 22:52:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qw12so32546003ejc.2;
        Tue, 31 Jan 2023 22:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkN86TIGDYJR+4nG2fHZ23r9O15jnUv5Y7OgjldbOWg=;
        b=XQIBijkI8+OKqPlP1sL19SlqXbWw60maYM9giAx3GHyaI8sTJzjRmp2DolRMnASr0y
         KN+uzR6MaFeH/IuHZUnl3SEco9dEAigoohMzr0+VR8jnKTbFs1fCxFNC7IK019wWt8OY
         QlzYoAHwljH2DooyMDx5L6kYW21Py4D8vjJ6cfSynz3h51BrFBttejiOKfgd1GgTw0dZ
         nvzLHSsmvPeJHRhlskiqcv2KfYB/dmNUWPK4L88y9+WMg/F2dS1qJkXnsz7aGsFYHnUn
         JUswLiy7imzInpudmE6IkD6zZJt8FYlpLUtjMa3u4G3B8tWtvyaAACqDkuz6q4JX0ttc
         zRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkN86TIGDYJR+4nG2fHZ23r9O15jnUv5Y7OgjldbOWg=;
        b=zrJt6ujNMV6nijKiz28w1N+sKoNkFLrzL/eAi2g2RV4Gjr6vIhZUDyl4QeMAuctw9f
         e7WtHAq69n4e5fNxAakftobnjbrmig2GWhJlE5A7/FWmUS94WXSjqttLKMkDeRpWjqlm
         bKSQmI0ypfWeW5BVGioG3nawQ0ApYyiqQa+odlOvM7SNMcZQVljWENmQlUZcbyOi+Kb7
         UJyGCMabPVzyXPhOnoyMsg/P8GVend3P+Or2pTJaORoowNG+GAW+3tlhZEr9XmOB2uhv
         LG/oA/HUMU0IFxkmYTapSfakQE10daiRxg830IuBq3+H2/ionVXcxSNChj1TDEVEI9zZ
         tQGQ==
X-Gm-Message-State: AO0yUKVwMJt3CgyvZjdV7V59/2qG1IHBrr7tA/j/UcHHeca2761ubg2T
        Msy8xFGLtPIUNKQuZAIh68UMtB29dwY=
X-Google-Smtp-Source: AK7set9RlXgjOXhXlIkZpvFu0cd4Wj6DSXLwpe5l9TlAygwD+iwHH++wtMJmQg75MNEL1biWwmOg+w==
X-Received: by 2002:a17:906:b7d7:b0:88d:fe1:1aca with SMTP id fy23-20020a170906b7d700b0088d0fe11acamr1102961ejb.34.1675234348849;
        Tue, 31 Jan 2023 22:52:28 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b008720c458bd4sm9509608eju.3.2023.01.31.22.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 22:52:28 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/4] dt-bindings: nvmem: mmio: new binding for MMIO accessible NVMEM devices
Date:   Wed,  1 Feb 2023 07:47:14 +0100
Message-Id: <20230201064717.18410-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201064717.18410-1-zajec5@gmail.com>
References: <20230201064717.18410-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

With the NVMEM layouts binding in place we should now use:
1. NVMEM device access bindings
2. NVMEM content description bindings

This binding allows describing NVMEM devices that can be MMIO accessed.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/nvmem/mmio.yaml       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mmio.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/mmio.yaml b/Documentation/devicetree/bindings/nvmem/mmio.yaml
new file mode 100644
index 000000000000..27e3f6142769
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/mmio.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/mmio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MMIO access based NVMEM
+
+description: |
+  This binding describes simple NVMEM devices that can be accessed by using MMIO
+  (memory-mapped I/O access).
+
+  It's a generic solution for providing NVMEM content access. The way of
+  handling actual content may be device specific and can be described using a
+  proper layout.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    const: mmio-nvmem
+
+  reg:
+    maxItems: 1
+
+  reg-io-width:
+    description: |
+      The size (in bytes) of the IO accesses that should be performed
+      on the device.
+    enum: [1, 2, 4, 8]
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nvmem@10000 {
+        compatible = "mmio-nvmem";
+        reg = <0x10000000 0x10000>;
+    };
-- 
2.34.1

