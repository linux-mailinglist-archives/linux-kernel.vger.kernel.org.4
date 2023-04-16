Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E126E38C9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjDPNgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjDPNfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:35:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FBC49EA;
        Sun, 16 Apr 2023 06:35:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u3so5468525ejj.12;
        Sun, 16 Apr 2023 06:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681652144; x=1684244144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjXGUzPKMMr8ygNmvKTs+ca+O+QBcfL+qA6w2J0vS7w=;
        b=UgUKRtwE4oogpbBNh8fzZ3FqYbVAAOAtKTi1c6uAgDKatTn7KPuM6DbVmUVkVTtmuR
         FSp52Dzw63N5O+/AzrgnCXSoYK2oSQ6Pk1xUfJ6Wa5OU0++bSc+N3LQgK0GOHmzJX46e
         hadyNfBXqpFptAYcDI0LULtH95r/hbrEvaAYEQZLVdnIUXIkK+ilqyKez5dYbcmosIGt
         gGm7HCaPN82U9qgXychN+Bc+WPuHmKEeO6r2sWVdFeSPesYbW6EUQH9UPMjaKL2MVwhG
         rCQY7wNkclVIuhCpcbx1T8+HQsk4OCgOYiYT6yMiQJnQIN4Di8RJkRrOYlyZ2ZTldpSH
         kitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681652144; x=1684244144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjXGUzPKMMr8ygNmvKTs+ca+O+QBcfL+qA6w2J0vS7w=;
        b=gFXGipWqgfAVaSc/XXKvm/DkdEgPluve8vdeT3RbK9okkKeNLb3yYVswDzZ43TWpjD
         5WRtYwB/4degUXNuaGoK9BQ25MKEEPezE5zzmEz+ZLwDxLRsm31vPccVsCtkZDfloG02
         Wa3Sn5VaqHkGwgv8MznKQaPXDTDYdofswfAIvl16Ml7hMBve4sLp6AjoD4lzHhjNhfwz
         5YgZ5dSatBF35y9J90Ax83vU3duThbHvD+v/Slkh6nn9sd4aqOF1oBtPsBSMzmO28sFV
         NHHzuECm7Qa5tNXfuxDTYomZR6edvdbD1FZ1JwcswAfrfdJOaAnb0oePOGWJIJqabEIB
         60jA==
X-Gm-Message-State: AAQBX9fWLQ5ExiyYu9G8vrj4o2WZddPaIMmnaU7vdvXxnASOXIEuT1VD
        rm2KGfpJZBndIfNPtWzkeBo=
X-Google-Smtp-Source: AKy350aB997CQTiblOPPq0SvVcmrg3sVPcAu4d+kAnkGtuMsIWRj3quw4TlqSzUjasl+SrIb1dRo3Q==
X-Received: by 2002:a17:906:8805:b0:933:130e:e81a with SMTP id zh5-20020a170906880500b00933130ee81amr4134021ejb.32.1681652144115;
        Sun, 16 Apr 2023 06:35:44 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id gn23-20020a1709070d1700b009373f1b5c4esm5122958ejc.161.2023.04.16.06.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:35:43 -0700 (PDT)
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
Subject: [PATCH v2 05/12] clk: samsung: Add Exynos4212 compatible to CLKOUT driver
Date:   Sun, 16 Apr 2023 15:34:15 +0200
Message-Id: <20230416133422.1949-6-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416133422.1949-1-aweber.kernel@gmail.com>
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
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

This is effectively a revert of commit d5cd103b06f9 ("clk: samsung:
Remove support for Exynos4212 SoCs in Exynos CLKOUT driver"); the
driver has changed significantly since then, prompting this re-make.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/clk/samsung/clk-exynos-clkout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index e6d6cbf8c4e6..326d5fc58727 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -55,6 +55,9 @@ static const struct of_device_id exynos_clkout_ids[] = {
 	}, {
 		.compatible = "samsung,exynos4210-pmu",
 		.data = &exynos_clkout_exynos4,
+	}, {
+		.compatible = "samsung,exynos4212-pmu",
+		.data = &exynos_clkout_exynos4,
 	}, {
 		.compatible = "samsung,exynos4412-pmu",
 		.data = &exynos_clkout_exynos4,
-- 
2.40.0

