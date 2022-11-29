Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E266D63BEC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiK2LT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiK2LTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:19:24 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B8E115F;
        Tue, 29 Nov 2022 03:19:23 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w79so13382669pfc.2;
        Tue, 29 Nov 2022 03:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN8un9HpKJ6jCwK6chNoIv5vh7+lXCbI1Cq9dR3jLDM=;
        b=Zt8+eooCT3/kX8hr0ToQ+vhWmiP+esTcK3OgQ7EZqfnpQIHWai7tbGyqE/5/TjkYgC
         Z6p6py2ieUZfNZegihl/bSANUCpXLoBlJ6EaS2++An0hRaJ9kIvlP8BSKWmOdwHzZu8t
         OQgI3eHtTcKEnjrG4aODlhlSrPi6BNPccy6zgJuUtX3CTM0xY8Mc0N5w6AR2fmmUHQMo
         M1Pj8AzaQhUWDyy7R513Fpy5DHHyOxVw7KDpv1HeTxcfU8M5curHqOP2HMnmlxGVnCHZ
         lTL3uKRfHJ162P5PS5FLabQR4MkuRnvDHobfSvXQOUve4EqXo+tT+PRd3HJfGBSmLBOf
         pdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN8un9HpKJ6jCwK6chNoIv5vh7+lXCbI1Cq9dR3jLDM=;
        b=eTZqabDUjew7ZlFGPUeqGWMtRJj/V/cM+rehflNyeIU2A9L6rvgFu36KB+h2qAsw0z
         aCtYRGkKP4ovBwq4uhuLQ8Per2/780m2RppmH3/aQ16LuCnXkcSMQ9m+jwMjbnkNo1i8
         E0Sm+9KjT3S1viR7C0L1bt/AkgYyk2F2NToNi4aBPsO5TFjd8nNMWv5+6cwrhnSZYSBY
         fKNcYF6R7TwKxFGpjNmrreNoNEXkoAFwXWlhV3Zg3fTgFvCNuhyaEl9XA4c6LvjI5Ito
         iQWqOsMdpGQgB3Y6Aa3JyBoutR28LQhYyy5RMtx97LLdfz2IC2AOXV/wCQ2EqbUCigbe
         Ozdg==
X-Gm-Message-State: ANoB5pkAE7b0iTb3dDp6GYjBx8LueYobyyEnLziBwTuPFN9d6VPwSvbR
        ByCpr/medziD8Rrh6EaWaFanI56kWnk=
X-Google-Smtp-Source: AA0mqf4lGibhk8kBdCOLNfuTAJU6kRxpfZVQ+Tg0b1+rza9qnIwU0kzvsibnJuAhQaKBxkNFETaN0Q==
X-Received: by 2002:a63:a0f:0:b0:477:af25:387b with SMTP id 15-20020a630a0f000000b00477af25387bmr28499949pgk.288.1669720762961;
        Tue, 29 Nov 2022 03:19:22 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d4-7fe5-5c2c-fa0a-e67b-3955.emome-ip6.hinet.net. [2001:b400:e2d4:7fe5:5c2c:fa0a:e67b:3955])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902d29400b00176b84eb29asm10528669plc.301.2022.11.29.03.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:19:22 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Gavin Lee <gavin.lee@ecs.com.tw>, Harvey <hunge@google.com>,
        Bob Moragues <moragues@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Tue, 29 Nov 2022 19:19:13 +0800
Message-Id: <20221129191901.v6.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries in the device tree binding for sc7280-zombie.

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

(no changes since v1)

 Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..7ec6240311db 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -655,6 +655,16 @@ properties:
           - const: google,villager-sku512
           - const: qcom,sc7280
 
+      - description: Google Zombie (newest rev)
+        items:
+          - const: google,zombie
+          - const: qcom,sc7280
+
+      - description: Google Zombie with LTE (newest rev)
+        items:
+          - const: google,zombie-sku512
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.17.1

