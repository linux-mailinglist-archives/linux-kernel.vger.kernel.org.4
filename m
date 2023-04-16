Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70296E36E0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjDPKBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjDPKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:01:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C461273A;
        Sun, 16 Apr 2023 03:01:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5051abd03a7so2754228a12.2;
        Sun, 16 Apr 2023 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639305; x=1684231305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifmHqQmj9ZpKE5qeUf2zOsOombCp0CdZ4s2CBALGYW8=;
        b=SgHTx1h8KHwCv9z+bn5VGDN8r6XKvNFuH2jqNCFw37FqJUt9kfEMNhpTapioXdMzru
         XIOjC3hLT7VtaE2umtbsVd1xzM5YNFch+5fjtOq6ehrPujIYDABTHwxBB1c8NO8yhINU
         qH6nLWdMW4lSzPaQkw88PY5Z3stZk4Pcs99cdQle2hhXw1t21JAGJ94O29fPa6PZsNMT
         fO2mgHvyJocDORRX01IIxn3JJCn/PM285UtO3IEMy+3pYCFM0rpU8aiwRQUuwRTFJzd9
         noSLqZd4n57u395S2rtXQxHnULWcS+ke2Nv/AkPtDmoWcLtx6MKVJODpR764J47r75FL
         p64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639305; x=1684231305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifmHqQmj9ZpKE5qeUf2zOsOombCp0CdZ4s2CBALGYW8=;
        b=Mdrt8gl71ExvrdO19pKuym4Gm/o0iAvnYCAl2gi/FYbtCrIOdssIqvf+3gO8IoVEJ0
         aossFeEiZkLVNmUOEVVzRDMBlRgaFLh/cT+PyRKQq88h0AdL5MReusq1yyXNnhsAxsrD
         nB46GJ4ru8d00dIi0zT3j+YDhzpVFsu21/rVqhvhwYRdImjkRL8BwwjIkBVa5ZyG49XJ
         Qtle0ObXaQCPSpUOT5f8KF0o3CNvtrCmvQOhJ2sLWGJEg/FTe0c+CEnPFDTaRgCmON+E
         pIenHx6eR58KI5s2gwmJKBEYFTuIvDQyxH0x4N0hPx7L1PTiwJo/MxwA8Z4Uvpi4vapc
         3T+Q==
X-Gm-Message-State: AAQBX9dRhsitGdfVFeIC6Z2lJlJ2FCOid2cqEGd6zMzwlPbf9DaV9b0B
        KvGmiENRPxL58usMWoiWT0c=
X-Google-Smtp-Source: AKy350YvjEqcVlLEalKOluRbrTlxGidK5ID3dL5VEztZsyzq+4AHgYCg68FJCeW/2AnEIa1ucNy0lQ==
X-Received: by 2002:a05:6402:216:b0:4fd:23c9:11ed with SMTP id t22-20020a056402021600b004fd23c911edmr9586434edv.17.1681639304618;
        Sun, 16 Apr 2023 03:01:44 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id lh22-20020a170906f8d600b0094f6bf5ac9asm145232ejb.22.2023.04.16.03.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:01:44 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 1/3] dt-bindings: panel: Add Samsung S6D7AA0 LCD controller bindings
Date:   Sun, 16 Apr 2023 12:01:37 +0200
Message-Id: <20230416100139.13741-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416100139.13741-1-aweber.kernel@gmail.com>
References: <20230416100139.13741-1-aweber.kernel@gmail.com>
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

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../display/panel/samsung,s6d7aa0.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
new file mode 100644
index 000000000000..969cef7738b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6d7aa0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S6D7AA0 MIPI-DSI LCD panel controller
+
+maintainers:
+  - Artur Weber <aweber.kernel@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6d7aa0-lsl080al02
+
+  reg: true
+  reset-gpios: true
+  backlight: true
+
+  enable-supply:
+    description: Enable supply
+
+required:
+  - compatible
+  - reset-gpios
+  - enable-supply
+  - backlight
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "samsung,s6d7aa0-lsl080al02";
+            reg = <0>;
+            enable-supply = <&lcd_enable_supply>;
+            reset-gpios = <&gpf0 4 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.40.0

