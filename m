Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5A37349A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFSBKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSBKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:10:14 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586DE1B0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 18:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1687137006; bh=l1Av13OOBeHvZ6hhVrMrrY1JviPoUrwczfkLMItzFNU=;
        h=From:To:Cc:Subject:Date:From;
        b=v1GWcFzR9GXrM78ith3aTO2L3gwShkuGbtZcQitGAWjKjPiIG8QMtzxBAEzVIKr5s
         AE+7K9ITO/vaFMj+gIME6QDFFf9xirUQTYL7fISoQT1pUXU5Hk7p9jYqn2ms8C1mI/
         wZFoZqj11dtT0Zy4eI1IoJMuxNV2P9qo2FKX57xY=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     linux-rockchip@lists.infradead.org
Cc:     Ondrej Jirman <megi@xff.cz>, Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] soc: rockchip: grf: Fix SDMMC not working on RK3588 with bus-width > 1
Date:   Mon, 19 Jun 2023 03:09:58 +0200
Message-ID: <20230619011002.2249960-1-megi@xff.cz>
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

From: Ondrej Jirman <megi@xff.cz>

RK3588 has the same issue as other earlier RK SoCs. JTAG
functionality muxed to some SDMMC data pins causes issues with SDMMC
interface. Without this patch, I can only use SDMMC inteface
with bus-width = <1>. (JTAG is muxed to data pins D2 and D3)

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/soc/rockchip/grf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 15a3970e3509..d768c5a70174 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -121,6 +121,17 @@ static const struct rockchip_grf_info rk3566_pipegrf __initconst = {
 	.num_values = ARRAY_SIZE(rk3566_defaults),
 };
 
+#define RK3588_GRF_SOC_CON6		0x0318
+
+static const struct rockchip_grf_value rk3588_defaults[] __initconst = {
+	{ "jtag switching", RK3588_GRF_SOC_CON6, HIWORD_UPDATE(0, 1, 14) },
+};
+
+static const struct rockchip_grf_info rk3588_sysgrf __initconst = {
+	.values = rk3588_defaults,
+	.num_values = ARRAY_SIZE(rk3588_defaults),
+};
+
 
 static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
 	{
@@ -147,6 +158,9 @@ static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
 	}, {
 		.compatible = "rockchip,rk3566-pipe-grf",
 		.data = (void *)&rk3566_pipegrf,
+	}, {
+		.compatible = "rockchip,rk3588-sys-grf",
+		.data = (void *)&rk3588_sysgrf,
 	},
 	{ /* sentinel */ },
 };
-- 
2.41.0

