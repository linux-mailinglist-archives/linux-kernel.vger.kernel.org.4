Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97409655177
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiLWOkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiLWOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:40:33 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E16837FA8;
        Fri, 23 Dec 2022 06:40:31 -0800 (PST)
Received: from hednb3.intra.ispras.ru (unknown [10.10.2.52])
        by mail.ispras.ru (Postfix) with ESMTPSA id CF5DE40737B8;
        Fri, 23 Dec 2022 14:40:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CF5DE40737B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671806425;
        bh=EhcMZIauTuOelwIwzHF+SwckBgMoMMbhnIK4cfP049Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=ZN2d9wc1csXf2o6f6UXQjMhGVzmhPifJTTac+l5OK9RFPfW/tHUi7BOPKbpCFpxuE
         nf5dP9/VM50u7tB7FW6Kvqeb3qo8czZAnixVYqM+4BFrheXEP79DzXdsNffmPu0FJm
         6O6zz7gJ/u4U1mtdTSHbD7SOeYqmvvhtlWiUhoJA=
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH v2] clk: renesas: cpg-mssr: Fix use after free if cpg_mssr_common_init() failed
Date:   Fri, 23 Dec 2022 17:40:17 +0300
Message-Id: <1671806417-32623-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAMuHMdXehA_n78nLXCwBdKV=So=6Vzjt5eye7ZE4bS_BvHnzEA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cpg_mssr_common_init() fails after assigning priv to global variable
cpg_mssr_priv, it deallocates priv, but cpg_mssr_priv keeps dangling
pointer that potentially can be used later.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1f7db7bbf031 ("clk: renesas: cpg-mssr: Add early clock support")
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
v2: Move cpg_mssr_priv assignment just before return 0; instead of
clearing it as Geert Uytterhoeven <geert@linux-m68k.org> suggested.
 drivers/clk/renesas/renesas-cpg-mssr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1a0cdf001b2f..5dce9779324d 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -989,7 +989,6 @@ static int __init cpg_mssr_common_init(struct device *dev,
 		goto out_err;
 	}
 
-	cpg_mssr_priv = priv;
 	priv->num_core_clks = info->num_total_core_clks;
 	priv->num_mod_clks = info->num_hw_mod_clks;
 	priv->last_dt_core_clk = info->last_dt_core_clk;
@@ -1019,6 +1018,8 @@ static int __init cpg_mssr_common_init(struct device *dev,
 	if (error)
 		goto out_err;
 
+	cpg_mssr_priv = priv;
+
 	return 0;
 
 out_err:
-- 
2.7.4

