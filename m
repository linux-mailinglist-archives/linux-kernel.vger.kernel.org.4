Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423FD606926
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJTTxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJTTxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:53:03 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2AB211293;
        Thu, 20 Oct 2022 12:53:02 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1olbb8-0005vb-A5; Thu, 20 Oct 2022 21:52:58 +0200
Date:   Thu, 20 Oct 2022 20:52:52 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH] clk: mediatek: fix dependency of MT7986 ADC clocks
Message-ID: <Y1GnFEjOWpplFjqI@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems like CLK_INFRA_ADC_FRC_CK always need to be enabled for
CLK_INFRA_ADC_26M_CK to work. Instead of adding this dependency to the
mtk-thermal and mt6577_auxadc drivers, add dependency to the clock
driver clk-mt7986-infracfg.c.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/clk/mediatek/clk-mt7986-infracfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index d90727a53283c7..49666047bf0ed5 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -153,7 +153,7 @@ static const struct mtk_gate infra_clks[] = {
 		    18),
 	GATE_INFRA1(CLK_INFRA_MSDC_66M_CK, "infra_msdc_66m", "infra_sysaxi_d2",
 		    19),
-	GATE_INFRA1(CLK_INFRA_ADC_26M_CK, "infra_adc_26m", "csw_f26m_sel", 20),
+	GATE_INFRA1(CLK_INFRA_ADC_26M_CK, "infra_adc_26m", "infra_adc_frc", 20),
 	GATE_INFRA1(CLK_INFRA_ADC_FRC_CK, "infra_adc_frc", "csw_f26m_sel", 21),
 	GATE_INFRA1(CLK_INFRA_FBIST2FPC_CK, "infra_fbist2fpc", "nfi1x_sel", 23),
 	/* INFRA2 */
-- 
2.38.1

