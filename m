Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E9563BF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiK2Lrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiK2Lrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:47:46 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB9323E99;
        Tue, 29 Nov 2022 03:47:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so2197115pjp.1;
        Tue, 29 Nov 2022 03:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN8un9HpKJ6jCwK6chNoIv5vh7+lXCbI1Cq9dR3jLDM=;
        b=DgRPd3HpHYjBqkpfMcOfAhhHhMOZuX09/9OZ+YU91yPvGPjeQHvqXvddZ95UM7kS9I
         IEHzmGqqUj1gYBSfYQWpJYJwDQQ83MdJXdi9gkdgwfqPmwO6EcGEwqOu5UayXtel2sf0
         uxwnesNdx0jhMbLhQr1q/Rg65Ze75KJtY8E2BfCl1fKNZjcoz80/2+HWQ9Bik88C4XP3
         CpwXFY4lTHCMnG4/7KMsSaUlIReUV2IMniUxfQ29scl5N9rxn3QXhOGOolfa99DfGFqW
         RR6cjkKzooQrIWC8df80WnwU5HtoJkNKHqU4Tqk6lxZXmWYhh9TtNiZNh+ps0AoOfpsD
         +/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN8un9HpKJ6jCwK6chNoIv5vh7+lXCbI1Cq9dR3jLDM=;
        b=8JlRKiUu1W/YUpsn3RUAzqIr+eCORr7y0r63S/aGzdtL8UZy0Uv3dGvczhkm3zN5cS
         XVx96A57T8HFoS6D0LGM9vEtHyNB72+6mNsVgTq66P5naRZabBuqbXPOJYsVgOP+mDK1
         BGHG/TrIL+jnt0Cq+3KzRz2nN1KNZ6lMlI6xF4jUENuUgggM9DmeUj5nB5WnGzPNTBYz
         y1igwdTIxnD1BzssUsba0gULEGD4DYIxzBsUN9AUd9pBjCwV77wT8J+PDJLQo4ywl6/l
         xX1zSLQ2QFsRNDmVTIb5k0fQz0FW/52Pa9g91MBjEX0RJfq+EBtGJGSdaQ/8p66kOmNz
         qy/w==
X-Gm-Message-State: ANoB5pl7EPqtBxSiM7Kmb9LURY2UNoDk/FkMfax5x55GIfIcrbHhi/pJ
        lUI0YMpQ1SUPQGNHBxwB4sf13HETpEk=
X-Google-Smtp-Source: AA0mqf6yAKePvogp5gmP0oXugJ5Jp+FCAk6YVnNJnROr1Bt42G69e7CFZNaPUsXZrgPZR7fal7ec2Q==
X-Received: by 2002:a17:903:cc:b0:189:7441:1ada with SMTP id x12-20020a17090300cc00b0018974411adamr16644845plc.13.1669722463392;
        Tue, 29 Nov 2022 03:47:43 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d4-7fe5-5c2c-fa0a-e67b-3955.emome-ip6.hinet.net. [2001:b400:e2d4:7fe5:5c2c:fa0a:e67b:3955])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b001892af9472esm10560709pln.261.2022.11.29.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:47:42 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Bob Moragues <moragues@google.com>, Harvey <hunge@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v9 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Tue, 29 Nov 2022 19:47:08 +0800
Message-Id: <20221129194620.v9.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
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

