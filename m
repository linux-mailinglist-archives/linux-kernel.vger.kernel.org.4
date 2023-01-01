Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B3B65ABEC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 23:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjAAWCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 17:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjAAWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 17:01:55 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1B82AC6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 14:01:54 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vm8so56059993ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 14:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWHvYV5ANxh44fAnbu/SIKvM1eyaybv8RI9j5qMIu70=;
        b=D80aUyXF24nfC9838cOKHP96aBm8eEFTNO5NV26uqleYoSwnPs4VT8p66pZ5t7rNlO
         WbymV29lTpfnvjFdBVgDYYU75DKxiDZSM/9YMEiORNZ9hhqOGChgGAkB81Fvm4MlDQA6
         tAtt67s1rvSdf8D82rDwELCZ72CWr1aqMDIteuo8o0LTL7cTDcuCh+Il9lllpM9sNTxv
         FAtB2OZk830T2QVef0M+3KHXD2axQPhySdEq2WU1mdozzi2298Qxh10XFti/38d2yeuC
         8LiA03SZvkFg1pZDH1/whvcGcdSITcBbXGf3e5kUA8mDmCSKssMfNJZOcSQ8jcY6x2VZ
         9QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWHvYV5ANxh44fAnbu/SIKvM1eyaybv8RI9j5qMIu70=;
        b=5CpC6cLGh83vhN80TBukrjp5WvHI7GwvMZy2w69f9uIJ/7zEacVWFdj4oQ8y2yyS7u
         bRQzGIv7PGmO5dibXLPBbHYx6XO/GqtObtTZsY6dQR/HJxLDD2XKXFpgjvp/yxHfTCv6
         DQZ5Ll1gphFHibXGst9LpNFsO9Wo1CQMquldzkOiqcZW0Ers5uefmCEM6V94r0A2MRFE
         fFpyNcvMFuetcF3ee5VAQFZVWfVDJp8CVjw8McanxDN2TWx+7DVIuWbFUoaWTFavPjK+
         tulNiHiU1d4/VAkXN0fL3VHjJwPM+TQWyq69w9PWmsz5ZsFfbPSdbzradKbmF99yvSi4
         LtAw==
X-Gm-Message-State: AFqh2kovhSYl3Bw8UwAUTz1jtsgvvIw65DwNWU80S4lDkMttAVIMjWgx
        KlLdc8G1QZyepRAI5Hh98u/i5g==
X-Google-Smtp-Source: AMrXdXvKToPZxcHkuMoE/615y81aE+lenmdxC3R2EXwCVGX0r600chYCaTjessAPeLLeFcT9WsYkxg==
X-Received: by 2002:a17:907:a643:b0:7c1:1752:da68 with SMTP id vu3-20020a170907a64300b007c11752da68mr29439639ejc.76.1672610512844;
        Sun, 01 Jan 2023 14:01:52 -0800 (PST)
Received: from predatorhelios.fritz.box (dynamic-2a01-0c23-7c55-d800-0fbe-25d2-487e-ae5c.c23.pool.telefonica.de. [2a01:c23:7c55:d800:fbe:25d2:487e:ae5c])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906304c00b007c17b3a4163sm12486807ejd.15.2023.01.01.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 14:01:52 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        linus.walleij@linaro.org, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com
Subject: [PATCH v7 1/7] dt-bindings: arm64: dts: mediatek: Add mt8365-evk board
Date:   Sun,  1 Jan 2023 23:01:43 +0100
Message-Id: <20230101220149.3035048-2-bero@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101220149.3035048-1-bero@baylibre.com>
References: <20230101220149.3035048-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Mediatek mt8365-evk board.

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

