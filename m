Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC7365C427
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbjACQph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbjACQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:45:35 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09B8DA0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:45:34 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:f1ca:ff0d:9dea:806e])
        by michel.telenet-ops.be with bizsmtp
        id 4GlY2900w2YHDVW06GlYRb; Tue, 03 Jan 2023 17:45:33 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1pCkPs-00203S-LF; Tue, 03 Jan 2023 17:45:32 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1pCkPs-001TJk-68; Tue, 03 Jan 2023 17:45:32 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: microchip: mpfs-ccc: Use devm_kasprintf() for allocating formatted strings
Date:   Tue,  3 Jan 2023 17:45:30 +0100
Message-Id: <f904fd28b2087d1463ea65f059924e3b1acc193c.1672764239.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In various places, string buffers of a fixed size are allocated, and
filled using snprintf() with the same fixed size, which is error-prone.

Replace this by calling devm_kasprintf() instead, which always uses the
appropriate size.

While at it, remove an unneeded intermediate variable, which allows us
to drop a cast as a bonus.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/microchip/clk-mpfs-ccc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microchip/clk-mpfs-ccc.c
index 32aae880a14f3b1c..0ddc73e07be42973 100644
--- a/drivers/clk/microchip/clk-mpfs-ccc.c
+++ b/drivers/clk/microchip/clk-mpfs-ccc.c
@@ -164,12 +164,11 @@ static int mpfs_ccc_register_outputs(struct device *dev, struct mpfs_ccc_out_hw_
 
 	for (unsigned int i = 0; i < num_clks; i++) {
 		struct mpfs_ccc_out_hw_clock *out_hw = &out_hws[i];
-		char *name = devm_kzalloc(dev, 23, GFP_KERNEL);
+		char *name = devm_kasprintf(dev, GFP_KERNEL, "%s_out%u", parent->name, i);
 
 		if (!name)
 			return -ENOMEM;
 
-		snprintf(name, 23, "%s_out%u", parent->name, i);
 		out_hw->divider.hw.init = CLK_HW_INIT_HW(name, &parent->hw, &clk_divider_ops, 0);
 		out_hw->divider.reg = data->pll_base[i / MPFS_CCC_OUTPUTS_PER_PLL] +
 			out_hw->reg_offset;
@@ -201,14 +200,13 @@ static int mpfs_ccc_register_plls(struct device *dev, struct mpfs_ccc_pll_hw_clo
 
 	for (unsigned int i = 0; i < num_clks; i++) {
 		struct mpfs_ccc_pll_hw_clock *pll_hw = &pll_hws[i];
-		char *name = devm_kzalloc(dev, 18, GFP_KERNEL);
 
-		if (!name)
+		pll_hw->name = devm_kasprintf(dev, GFP_KERNEL, "ccc%s_pll%u",
+					      strchrnul(dev->of_node->full_name, '@'), i);
+		if (!pll_hw->name)
 			return -ENOMEM;
 
 		pll_hw->base = data->pll_base[i];
-		snprintf(name, 18, "ccc%s_pll%u", strchrnul(dev->of_node->full_name, '@'), i);
-		pll_hw->name = (const char *)name;
 		pll_hw->hw.init = CLK_HW_INIT_PARENTS_DATA_FIXED_SIZE(pll_hw->name,
 								      pll_hw->parents,
 								      &mpfs_ccc_pll_ops, 0);
-- 
2.25.1

