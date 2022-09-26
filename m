Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2685EA167
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbiIZKu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbiIZKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:47:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AE95724A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:26:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d11so5811613pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vKF6uDKRpSETCfWZPmnW4TNC2jW6TTo0IYMeEINomJc=;
        b=EmWu+Hp0mYKEWNIc/wJSX5GWZgtyM4bpkofx1+z7PSCEyK17Zw8lV2mtmVPgPkEPet
         ziEWhQInfBDgILGkuhTb0/Sp2Jh7E/KQ4RaNzR1MQansnDk1amueRD7HT42EeRz2vyZf
         vLrEnd9lWDrZP2P+9+fpx3+9eCmBh197wxnJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vKF6uDKRpSETCfWZPmnW4TNC2jW6TTo0IYMeEINomJc=;
        b=GJHieFGyQn9WKXmz5R646KF/NLtNKdCmg2Isp3deqWmERnx79TleBAm0kVcQlMp/Kv
         7z+369NjK84yry/1cl7LvEJ2sf3ZPpSchQ56A8qwVc1CDg86ril+DkEzqZZuj9oc1Ntu
         upZLhSD5/P3mXw6n/rgH7cDLnLfGl3QvBdlxaDwJOZLh9wlj5mor8IxSgNuq38i3Q/Q+
         jOebdjGrIE1USOwFmrOgThsKweBhC3SbFTW4CrYi567RAL4MIIvEf+geeHKu5rBObUHt
         Hy0Uqii5//eDb0tLFcJL+yKZoGfbuqFl+0iZNzAsoY/fJZfY2SucKprcqW62VRpOf/2V
         vT2A==
X-Gm-Message-State: ACrzQf1jnHaAZ7TufXFViCKGK2Rfz9vyVcvWizxXXpPjpXOgL22aq5Yb
        q86flMfYi2qJ0bCkth14GNkLcrQ4arg4Yg==
X-Google-Smtp-Source: AMsMyM4RmFhd4z51ZSDU0ZsE7JaNNUJpRIELJK6UXyR3OrLy0D+s42ZSQWEsKTwERKphV4P1ZC2s3A==
X-Received: by 2002:a17:902:d48e:b0:178:b5d:ab3 with SMTP id c14-20020a170902d48e00b001780b5d0ab3mr20925242plg.22.1664187959096;
        Mon, 26 Sep 2022 03:25:59 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1340:7319:2f7a:3be9])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79af7000000b00536aa488062sm11750236pfp.163.2022.09.26.03.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:25:57 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] clk: mediatek: mt8192: Implement error handling in probe functions
Date:   Mon, 26 Sep 2022 18:25:23 +0800
Message-Id: <20220926102523.2367530-7-wenst@chromium.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926102523.2367530-1-wenst@chromium.org>
References: <20220926102523.2367530-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is similar to commit f3e690b00b86 ("clk: mediatek: mt8195:
Implement error handling in probe functions").

Until now the mediatek clk driver library did not have any way to
unregister clks, and so all drivers did not do proper cleanup in
their error paths.

Now that the library does have APIs to unregister clks, use them
in the error path of the probe functions for the mt8192 clk drivers
to do proper cleanup.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8192-aud.c | 15 ++++-
 drivers/clk/mediatek/clk-mt8192-mm.c  | 17 +++++-
 drivers/clk/mediatek/clk-mt8192.c     | 83 +++++++++++++++++++++------
 3 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index 8c989bffd8c7..825b80fc403d 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -89,15 +89,24 @@ static int clk_mt8192_aud_probe(struct platform_device *pdev)
 
 	r = mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
 	if (r)
-		return r;
+		goto free_data;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		return r;
+		goto unregister_gates;
 
 	r = devm_of_platform_populate(&pdev->dev);
 	if (r)
-		of_clk_del_provider(node);
+		goto remove_provider;
+
+	return 0;
+
+remove_provider:
+	of_clk_del_provider(node);
+unregister_gates:
+	mtk_clk_unregister_gates(aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+free_data:
+	mtk_free_clk_data(clk_data);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index 1be3ff4d407d..4c90e0cd9f7c 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -93,9 +93,22 @@ static int clk_mt8192_mm_probe(struct platform_device *pdev)
 
 	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
 	if (r)
-		return r;
+		goto free_clk_data;
 
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_gates;
+
+	platform_set_drvdata(pdev, clk_data);
+
+	return 0;
+
+unregister_gates:
+	mtk_clk_unregister_gates(mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+
+	return r;
 }
 
 static struct platform_driver clk_mt8192_mm_drv = {
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index d3f57fb73c49..94aab61193a0 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1078,26 +1078,64 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
-	mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node, &mt8192_clk_lock,
-			       top_clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base, &mt8192_clk_lock,
-				    top_clk_data);
-	mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base, &mt8192_clk_lock,
-				    top_clk_data);
-	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+	r = mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
 	if (r)
 		return r;
 
+	r = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
+	if (r)
+		goto unregister_fixed;
+
+	r = mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
+				   &mt8192_clk_lock, top_clk_data);
+	if (r)
+		goto unregister_factors;
+
+	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base, &mt8192_clk_lock,
+					top_clk_data);
+	if (r)
+		goto unregister_mtk_muxes;
+
+	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
+					&mt8192_clk_lock, top_clk_data);
+	if (r)
+		goto unregister_muxes;
+
+	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+	if (r)
+		goto unregister_adj_divs;
+
 	/*
 	 * Remove clock provider set in clk_mt8192_top_init_early() first
 	 * to avoid duplicate entry, and re-add it so the OF related code
 	 * gets run again with the full set of clocks.
 	 */
 	of_clk_del_provider(node);
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
-				      top_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
+	if (r)
+		goto unregister_gates;
+
+	return 0;
+
+unregister_gates:
+	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+unregister_adj_divs:
+	mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), top_clk_data);
+unregister_muxes:
+	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), top_clk_data);
+unregister_mtk_muxes:
+	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), top_clk_data);
+unregister_factors:
+	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
+unregister_fixed:
+	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
+	/*
+	 * top_clk_data is not freed, as it is not allocated by the probe
+	 * function, and it is potentially still used through the
+	 * of_clk_add_hw_provider() call in clk_mt8192_top_init_early().
+	 */
+
+	return r;
 }
 
 static int clk_mt8192_infra_probe(struct platform_device *pdev)
@@ -1116,14 +1154,16 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 
 	r = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	return r;
 
+unregister_gates:
+	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return r;
@@ -1145,10 +1185,12 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	return r;
 
+unregister_gates:
+	mtk_clk_unregister_gates(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return r;
@@ -1164,17 +1206,24 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 	if (r)
 		goto free_clk_data;
 
+	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+	if (r)
+		goto unregister_plls;
+
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	return r;
 
+unregister_gates:
+	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+unregister_plls:
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return r;
-- 
2.37.3.998.g577e59143f-goog

