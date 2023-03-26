Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310546C98C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCZXiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCZXiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:38:18 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769464ECA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:38:16 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id ca2-20020a056830610200b006a11ab58c3fso3018645otb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1679873896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ76nHN8M0ZiVoHm0Euw0qHTeLSoiFoZdMJCuKUGiYk=;
        b=EjDyV+MaIAxYS604JCZXVJ4L5q1IT4a9dGC4uZSg9fnQ7oS4QxWRPKLEG87YguBnMB
         /84j9uLvLcHSLYLF7CYmvn+A8mawXKiOMvrW0gFdr1Oufix6/iOQ7VY7vL820Q6Ly1Pi
         VCUaso4KkCS5PvoiEGLHAZRzmt2kZ1swXXPp7nlWgF3RkamL0Imk3ewiTpfx+2paSBS+
         mXGwozx6R1qq8w9PdRH8e4U7Xwax93+DTi2CefDt8UXxx/c9E5vp7Gllc51KP9+Ge4G8
         Ulvnc050MyYSj8hzBCVajLc7R3YkDRWQU9h++6PCQoVROuhVX0WwpE0RkeYHipNbUjdi
         hrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679873896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ76nHN8M0ZiVoHm0Euw0qHTeLSoiFoZdMJCuKUGiYk=;
        b=2sU7h9Z/J8QCI3Smf/v0BI0gy/pJ1stkr1L/H3xEx4eDg8+0D9YV3sPPrmxfGEAssq
         dS0oOWuZyCa/zxJulLbUTv4Cj/OkJjwudxPfSjxoF11SqZQYX6gOzWuzgq0eOgzOn3GW
         EXC9d8qqkFV020rhHZFvg2HARAZWI4SnVjC+2Jl5m7WQyk87o2Ec4dwFgCgHtbcnRBlh
         okkHkztU6n5ZE54SCL5BSdt0yYelj6Eyf9vwHZZ6h5Tmf/wwodtKnwksHpZt6+J+BKu/
         qHWTfZ8P6KkOmQd5KitaHoqaOxS0MBAsywthCDEXRZJxh/5Eyv/tDLtx+3eM85tQXtAe
         hi5w==
X-Gm-Message-State: AO0yUKVG6G6ihOd9Ni+YAH4z99owpK/26IWaKshOVLREka25F0J1gMhr
        jAKQPn8OXeKbiNifquWmLNuSmw==
X-Google-Smtp-Source: AK7set/poyocwSjgt4kFmjnW3pwZ5Iz24rXbve9Gc7DkkI7MBDBzCetTHn68sqVw9KftHtElyH/98w==
X-Received: by 2002:a9d:367:0:b0:68d:3fc8:7c11 with SMTP id 94-20020a9d0367000000b0068d3fc87c11mr8372498otv.12.1679873895825;
        Sun, 26 Mar 2023 16:38:15 -0700 (PDT)
Received: from localhost ([2600:1700:eb1:c450::35])
        by smtp.gmail.com with ESMTPSA id f25-20020a9d7b59000000b0069fb87285fdsm3710394oto.59.2023.03.26.16.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 16:38:15 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/4] dt-bindings: net: Add WCN6855 Bluetooth
Date:   Sun, 26 Mar 2023 18:38:09 -0500
Message-Id: <20230326233812.28058-2-steev@kali.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230326233812.28058-1-steev@kali.org>
References: <20230326233812.28058-1-steev@kali.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the QTI WCN6855 chipset.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
Changes since v7:
 * None

 .../net/bluetooth/qualcomm-bluetooth.yaml       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index a6a6b0e4df7a..68f78b90d23a 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -23,6 +23,7 @@ properties:
       - qcom,wcn3998-bt
       - qcom,qca6390-bt
       - qcom,wcn6750-bt
+      - qcom,wcn6855-bt
 
   enable-gpios:
     maxItems: 1
@@ -133,6 +134,22 @@ allOf:
         - vddrfa1p7-supply
         - vddrfa1p2-supply
         - vddasd-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,wcn6855-bt
+    then:
+      required:
+        - enable-gpios
+        - swctrl-gpios
+        - vddio-supply
+        - vddbtcxmx-supply
+        - vddrfacmn-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p7-supply
 
 examples:
   - |
-- 
2.39.2

