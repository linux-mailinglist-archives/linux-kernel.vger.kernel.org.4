Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A667B4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbjAYOgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjAYOfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:35:55 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6385957A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:35:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vw16so48135981ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tN16lN3tQI1TVAWs7NSp7WntR2GpAGJj0GT7j6mK3Fw=;
        b=of6sbOD2tWa0RW4bJ3Il9EJBg+LeGX17z0Hq0/avk/NtM8cKmwTyKRRl7nPyyOxGwL
         mr2Qdv5TZ8iivrClY+6MV38YSUbwAhpZqrydvD5VKDl+CtN9Y74N2yPX/CGMF8yCJ4E/
         ZS2OOvWGfZvThUoOd4g6sWvzN9yRMzSFLS6Ghi5PQWElAMgukvYaUXy0oCSqzKAePT8D
         yuHKCh+b3jdVSLeVzCFnGM0F4f6KkE+8vNF63ZDI3J3v2Kx3//mnI3uzGU2d5ASxOBFl
         CS+oQf1lZQ9j5TpXVqmaAm39eKut09JSsWx2XLA5u1g+oj63Q1JJsUSk/F8KrgLDMLhT
         SK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tN16lN3tQI1TVAWs7NSp7WntR2GpAGJj0GT7j6mK3Fw=;
        b=lykVKI2jAG8+NKiTfyrxusFjYtbGErDC+MZHD1cA3m+RxFf6dWb25hwi8v7SQcmvNV
         fQQRYFlKxfE1o6hW6gLOz9W2pk4XrEkUBvAeh2mU1ifGN0eizkU6CPP0BivSDKEV8rXY
         mRhnMDIVpntMChPZTIFXhAEfftPcKwSLlwRQPWG8iiRzUOpVoQi0E84Yk6CqyDGcjPlY
         JLVNuUoTL3NbbiPrFP4tJxNaykm1Q1MLZfgaFhr0cjZ8ms1hqgKgvZQgQLc47I2bHT/R
         tebRb+3ngytKcG7UKLJNkItRt7RohfSr4N0ACl6XqqJFu2ioiYzMcRdIHbwwE7XQ/dCy
         zy1A==
X-Gm-Message-State: AFqh2kqqX+uNfQ/pUjgWZ9EIPrLPaRDnIajvawR6mB3KASjhklQQ1AYi
        msYlH+D0Zep7eG07BK+rGxEdQQ==
X-Google-Smtp-Source: AMrXdXvaspNlldvkzbbWkaCPYnTmR1+Wj4YdgO5nLJERa80fBJ5oe8bu2kzgEQ/qdrEdkw2J/9fytw==
X-Received: by 2002:a17:906:40a:b0:86f:a21d:62b7 with SMTP id d10-20020a170906040a00b0086fa21d62b7mr35265266eja.9.1674657309549;
        Wed, 25 Jan 2023 06:35:09 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id gx2-20020a1709068a4200b0082000f8d871sm2437789ejc.152.2023.01.25.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:35:09 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        daniel.lezcano@linaro.org, chunfeng.yun@mediatek.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        allen-kh.cheng@mediatek.com, sean.wang@mediatek.com,
        zhiyong.tao@mediatek.com
Subject: [PATCH v9 3/9] dt-bindings: mfd: syscon: Add mt8365-syscfg
Date:   Wed, 25 Jan 2023 15:34:57 +0100
Message-Id: <20230125143503.1015424-4-bero@baylibre.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125143503.1015424-1-bero@baylibre.com>
References: <20230125143503.1015424-1-bero@baylibre.com>
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

Document Mediatek mt8365-syscfg

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 1b01bd0104316..7beeb0abc4db0 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -50,6 +50,7 @@ properties:
               - marvell,armada-3700-usb2-host-misc
               - mediatek,mt8135-pctl-a-syscfg
               - mediatek,mt8135-pctl-b-syscfg
+              - mediatek,mt8365-syscfg
               - microchip,lan966x-cpu-syscon
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
-- 
2.39.1

