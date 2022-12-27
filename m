Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335D7656925
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiL0JwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiL0JwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:52:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C41E9FED;
        Tue, 27 Dec 2022 01:52:00 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so4163201pjq.1;
        Tue, 27 Dec 2022 01:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxkElKmgrqtTP5be0jVrJHJmBiDppX9Zdl7lKzzovCQ=;
        b=pn9bWV2mFXImcDnXT/ZYc6mZuqBpqqHEMG2I8uDVhburANDTQ6g3gqHSk60xuAbOxN
         YbgJFlGmUFRLXXWtexwTRev0H2jrHYcC6sHRyaIvbK7Pc3hVg5bhiM/aE71tKR7/RzFt
         3KkvMRJ8el/7lhHHxDpi24IL5q3Zudz/JdbHKxbS5+753Sa3AEVBB2ScCm6N+GiwzOLO
         zRwW0TKEsv7tY9J+QCJUfrTxDYIwlweZn2xuPqMMjCxXsFqO4OMkaghE3g+ZPY+yIujK
         /zWnfCU91J168dDEgBz4wAyZmli9BvIcpY38jIYKMmw93dDQKGL3zs88T9oBVNMyfh9a
         1/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxkElKmgrqtTP5be0jVrJHJmBiDppX9Zdl7lKzzovCQ=;
        b=70Eky/z8znv7B6vMLlEna48jAoeBRKZcqg17I5k9N6q5Ns/5LwgB/NDIrAftHhH+8g
         Xtl/yo/4hCOHjvpV7WJClYsjYj5mmH/SDzTIW8O6eT6qoUdhKarpoD4OYKb//LkFk8J1
         04QqpxOHKVDtrHuAB+6iy6OVhLj1hF0KyxzT0EksYH537EEq/M947taYDQNRNExEgzrK
         mbPJufiHSdJHJoZQV2UzdpuJjzgTuKcBbBdi6RvDHH8h4Z85Nbj+kzVsh+ArmvyQcWj3
         9MqHeXMD0FoZa7pVxCtE+MID4fpHF3fHwWEpwB7OO8rd8leHDBmtPV8NloLT4Du0NTDF
         nSwg==
X-Gm-Message-State: AFqh2ko0Ih5J1ZbvT1m+YHJsXoDcryBp3Y/NXzq0xqzFf8ccxZOp7KlA
        vSiJ0HicyLIOvXYDlkte3gbTryzlajkTYA==
X-Google-Smtp-Source: AMrXdXsO4mwO6dEWP1kCE+jo1tgiPFW/xdFHtO3FRdvRNEq4twaFH2IXpwVYCWlwM8Ot8o8mr03p7w==
X-Received: by 2002:a05:6a21:1507:b0:9d:efbe:529a with SMTP id nq7-20020a056a21150700b0009defbe529amr25598732pzb.10.1672134719625;
        Tue, 27 Dec 2022 01:51:59 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 21-20020a621515000000b005813aec74bdsm2619052pfv.139.2022.12.27.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 01:51:59 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 3/7] dt-bindings: arm: nuvoton: Add bindings for NPCM GFXI
Date:   Tue, 27 Dec 2022 17:51:19 +0800
Message-Id: <20221227095123.2447948-4-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227095123.2447948-1-milkfafa@gmail.com>
References: <20221227095123.2447948-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings document for Graphics Core Information (GFXI) node. It
is used by NPCM video driver to retrieve Graphics core information.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/npcm/nuvoton,gfxi.yaml       | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml

diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
new file mode 100644
index 000000000000..c033128e567a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/npcm/nuvoton,gfxi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Graphics Core Information block in Nuvoton SoCs
+
+maintainers:
+  - Joseph Liu <kwliu@nuvoton.com>
+  - Marvin Lin <kflin@nuvoton.com>
+
+description:
+  The Graphics Core Information (GFXI) are a block of registers in Nuvoton SoCs
+  that analyzes Graphics core behavior and provides information in registers.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,npcm750-gfxi
+          - nuvoton,npcm845-gfxi
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    gfxi: gfxi@e000 {
+      compatible = "nuvoton,npcm750-gfxi", "syscon";
+      reg = <0xe000 0x100>;
+    };
-- 
2.34.1

