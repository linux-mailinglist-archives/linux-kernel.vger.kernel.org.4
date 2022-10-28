Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3972D611DFF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJ1XNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJ1XNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:13:15 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5551DC0A4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:13:13 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id n18so5034733qvt.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ukQQfOYSPm/+bCMthg8nZwj163N2VFbmekvUQi+HF/A=;
        b=tJ0qVOk5vF+xzBZsnUZQ+ugGW7Gw0IC12me1ZSTUBwfLTQ7s4iYoyLTvu/rN1YI1k5
         nGBjdT0KpOXWsMAWJ4jvwqsMoK9nNegrLmmKIBICFtrEmvb3mgLffbp0haIjJef1H9yK
         nL8uuRMXsuiPDY/1wmTrzPLZXAlBz/C6p+rr5Bd/0VWEDRtJA7NLwKwZvUW4QkbPECMa
         s2y3T/Qw4ACeua7jIA8ub17tRcQy2yFHo7LI/a39RWGt0C4MnP8nUrekPIxwOu5Mfdu/
         jQxBScD73yQNej/nyPWRkWzv18c/fM67KFZrep9JyZsRTfk5RAo6V8buYLaRSgVSafJW
         NH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukQQfOYSPm/+bCMthg8nZwj163N2VFbmekvUQi+HF/A=;
        b=S0URc+ID9PRU55ekbdWOp8shbK9N6EOLMkRKc1PKFnN0BX1KL+n81YRy/TotKHktkp
         nwtJ7mxv3fAxdmtDTWV0CKEJE3zt+n1cj3EIGs78hpEep769LPzwFbqw98B8NfN+tBC+
         J5zUfq9dc6tVEKN4lAgUuwX9BAkkRFPwE098WZP33PbQVASUqBmXzydVAVDFL+6rz2Q7
         61rl4KeGofUnYWIIy8dTujxRS7/nmQf0zi5HgPpzUzxyyi04LWgRlTheALApehuA1W8y
         fOSBqfQzXytfAgBVMTKr4/CPMTg0Pf9DSPIRtJbG4/tgP0emYyDClMIQICYl9N6Ab0Wo
         thuw==
X-Gm-Message-State: ACrzQf2RZDFNy4hFmKNCPSxX1BTji6VZXMYJKLC2Tb3ai528LoJh6xMb
        nZIkSXn722VDXcPnVSmXNTEXCg==
X-Google-Smtp-Source: AMsMyM7NTDIK+8v3wplA9/kAnXQHJEjgj/3Z7iy1r0z0CoEiwKcmQbEF6c3PG5w1BZ2a5jFhz+GApw==
X-Received: by 2002:ad4:5bc5:0:b0:4bb:7e1a:9de6 with SMTP id t5-20020ad45bc5000000b004bb7e1a9de6mr1618274qvt.68.1666998792570;
        Fri, 28 Oct 2022 16:13:12 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id ay7-20020a05620a178700b006cfc1d827cbsm8256qkb.9.2022.10.28.16.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:13:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mfd: Expect specific type for monitored-battery
Date:   Fri, 28 Oct 2022 19:13:09 -0400
Message-Id: <20221028231309.565451-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Core schema does not define type of monitored-battery, so the schemas
are expected to reference proper type.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/ene-kb930.yaml      | 4 +++-
 Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/ene-kb930.yaml b/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
index 06ed9ec8f4bb..b4c6f9529ce1 100644
--- a/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
+++ b/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
@@ -22,7 +22,9 @@ properties:
   reg:
     maxItems: 1
 
-  monitored-battery: true
+  monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
   power-supplies: true
   system-power-controller: true
 
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
index 935e17099213..d136a05c7758 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
@@ -126,6 +126,7 @@ properties:
     type: object
     properties:
       monitored-battery:
+        $ref: /schemas/types.yaml#/definitions/phandle
         description: |
           A phandle to a monitored battery node that contains a valid
           value for:
-- 
2.34.1

