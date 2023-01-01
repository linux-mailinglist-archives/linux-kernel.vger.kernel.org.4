Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4536F65ABF9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 23:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjAAWCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 17:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjAAWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 17:01:59 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97600DB3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 14:01:58 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id t17so62923128eju.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 14:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQFWSjnAmXGCxMB5DVpOmGczTzlI1ebWvjBAsrHPlS4=;
        b=HPB4QYzmfLrrNaQyHlmIsiq0AfayG31cj5XucwJY1CBnCzU8OGoBaoSLhcmH3yCg9U
         ZqG51G/2VGKGfJY5MXUQ2C5cZFVJ8AmAf19MNh8TySS1cvC38sz1bcHXLF3+/M4itWy4
         YwgkPhLYDsUBEjmm9bJhrqZ6oFt/cYFU5t/Eh3kbHCceR+8E2lXpHqNjkNs90DNxeq0Q
         3+g6oVA6XfYyIQzJkFmEYLk61CNImaif0BjPSlLCfuXzPa0UxVzuiNpLY8dB/E8Q+u8C
         2i/hv26/34dj9OMKyJIwjwR08lV/rcwj1vY5UGmUYNCLUQD0/xoGLlFJrVQt2LSriDUi
         NVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQFWSjnAmXGCxMB5DVpOmGczTzlI1ebWvjBAsrHPlS4=;
        b=TA76SJ4Nn6gB7MBck9hmy1aniIqvBNo8FWVj5TieZ9HgCZ12JthJTO2km/qM0T5xWa
         9TNtSuB6HnBiWm2MUXDDE7mpWYP2xuFXrNKkwNSXqsxeuUbDpE421gGzUr2Upro8dGdJ
         gbV63+xSRoNfMf3/mcQDgNYrUFK0aUxboNT5QFuR09umfZOBfoHizWcq0VBTw2paNJUs
         RphwG67ZsXqY6EuyL9oG3h2DHQAoX+XdWBDpiz2y+7IU6Tkbd7GfYtBvh8giJWflKJdc
         iDxjhHJ4pdXT7cSayqdqV7EntAvi5oyNbAbdjPcVp7UHkhtnQn0dL6uyYE19uTehpj6k
         D5MQ==
X-Gm-Message-State: AFqh2koBou75QjOnS1h0No1D4fsznZjjb7A51Ca3IEnQqel0McxPv9vL
        57e07zdDes2kOCXZQHFqLxRESg==
X-Google-Smtp-Source: AMrXdXv0rMjq/yUVJ/swTJts7JE6YfwbMUkTB0fsEIfuWBc9Yg2cDSYNeys21c057DPQOdC76+6IIw==
X-Received: by 2002:a17:906:9f28:b0:7c1:5b5e:4d85 with SMTP id fy40-20020a1709069f2800b007c15b5e4d85mr32057444ejc.51.1672610518175;
        Sun, 01 Jan 2023 14:01:58 -0800 (PST)
Received: from predatorhelios.fritz.box (dynamic-2a01-0c23-7c55-d800-0fbe-25d2-487e-ae5c.c23.pool.telefonica.de. [2a01:c23:7c55:d800:fbe:25d2:487e:ae5c])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906304c00b007c17b3a4163sm12486807ejd.15.2023.01.01.14.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 14:01:57 -0800 (PST)
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
Subject: [PATCH v7 5/7] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC bindings
Date:   Sun,  1 Jan 2023 23:01:47 +0100
Message-Id: <20230101220149.3035048-6-bero@baylibre.com>
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

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index 7168110e2f9de..d2655173e108c 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -28,6 +28,7 @@ properties:
           - mediatek,mt8188-mtu3
           - mediatek,mt8192-mtu3
           - mediatek,mt8195-mtu3
+          - mediatek,mt8365-mtu3
       - const: mediatek,mtu3
 
   reg:
-- 
2.39.0

