Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B125EA459
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 13:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbiIZLpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 07:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiIZLml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 07:42:41 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBAC71BFE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:45:59 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id z25so10190471lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rNWG4JRe++162NhDsfBIYQjTSKMyRVIRJUKX50ptAGY=;
        b=apxdxC/SZwYOVZdXn24zNBfDFMi7EsEuSmVWj/G5E7GAKkNZyQyX/ID4c6HnZkHbEo
         gVMD4bQFbeOrQzgMFGXt6eu5MdTVjYOiSSK3WpdMOafWWegTCyoqHnLWdZoGsGIyhy3k
         iLFE1mtY8NVMrsD6yL0AKE0H8fz4x5egsl7ImWlfltr1xExX2ugkok9daCAdEp1QVZCx
         RxOIL3VKv3EttfaNcX9i+6zAP8GaBP2BX9PjdQz+mZcSyK9cbMbVeRUgFOGLGd5rD+ei
         YEcX0uNahfhoa/VxgdTxGNAt//86dEk0bX3m5temSnsyOz5wgR7zNsnGVteXqUuJ1no+
         V0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rNWG4JRe++162NhDsfBIYQjTSKMyRVIRJUKX50ptAGY=;
        b=imOP4BlQm7uwd1TEw7K7p12EJP8d0pfteYaQ+4318ZC8FyVOQUF3AQCKoyHo+Zqjbj
         oqF2ERZlIhu0jlTFsEeC9JMHQ4T11zDCohVLlUN1R2vf60u3ZCVfCJlCUTI3BXwdXwzw
         MmQiUn6fnVTy8eSeuazKlJkWBK0eEWeu4cj9PxcWzeIOzspyNBe9ece1v+aW6nzU7jvw
         FZUMhqZY8wWcRmWULmu7osEXaXgwilL27h5LoFIWcRa7PvR9/jzXECE/eGgs7GznQqYr
         XLyVJDbi4IFGaE0lWFylE+ca1UDuxKMO7iR15eOqSZ2kG3o54VBl/LT9AVWRIeLQnOGu
         +yGg==
X-Gm-Message-State: ACrzQf0Di4IQzH3uV1PiFc79QBFd1kRKqbIaPUAC60MhcYbolOOrYLNx
        pQw4az+p7APboGFZQ7YcRfTflw==
X-Google-Smtp-Source: AMsMyM7CTPcD1Iie9wuX6WkBzCWvvWDCPmmDKnQ42CjusRkxdgW8d+lPCLtPFyFHH5xQbvrQRr7TgQ==
X-Received: by 2002:a19:4f01:0:b0:49c:94fc:1848 with SMTP id d1-20020a194f01000000b0049c94fc1848mr8103685lfb.415.1664189046445;
        Mon, 26 Sep 2022 03:44:06 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y1-20020a05651c020100b0026c423959desm2313408ljn.25.2022.09.26.03.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:44:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Tomasz Figa <t.figa@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH PULL 1/2] ARM: dts: exynos: correct s5k6a3 reset polarity on Midas family
Date:   Mon, 26 Sep 2022 12:43:53 +0200
Message-Id: <20220926104354.118578-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926104354.118578-1-krzysztof.kozlowski@linaro.org>
References: <20220926104354.118578-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

According to s5k6a3 driver code, the reset line for the chip appears to
be active low. This also matches the typical polarity of reset lines in
general. Let's fix it up as having correct polarity in DTS is important
when the driver will be switched over to gpiod API.

Fixes: b4fec64758ab ("ARM: dts: Add camera device nodes for Exynos4412 TRATS2 board")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220913164104.203957-1-dmitry.torokhov@gmail.com
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index b967397a46c5..8e1c19a8ad06 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -586,7 +586,7 @@ image-sensor@10 {
 		clocks = <&camera 1>;
 		clock-names = "extclk";
 		samsung,camclk-out = <1>;
-		gpios = <&gpm1 6 GPIO_ACTIVE_HIGH>;
+		gpios = <&gpm1 6 GPIO_ACTIVE_LOW>;
 
 		port {
 			is_s5k6a3_ep: endpoint {
-- 
2.34.1

