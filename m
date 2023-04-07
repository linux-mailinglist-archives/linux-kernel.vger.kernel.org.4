Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F1D6DB028
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbjDGQFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjDGQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:05:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C00793F7;
        Fri,  7 Apr 2023 09:05:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id by26so9336002ejb.2;
        Fri, 07 Apr 2023 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680883535; x=1683475535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCfQI5H/IeKkKNwHRcXn8+odI3X7WyBM8i0fjwltF7k=;
        b=HNqR5326kJmWXU0ZtNwFpVFizD3u6TQfamQEFGsMyZvrKQSr0ALzvN139R9Mh4rNSw
         1oi4T4+76roxk7BpyQ+FGw/skyEbL2rTMU/Z8fjF6uemqWTWcRdXgu3ZRVqS/H8MkQ+y
         JNvWwyoTTkB4ny7qaVo6/0gx5EePsVKDWR75uxDsQukLUX8LFdP7dNTyMNAApph4cMaO
         ukiiqs5hYDgjwyGjku8foeaRsjKLtygZWUTxrFHkr2JgCgxsc8ZTHNa0g8LSGHTQSShd
         0E+1Zd3AJrdsp0qeHtWoCPtX3G+4dls8fbg9nfMFy3eo6zyyasM84iF5yW5OFcVm3C3J
         nx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680883535; x=1683475535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCfQI5H/IeKkKNwHRcXn8+odI3X7WyBM8i0fjwltF7k=;
        b=qG47Paj9TLaw+5Q4wPOGYaFeZRbgbfVZddeFzabpDikOLFm1Aj2PqPaCqaNyTSdXsw
         AotYe91ZTon0DyaWlSLPbiyX9XK4pqPieaF1yQlDWBhOs5/5y2US2/KPmTh+OZBNWqyW
         lm0jHS08difx5Uzfz4OHmE5wsixSHE+UYy3zK6TMl2eU77398CNOVeQy2K8vWSqBsFEx
         DgxekFcUIRR2Fu3k+vkfAGVb5PMksiGT0SzSRTpYZPI3x2DZi78g4uPFB3LrnNp30grk
         q8xLvzNTVS1Gd588ZRTgFRdaLc+Q1SEqcezLPktfxCSs7eGpNfi2914PaonN+w30sVPh
         xVhg==
X-Gm-Message-State: AAQBX9dwU5BbWX5Y+TTFHaUwnC371OQTUTevlv+HpQAnWttwkiY+TTUA
        0Lm+7RJc2ry6nhfs17Bclgw=
X-Google-Smtp-Source: AKy350akfoI0pLWIggcByDI3OO5rr0ArYuxGkJywSu6zZF2AczSB4jcP3pBrL8z3FuurlJUU+OwjSw==
X-Received: by 2002:a17:907:7e95:b0:932:f88c:c2ff with SMTP id qb21-20020a1709077e9500b00932f88cc2ffmr11244427ejc.34.1680883535614;
        Fri, 07 Apr 2023 09:05:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.79])
        by smtp.gmail.com with ESMTPSA id lf11-20020a170907174b00b0092b546b57casm2147585ejc.195.2023.04.07.09.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:05:35 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: hwmon: ina2xx: add supply property
Date:   Fri,  7 Apr 2023 19:05:07 +0300
Message-Id: <20230407160508.20479-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230407160508.20479-1-clamor95@gmail.com>
References: <20230407160508.20479-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vs-supply property.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 47af97bb4ced..8648877d2d01 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -57,6 +57,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 4, 8]
 
+  vs-supply:
+    description: phandle to the regulator that provides the VS supply typically
+      in range from 2.7 V to 5.5 V.
+
 required:
   - compatible
   - reg
@@ -73,5 +77,6 @@ examples:
             compatible = "ti,ina220";
             reg = <0x44>;
             shunt-resistor = <1000>;
+            vs-supply = <&vdd_3v0>;
         };
     };
-- 
2.37.2

