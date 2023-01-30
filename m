Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2782680F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjA3Nng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjA3Nnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:43:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4386214E8C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:43:32 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso5358307wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dzAvNhqbLHD8Qqr5U4HkMhu9d4Ko8KZtdb+p3yzQqo=;
        b=r3+O9ok547RbwEpeaTLhkg2nhQik6ojXy+fTq+Mnx7azfKGPocnjWfqHgTANTMmRRi
         Ga7BrBfT6JMqxyyLMGSRQGNZWeS/0obKNdiOuurdTQfR+4PLPos4/1ZQ7Lrt6uEn6siU
         mXpsUovrCJCA6CmoF6tql2U5NHvmyJxWbUQtFpIa1/YnhFNS9efyClfxEwebL08zPvOw
         SExuyJGXGdar9XV2X8crhizmga9Wi/Mh0H1rRXTsBeOkK2Qsnk+qHb0V1vVsQYGpWtLx
         vAwsDI3vaM0mJSi6vBtY+oyJKFvojk84NRYYDuVRU4DAqvyl5WGPE3dT9ddYNJc4hv2j
         d0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dzAvNhqbLHD8Qqr5U4HkMhu9d4Ko8KZtdb+p3yzQqo=;
        b=qcNmWKYA1XHFegderd+7Qg3Mh3jQTlKraWUgY2PvvIegHi/O/ZPS5l8esIb/pbbw37
         CLHd4UB99WhQ12kDLrND+AeT1qkrwU7jdBRHgig/n2M9SjFGyzJsP8trl6U+9S4vQqON
         IDgkHoRhCs8Z4MXU7E87BqkOsdjpcw3XthtpSbqHi8VZzvtEd9CzpYUWsyxmzw11GMBw
         unPXkDS0SoO3THoPnoOFzgtchH4NZWXhblx0mcE343aD+BKZy9n2AsTpbpnDC7l3km3p
         RxqM+Tnj/mWxeLVcfi14hx5PQ+0VpKL2FqNZg0v1zqa06PIxivxq9Uo7iVBxNYzVPuc2
         WYTQ==
X-Gm-Message-State: AO0yUKUIUKsnx0RIoTxP/FFWOP/n9yaG01wSfXyb/ekjehIi7I7Fd+bw
        rn9yTEYeM5CFllQZRTC2jvHuew==
X-Google-Smtp-Source: AK7set97xlKmmDBvKPBmRQ17fPHhyiyadsOAAP+bSHsQR+a7netx9q1OsYsNQSaB7yg2FcxInSshMQ==
X-Received: by 2002:a05:600c:3545:b0:3dd:1ac2:989 with SMTP id i5-20020a05600c354500b003dd1ac20989mr256851wmq.39.1675086210825;
        Mon, 30 Jan 2023 05:43:30 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b9a5:a1fe:d3ab:6b40])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm27403410wmo.2.2023.01.30.05.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 05:43:30 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] dt-bindings: watchdog: qcom-wdt: add the interrupts property
Date:   Mon, 30 Jan 2023 14:43:28 +0100
Message-Id: <20230130134328.178591-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The interrupts property is used in all nodes using this binding but not
defined in the document itself - hence dtbs_check fails for them. Add
the property and update the example.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/watchdog/qcom-wdt.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 27fb484d5f8d..45940d643b92 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -46,6 +46,10 @@ properties:
   clocks:
     maxItems: 1
 
+  interrupts:
+    minItems: 1
+    maxItems: 5
+
 required:
   - compatible
   - reg
@@ -55,9 +59,16 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     watchdog@208a038 {
       compatible = "qcom,kpss-wdt-ipq8064";
       reg = <0x0208a038 0x40>;
       clocks = <&sleep_clk>;
       timeout-sec = <10>;
+      interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+                   <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+                   <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+                   <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+                   <GIC_PPI 5 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
     };
-- 
2.37.2

