Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9CC62E650
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbiKQVFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240226AbiKQVEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:04:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AF882232
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:06 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id i10so8227564ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAZa5MFL/kgwwXWrMqu8oN1aUslhiGgDdUjW81Mvb9E=;
        b=XZBw/6JKc5rCyqd38GXo449XIEv3Pgnx/zV+EwB6bkMu7QdA3f5UMa5tHMvBjgZzBE
         uEKwrFE3SAZzIrnNf8MlwfrdlexUb7BK9KXsHO4ejyvxWkBQVNQ2OJPE5TGb6kKFePGW
         52Rll9OU9NXj61EHN95qVgdUAGOGZoNuhhtZJCVgbrSsiBtj4XK2RVNkmi8IAFBcnU1j
         9q98v1XEcO+CtNDuXUYYbW0usND2Y5IEcutXWvldYBMTxQvk6+U8/S9fQsfAiAWKYVCG
         hrba6pp1uZjPT4F7OIuywMumhy6TP2IAQNMwSiI/0uBADkwix95zhfEFzcQXdRYPmfkl
         OCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAZa5MFL/kgwwXWrMqu8oN1aUslhiGgDdUjW81Mvb9E=;
        b=igrk+TXoVf2iVJtgkONIWBTCbH1e1jSF5fZdsV7zWP1KYqRHGF8zxBDIxGueLaDmOW
         27mAT28tv2Qwf3/JQMC59WEzqOx1MfXiJJ7f5QOWjD/1gST38nqUyZheaT00A/oZm4EX
         P1rNqhlZjLiivm16myznZGA61LNFThLBo/mmcVi1aqY13UkD2aJxk5zb5Km6LCr2xDse
         EjBiI8KQDkE0EPc4DORBPEzWb4VSeD2hiWLZis4no6eZRz3jnZEc8Shtkr/2DDwVamJS
         rHCRcTQLicHeYrkMtgMaOdGQPOdK2VlSicWx5Zh9ftU9Ezl5BaZifOtBxp+nHo+/yWQB
         Wgkg==
X-Gm-Message-State: ANoB5pl8uv3lgxQwHSl/NSIuMb5luH96t+uBGV77uG013CN0CAdjgSmL
        Ijs8uHNTf9/QJvZiInao7ucloA==
X-Google-Smtp-Source: AA0mqf6W3sFv9vFKd6YCkQLpyKtG+CyoNEaecRwrtqA8rwwNVI7AEZQPgXiyZgWKtmNic/zKOZsXeg==
X-Received: by 2002:a17:906:3385:b0:7a2:b352:a0d3 with SMTP id v5-20020a170906338500b007a2b352a0d3mr3502702eja.399.1668719044782;
        Thu, 17 Nov 2022 13:04:04 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7cc8f000000b00461c6e8453dsm970807edt.23.2022.11.17.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:04:04 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogiocchino.delregno@collabora.com
Subject: [PATCH v3 1/7] dt-bindings: arm64: dts: mediatek: Add mt8365-evk board
Date:   Thu, 17 Nov 2022 22:03:50 +0100
Message-Id: <20221117210356.3178578-2-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117210356.3178578-1-bero@baylibre.com>
References: <20221117210356.3178578-1-bero@baylibre.com>
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
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 7642f9350d2c0..a9c18fc7905c0 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -243,6 +243,10 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - items:
+          - enum:
+              - mediatek,mt8365-evk
+          - const: mediatek, mt8365
       - items:
           - enum:
               - mediatek,mt8516-pumpkin
-- 
2.38.1

