Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2804A659C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiL3UgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiL3Ufv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:35:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB8121B4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:35:50 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u18so30318855eda.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yM7tLQukK3ee+o3GHKaxNTtqE120eC/46qEVclUSCs4=;
        b=t5pna3QqL+sBeE8/5zDfQsBdLVknUMNTLIqs2q1dls2xGpMch615A286HxjBsN2dOm
         npqoPD74TllHB/3F7MJPp2C7iB8/LLLB6r/CcAIayufmkzp4ccVFNmi42q6Y/jMPRMQt
         5BivKCW0Yi9VAwGfZSYOjBgA5oGcSPThctCYL0XvPK33ZynHjO+0wrMzO9E+E3joBzah
         VLZgbq5+2lUzkhx18uDh4C8Rkln7skEcQupqD1W6sxrGJMioZqCDgK20oYdL1KbfeN6E
         Tir5cHDpFErIg9U7eJu7WEcqKwnMZIBiRqVJ0lQ8qxDP8ysnqcr1gunHlGfo5y8nnBzz
         hjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yM7tLQukK3ee+o3GHKaxNTtqE120eC/46qEVclUSCs4=;
        b=kvOeVnFqs2/uLEC1pXG6VF5K6wgUbcbaKXEkQ+Kf44Hwrxcj4OdJequhY75f+bAdXL
         X20wFDwluny1/7za7tRUVY+1tlqEruTBv+LREsiACUB/XkhgtTFNtcOt2RxiHMXKNAlj
         csAwo86stccppn292dlRp6l/kpFyrhJPp89NshPcE26YiFH7O1LkRCjBUPcHULH5Ahux
         CUnhZZPRsMZCR2aCFZbIZFBTKgupeNVQJqdBo0l3zH1n3qsZkbxHbDmgYubcX4Dhvu9b
         i7zmVGAPfuPMu3i3uH1ZzmAcQItaiJdtCntc8N1n5fcxYkzM1TqgPHuq2sstAZKZXtfq
         81Xw==
X-Gm-Message-State: AFqh2kocoukrHkmojavgo+3abZfIDFG7B8Kw5yGFVojlSMMln1K+y4BG
        nLqZx59Vj2+1/ADPtGGOeS0w2g==
X-Google-Smtp-Source: AMrXdXsga6iFLx1oZJHSwuX/gfAy91cdL0LJIGCBRo/xm9zrj7Kxo+hWBVGKehvpRGIKQq6GCv4wLw==
X-Received: by 2002:a05:6402:3224:b0:47d:810a:f410 with SMTP id g36-20020a056402322400b0047d810af410mr39930114eda.24.1672432549228;
        Fri, 30 Dec 2022 12:35:49 -0800 (PST)
Received: from predatorhelios.fritz.box (dynamic-2a01-0c22-cd9d-4b00-ef17-3c78-1696-7315.c22.pool.telefonica.de. [2a01:c22:cd9d:4b00:ef17:3c78:1696:7315])
        by smtp.gmail.com with ESMTPSA id c10-20020a056402158a00b00482c1f1a039sm8350500edv.30.2022.12.30.12.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 12:35:48 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        chunfeng.yun@mediatek.com, linus.walleij@linaro.org,
        lee@kernel.org, maz@kernel.org, tglx@linutronix.de,
        angelogioacchino.delregno@collabora.com
Subject: [PATCH v6 6/7] dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC bindings
Date:   Fri, 30 Dec 2022 21:35:40 +0100
Message-Id: <20221230203541.146807-7-bero@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221230203541.146807-1-bero@baylibre.com>
References: <20221230203541.146807-1-bero@baylibre.com>
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

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
[bero@baylibre.com: Cleanups suggested by reviewers]
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index a3c37944c6305..c119caa9ad168 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -35,6 +35,7 @@ properties:
           - mediatek,mt8188-xhci
           - mediatek,mt8192-xhci
           - mediatek,mt8195-xhci
+          - mediatek,mt8365-xhci
       - const: mediatek,mtk-xhci
 
   reg:
-- 
2.39.0

