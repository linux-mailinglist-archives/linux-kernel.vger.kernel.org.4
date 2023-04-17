Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4116E47F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjDQMkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDQMkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:40:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C78121
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:40:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id la15so2227777plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681735205; x=1684327205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wZohT/rXRJ7RxEfPJSlKRsC6xJ8iy8PXX3oqB2TB2A=;
        b=L5kG2yNcDDrg4gc3IALK+Yb2SB9Q4uN8X3KQqJhb41hm0SKz2nxeH/xReR+dIyPsWd
         mHdkLsagwuVp+SqIAqUQfvU4w5Rwnc5l5r1JBnfrI0OGf01GCi3zz7YUwah4nUtfDYeZ
         rHBDB3tgAKpSyZc87VWKGyTaUoF+O3orNj0pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681735205; x=1684327205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wZohT/rXRJ7RxEfPJSlKRsC6xJ8iy8PXX3oqB2TB2A=;
        b=FF0Oa54p9WDYLL6U916W3MSuKKHWYr6cA8PPGNsYl4Iw9ZDX8u+h37e1bP93BK7iZa
         +0a9cEqlUEvFoVaVQhzWFjoEJgBnTr/j9Ucc9IeuMV8iPk4d9Vv8AEXhFK/ClIBo+Wom
         V0OwEzeJOl/kYfeK2CmIlv0yhkGqtpF8AgrYplbaBfVkuSI6t1oiYjc1OdyepOsBkrqo
         2LObDt46t08bpQTySLaYAaAbvtKx5ghwKf2ZRE24vidxCHtLjokR6vnN3OLaKonm1UCI
         TH0x7wLS+ve9g0tWR4tuzVU6nnuQDwBFU4vXOT61/qgnIJcWzVzImPyv1CkzuaQTOJF1
         /o0Q==
X-Gm-Message-State: AAQBX9fuWvKWdZm4and0pj9TyRbetwghADsAUFd+mCB7LLoCFEXn6UgQ
        pi1SSNw+LPsrlx72+HPO9JCwNg==
X-Google-Smtp-Source: AKy350amnx4vQZWZh+xVgxnz5F9g1Ghxm0KeskyBP72RnpTiQW5hibRE3/bNwwAs389ftS5nG+HdUw==
X-Received: by 2002:a17:902:e811:b0:1a5:898:37aa with SMTP id u17-20020a170902e81100b001a5089837aamr15105552plg.15.1681735205392;
        Mon, 17 Apr 2023 05:40:05 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:c8e2:dd4:3c45:24e2])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b001a6467cfbeasm7595361plk.53.2023.04.17.05.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:40:04 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Doug Anderson <dianders@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] arm64: dts: mt8173: Power on panel regulator on boot
Date:   Mon, 17 Apr 2023 20:39:56 +0800
Message-ID: <20230417123956.926266-1-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "regulator-boot-on" to "panel_fixed_3v3" to save time on powering
the regulator during boot.  Also add "off-on-delay-us" to the node to
make sure the regulator never violates the panel timing requirements.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index d77f6af19065..03d1ab2ca820 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -96,6 +96,8 @@ panel_fixed_3v3: regulator1 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		enable-active-high;
+		regulator-boot-on;
+		off-on-delay-us = <500000>;
 		gpio = <&pio 41 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&panel_fixed_pins>;
-- 
2.40.0.634.g4ca3ef3211-goog

