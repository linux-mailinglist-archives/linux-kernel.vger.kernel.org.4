Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD786E372F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDPKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjDPKSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:18:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC54C170D;
        Sun, 16 Apr 2023 03:18:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50506ac462bso2742062a12.3;
        Sun, 16 Apr 2023 03:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640297; x=1684232297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjXGUzPKMMr8ygNmvKTs+ca+O+QBcfL+qA6w2J0vS7w=;
        b=JuDRUCNLbgpuHXyBai4VgEQz2LHyBsvcksieW2gFVZn1a3JvqAN1jKKWnUuYs3tvfX
         gypRLo1FRoF49Ux1fV1yb80Jj9ScWPYMqB0fD/4/5w7+ErAAlHlhUQBj6Q2s0pKbsiAg
         6IUYr0FX/DY4wfSXIO8lPa9kQyEZSEnwa5cWM/FImvQgfCWOTxlwy3sLGFgKrc6338Nh
         DOpHJokg4i1jSlveMw468LNYawjMmZitqX5u6BDdgmwHtwQMVmscPCRbI5mBCyoay/v7
         Oq9bF06b5NQzqCadwQ3/LiZRoaNEeSACd14Ni62ivVWXuXh1En2d3fNC0A1C8LyhMNSB
         g8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640297; x=1684232297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjXGUzPKMMr8ygNmvKTs+ca+O+QBcfL+qA6w2J0vS7w=;
        b=PPSXaNpGgCVPVr+xFFK3yXNHPJeWQNPEY89p2eGlVFC7bpvyFYoPCqfE7XZ5qnihHH
         lrGZT2nfMrU8yhsvJQeeSIp5CI9lxW/B1vgh0ex6IZ/3bn2RdQqxUZ9L+qoFH7LpEBsa
         xyNQMuDZWxF8OMmr8MsoDDB1ne/e+Qk+fLFEiPlCScJQCac83ngdJJndyvA9RkAJWrDe
         ioTBLnU13yjRSRgMn4OjWN6et6EbU+BoxxGMkyt4HDyF17GJEVXqAQZDPK5CVVCR5BVL
         grae4PF5HWpwU9s+qGA7MS2f4cC2lzE2B5+phPXFnEbd01AFXT+wExs0BblgKfPPxP4p
         zsuw==
X-Gm-Message-State: AAQBX9eFuaMMxCO+0WybPalA4KMSRH6bUmRh2FYjL5GgdBBDaAG68R63
        hD8z68RUZgARmnlaM/RyDzQ=
X-Google-Smtp-Source: AKy350YfVhGOxo4Fyh2YnwO3mRSIj+MpEFHXrWuxS67lJ6XKwts4kom34TO/LfZQGUpsH9S+3YqSHg==
X-Received: by 2002:a50:ed0f:0:b0:504:aeb5:89c3 with SMTP id j15-20020a50ed0f000000b00504aeb589c3mr12648303eds.5.1681640297417;
        Sun, 16 Apr 2023 03:18:17 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402019400b0050476da5160sm4427443edv.45.2023.04.16.03.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:18:16 -0700 (PDT)
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
Subject: [PATCH 05/12] clk: samsung: Add Exynos4212 compatible to CLKOUT driver
Date:   Sun, 16 Apr 2023 12:16:17 +0200
Message-Id: <20230416101624.15866-6-aweber.kernel@gmail.com>
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

