Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9891B60949C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiJWQIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJWQIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:08:04 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2986A5BCB7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1666541278; bh=Xqe11Ibqu1NMh5rur/Ihh+EKSfXa12WMvQt557WAbbY=;
        h=From:To:Cc:Subject:Date:From;
        b=C7R1LepSst+u0rs2BWjVoU/OgTNul4lRGyCMQgdXH/iuYd1xPpgj29NwV5AT2T95A
         dDivamyUv51VfefpUpwDdaxiIax1TAPHjawjkw1u42EItsmM0RkZua5xlASwThYL0f
         7KSk+LpLgTkW3HY7EBBPHufiphKpFKK+cv/wSD1c=
From:   Ondrej Jirman <megi@xff.cz>
To:     linux-rockchip@lists.infradead.org
Cc:     Ondrej Jirman <megi@xff.cz>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Morgan <macromorgan@hotmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ROCKCHIP),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/rockchip: dsi: Fix VOP selection on SoCs that support it
Date:   Sun, 23 Oct 2022 18:07:47 +0200
Message-Id: <20221023160747.607943-1-megi@xff.cz>
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

lcdsel_grf_reg is defined as u32, so "< 0" comaprison is always false,
which breaks VOP selection on eg. RK3399. Compare against 0.

Fixes: f3aaa6125b6f ("drm/rockchip: dsi: add rk3568 support")
Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 7d50a4f463d9..2982a4e9a6ed 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -760,7 +760,7 @@ static void dw_mipi_dsi_rockchip_config(struct dw_mipi_dsi_rockchip *dsi)
 static void dw_mipi_dsi_rockchip_set_lcdsel(struct dw_mipi_dsi_rockchip *dsi,
 					    int mux)
 {
-	if (dsi->cdata->lcdsel_grf_reg < 0)
+	if (dsi->cdata->lcdsel_grf_reg)
 		regmap_write(dsi->grf_regmap, dsi->cdata->lcdsel_grf_reg,
 			mux ? dsi->cdata->lcdsel_lit : dsi->cdata->lcdsel_big);
 }
@@ -1643,7 +1643,6 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
 	{
 		.reg = 0xfe060000,
-		.lcdsel_grf_reg = -1,
 		.lanecfg1_grf_reg = RK3568_GRF_VO_CON2,
 		.lanecfg1 = HIWORD_UPDATE(0, RK3568_DSI0_SKEWCALHS |
 					  RK3568_DSI0_FORCETXSTOPMODE |
@@ -1653,7 +1652,6 @@ static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
 	},
 	{
 		.reg = 0xfe070000,
-		.lcdsel_grf_reg = -1,
 		.lanecfg1_grf_reg = RK3568_GRF_VO_CON3,
 		.lanecfg1 = HIWORD_UPDATE(0, RK3568_DSI1_SKEWCALHS |
 					  RK3568_DSI1_FORCETXSTOPMODE |
-- 
2.38.1

