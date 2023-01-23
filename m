Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF16781C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjAWQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjAWQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:38:47 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A96C2BF16
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:38:43 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vw16so32017795ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwIzfbsFdCDai/q3cnqayXJcFTx4vajk+OuUztkusTY=;
        b=QjrELehf58NiDOcx1umOBtfzjufY690uzbZ6j9DjbF2OZ8ZJuBVSr3CAaXW76DDPGK
         30jUGOyhvvOwyaqZcz5L2R0g6p/lgs7OvUqI8mYEQiM793QGPRqi7dD1Wtkg0RWToWpz
         rLk4CHA5929SMha31bE2tQJdqHFMXp8166lSX4fpuuK3M4fhaj9o3T0x9K+z1tgzcb/+
         ES7Tz0Ub953AcgDXTgz+idHt6B3Bd88ls3UpQ6SyoN0B3ebraDUvKT5Bnb7Huq0qnHs+
         5I4LrNCG5QSrpoUyTraJARy+Eo+tGBkQio3rx5dG78bnCKViz6IiLjRQUSXgxXfxgS+Z
         zseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwIzfbsFdCDai/q3cnqayXJcFTx4vajk+OuUztkusTY=;
        b=EVqkZXVFDiPT9aXoWCiVHLMddK5XuD7VEF5EiNuqdyxxSEm8ELaEfd4aSEi3sqm2H1
         ADIuL4kQmS6WypnvxKWpRvJkwuaqTDLPFKub59EEovTbiF2/eXTvBnCgBDHfdZxGu7tT
         o7NsRCyalQsgWLsK34VGzU6uwULWKlGMhw4kHXk1JyCDNo2MnoVSl1Hvt382M7duOJJo
         Z9LZRnltY39XApUI40vwxa5fhLvgvbIfjj69P0T6ZaYid2P1Yd/Edd4QtbbS6dddUctR
         t2ORutOwNPnf3bJQYw1APBQgc8jPRkLUzotnpsJ4AIfy16qsZlpFRgp4QJzwLWFk9qSo
         faNw==
X-Gm-Message-State: AFqh2kpx28c2id4qIQYZHwCAZJNMTl046kr5hETili482DM4xOMcZsDU
        ioE4QKI7R+mUIPlz9veaeocnAA==
X-Google-Smtp-Source: AMrXdXsaR1LCQ2VUgGGbrrFRWvmzZc/xLAMYBZvEm4yMHZjJSibP2ur+qU9ve96r0V7MGjpXmSkINw==
X-Received: by 2002:a17:906:abd8:b0:7b1:316c:38f5 with SMTP id kq24-20020a170906abd800b007b1316c38f5mr27711033ejb.30.1674491921740;
        Mon, 23 Jan 2023 08:38:41 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b007c00323cc23sm22198562ejc.27.2023.01.23.08.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 08:38:41 -0800 (PST)
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
Subject: [PATCH v8 5/9] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC bindings
Date:   Mon, 23 Jan 2023 17:38:29 +0100
Message-Id: <20230123163833.1007181-6-bero@baylibre.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123163833.1007181-1-bero@baylibre.com>
References: <20230123163833.1007181-1-bero@baylibre.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.39.1

