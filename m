Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77186781C4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjAWQjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjAWQiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:38:52 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C77D2C67A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:38:43 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id v6so32073597ejg.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5xBfE/ZGOPJTnop+MEy0u8c1qaCOncm13Ltk1p/JL4=;
        b=MWbFl0fFs6X1J9652vnZ2jFb5SsMsWSMD64p7Pl7ZA5kY5wVgr2GrHACP0hNfu3LrD
         2IAJRdvYJPiiWLjuAl+DFavCiGc/W8kbCTGObhJGSAo3yJQRRO9wJxN8clv8Dz8K59b+
         UWcaKIn7Ze9KzNKcf2/FlvDyNAZtdr4tpzcXD/trVn18QA5lWZaRo3XdeT0se/j022Gx
         EgdYnJZafOhCUMOH18xs4rVLX4cKcQRXqQ1ikqDvK4Eibi6vl3Qq2CkBJtscmocM2Aro
         e2PN4C7FX7CpGq8DPvDGH2cqLr1macm/GZWnQ9ddP3tWXFmzaq8Fsi4IQd7T3npo6MeZ
         nWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5xBfE/ZGOPJTnop+MEy0u8c1qaCOncm13Ltk1p/JL4=;
        b=uDznRjj44puSpM9OdvlE7QBly7u+cRw43iYSNOSpUS0Rhlg6BO535b5wN2VFH2wNN8
         QHwpd3Qj7ZrT/wHxXp8KPCNnE0OggshkGBKGjzGm9LzgOBcErX4VlY6k6ciWxQ2C1KGj
         amScJ/bprlLLeMn3VDbE70ALDaZiMfOJ1j6LvCyNbHXSxyHz2YMo5Iy8txDva0gwTobR
         /bNopxOfDH4WCwl586RD2Eon3+Iqt2TTYxpeJknISfye0zEaD5uS2vGxE3owPRZVL6g1
         Ro+lkkmBnyjBAu+aVEESQVcGK5JIgiFLodgH8y1ipnjVQlbcUoKrTm2WH2X1u8LIfEAH
         w6Fw==
X-Gm-Message-State: AFqh2krm5qxNiK/L4Sjrh+Qv12S21OGP7oVm1M3agaW7WVHl6M4DAbWD
        Gk1Txc4tgbQvUv2DNHbsXFiKYA==
X-Google-Smtp-Source: AMrXdXv57ocedntrh5QnUnDefvvhX7pt1cDtQ84oLO85e66RfwqoZWrpEImunNzGF87OkLTwDvcCIA==
X-Received: by 2002:a17:906:2b57:b0:86d:3c59:73f8 with SMTP id b23-20020a1709062b5700b0086d3c5973f8mr26028815ejg.34.1674491922938;
        Mon, 23 Jan 2023 08:38:42 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b007c00323cc23sm22198562ejc.27.2023.01.23.08.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 08:38:42 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        daniel.lezcano@linaro.org, chunfeng.yun@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        andrew@lunn.ch, gtk3@inbox.ru, sean.wang@mediatek.com,
        zhiyong.tao@mediatek.com
Subject: [PATCH v8 6/9] dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC bindings
Date:   Mon, 23 Jan 2023 17:38:30 +0100
Message-Id: <20230123163833.1007181-7-bero@baylibre.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123163833.1007181-1-bero@baylibre.com>
References: <20230123163833.1007181-1-bero@baylibre.com>
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
2.39.1

