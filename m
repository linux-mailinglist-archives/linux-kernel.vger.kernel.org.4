Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0B638D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiKYPLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiKYPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:11:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B91CB23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n3so7193266wrp.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SERY71Vd1RHSOGeZoeNuejCrV5VkyCcMPbYPY5d0cXg=;
        b=CnUVkXQCV0WmPc2slCHcG/UmeprUoeDc+HlyXnUrx7JqxMpxCpCSA7pFyTYrn3mqf6
         chG2YxoLRHhLgIiCELc++4B1UO7vEWIO0oHL6z/LV5CSTxCatVilLeg11jMkZCBQMWs3
         zW1rSxQQf6k1mTmZojQfo+AVzx5qoZe9/cxOpyLTNcJJKKZ/JVHOjVrvrVtlzzAZjiWA
         AdCxHGywAm/G7J/6ExZqMAYEmYougS7BANF2KKGxYQf+O/ca1CLWhzgOzDRAu5nkw4BI
         +twOvRJipNrOLHGP757UiYCkaCsXZQC/C/MSNzWd5wmskYQprhUJm6FXSZTcpkXY1jub
         Lf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SERY71Vd1RHSOGeZoeNuejCrV5VkyCcMPbYPY5d0cXg=;
        b=FoB1r8RoULyKJ45xPxKnV3bRqzNAwOX5Er1LifUXvUVnKaCA7cbWdK5Dte6kiRelQK
         ov086i6W4FuYxtc5bdv9y79U55ltkJfV9NFsYWOktJNGkMb1OxIhtxxK/UpEkLSKy43D
         ZHWwh1YSEOz19jNSDxGrOPFS/YSdFbhu7+4IM6bCK90s3tLGqBfVLXCLqZC8RihNpwAH
         TNI4AlC9qcETJeIEvU7AehvKDnth/iR1YK0K4KpjtF0QdjGhALWGgtImO+QOBE7YVo9o
         CnRVl6uTgxkt+bSilC25xAk+NrWVc9AY901CXMzg8Et60rsV2u4A3t3xSWZ6jr4JY0FO
         2w3Q==
X-Gm-Message-State: ANoB5pnyq7rU257N/fjjVv8JBHwfRLFIVzpA1+eB1gUo/Xkj3iPGfMdD
        REXDGkJm9cUD09+WSojCbg2JkA==
X-Google-Smtp-Source: AA0mqf4igpRB04xMtP9+f7/oC4bWlo8PKHx3XdmeOCBzo2w9zn/sPMuCZmOrNXrSKGKCwWr79oTWzw==
X-Received: by 2002:a05:6000:12c3:b0:236:8130:56e7 with SMTP id l3-20020a05600012c300b00236813056e7mr23334960wrx.309.1669389084210;
        Fri, 25 Nov 2022 07:11:24 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id w10-20020a05600c474a00b003b435c41103sm11565885wmo.0.2022.11.25.07.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:11:23 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 25 Nov 2022 16:10:14 +0100
Subject: [PATCH v6 03/10] dt-bindings: rtc: mediatek: add MT6357 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v6-3-4f589756befa@baylibre.com>
References: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=UVzrRIoQ4/WPI9WfRYNgs1FH7udWyYMvOv47aHSYxpY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjgNsWWFNWP2r19g13DFXu9HWhIrsdMIy+ZJjgbRS0
 4ii6dxSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4DbFgAKCRArRkmdfjHURbZuEA
 C1kbaOn8T/19Axqe3IfUlgoWPR1nuWLhIdexIoDHt5ai1UR3KlEIGPpLp5zkUbGqisBFdfLXUgdySq
 So0aFZ68mnCH8+tFAz4oqBHk/Kx/EoNpegC2r4cOtkqd3g0WemyRvhmdt22Suc+f5U1O55Hwk27fpT
 voC0B4CNXRlYSt8nhl/5UYmU/5Zx1wEoDNDoT8GGfg1khPYigJVg9qN54MyBAe5VhSW/+O5Lm/NHOw
 f0BNO7b0xqaQtiWHZxuBvbVR8pHjD8yaoUiueX7qsCRLCdiyNwOGm8NXBdP/33XuoIFGI6jWzUOka+
 vw3G1++yCphEWdHa4oN9TZW1g7DKJvS0xqgceVp9+DhGR/nABNcrpXMXlVi/nbvCZrvWectGs9nmCv
 IG53KpWjnDuQHrQHGgafivFJ9OhnwAXLVDQSiwpyqB0dzr+kvITTfDJ5rgsajWG7YyPB4XVypVHV1H
 zp+a90msg74NHsfBUwX+yHan9SDPefltQZz7DCYJxHntrSK+uQaKkaqt13DkzOr+GJNxSp/bEntTII
 N2P+Wycdlai24xk0YFDSsTppcFqo3Mjyy/ZpB7QzHeclL+0FIuwzGvFNdzFdt23qwRQkRMgVu0RGS/
 8BubbetpaGvJv3LIsowBFn0x3WRA0DWP10IaGZvOmFWyX3zcVWGXOMdg3Zjg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of mediatek,mt6397-rtc for mt6357 SoC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
index 97b09c81e548..d582625430e3 100644
--- a/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/rtc/mediatek,mt6397-rtc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: MediaTek MT6397/MT6366/MT6358/MT6323 RTC
+title: MediaTek MT6397/MT6366/MT6358/MT6357/MT6323 RTC
 
 maintainers:
   - Tianping Fang <tianping.fang@mediatek.com>
@@ -23,6 +23,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt6323-rtc
+      - mediatek,mt6357-rtc
       - mediatek,mt6358-rtc
       - mediatek,mt6366-rtc
       - mediatek,mt6397-rtc

-- 
b4 0.10.1
