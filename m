Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C7D6E3748
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjDPKTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjDPKSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:18:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5091733;
        Sun, 16 Apr 2023 03:18:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94ed7e49541so138090366b.1;
        Sun, 16 Apr 2023 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640304; x=1684232304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Vw7IkhYneCykALUpZzpj7USB2Ld/fNOUvy0zl1WvSk=;
        b=d3y8JwMRUwKh1tdSMa3QufUNZpkVuowkFvs4vXbquxrQmW8u3zh+YVaqidheSd18Yh
         sSXeivwOOH8D+8PiCzIwl0EluBzr+9LDHM11AiA/JtHuqWxwbIi1PP50x1HeBbs+dIx+
         GAR9wetWmRxOwNik60THfZ4owhwjEkCv9bHYWlG2oLvny7tsaMg5681VpCrmwlljWfMv
         /wvCkvIWlVWZ39PtNCy0m59vaZ/dl71wsBwPGfsJlJRxSzm0LqR8Cy8U4iSU06DUsyE/
         gQLfm8LhsjWqkWVFZxRz8gZjMnreGOJTOz/pjnzDOzrXfhsYMnFiuabKdZgsoL0zsaeX
         PaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640304; x=1684232304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Vw7IkhYneCykALUpZzpj7USB2Ld/fNOUvy0zl1WvSk=;
        b=a62wEgc2zwf9hWOyFjOEmSjevWWqOmJAhV0tqt2Hb2YcdTp/xGXbF9ubuPqUMW2mco
         QbTAJ9rWoelCAWv4DPMPHaI8jS8WaLZrw62xqdIJAf1Tc2n7Ta+VXfmJUhO9PwVh7G07
         8meigfiJp8dYjZgi7A7SUCrzm+g/txXp8+frmdUyCgVq0iq8C1BgC/vcVApKl582YxFq
         cUpg9Gf+L/ueTGIcjrHBWD/7m+WbJoFsx/AJf79gm1KDGWFzMrmlD1Lt8wiL1fOpFv2g
         yNW6YZQQhwi2mriGtKJ7fUhG5zqvDW6CaTi+oz37hnxvC4T/27B+bBu4Ty5HRnT+Zzc3
         cZOA==
X-Gm-Message-State: AAQBX9cLcqSccbDgbcElheon0mD/6aFASGtgmIWDy0aWSRrW7WGVrP+y
        0k75ulyXik8iYVdL0aFuU1xlxnPh6Y8=
X-Google-Smtp-Source: AKy350baF3wt8f4vZvCbFp7IBlN80m1snCFuzJDRbGXEHsXmYWJBHgGmsrQ4P3yYeHwlqivEcl086w==
X-Received: by 2002:a05:6402:1b02:b0:501:d4f9:3141 with SMTP id by2-20020a0564021b0200b00501d4f93141mr11301812edb.32.1681640303935;
        Sun, 16 Apr 2023 03:18:23 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402019400b0050476da5160sm4427443edv.45.2023.04.16.03.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:18:23 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 08/12] Revert "phy: Remove SOC_EXYNOS4212 dep. from PHY_EXYNOS4X12_USB"
Date:   Sun, 16 Apr 2023 12:16:20 +0200
Message-Id: <20230416101624.15866-9-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416101624.15866-1-aweber.kernel@gmail.com>
References: <20230416101624.15866-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform was originally dropped in commit bca9085e0ae9 ("ARM:
dts: exynos: remove Exynos4212 support (dead code)"), as there were
no boards using it.

We will be adding a device that uses it, so add it back.

This reverts commit fee7e1d50c6e6da1d99035181ba5a5c88f5bb526.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/phy/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index 3ccaabf2850a..f10afa3d7ff5 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -59,7 +59,7 @@ config PHY_EXYNOS4210_USB2
 config PHY_EXYNOS4X12_USB2
 	bool
 	depends on PHY_SAMSUNG_USB2
-	default SOC_EXYNOS3250 || SOC_EXYNOS4412
+	default SOC_EXYNOS3250 || SOC_EXYNOS4212 || SOC_EXYNOS4412
 
 config PHY_EXYNOS5250_USB2
 	bool
-- 
2.40.0

