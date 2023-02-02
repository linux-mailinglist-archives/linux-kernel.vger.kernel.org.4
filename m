Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B96878B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjBBJYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBBJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:23:58 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3D06F706
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:23:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lu11so4182819ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+895vSqqhP2PRbIGa0xaBQ6CuDJr2raP8r23AovQRk=;
        b=cVZq4U7jNfYXgMVU/53hG/SLEZlJ3VACL1yopNshey8SZArqPpFNsGRs6NPIhl7Foi
         h+qV2nw2xCQOb7qJ8a/Yh9q3TA/f67Koi3HVxazOs6GIaTBDSm2W/9k2lY/ussVcR49w
         EnIgw2361jZzHuGq5i31DYNSOxPepEwBWO0FCjnxMOFgqf7NfJnhY4sSEEF0XOalbDsP
         i0HfXbIzAlirXhfioNHW3J6mEwLOvo07DfHh8evqZThgsppmRgMqBCRyfOysU1kDIJNi
         DHwUbK6sxkkzIB/xo6g4ZrSb4r3ock6M3DUrCqGsaN9NSajPVsSdb8a49LGuCGKqq4+Z
         x/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+895vSqqhP2PRbIGa0xaBQ6CuDJr2raP8r23AovQRk=;
        b=1mLNtiWZlSSA7qksaaDdwPLzSxZWkL+440btCxtZ3hF4FfweHMZC70ov9soBHb8P3z
         eg0xHGDTLisx+3LI6zHj/iY1IaWEXIHi+3eTV2PgWoh8b9+rdfgMYaRDMr/sFmIRQ0RV
         HzQ9PklYQ+s2H56c77nrLnV/puwOie/g6XhUAOIF1litHeO9pmc8un+WKM02c3xahSxh
         6BbvveOg0vNlOWk66ndVn0DPIVB8yF1PnaPdEB+AOVOWfpJri0ALVNOmRtAJ05TGqt7C
         RCQNigNCXQTq6ZtMPOktSuXbcEY2qUO5W/IrKBYc6qQdKAWulwNbuJHesIAuhA8mwi2j
         YD6Q==
X-Gm-Message-State: AO0yUKUFkgsfvBCtoL1cXgHgMHXGMx7CfhmHBPrg7sPyV+qUNAOH+Gkg
        Z+AqMID0ES+zBKdcCcM877xJNw==
X-Google-Smtp-Source: AK7set9vcjO4GbumvXKV0620pDVqT04sclTstNMLqtFNmG+OR6TMgSxuScq3KVvtuolgU2bUTBGqPA==
X-Received: by 2002:a17:906:f190:b0:888:6ae0:d12e with SMTP id gs16-20020a170906f19000b008886ae0d12emr5678697ejb.36.1675329835051;
        Thu, 02 Feb 2023 01:23:55 -0800 (PST)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906474400b00856ad9108e7sm11372658ejs.70.2023.02.02.01.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:23:54 -0800 (PST)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Date:   Thu,  2 Feb 2023 10:23:24 +0100
Message-Id: <20230202092325.21241-2-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230202092325.21241-1-maarten.zanders@mind.be>
References: <20230202092325.21241-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding to configure the internal charge pump for lp55xx.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---
 .../devicetree/bindings/leds/leds-lp55xx.yaml          |  8 ++++++++
 include/dt-bindings/leds/leds-lp55xx.h                 | 10 ++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/leds/leds-lp55xx.h

diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
index ae607911f1db..22e63d89d770 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
@@ -66,6 +66,12 @@ properties:
   '#size-cells':
     const: 0
 
+  ti,charge-pump-mode:
+    description:
+      Set the operating mode of the internal charge pump as defined in
+      <dt-bindings/leds/leds-lp55xx.h>. Defaults to auto.
+    $ref: /schemas/types.yaml#/definitions/uint8
+
 patternProperties:
   '^multi-led@[0-8]$':
     type: object
@@ -152,6 +158,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/leds/common.h>
+    #include <dt-bindings/leds/leds-lp55xx.h>
 
     i2c {
         #address-cells = <1>;
@@ -164,6 +171,7 @@ examples:
             reg = <0x32>;
             clock-mode = /bits/ 8 <2>;
             pwr-sel = /bits/ 8 <3>;	/* D1~9 connected to VOUT */
+            ti,charge-pump-mode = /bits/ 8 <LP55XX_CP_BYPASS>;
 
             led@0 {
                 reg = <0>;
diff --git a/include/dt-bindings/leds/leds-lp55xx.h b/include/dt-bindings/leds/leds-lp55xx.h
new file mode 100644
index 000000000000..8f59c1c12dee
--- /dev/null
+++ b/include/dt-bindings/leds/leds-lp55xx.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DT_BINDINGS_LEDS_LP55XX_H
+#define _DT_BINDINGS_LEDS_LP55XX_H
+
+#define LP55XX_CP_OFF		0
+#define LP55XX_CP_BYPASS	1
+#define LP55XX_CP_BOOST		2
+#define LP55XX_CP_AUTO		3
+
+#endif /* _DT_BINDINGS_LEDS_LP55XX_H */
-- 
2.37.3

