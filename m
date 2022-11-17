Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED61562E651
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbiKQVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiKQVEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:04:51 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18D48E2AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:07 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so8250595ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3nU7X0djX9jQ80iI8+t0kZ5Fy4kB3s5F+snjwXKwEE=;
        b=x0/2+JLtr5Wevfc3DaNs8djNaF+ABrzMQdBLyBvmMIRdvFr6TTAal/W4ymfMF/LlMm
         UmJRTSm/5ZTxaaFM+jIxzkNZt/gGSeS94TkXx6WN8rWl7SsHcL0P9Dzz+sVnmPvFa5OY
         zJe1wFSiHOnYcbK5spt/YUA+pX2CpMN2X5HCQxWMCok+28apKKiMYIznTp6dENuNVIbH
         5a4KZsa0LSxYYLUSkVZ5hMRsVQ4tnnjBL2eq0rB9hADwj/LotVke1a/rmuiScWKgwFPb
         9yHqrhNxV5adPmAm5q/DnxiqoWKxH/nf/e9WDHuxJHHT6hh3r0fpL+BaiJqrcrxrqF5D
         oPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3nU7X0djX9jQ80iI8+t0kZ5Fy4kB3s5F+snjwXKwEE=;
        b=DMoht4cIEIQiqKA3yNQXgHTu5RLhszsz94bpsf5UYY1iQ8SqZrUzd5DdkBfW/Eyi9U
         swnwPXXkxzh7XUumG1GgTbq3kRQBLVUfYnktflM8P0YOzVWtJ59QV5/cSKGR+WRqXxGo
         y9Al33yfnF3xfp2AA7H1u8MNphiGPqETpsDp/rmGFbfbD9tDDp4IWdzvJ+1feKcOIbUW
         T8gKLKtYO6+bAv1zZTVRIkm/e/3EO0qxtR1rbTeySXolbb8Duud4dO1jEqnaROXljfYw
         l9cofT2Rneh/MvvYVOs6W3fDBNpFRY61cR6jJxCTKP5pPqs8mGWtptV9LHC+sfbO4Ifu
         1XmA==
X-Gm-Message-State: ANoB5pl9OLMnyoMw0CZEZAGEF+WMfje+Yrk3BjG16LaXohd3P0Vxy4mu
        B/dEqQD7Ki4bouEbS9QiYcex7Q==
X-Google-Smtp-Source: AA0mqf4uoNtESHdzhp16/6ko0ItxfiZu0quayLxZD4UoKpS1Y/Tuw9fVd+KNhzvHX8Qelbqbvsb62A==
X-Received: by 2002:a17:906:4e46:b0:7ae:129b:2d3a with SMTP id g6-20020a1709064e4600b007ae129b2d3amr3568516ejw.552.1668719045581;
        Thu, 17 Nov 2022 13:04:05 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7cc8f000000b00461c6e8453dsm970807edt.23.2022.11.17.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:04:05 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogiocchino.delregno@collabora.com
Subject: [PATCH v3 2/7] dt-bindings: irq: mtk, sysirq: add support for mt8365
Date:   Thu, 17 Nov 2022 22:03:51 +0100
Message-Id: <20221117210356.3178578-3-bero@baylibre.com>
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

Add binding documentation of mediatek,sysirq for mt8365 SoC.

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index 84ced3f4179b9..3ffc60184e445 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -25,6 +25,7 @@ Required properties:
 	"mediatek,mt6577-sysirq": for MT6577
 	"mediatek,mt2712-sysirq", "mediatek,mt6577-sysirq": for MT2712
 	"mediatek,mt2701-sysirq", "mediatek,mt6577-sysirq": for MT2701
+	"mediatek,mt8365-sysirq", "mediatek,mt6577-sysirq": for MT8365
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
 - reg: Physical base address of the intpol registers and length of memory
-- 
2.38.1

