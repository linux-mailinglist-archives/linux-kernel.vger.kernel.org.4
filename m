Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898A36780E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjAWQG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjAWQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:06:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0EAD529;
        Mon, 23 Jan 2023 08:06:23 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 270926602E39;
        Mon, 23 Jan 2023 16:06:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674489982;
        bh=a//s0VQPI4VdLC1yskDrbe3IDSo3z5asw/jCKWGhMlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3V1YsI/b+cbffNHubYqbr0HJ7rUbYaejxLw+JGWCgYDdM4NWGo0N/D08482o4TqI
         Q7R9Lgt+M023xCUnAiQW3HEviuOqk69dXNzV4ufWXNyeu2bsGKhruDo+bTCOmEEge0
         XNdHYZvCYM6D5fd5MjSgG5CET4ba2iqhmaL5xOuzGhhZg/41scThqm58W/HPG/1m/h
         DpRqNnV9teGc9T/zLhYqu0wF63mlmAgNUuZcPofkwCBGTPJyUlbQuuSR2a0JwCqCRi
         QNSOCcBPUNP61fNPQT1XTA5TvaOp/SmZuLGfROcw6GrKnoRbNit1RyeEcXivfrdb1A
         6yW8j4K1va6JQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        weiqing.kong@mediatek.com, jitao.shi@mediatek.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/2] pwm: mtk-disp: Configure double buffering before reading in .get_state()
Date:   Mon, 23 Jan 2023 17:06:15 +0100
Message-Id: <20230123160615.375969-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
References: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DISP_PWM controller's default behavior is to always use register
double buffering: all reads/writes are then performed on shadow
registers instead of working registers and this becomes an issue
in case our chosen configuration in Linux is different from the
default (or from the one that was pre-applied by the bootloader).

An example of broken behavior is when the controller is configured
to use shadow registers, but this driver wants to configure it
otherwise: what happens is that the .get_state() callback is called
right after registering the pwmchip and checks whether the PWM is
enabled by reading the DISP_PWM_EN register;
At this point, if shadow registers are enabled but their content
was not committed before booting Linux, we are *not* reading the
current PWM enablement status, leading to the kernel knowing that
the hardware is actually enabled when, in reality, it's not.

The aforementioned issue emerged since this driver was fixed with
commit 0b5ef3429d8f ("pwm: mtk-disp: Fix the parameters calculated
by the enabled flag of disp_pwm") making it to read the enablement
status from the right register.

Configure the controller in the .get_state() callback to avoid
this desync issue and get the backlight properly working again.

Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pwm/pwm-mtk-disp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 82b430d881a2..fe9593f968ee 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -196,6 +196,16 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
 		return err;
 	}
 
+	/*
+	 * Apply DISP_PWM_DEBUG settings to choose whether to enable or disable
+	 * registers double buffer and manual commit to working register before
+	 * performing any read/write operation
+	 */
+	if (mdp->data->bls_debug)
+		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
+					 mdp->data->bls_debug_mask,
+					 mdp->data->bls_debug_mask);
+
 	rate = clk_get_rate(mdp->clk_main);
 	con0 = readl(mdp->base + mdp->data->con0);
 	con1 = readl(mdp->base + mdp->data->con1);
-- 
2.39.0

