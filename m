Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7A6269F3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKLOea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:34:28 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB1F1A83E;
        Sat, 12 Nov 2022 06:34:27 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id y14so18525365ejd.9;
        Sat, 12 Nov 2022 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRLnk3UcVriiraB+P5IRs9+XnPrK8g6dmPwsFT/Y3Ks=;
        b=bhZvmvnslbl/lwJ2P6jBtaEx2ErffCScS4yoFae0boGMv+6GW0tREqgTSAR9jCCv69
         PPBU76PRH259Y4iuEZNzWWzh4QTGCzDSnBVlGCMOV4q/vLv/Xccsju/pH/+KnLfVpq7P
         XhPqq0nOANmUI8u2iFPYayoMrAZbO91svXrM4lbHMCQJ0cZu3kFDfdytYWqE9lqDYgyt
         zLLKKfN/GQrw5U8NF2EbIwapvsE5vLZ3WTk0jRjI/lI4Cvydfe8gTw9cuR2WDOMlGRJj
         LgbdA5icaG1DB6kFTnFpXTxUZg3Ab7a1K6RAuUfpyCvref12O7xQLPJrrT62F73B7BVI
         Ec8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRLnk3UcVriiraB+P5IRs9+XnPrK8g6dmPwsFT/Y3Ks=;
        b=LjpQl9jSIvzhzz9WOJ3dQK21i5J/hN2E1ZNdY42Zk1brWb3uVXbSZ957qd9qq6NX8Q
         jI9TPsQvbotTdQBSpWKtgKkdgu2a1szjZYYVEZh3mlgoiivf79OFV7gvFSAmyoUFuYqY
         KwAi0XtkvMhhR7Zbo3S3xKZo9R1OAPsDqaI1TRY4NuPE1NjdFiaoNQbwJ1aoXghmtwvv
         HSn2sEC0Jn8yjp68mn8vnNk5jEZR2DKc7m6c0B1SIRL1heeVEr5DnyvorHDoQPCn1u7u
         d8DCOOfrfdc9k29Fv1PHJuZNA8XSK71HtJzFlavSM07wlMhchwn/muWcEjjssvNLrkXF
         y5GQ==
X-Gm-Message-State: ANoB5pkXSVijXI0zHryo5C2S0KfSyuEsZahG5VJaC0zh2CYi+7vXyKbf
        wl/Zb7iCqPAgp0k8RZ7bVbdLIQ1tsahvKCmj
X-Google-Smtp-Source: AA0mqf4UL331vN0Ad1gthWmrUlybazG3j+qr8mxS3qEjiQwei7Nr1qi7QFoz2dy7D9IMj+Z0X6mVGA==
X-Received: by 2002:a17:906:4dd6:b0:7ad:a030:487e with SMTP id f22-20020a1709064dd600b007ada030487emr5414091ejw.508.1668263666038;
        Sat, 12 Nov 2022 06:34:26 -0800 (PST)
Received: from localhost.localdomain (83.31.120.236.ipv4.supernova.orange.pl. [83.31.120.236])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0077a11b79b9bsm1974668ejf.133.2022.11.12.06.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 06:34:25 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?q?Jo=C3=A3o=20H=20=2E=20Spies?= <jhlspies@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] dt-bindings: arm: rockchip: Add more RK3326 devices
Date:   Sat, 12 Nov 2022 15:34:08 +0100
Message-Id: <20221112143411.517906-3-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112143411.517906-1-maccraft123mc@gmail.com>
References: <20221112143411.517906-1-maccraft123mc@gmail.com>
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

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../devicetree/bindings/arm/rockchip.yaml         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index c6c69a4e3777..d2748826cf39 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -30,6 +30,11 @@ properties:
           - const: amarula,vyasa-rk3288
           - const: rockchip,rk3288
 
+      - description: Anbernic RG351M
+        items:
+          - const: anbernic,rg351m
+          - const: rockchip,rk3326
+
       - description: Anbernic RG353P
         items:
           - const: anbernic,rg353p
@@ -468,6 +473,16 @@ properties:
           - const: hardkernel,rk3326-odroid-go2
           - const: rockchip,rk3326
 
+      - description: Hardkernel Odroid Go Advance Black Edition
+        items:
+          - const: hardkernel,rk3326-odroid-go2-v11
+          - const: rockchip,rk3326
+
+      - description: Hardkernel Odroid Go Super
+        items:
+          - const: hardkernel,rk3326-odroid-go3
+          - const: rockchip,rk3326
+
       - description: Hugsun X99 TV Box
         items:
           - const: hugsun,x99
-- 
2.38.1

