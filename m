Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA8647320
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiLHPcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiLHPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:30:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF3F84B7D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:30:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h12so2020216wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 07:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6+ABKaCFT5+1C0Y5clbHMJQa6kjF8TIULfr4cCgl3o=;
        b=LCM7oOJmoRy3wGsCUMZoYwr4aV/73j1pYFhJO1iyfzfdj3blRZvKZ9A7suusfQN3IK
         HVhZRy+PL2X0cNNsC5KQp5DgCNKpAttJ396X3I4R8ldvQdKBGe3fJ1ik2epMa1x7tqao
         qDET9+GWyGzE+IFBrTufBYCQDV9QFNzm0R84bD3/QDUSfHpjgKHT6PileWavmSptJc2n
         7vc/NwPAJQFmaeiZh1ightM1l2fYFyRF4SPdvA2O63R1QabasL939xMxgR1e7hDJHTII
         xZ5a8x3tumNJhtq92nPdzh9DyWPqH3fQ6puB38waQgqaZOWPPFmBcfhremrScaTkRTS3
         4BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6+ABKaCFT5+1C0Y5clbHMJQa6kjF8TIULfr4cCgl3o=;
        b=xCZqAQvr21id62AlIu28WqEqAtk3qba22ikAwdUOFwQ572PI1ZaA3XnzlGUZ1DyVMT
         S+Ck8JcD0/m64M5a91rKul+O55EhxDRX9nEtkSx3FcHRQaWyO75hynmgLKa9m5K+5Vfe
         HQpiFIusSmkSLN438QZJsH9xHH05/vJiDGfMXZSjumMD/X+XwewzEA5nKALxU2pp5hhr
         q6cJbEg4Uf20C09l8zYtkVXcrSqbrrqhostnDvSwZbZoYAnVXjLbGVXlItUjb9jWGO60
         XhHEyBQa82DnO6qTzn5Eq9z64Pekm8O3ZYV4C+gap2TifozNU/dTQGqNHd0b0/V4ScSx
         Eorg==
X-Gm-Message-State: ANoB5pnNDJYAN6PrCwwoGL1Nr9uCgyljoiJGvL/CKAXVUatpFudcgoEt
        jGCAmvxBtljY8w9F/mWB6LaWMg==
X-Google-Smtp-Source: AA0mqf5FOPXltuZLPneEbB5VngzDKQGwN6thrtAgUY/6DvNUrqLQncoLNWjNWmFSiUbzrk74ARetEQ==
X-Received: by 2002:a5d:6407:0:b0:242:2cb4:6fa2 with SMTP id z7-20020a5d6407000000b002422cb46fa2mr1703001wru.31.1670513447701;
        Thu, 08 Dec 2022 07:30:47 -0800 (PST)
Received: from predatorhelios.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b002366553eca7sm10673239wrt.83.2022.12.08.07.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 07:30:47 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v4 6/7] dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC bindings
Date:   Thu,  8 Dec 2022 16:30:39 +0100
Message-Id: <20221208153041.3965378-7-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208153041.3965378-1-bero@baylibre.com>
References: <20221208153041.3965378-1-bero@baylibre.com>
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
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 939623867a646..3b92725bbc99b 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -34,6 +34,7 @@ properties:
           - mediatek,mt8188-xhci
           - mediatek,mt8192-xhci
           - mediatek,mt8195-xhci
+          - mediatek,mt8365-xhci
       - const: mediatek,mtk-xhci
 
   reg:
-- 
2.38.1

