Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369A1690DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjBIQE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjBIQEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:04:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76467658EB;
        Thu,  9 Feb 2023 08:04:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D1DAB82195;
        Thu,  9 Feb 2023 16:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FB8C4331D;
        Thu,  9 Feb 2023 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675958655;
        bh=4NI43FI1odeK5NMjk1q4hgRlikJL79bNrNo0FrjEahU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXRCX8yzU2MFIyfUNivWfDugTbqb0quXUUeLBypa8Cc0TaryezddYbZWvRLXwjAE4
         vGdOk0dWOUIARqo5AFQyEkKsnwd0t6Wq7c1vBXeyBTOtr5O4zttxmakN4xXhjiBWCp
         fOrsJxtdETdLZ/Da71a/IoZIufSp9AakaYiuSo5MC6AqrMcNUPwuOxkKSYNKHcZc0B
         28L+YQ8cacBZoithMGGcbv7y+5k/ppZpg8Q+X3BIhGlUNTtQ5k37I8qdKsNjAGIWwe
         j4nxj+l2jIi7WYGxuImIfreNhg3EiD0x0hSAps7Oe6NyhYdZxX4khNo3ZHpYVAt89A
         /QFYFje8wp6zA==
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: [PATCH v1 4/4] Revert "arm64: dts: mt8173: add mmsel clocks for 4K support"
Date:   Thu,  9 Feb 2023 17:03:57 +0100
Message-Id: <20230209160357.19307-4-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209160357.19307-1-matthias.bgg@kernel.org>
References: <20230209160357.19307-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

This reverts commit fc6634ac0e5380aeb1063275a2e9a583d41b2306.

The mmsys is a clock provider but does not have any clocks connected to
it. Therefore assigned-clock properties should be applied to the users of mmsys.

This fixes the DT schema check:
mediatek/mt8173-elm.dtb: syscon@14000000: 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index c47d7d900f283..b753547e250fe 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -988,8 +988,6 @@ mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8173-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
-			assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
-			assigned-clock-rates = <400000000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
-- 
2.39.0

