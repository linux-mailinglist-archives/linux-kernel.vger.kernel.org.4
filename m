Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE73573113A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbjFOHrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245171AbjFOHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:47:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0496DE69;
        Thu, 15 Jun 2023 00:47:09 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A548E6606F5A;
        Thu, 15 Jun 2023 08:47:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686815228;
        bh=INbAkaTkqa0MJxcHxqulN2VnoNlZzC16MoB2u0RY2YI=;
        h=From:To:Cc:Subject:Date:From;
        b=LsZ2eID+Ql8YnSljnLZg+w7emxAC5F45c/bvjMsh+4YhC3FOIKmvLSE13s89x4MXh
         aPaSGRx7SGV0X7Xf0Y1jo/HxG8XoLVMHTjUkuKc1hO6yGU/bYtiFB0vlF3zx2MbAsv
         M9jItEzs3N705jPLRFv29XgKwoBFkU5jF+FrhyqNQI3MwE/upOo6JP+yE49jpD31VY
         pCZvVPO1//s9x7+jENzES18fZDwlDCNWkAMcwQuu7LcqZnIGXAl5JFFjG+Jlk7y193
         f2KBwbpcQSZm/OF5MQp5OnEP9wnksCzF9aPwNRamswiKLZs7IrY+Oq6S+H6LSES5EN
         dKWDgxeUJdzog==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chaotian.jing@mediatek.com
Cc:     ulf.hansson@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH] mmc: mtk-sd: Set src_clk rate/parent for accurate clock rate
Date:   Thu, 15 Jun 2023 09:47:01 +0200
Message-Id: <20230615074701.34063-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek MSDC controller has an internal divider for the input
(source) clock, but that may not be enough: as there's no multiplier
it is impossible to achieve certain clock rates depending on the
source clock rate.

This is especially seen with the SDR104 mode, where a clock source
typically of 200MHz or 400MHz will make us able to achieve 200MHz
(depending on the SoC's MSDCPLL, this will be more likely ~199MHz)
instead of the optimal 208MHz.

In order to solve this issue and achieve an accurate clock rate
for all modes, call clk_set_rate() on the source clock, so that
the clock framework will either change the PLL's rate or, more
likely, will switch the clock parent to the "best" one.

Since some platforms share one MSDCPLL for multiple MMC/SD "MSDC"
controllers, making sure that shared PLLs won't get their rate
changed (and devices over/underclocked) is obviously done in
the SoC-specific clock drivers, starting with commit
f235f6ae59e5 ("clk: mediatek: Remove CLK_SET_PARENT from all MSDC core clocks").

As an example, on MT8195, an accurate frequency will be achieved
by reparenting of the source clock from msdcpll div2 to univpll
div6-div2, giving out exactly 208000000Hz.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 8ce864169986..e0217783d22d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -886,6 +886,13 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		return;
 	}
 
+	/*
+	 * Select the best clock rate for src_clk: this is done in order
+	 * to save power and/or achieve an accurate rate for DDR52/SDR104.
+	 */
+	clk_set_rate(host->src_clk, hz);
+	host->src_clk_freq = clk_get_rate(host->src_clk);
+
 	flags = readl(host->base + MSDC_INTEN);
 	sdr_clr_bits(host->base + MSDC_INTEN, flags);
 	if (host->dev_comp->clk_div_bits == 8)
-- 
2.40.1

