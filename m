Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6840688F75
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjBCGJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjBCGJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:09:08 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A11B73074
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 22:09:06 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id o66so3367244oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 22:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGIg7efke9/GL7H7bmsFZBD24JST84PhbzNPSEQBcS0=;
        b=Gx3JJFW5AmJIEM9E+xl833GmF3UeU0UV7IAeZXgwSRigqwr6QDvIOTnKo2EkuZ4JBm
         K6DrHnjSeSmJoCoIh6M/27+RN5mb5f6nZnwydy6yGgHr5+c2x/Z/vTkvNBHWsFSIKOpf
         yqBBFZG3BxR8P0ZWskEJmKvJzK5oBXAGVqV8OaVNtpBtmnKKLrgqMfFGVTYFO0jnuafZ
         L07xfeGNfL/12k31PvlMuOkPxYvmIGj5X/g8e3VKVSP9wwjzij/2lODHwYoa/INsTTxX
         7vYWKYSZi7zg3snrVindw0/0CaZt2VE9G4cWIdCmR/NSkvFIqDOxNLaAdXmaAok7Z3Yt
         po+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGIg7efke9/GL7H7bmsFZBD24JST84PhbzNPSEQBcS0=;
        b=EwfnrPOjGuFTvUNX/SGX1FEoq27GhTcMran5vgXXRvmmxjg0JUXCbfZB5XM2NMd21Y
         HSVf5e1lIdSEiwhUjDS/8+fHIM1daExAmoFUc3rGZntYPJSltfBdLqZvC6ceYQLy2zvi
         /2kmr/4LC27ZJafyfaBCaTiObdY+8Wtr8r64ETwDzmd/dc+U6sdAxj2IXUOSjV8P9E/6
         aIrNLmKt4v6biK0zyxqK1IS0ebtXXSsUWvShvWuomBq97rmdHV9A43YvTJ+8bcwUTtim
         XWNzi7bN/ZeNLpLBJM2prznLyido03OGHqSESKzzsCZQzVBzFa9Cy2jUJs+4YATjZP+k
         a+fw==
X-Gm-Message-State: AO0yUKW+K9LKctdTFP8zSwOHIRDoJ3wDnRFtcDS1AfaHMsaOGpM7XweI
        SeJ8uO8PykJo5Srw6O4jsYZoCA==
X-Google-Smtp-Source: AK7set9l6Dt74iN/9jGW0AVDX6iku7ADOWzwYFPSr3Jo+72AyEvOoSgqinrOWBW3zn3x3g4yc+CPKA==
X-Received: by 2002:a05:6808:6182:b0:378:2467:5cf0 with SMTP id dn2-20020a056808618200b0037824675cf0mr3949544oib.25.1675404545734;
        Thu, 02 Feb 2023 22:09:05 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id d2-20020a056830044200b0066ca61230casm757387otc.8.2023.02.02.22.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 22:09:05 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] clk: samsung: Extract clocks registration to common function
Date:   Fri,  3 Feb 2023 00:09:22 -0600
Message-Id: <20230203060924.8257-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203060924.8257-1-semen.protsenko@linaro.org>
References: <20230203060924.8257-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It might be useful to have a separate clocks registration function, so
it can be called from different users. Extract that common code from
samsung_cmu_register_one() to samsung_cmu_register_clocks(). Also make
that new function global as it's going to be used in other modules
further.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk.c | 46 ++++++++++++++++++++++++---------------
 drivers/clk/samsung/clk.h |  2 ++
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 912dfbe5ac20..b6701905f254 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -335,6 +335,33 @@ void samsung_clk_extended_sleep_init(void __iomem *reg_base,
 }
 #endif
 
+/**
+ * samsung_cmu_register_clocks() - Register all clocks provided in CMU object
+ * @ctx: Clock provider object
+ * @cmu: CMU object with clocks to register
+ */
+void __init samsung_cmu_register_clocks(struct samsung_clk_provider *ctx,
+					const struct samsung_cmu_info *cmu)
+{
+	if (cmu->pll_clks)
+		samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_clks);
+	if (cmu->mux_clks)
+		samsung_clk_register_mux(ctx, cmu->mux_clks, cmu->nr_mux_clks);
+	if (cmu->div_clks)
+		samsung_clk_register_div(ctx, cmu->div_clks, cmu->nr_div_clks);
+	if (cmu->gate_clks)
+		samsung_clk_register_gate(ctx, cmu->gate_clks,
+					  cmu->nr_gate_clks);
+	if (cmu->fixed_clks)
+		samsung_clk_register_fixed_rate(ctx, cmu->fixed_clks,
+						cmu->nr_fixed_clks);
+	if (cmu->fixed_factor_clks)
+		samsung_clk_register_fixed_factor(ctx, cmu->fixed_factor_clks,
+						  cmu->nr_fixed_factor_clks);
+	if (cmu->cpu_clks)
+		samsung_clk_register_cpu(ctx, cmu->cpu_clks, cmu->nr_cpu_clks);
+}
+
 /*
  * Common function which registers plls, muxes, dividers and gates
  * for each CMU. It also add CMU register list to register cache.
@@ -353,29 +380,12 @@ struct samsung_clk_provider * __init samsung_cmu_register_one(
 	}
 
 	ctx = samsung_clk_init(NULL, reg_base, cmu->nr_clk_ids);
+	samsung_cmu_register_clocks(ctx, cmu);
 
-	if (cmu->pll_clks)
-		samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_clks);
-	if (cmu->mux_clks)
-		samsung_clk_register_mux(ctx, cmu->mux_clks,
-			cmu->nr_mux_clks);
-	if (cmu->div_clks)
-		samsung_clk_register_div(ctx, cmu->div_clks, cmu->nr_div_clks);
-	if (cmu->gate_clks)
-		samsung_clk_register_gate(ctx, cmu->gate_clks,
-			cmu->nr_gate_clks);
-	if (cmu->fixed_clks)
-		samsung_clk_register_fixed_rate(ctx, cmu->fixed_clks,
-			cmu->nr_fixed_clks);
-	if (cmu->fixed_factor_clks)
-		samsung_clk_register_fixed_factor(ctx, cmu->fixed_factor_clks,
-			cmu->nr_fixed_factor_clks);
 	if (cmu->clk_regs)
 		samsung_clk_extended_sleep_init(reg_base,
 			cmu->clk_regs, cmu->nr_clk_regs,
 			cmu->suspend_regs, cmu->nr_suspend_regs);
-	if (cmu->cpu_clks)
-		samsung_clk_register_cpu(ctx, cmu->cpu_clks, cmu->nr_cpu_clks);
 
 	samsung_clk_of_add_provider(np, ctx);
 
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 3fd6c0868921..ab9c3d7a25b3 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -377,6 +377,8 @@ void samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 void samsung_clk_register_cpu(struct samsung_clk_provider *ctx,
 		const struct samsung_cpu_clock *list, unsigned int nr_clk);
 
+void samsung_cmu_register_clocks(struct samsung_clk_provider *ctx,
+				 const struct samsung_cmu_info *cmu);
 struct samsung_clk_provider *samsung_cmu_register_one(
 			struct device_node *,
 			const struct samsung_cmu_info *);
-- 
2.39.0

