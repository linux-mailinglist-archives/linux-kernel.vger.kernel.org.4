Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150AC74B79F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGGUGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjGGUGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:06:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4411FE0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:06:33 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id HrioqFRE4feeSHrioqfk6G; Fri, 07 Jul 2023 22:06:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1688760391;
        bh=NNP4iq0IL2DpVEo7mW+DHCzkYdUL71H8TAMN9x7jU5Y=;
        h=From:To:Cc:Subject:Date;
        b=qxKDn1rd6aRJntv6HEybP95UQQBUkoBRs3iYH63Tb/bqRsbmkhMY3DuIs7ihp/fYV
         LReyOPV1nl4Fos2uTIwXc6P9DwQ+mFRa9IsfNGY+kY3Cbitk+1LSNZZxph7mP6VKkG
         0Yt1IxbEPqIJZ76+naNI55mNwrGeJl25YfnKnoRf0JUQ03dER75D/FX2SMwmBUGwth
         WKcEKGP13mHGDmgU/u5b/VZwxljnKm8KSLgwGuObCniun8L/i2RH/pfl7cpUXyfyH/
         NKkLfi/PwjaNge1f0Yf7mspm3yBMfmdJc++fI7JzLlztxb/ThdE4xsZx32CNH09Nrh
         8w9dwD5L4hKYA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 Jul 2023 22:06:31 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: renesas: rzg2l: Simplify .determine_rate()
Date:   Fri,  7 Jul 2023 22:06:27 +0200
Message-Id: <fed02e0325275df84e2d76f8c481e40e7023cbd9.1688760372.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rzg2l_cpg_sd_clk_mux_determine_rate() is the same as
__clk_mux_determine_rate_closest(), so use the latter to save some LoC.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/renesas/rzg2l-cpg.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index bc623515ad84..255920c064d9 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -182,12 +182,6 @@ rzg2l_cpg_mux_clk_register(const struct cpg_core_clk *core,
 	return clk_hw->clk;
 }
 
-static int rzg2l_cpg_sd_clk_mux_determine_rate(struct clk_hw *hw,
-					       struct clk_rate_request *req)
-{
-	return clk_mux_determine_rate_flags(hw, req, CLK_MUX_ROUND_CLOSEST);
-}
-
 static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct sd_hw_data *hwdata = to_sd_hw_data(hw);
@@ -250,7 +244,7 @@ static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
 }
 
 static const struct clk_ops rzg2l_cpg_sd_clk_mux_ops = {
-	.determine_rate = rzg2l_cpg_sd_clk_mux_determine_rate,
+	.determine_rate = __clk_mux_determine_rate_closest,
 	.set_parent	= rzg2l_cpg_sd_clk_mux_set_parent,
 	.get_parent	= rzg2l_cpg_sd_clk_mux_get_parent,
 };
-- 
2.34.1

