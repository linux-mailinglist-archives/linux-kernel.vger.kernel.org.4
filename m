Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7F6FAD35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjEHLcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbjEHLbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:31:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38473EDA6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:30:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f00d41df22so28208181e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1683545458; x=1686137458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCcpa8mh8EUPdc5cCKwnMcMZnzZb8Ven1VF00UODHfU=;
        b=qUCA3KSpK0KLofEQAl1J4VbNkFSBblrbel7Qyuby6GRPvaAdm4jfsLW4bnPm6lbW1e
         qcx4KopofnzhxwdlRp5SgOvrsC8bSrQikYwDCe8CB0VzaaV29H3evCR07OyELOjjd9hv
         4ABDXIq9k+NnJkSnIvGCTxqEkC3J2ijAsap0a326g4cBJErQiTFHDh1HyeEJrrF0aQyV
         so4WxN+vdwxfLVQ0zsQ/oAPw6hl8Xp6RSbAhruzbWScKKnzz8m7iuYWDzcUiK2HoQxYM
         dfPCaLnF77CwiboVDj2zI3wlkFslCIvwTwL3Z9dta+vjQS4I0jKVO0i/fTAS+KT0Ztz0
         GLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545458; x=1686137458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCcpa8mh8EUPdc5cCKwnMcMZnzZb8Ven1VF00UODHfU=;
        b=bPA3eyyZq3hAb+Qs6Y+AnYdYwHYFBrlYwMS0cZkhm6HdD7Fwd2HcgaVhOZZgWKdoXl
         8BU49xpSMBHQc2e7Epdb2uMar5SIYqFL92qzi4Ny9yyhL3UQXhaA8H/FTuUTFIjqLeHO
         nmbiygVDh97zHC62wgvkQHczlovKEHSfSlLobL3Dro/rEsYm0zUZ71aGeVOzlw84baPs
         nvx/CCc4GmaHikcCZBN4p/3303rWrgstuhY/BERRehynpHojzzmcwFnmUiGml1PLzRpf
         qBj2rZ53k6YP/1BelH2rKNatXZg/GOW4nx+km47BcwNfck+uZW6orqdo6QYrLv/I6yn7
         CE/g==
X-Gm-Message-State: AC+VfDzH1BbpT0kWbcTTY/gdWTRZBbbIbcC1+lDt5KhL7t2FXi/1DGaM
        Af5JtGAJ4CW9E8CGTCogV5GvLQ==
X-Google-Smtp-Source: ACHHUZ4EEcaGcUaK7vu//980DZoWeqhAaPt+zAj10ov/qO3SBtQsFVya9VsjeLlvmcsuL40m+iZZXQ==
X-Received: by 2002:a2e:b5d4:0:b0:2a9:45fb:6331 with SMTP id g20-20020a2eb5d4000000b002a945fb6331mr2698032ljn.6.1683545457872;
        Mon, 08 May 2023 04:30:57 -0700 (PDT)
Received: from panikiel.office.semihalf.net ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id k8-20020a2e2408000000b002a8b9353338sm1144406ljk.117.2023.05.08.04.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:30:57 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        amstan@chromium.org,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v2 3/7] ASoC: dt-bindings: Add Google Chameleon v3 i2s device
Date:   Mon,  8 May 2023 13:30:33 +0200
Message-ID: <20230508113037.137627-4-pan@semihalf.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230508113037.137627-1-pan@semihalf.com>
References: <20230508113037.137627-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for google,chv3-i2s device.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 .../bindings/sound/google,chv3-i2s.yaml       | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml b/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
new file mode 100644
index 000000000000..3ce910f44d39
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/google,chv3-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Chameleon v3 I2S device
+
+maintainers:
+  - Paweł Anikiel <pan@semihalf.com>
+
+description: |
+  I2S device for the Google Chameleon v3. The device handles both RX
+  and TX using a producer/consumer ring buffer design.
+
+properties:
+  compatible:
+    const: google,chv3-i2s
+
+  reg:
+    items:
+      - description: core registers
+      - description: irq registers
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i2s@c0060300 {
+        compatible = "google,chv3-i2s";
+        reg = <0xc0060300 0x100>,
+              <0xc0060f00 0x10>;
+        interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.40.1.521.gf1e218fcd8-goog

