Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594AB638C43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiKYOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKYOdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:33:38 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D8E2E9CC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:33:37 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j4so7222183lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxlrZWPFCrFQp2sHfL4Kx3y4fi4AGKGpCjaVKusjlG8=;
        b=u7zDvcN/YwdQwwUSi++0dMjhKMK7C+JAG4gCC3LTftZyocaB4/tBX8OuIK8pEBmMWK
         +R+vLtA2DjkxmMHwu8qJ/iUP1dopSN2EHgs/NmFaa35vOendIogkE2GvTl2BSWVdWqNT
         4EwTNrA9FiRrg8kwLJpy6/c1eDtbjMecDgvlFtscL14SHQ0AeTImj6LN2DVdQYavSahG
         4NdQT9Fk2DDiySd1HHQ7aURbfutRqz/kmTI0Y3DphBVE1TflCqj6e/zpON8vroqRoCjE
         b+8s7C6LNM66Y3GwfaqF2S9H7JU02n8BgHgXkFIztErUy7oxtcGcf4AWcJHzo5UJEJCM
         hPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxlrZWPFCrFQp2sHfL4Kx3y4fi4AGKGpCjaVKusjlG8=;
        b=DGAbknd/iS2nj0K7wPdSkK/yvpaKfGjq8jdNVhM12bxwghx72+IetjC8EORO9ks4X8
         eWJwTAuK4y8sn5LOBSlEjd2GxJI9PpXKh+m4nIhpbzOX2FkW+TxpsX9MNfzqWPYoQ5/j
         EE6T4T7ajDVjZdQJp7j9pd5NV8l2zJKQXvFZqiiBTtJRXaUOUgXR2bqN3wn6ucTOlTkS
         CKVxUTSfVflmZ1zEwNFWX9RpM4JOG2ce7k5NsvtWwHGQ8TjKtGgeMby/lRWkLLdD52NZ
         Oj751GQZFxar4fydCuoJtOtuzlvFE6xti5zQjIUC3vclW3zXtPUUu56/0X36gR4j4+fg
         1y4w==
X-Gm-Message-State: ANoB5pmtTCTJdgU3geAqxFDYJJv/xjE4xXsFUe6WQuZKr0eJpZyJ3nbX
        qFogbDl2Sv3mER2ok0PTcdGRig==
X-Google-Smtp-Source: AA0mqf4CLFbynW8Xkv7G/S3W3bwEKgJFc7U0ncZcpC6avjkTBUEFmbGof8INlOched8bha1V/SKsXQ==
X-Received: by 2002:a05:6512:2989:b0:4b1:753b:e677 with SMTP id du9-20020a056512298900b004b1753be677mr12245606lfb.407.1669386815560;
        Fri, 25 Nov 2022 06:33:35 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k26-20020a05651c10ba00b002798ab42fffsm312966ljn.129.2022.11.25.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:33:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Nikita Travkin <nikitos.tr@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Andrew Davis <afd@ti.com>, Gene Chen <gene_chen@richtek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Luca Weiss <luca@z3ntu.xyz>, - NeilBrown <neilb@suse.de>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] dt-bindings: leds: lp55xx: allow label
Date:   Fri, 25 Nov 2022 15:33:29 +0100
Message-Id: <20221125143331.473981-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125143331.473981-1-krzysztof.kozlowski@linaro.org>
References: <20221125143331.473981-1-krzysztof.kozlowski@linaro.org>
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

The Linux driver and at least one upstream board use 'label' property:

  qcom/msm8996-xiaomi-gemini.dtb: lp5562@30: 'label' does not match any of the regexes: '^led@[0-8]$', '^multi-led@[0-8]$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/leds/leds-lp55xx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
index 7ec676e53851..dfaa957eee74 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
@@ -48,6 +48,8 @@ properties:
     description: |
       GPIO attached to the chip's enable pin
 
+  label: true
+
   pwr-sel:
     $ref: /schemas/types.yaml#/definitions/uint8
     description: |
-- 
2.34.1

