Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9464C0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbiLMXoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiLMXn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:43:56 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E89F6454
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:43:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v8so20211900edi.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMWE91a+pM6oT2mNZ7gfHqIhmh1zpfFSCXxbfA75K/I=;
        b=KjTg7+fHnrZSJ9TzbIsuime+L1iUIUwcVnapNP7Kz2D3un0pTvjzZ2erx7j4s4gVEU
         q2O+Vn65Z3QsWnPwgojrcUuASdZU9O7eDJQMkV6U1OxmSnuYP5GNYwZrPChVe8WFciB2
         OiPvOOHpgKhu/WeZsxcNCVhLDYqw81qj4+mqLePCEsClvo2uz5DZ+UF9meaL6L+aGPpP
         otkWO9YYIY9wAzU4O+wq71Ly0Sh4qD1zTPYUhH+bPgPaJE+KDqUgsnIMAenQaWv1mbIZ
         vvN1y0vi2rSHWWPw00xS2aB/KQb00bBRXp9lm4MoZjLEx+w7ivYWFXiITBSHqTzALnmc
         NFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMWE91a+pM6oT2mNZ7gfHqIhmh1zpfFSCXxbfA75K/I=;
        b=Z7BpXVivz9K0uat9IOpQ6qiiWbfYJAwf+BUl2SCcc3JGW7eYS26CUqvk4JntdeDXal
         +zYzDj+GO4201xW5wu4xvoc7FFpcjC9hmQTDFXgy2py+rJKsU85woly4X2XZDhlciANU
         YzfoRWWFdaY8Anwwc554i3dOL+h8eqfmt1dMnlHrCorCGznsYEdUtWNqgiXsA3RCYF0U
         nd+hFc5zFBE7o8dyhxh6618zCuTm1Ni5wWuvccsJyV+SygRKrtthclvu2qgO8DOe9TSC
         BMQ2pUvPWjpyjTA5l0XYCMAJfHm2P1N8t2VvIyibCeUwWbva9srx0Q+0Xkaif4bygNyn
         G43g==
X-Gm-Message-State: ANoB5pmW3s5uiv6S55VItBOFt4jane6FZg0MBB9GSE4AyeEIc3vUYGLN
        so9KRYLO7YsE4BjnVm6LdrNIeQ==
X-Google-Smtp-Source: AA0mqf7VY+UGWGAMmObwTeYssJFUqQjOW3MtCDrFoe81hJCUG38R80/7WKyZmkUHMO+BOY6yug4ZPA==
X-Received: by 2002:a05:6402:913:b0:46c:fe2d:a588 with SMTP id g19-20020a056402091300b0046cfe2da588mr17564775edz.18.1670975035226;
        Tue, 13 Dec 2022 15:43:55 -0800 (PST)
Received: from predatorhelios.fritz.box (dynamic-093-129-109-038.93.129.pool.telefonica.de. [93.129.109.38])
        by smtp.gmail.com with ESMTPSA id f5-20020a05640214c500b00458b41d9460sm5407498edx.92.2022.12.13.15.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 15:43:54 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v5 6/7] dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC bindings
Date:   Wed, 14 Dec 2022 00:43:45 +0100
Message-Id: <20221213234346.2868828-7-bero@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213234346.2868828-1-bero@baylibre.com>
References: <20221213234346.2868828-1-bero@baylibre.com>
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

