Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14D06C6890
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjCWMiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjCWMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:38:18 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C32726;
        Thu, 23 Mar 2023 05:38:17 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id l15so9955891ilv.4;
        Thu, 23 Mar 2023 05:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NrJl98Wq/VFN/yn07I9btG+z5z9nbLGL2qm/kQRv2Q=;
        b=RBeBfX/9tL/CbzDuswXSHMrbVF2l+xUgqV9oijBAWbZNUSN30SAa4BGumOO57ZJjNR
         mjnc+cVEimwRFJNfcJ/9llQlEz0cIVieiWX2LNhGY+syfwlpOY/My16y9LTMVHq3PTOE
         StM4rehYNGlSebhI1B9v2mnRQW9sf++ldUdMSVVOTKK77VLdC3Y+FwsgqHUTiTwCM9dz
         tIxFbQ76ZiNdn+mpw+6B4rjW12CugnZG7l5//IW1tux7iJozneu+FCZZyijSIz2yU2zC
         DdSueEezvmY/OIKd/ZTVpaaEYI468KLnqtHpbK3nv9RnKwjHQXbag50iwzVOkjQz8f7/
         MrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NrJl98Wq/VFN/yn07I9btG+z5z9nbLGL2qm/kQRv2Q=;
        b=n0wqrndWDb9yH0DfpPTQ+PZgJUajmSQgh8JWg1t9ib6Ix/SIqDWFeX58BmG2vcYPIE
         3d0msi0MMyMPCnd5ufkAmsdwAAWtnmxPpy7gbcuI0dH1Xig3ArJAH5XXE9YkwkEf4S3D
         d8/ZJa5I43iaa8aZQAg//ZYy/pMvMBpebLsvDN8dbOUpW2LcOaYj5vlP9fgAtMq5PkvV
         4MxxtTRO5q7IHHyHRlgm/Z4JNhpTJksQbTTDFGNLhww5aYcFnIOEDdBKoKg0yQXacyU0
         gdRtQLghHXBw9Vz5Xi1CjnrvUDy7tf6Ur5teViHRfHfBSLZYubErixAmUBHFTU3Irl3X
         opeA==
X-Gm-Message-State: AO0yUKXyoJZ/NQ0wzabtPjYIW2dB9ntFJjB+c8a72PhHiSoPWS4PrGJN
        A8avA7nVXP9iMNDF8sJRvcE=
X-Google-Smtp-Source: AK7set9Pab8qklvfXaksZLPOMTdj06BRiNdxIgLWC1L6TCmhaG4H2ugKGm2v62LuWYgE0u0AQcTIuA==
X-Received: by 2002:a92:dc07:0:b0:322:f878:abcc with SMTP id t7-20020a92dc07000000b00322f878abccmr6168611iln.24.1679575096360;
        Thu, 23 Mar 2023 05:38:16 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id n11-20020a6bed0b000000b00758993500f3sm1307608iog.7.2023.03.23.05.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:38:16 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>, Andy Yan <andyshrk@163.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: Add doc for Xunlong OrangePi R1 Plus LTS
Date:   Thu, 23 Mar 2023 20:38:06 +0800
Message-Id: <20230323123807.11882-4-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230323123807.11882-1-cnsztl@gmail.com>
References: <20230323123807.11882-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for the
Xunlong OrangePi R1 Plus LTS.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 01df9a5a0cf5..210213a1eaa9 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -831,9 +831,11 @@ properties:
           - const: tronsmart,orion-r68-meta
           - const: rockchip,rk3368
 
-      - description: Xunlong Orange Pi R1 Plus
+      - description: Xunlong Orange Pi R1 Plus / LTS
         items:
-          - const: xunlong,orangepi-r1-plus
+          - enum:
+              - xunlong,orangepi-r1-plus
+              - xunlong,orangepi-r1-plus-lts
           - const: rockchip,rk3328
 
       - description: Zkmagic A95X Z2
-- 
2.40.0

