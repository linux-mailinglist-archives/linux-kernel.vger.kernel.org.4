Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A3C6B023D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCHJCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCHJCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:02:32 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFAC9609B;
        Wed,  8 Mar 2023 01:02:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s11so62761658edy.8;
        Wed, 08 Mar 2023 01:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lzu9bzEGqcu2KmMdZnQFwDXwVJpSW2jAVAy1BeLRyY=;
        b=oeXzRPdGt3zyzDQNXPT58ahdDhTnpdodkZqd2euRE/JqRnO6nI/tJGwG9l9ywshUxF
         Dt40RzzWSWmXyjpSzpPo4Wew+2j0baFjasmMaYRMGAeUCq0/wcYC/Jjz3L/jdqFdj6Qr
         XMVaWk8rIdsQr6Qm+terGnqznbaxgdTfdDLabXOI8lLdElv0vRATTL/vcieH8Y3lNEFe
         qAHpP2h07WFzjjH81BTP/nORscSehU1S1uwCk4nRNZ/BSSdYAjCgaFnzz/wOcaQKaZNw
         F9/hlRwDGw8oC20bmkBo85YCfPXd3Q1+vLippv9+gMPo3yYlRkyp5SSMKmGkwVK2DN/j
         RgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Lzu9bzEGqcu2KmMdZnQFwDXwVJpSW2jAVAy1BeLRyY=;
        b=Uk0LZaVFlRYv/2UThrwh2L1TlQg98G28f+aVtLeNek3pd15V1aa0iFr9eNe+iz059E
         twjaVfELuepjoSwXObnLwNOcXszwR2WibN9S3EpOocieFEczJivAYHXH9rFsA9pBUSEy
         3mdRp1y7M8YlP+9fN5cl6m4b2eLT0zzrvM03ueqd5STPw7zdj90zQIhUGoVamhwP7oMn
         zhFSm/iN2JUQ2/wqL2St1BPQtECUn5dHV3LVTM36lJzUVk0Zwp2bamreKp1dXFkyx1+3
         NloTt8Gd2TpktfLWcdv+WvZYHZ+xXVl3lFQWMCK5DpIZw7JEw7BTWQvDn75obnd14c8P
         3CcA==
X-Gm-Message-State: AO0yUKV5V4aqxOYefMfEjLFvN+c+qURsOA/pg4vRovj+krJuFyDr2gKh
        DlEUBBGgfmsPib0HxEEip+I=
X-Google-Smtp-Source: AK7set/Her90RNscwTP5bNel7eLNCnOT9PBBZUAptMF40yGu56VSiRix3MVUs1gfbm4s3Glk6JwKtg==
X-Received: by 2002:a17:906:fca8:b0:8ae:707:e129 with SMTP id qw8-20020a170906fca800b008ae0707e129mr16319860ejb.19.1678266148422;
        Wed, 08 Mar 2023 01:02:28 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090643c700b008caaae1f1e1sm7153709ejn.110.2023.03.08.01.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:02:28 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] dt-bindings: iio: light: add apds990x binding
Date:   Wed,  8 Mar 2023 11:02:16 +0200
Message-Id: <20230308090219.12710-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308090219.12710-1-clamor95@gmail.com>
References: <20230308090219.12710-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding for apds990x ALS/proximity sensor.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/iio/light/avago,apds990x.yaml    | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml
new file mode 100644
index 000000000000..9b47e13f88e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/avago,apds990x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Avago APDS990x ALS and proximity sensor
+
+maintainers:
+  - Samu Onkalo <samu.p.onkalo@nokia.com>
+
+description: |
+  APDS990x is a combined ambient light and proximity sensor. ALS and
+  proximity functionality are highly connected. ALS measurement path
+  must be running while the proximity functionality is enabled.
+
+properties:
+  compatible:
+    const: avago,apds990x
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+  vled-supply: true
+
+  avago,pdrive:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 32
+    description: |
+      Drive value used in configuring control register.
+
+  avago,ppcount:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 32
+    description: |
+      Number of pulses used for proximity sensor calibration.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupt
+  - vdd-supply
+  - vled-supply
+  - avago,pdrive
+  - avago,ppcount
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@39 {
+            compatible = "avago,apds990x";
+            reg = <0x39>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <82 IRQ_TYPE_EDGE_RISING>;
+
+            vdd-supply = <&vdd_3v0_proxi>;
+            vled-supply = <&vdd_1v8_sen>;
+
+            avago,pdrive = <0x00>;
+            avago,ppcount = <0x03>;
+        };
+    };
+...
-- 
2.37.2

