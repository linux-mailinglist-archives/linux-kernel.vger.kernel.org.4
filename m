Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3451D64C0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiLMXn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbiLMXnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:43:52 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED313E3F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:43:51 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c66so20192195edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unaiPR7U0bSA4jIaNyFaE18Ri5beRIzrT2lfy7T7b+k=;
        b=4BP1l0f65r9/a+w5k3VKrLf4iTN60No+ztQ1ub1VqcSXNxyO+B6M0qqvd726B3OfTE
         ayFLPh95wwH+lh+CvmzpgPSMOvvOr/ePFaXJAn4YSRh5e2qtRPQi2F3SbtZgGuEgO0SA
         WpjV4T8gztSAA2XQtApBHrBxPt7kYLz8lYLgr15f0/CgDXry8EBSiEZ9df+zCb2ZgRVA
         DULZTZ0lcuG6TdqoxnnYcD0cVDQFp3JoJV2c+jRgkdBytpNOM41aIc6LSJ4KQibOTz5S
         ybbDlOTcNgVlcz0yCH36mNjGJbK3cGFD73kLmRAtVFgNJfE4InUBISWknR2kQjNJG82y
         Z1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unaiPR7U0bSA4jIaNyFaE18Ri5beRIzrT2lfy7T7b+k=;
        b=GERV1SA4wy2d7pgz9EnkiIBlYlavTtmaqP+ABT/DdtmNxSboBnG0GqOORaSrqV6hEH
         weQJyzzuEsHS2dNNeU6KMZUalae9i0Ml4nrtxA3o6jrkQU9S1T4SjLNtl5jTzprOvqwH
         XjqNrQQt5jlCGf4paQzNmLGJPaWanFyN9ctVLcfHEv9oly4ILSAcdnIo1wFKO/uSCxhm
         TRFFx2B6DUuFPb1HeA6erESAMM6Z/pdm9fbCcrnwWOG2QQdajQC/GlkRF5GPhutQ3Lz/
         ryRrFGK46a+yksZEEo1Qrp1Ye1jCSEnzwDXSC6LuSP1/285D11Zs+6aqVtb1A+eW1zcl
         iR5w==
X-Gm-Message-State: ANoB5pkwHz8CGmkuJcBvZfIZvuvXLisD+MZ5Tqg2FjzuOvzQBGo/eRNq
        /jt1RWY4dlqTCDAYRYB3vwlfjA==
X-Google-Smtp-Source: AA0mqf6VVtH0+m2H7JGcxe0//+7NbC98TbZH9LSOIcRviAn+dwdPkNCy6oPr0SNQJVJ/jZokDfm+QA==
X-Received: by 2002:a05:6402:f23:b0:46b:159e:9511 with SMTP id i35-20020a0564020f2300b0046b159e9511mr22304036eda.7.1670975029720;
        Tue, 13 Dec 2022 15:43:49 -0800 (PST)
Received: from predatorhelios.fritz.box (dynamic-093-129-109-038.93.129.pool.telefonica.de. [93.129.109.38])
        by smtp.gmail.com with ESMTPSA id f5-20020a05640214c500b00458b41d9460sm5407498edx.92.2022.12.13.15.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 15:43:49 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v5 1/7] dt-bindings: arm64: dts: mediatek: Add mt8365-evk board
Date:   Wed, 14 Dec 2022 00:43:40 +0100
Message-Id: <20221213234346.2868828-2-bero@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213234346.2868828-1-bero@baylibre.com>
References: <20221213234346.2868828-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Mediatek mt8365-evk board.

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 2275e5d93721b..ae12b1cab9fbd 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -244,6 +244,10 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - items:
+          - enum:
+              - mediatek,mt8365-evk
+          - const: mediatek,mt8365
       - items:
           - enum:
               - mediatek,mt8516-pumpkin
-- 
2.39.0

