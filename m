Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5295F7877
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiJGNAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJGM7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:59:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13083DF1E;
        Fri,  7 Oct 2022 05:59:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id iv17so2846901wmb.4;
        Fri, 07 Oct 2022 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oRYhQiIHd6UjeWm2BNaRmlMckXEAf/HgaAJfjR9b3k=;
        b=ScFIWgaj3yLcgJnEYfYsCRiVNeuvze2Ok1tg8ZiywyeDYWxTXoeqcfEHkCeGiKG6Vj
         WQTBcpav8TT32RcrSiqWIemM3pZ5hW/JIFC5zcYa0sb7C+EJe6SleZS+JDw4X0xAIoW+
         fmGCG6PWHHXdHoIys1lwRPqK8EGSzjy+jH3w9xM2BllV4JmnXFBtMRrLNmHwj5XvM2pu
         IlznhUZ1uu73KCpsLqxV5pZZx8F8SlQhmk084eXhiYjVxu9pv8zn6XTE59o+rG+vfPv4
         Zy8kFkvk8ZMXSkJaQZPkh1UH+iy5O6J70SxCn6f4Z4xTbh5ROBKCfl+G8C+QLUEMUjNb
         Vq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oRYhQiIHd6UjeWm2BNaRmlMckXEAf/HgaAJfjR9b3k=;
        b=lQTbGf3yQuiAlcpsPJO9Gy7t9ZTMeIiRMCg07yAx9gEVHaHoyMWuznzWSKpNyEhMP5
         +AMLESgN6HylNkMur9H//FHWr8fDSggqWNsB9f7U5x45t5GyuYbIUgvWQOP5JUmVCt/L
         tQLGA5zSm5mEOheDbEpWZdjy9gn8gzaPPvagtQN8e9QZNiQ6xFGzFTjIbKDE9IlDVsbP
         0+QWcTDB9xsjUYJtMF+gRcUsWPLnrBKQpt54dveae7mcnccbRWS1S9lIG8JMb7ZWkX77
         AZkxuZU0nlm81VBg4Sc2kr0uuOS/1iKZbEOQdAKJxzucMYYApUw+UXxUif4wiv3GtuHS
         E2sg==
X-Gm-Message-State: ACrzQf3mSK3wEHpTRc8wxEZb7+QRxKfiwNNmEcJdyFD2D3a3xJWDGPYb
        n8DojMY8SyRLtc5S92WZQkQ=
X-Google-Smtp-Source: AMsMyM5NNXj9ULU6LrQtK0blsjNwRouxeAolg46uvewAEbt8vKaKi6qKFO3P17L12gnOOMIPhSzcew==
X-Received: by 2002:a05:600c:3b9e:b0:3b4:4cf1:9531 with SMTP id n30-20020a05600c3b9e00b003b44cf19531mr10126717wms.64.1665147583483;
        Fri, 07 Oct 2022 05:59:43 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00223b8168b15sm2008243wrs.66.2022.10.07.05.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 05:59:43 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/10] dt-bindings: pinctrl: mediatek,pinctrl-mt6795: Fix interrupt count
Date:   Fri,  7 Oct 2022 15:58:59 +0300
Message-Id: <20221007125904.55371-6-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007125904.55371-1-y.oudjana@protonmail.com>
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

The document currently states a maximum of 1 interrupt, but the DT
has 2 specified causing a dtbs_check error. Replace the maximum limit
with a minimum and add per-interrupt descriptions to pass the check.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
index 73ae6e11410b..a3a3f7fb9605 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
@@ -47,7 +47,10 @@ properties:
 
   interrupts:
     description: The interrupt outputs to sysirq.
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: EINT interrupt
+      - description: EINT event_b interrupt
 
 # PIN CONFIGURATION NODES
 patternProperties:
-- 
2.38.0

