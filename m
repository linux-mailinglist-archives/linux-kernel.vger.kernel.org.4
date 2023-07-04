Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B982C7469CD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGDGoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjGDGog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:44:36 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A39E52;
        Mon,  3 Jul 2023 23:44:35 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56344354e2cso3592273eaf.1;
        Mon, 03 Jul 2023 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688453074; x=1691045074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OHbfvvmaSbzlb/vBLJ9aFEGcvRSExJ6vAXO7h1XWQ4=;
        b=KY2obyYESzVjRBeUsmZ60npJo2lZdksg//QRatxMy4X6uTgeTH330jAXlM1kxn4bcx
         +oZrv+Rk8AGPumczcrqQe1OI7rjWRb2Otd04BEeuOyYElrUTacsxdD7nT9AI61xlRD+C
         NOsC6vB0j5Ckh0M1f81CgZYi8Tk8yRLeYZob2TxvxmceX72Jr6fIZY3Hj0qt4wKHqJOz
         mOPCWzz81GE6+jbZ74v+h5eDTPYQzu45Mm345kUTJzBai+5/aAzS7K7xLxrr45x51Hph
         hmYyoaT+g250b30VjmisILMIeE50kGsq7ZUswM8GH1TSMhxjkpc8LvebWbUgyEckH6Mv
         G4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688453074; x=1691045074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OHbfvvmaSbzlb/vBLJ9aFEGcvRSExJ6vAXO7h1XWQ4=;
        b=Kz2Lgk4+qXuLTJr8mkoEdHj7TK/BrNyFCNjibF112uUPBfNt1923/bmio/9Xeh7VcE
         HJAI/H4DI/kRcDU+YHl5hFxwxM/yy/j6LzwDXkLy0JPBhhV+hQTkYpEev0SHZXwQ3xu2
         mFXZb1X21NzKBggnyNVGPZuWI05btR4HJSSrzx4jg98+8WTEHh0EoxTfLs60e8zGRMtL
         bY4L10xNKjaSGgLbZ1Vp5ewH+v8yu+iGz/8xDfp/jedPiKNF2Fe3CiYoZNJ64ToQeZRl
         9NkBbK/6cg0JlUB9T5Y/tFEHmoFx600+JxswZoCKyyjA89yEVC5dEyStCXj1iJUzZDYh
         0FsQ==
X-Gm-Message-State: ABy/qLbnSmQt0sTXK/4Vbtx5DV+D0af2cxx4+2XEWTn33Tji73UAvt2k
        7vl3YuKnKrwqaaf0x2nDmdg=
X-Google-Smtp-Source: APBJJlHD6Bco3FK8+YJv9FEp4SHU73++m6lHAAoBoXMzH7wGLP95nW1aLC6eAF3yywPVlsMsaw6OtA==
X-Received: by 2002:aca:1308:0:b0:3a3:9293:dd75 with SMTP id e8-20020aca1308000000b003a39293dd75mr8857519oii.28.1688453074572;
        Mon, 03 Jul 2023 23:44:34 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u2-20020aa78382000000b00668652b020bsm14863429pfm.105.2023.07.03.23.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 23:44:34 -0700 (PDT)
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
Subject: [PATCH v13 3/7] dt-bindings: soc: nuvoton: Add NPCM GFXI
Date:   Tue,  4 Jul 2023 14:44:08 +0800
Message-Id: <20230704064412.2145181-4-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704064412.2145181-1-milkfafa@gmail.com>
References: <20230704064412.2145181-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 .../bindings/soc/nuvoton/nuvoton,gfxi.yaml    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,gfxi.yaml

diff --git a/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,gfxi.yaml b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,gfxi.yaml
new file mode 100644
index 000000000000..0222a43977ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,gfxi.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,gfxi.yaml#
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

