Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9674B29E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjGGOFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjGGOFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:05:30 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E41B2718
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:05:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so29186911fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738705; x=1691330705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kubpqVY+wfLhuDXukhvTufqnNdzOkNaWWajItyQMxWM=;
        b=Yup815+bfBG+qKfdbmDkUR3hKM6OAuBkkeYgoD2wvVs9x5tdisLBsy8u2bqr4f0DSn
         2hpXqIDKiEHwTBDti5FM+cY06+KHs3ahD0ERG7JtxSrdcFY/d1TdG5zS2+1q6NZ2XDRa
         nhT9l5Q5vWWicaDnhDKsO2gN6hgk+R07ln21n95e+IJM3QzONtlULjHog3dTjn/IcVoS
         vueGTxyyKt5sKLmjkgv9J4FeijJ1//uc5tuUiHMULMUC6h/huzNPmq9niLaBJRCgKDM3
         jBbufA5CCrqoJ06HpRS+dZycpRG2yg5STU724HPnDQgmA5NRhs4uY1pYfC5uX+WNnLKX
         DoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738705; x=1691330705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kubpqVY+wfLhuDXukhvTufqnNdzOkNaWWajItyQMxWM=;
        b=JPg+Vd4tsOtyw0q73gfdGU1L1zaHEVCNmzV9gLU9IgYllUVp5eT1krvENvQdF7YZDS
         +ILXHGKSB1u2EqTd5d1qpYYlM5Vlf36Enoz2wpOcUZBGQLBiPEdh50QtZTctcX1oLNVC
         GOkn6KBzLGjaq4wAGGFUn4RfKkE4UwlQbrB/N0lCKc+GvGKNM3PJPbdVs7DgrfqcyNFE
         1aQgkNG83wWQb83h6CY/FUcMulG7QJyR7+9yqRdURNk1L4XSkZJHUejX0dEcAplCu9+F
         jE91taoEQ03hfVPOnZpxMbfZ0oaVfd0Oziif8i637PnCixAvYCBroJJZl/rwm4cAuCYP
         sJyw==
X-Gm-Message-State: ABy/qLZSCbSjO+c0jHrskDfBCDN/Obc1bug4qE/2zc3WZUGSeQrd4Ocn
        RWdrHg2zF5XF45Wv7rzmbV4eKg==
X-Google-Smtp-Source: APBJJlF67NbLX0eb6y4ugssNq0/Qewc5uDxjKQNtG/3DMiEh/RVTtC8ZQ2+0X4TTuC06eW+jJBdiPw==
X-Received: by 2002:a2e:8745:0:b0:2b3:4ea3:d020 with SMTP id q5-20020a2e8745000000b002b34ea3d020mr3841130ljj.17.1688738704915;
        Fri, 07 Jul 2023 07:05:04 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:05:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 14/18] soc: tegra: Move powergate-bpmp driver to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:30 +0200
Message-Id: <20230707140434.723349-15-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707140434.723349-1-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's moves the powergate-bpmp driver, while we leave the pmc driver in the
soc directory. To move the latter, we first need to split it up in a few
pieces so the genpd parts can be moved alone.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: <linux-tegra@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                        | 1 +
 drivers/genpd/tegra/Makefile                  | 2 ++
 drivers/{soc => genpd}/tegra/powergate-bpmp.c | 0
 drivers/soc/tegra/Makefile                    | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/tegra/Makefile
 rename drivers/{soc => genpd}/tegra/powergate-bpmp.c (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 76f2a411e6bc..e6f34d82e6a8 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -10,3 +10,4 @@ obj-y					+= rockchip/
 obj-y					+= samsung/
 obj-y					+= starfive/
 obj-y					+= sunxi/
+obj-y					+= tegra/
diff --git a/drivers/genpd/tegra/Makefile b/drivers/genpd/tegra/Makefile
new file mode 100644
index 000000000000..ec8acfd2c77c
--- /dev/null
+++ b/drivers/genpd/tegra/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SOC_TEGRA_POWERGATE_BPMP)	+= powergate-bpmp.o
diff --git a/drivers/soc/tegra/powergate-bpmp.c b/drivers/genpd/tegra/powergate-bpmp.c
similarity index 100%
rename from drivers/soc/tegra/powergate-bpmp.c
rename to drivers/genpd/tegra/powergate-bpmp.c
diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
index d722f512dc9d..01059619e764 100644
--- a/drivers/soc/tegra/Makefile
+++ b/drivers/soc/tegra/Makefile
@@ -5,7 +5,6 @@ obj-y += cbb/
 obj-y += common.o
 obj-$(CONFIG_SOC_TEGRA_FLOWCTRL) += flowctrl.o
 obj-$(CONFIG_SOC_TEGRA_PMC) += pmc.o
-obj-$(CONFIG_SOC_TEGRA_POWERGATE_BPMP) += powergate-bpmp.o
 obj-$(CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER) += regulators-tegra20.o
 obj-$(CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER) += regulators-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_186_SOC) += ari-tegra186.o
-- 
2.34.1

