Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488EC61160B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiJ1PgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJ1Pfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:35:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688BF80EA5;
        Fri, 28 Oct 2022 08:35:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d26so13742946eje.10;
        Fri, 28 Oct 2022 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/c962wLBz3jwOt0DTXoQo5h9XxAFZISj22YocQOqFA=;
        b=MtVvEBTivA1ttdlsg5yKdUZ64LflhtWSZlKxObBCtgFUYA5lN9vhTEikPFDwqckQak
         Qa8KILIOh9SP43ZP25ewJc0IGzUS2BvDHn+wguRGw2FUHHFO6ZrKkXHi8Pan2IcYbUmd
         9e3WHRMlWteSqZywc2z7GkmhBGliSIERKBwJ3RfefURwfOighqPdSaW5qeDr1XSXuIDP
         +oGVfaiKhoa/Tz0wYd8TFXPFPNWzGCuEGmSdQjfzLcEAja7ZrQ7H2KO84cjqAZ0aNGPX
         i+y4Ntrfv5IHlNdyBAbPrjv2LUQUoUR4371U5vtK8w8yT481bfW+nn2uotekAjLG2o5y
         0HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/c962wLBz3jwOt0DTXoQo5h9XxAFZISj22YocQOqFA=;
        b=Lz7vUuDC77abrKXTmBoC9yPhOd3vJBwR4n03k3u2hjhF9jnXQcoGyuDLLEQ8Rar6Ls
         zb9iaKjpm49L8+ucVdcoJKWD+WXotDeyHChkI2TZwZqQxCV8t5fu9pRkokWBzD5dGHwI
         4KYWltRq4tFaPOWndFjjqdvgcK66DCT5bCChuO2Qm1jPzm74cVOiFF6ils56nwabYVNz
         56H6/iyEH4L8rGeLCnRX2MSn8XHtyEMzC4XDkiBkS18Ttaz0lwgE0GDaicyL0PmVH1tG
         1tCWIEBc3qGeAwTfXS8t+7ZZwmpJlWwYbNMBOEDWOHtfBEHngZ+b6wSri6sWwCzc8aZM
         bCwA==
X-Gm-Message-State: ACrzQf2aGPFoSSkSDgxfW+6ABcOYC8IElq1urNnl1UMhO6Zhx/ivfYzD
        tInW5sJ7m50pOIwLB5kO0u8=
X-Google-Smtp-Source: AMsMyM7dK5jbLdR3FyoZhjAwUUdBWDcpVaroS5nQ1v4sTmvceLtXEQLQUFKx28sLPQQ1KMiNBnnLJQ==
X-Received: by 2002:a17:907:7da5:b0:78e:2c3b:55a2 with SMTP id oz37-20020a1709077da500b0078e2c3b55a2mr46839745ejc.96.1666971333035;
        Fri, 28 Oct 2022 08:35:33 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:32 -0700 (PDT)
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
Subject: [PATCH v4 06/13] dt-bindings: pinctrl: mediatek,pinctrl-mt6795: Improve interrupts description
Date:   Fri, 28 Oct 2022 18:34:58 +0300
Message-Id: <20221028153505.23741-7-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028153505.23741-1-y.oudjana@protonmail.com>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
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

Clarify the meaning of sysirq to avoid confusion.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
index a3a3f7fb9605..9399e0215526 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
@@ -46,7 +46,7 @@ properties:
     const: 2
 
   interrupts:
-    description: The interrupt outputs to sysirq.
+    description: Interrupt outputs to the system interrupt controller (sysirq).
     minItems: 1
     items:
       - description: EINT interrupt
-- 
2.38.1

