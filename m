Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C48679C34
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbjAXOlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjAXOlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:41:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDAD49552;
        Tue, 24 Jan 2023 06:41:33 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so14249656pjl.0;
        Tue, 24 Jan 2023 06:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq3YLnLVdkwJ+hnndTnVXYO2IvsFe7R/GdMhEuzT5j4=;
        b=qMpHIwatJI7zt7K0Oj5YJJtNre1MxSkLAvexCvRqP0sIGGVEuxDWUkXxM2h8INC6++
         400E9rHBOh8w+sa3EX4PJ5/lnt5rrnU0oBvBK9XrMdsKyVWF2Vtynj27X0kTQ6Ol3an5
         Apgf/y9I8CySuRTNTIbgYusdiWQ1SWQjJSQqZus6cQ/uXXC2Xc7QXhbYGh5qKK2LnG5z
         LiLsOzpxV8oS08MvJyE2hAUyORdtOkxskccUWUK/Wut7Y+oIn3xSZOD3Oq32wkNrjDxs
         TSZ0KY/ESm4aoJw5iIihi5Nh1X4cb9UglvXj8WZYUnKZcnrSxMnAUwmZ2vMrcvcR07wc
         FyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hq3YLnLVdkwJ+hnndTnVXYO2IvsFe7R/GdMhEuzT5j4=;
        b=y3IWfR3WZWFfwALKRxmiZzmxD3AFe0HXYd9FsXZ5Agvz+eb4Y8ejE6Ni+iBHj5V+bG
         eQTpAD4f6GrOj5k9eq3AssC2k7KZ1lNgxVD6AnqtrEhnGEIxpC16rpYg2oEwaCpIqPoQ
         CKVz8KGDNSyNixD1Ik16viVDd2qBO4V39F3b9N60rHzsZbGJTyamZCHFjAwRt1geOLAP
         Xyjo0h4B8zcJ33Vt8gMgypzQTXZI+niVJT3ioWN5rvqGfyMypKtESKIztw9MIBOs97qz
         os/7mQBcht3SPZR2w8ssHhMRAe2FbFltSpgM3AEUy1s7lKMbJNteoIA9Ib86paBxHY8s
         4T6A==
X-Gm-Message-State: AFqh2kpalaY/pVfTWjeR8+rdispKg/WYNR/jm3xp7CCxppPnyXDvSHVC
        xiwZOA2gv2NR15KzPO7iVCI=
X-Google-Smtp-Source: AMrXdXvY1o7Qhxes1YcRkrxgd4lGAV6Hmi6k9DyO8x/ZrZHVk5g2zWtj7+yHvsP+tOAhpSj57x53Vg==
X-Received: by 2002:a17:902:eccd:b0:194:dec8:9824 with SMTP id a13-20020a170902eccd00b00194dec89824mr23203736plh.26.1674571293053;
        Tue, 24 Jan 2023 06:41:33 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b0019602dd914csm1747865plc.180.2023.01.24.06.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:41:32 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v4 4/4] dt-bindings: usb: Fix device tree binding for VL817 hub controller
Date:   Tue, 24 Jan 2023 14:40:53 +0000
Message-Id: <20230124144054.13556-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230124144054.13556-1-linux.amoon@gmail.com>
References: <20230124144054.13556-1-linux.amoon@gmail.com>
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

Cleanup by removing unneeded quotes from refs and
add maxItems to reset-gpios and fix the required list.

Fixes: 31360c28dfdd ("dt-bindings: usb: Add binding for Via lab VL817 hub controller")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../devicetree/bindings/usb/vialab,vl817.yaml  | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
index 5f9771e22058..23a13e1d5c7a 100644
--- a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
+++ b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
@@ -14,29 +14,32 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - usb2109,2817
-          - usb2109,817
+    enum:
+      - usb2109,2817
+      - usb2109,817
 
   reg: true
 
   reset-gpios:
-    description: GPIO controlling the RESET# pin.
+    maxItems: 1
+    description:
+      GPIO controlling the RESET# pin.
 
   vdd-supply:
     description:
       phandle to the regulator that provides power to the hub.
 
   peer-hub:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       phandle to the peer hub on the controller.
 
 required:
-  - peer-hub
   - compatible
   - reg
+  - reset-gpios
+  - vdd-supply
+  - peer-hub
 
 additionalProperties: false
 
@@ -45,7 +48,6 @@ examples:
     #include <dt-bindings/gpio/gpio.h>
 
     usb {
-        dr_mode = "host";
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.38.1

