Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9D561E35D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiKFQPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKFQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:15:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048226273;
        Sun,  6 Nov 2022 08:15:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9536B60C99;
        Sun,  6 Nov 2022 16:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECD0C433D6;
        Sun,  6 Nov 2022 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667751319;
        bh=FbLISYc+tCx9bORuK7HTC44fJsuZf4FUlfuVM5oFnB0=;
        h=From:To:Cc:Subject:Date:From;
        b=An+Fvj3T4KVMz0MzSpXzyc3HtdizksxaU7d1CrP97neOo84uokPuoDTV8UGyQ2Z5b
         NPKLtKoze+mdNGmszyy2b707IdE3GSusYukPdK3gIUQ9tzn4kLQqYHLQb7o6puMMS/
         yl4FtsGrqwO8qhLd5IZNvsThy2vVcdfr8DvrxlUWn7dgzpZRxJkXX3/UJdtq6gyhcp
         FF8LQpXbEMKrfQKQ6clI1zU+ndgD5poP25KVPdMUbWmx34VivqCFGWvQEFaqJz3K+b
         ICOoXxUEOzAPZ75HY/AWHuogoWyb6w2DHefu/jhiNmZ7kKsHLPJWO5XJStaMFoIQRM
         jRZCoCP+zXv/A==
Received: by wens.tw (Postfix, from userid 1000)
        id 1E8735FB95; Mon,  7 Nov 2022 00:15:16 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Fix Pine64 Quartz4-B PMIC interrupt
Date:   Mon,  7 Nov 2022 00:15:13 +0800
Message-Id: <20221106161513.4140-1-wens@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Ths PMIC's interrupt line is tied to GPIO0_A3. This is described
correctly for the pinmux setting, but incorrectly for the interrupt.

Correct the interrupt setting so that interrupts from the PMIC get
delivered.

Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B device tree")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index 77b179cd20e7..b276eb0810c7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -246,7 +246,7 @@ rk809: pmic@20 {
 		compatible = "rockchip,rk809";
 		reg = <0x20>;
 		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
 		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
 		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
 		clock-names = "mclk";
-- 
2.34.1

