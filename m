Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFE1742C10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjF2Sn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjF2Sno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:43:44 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757AF2D55;
        Thu, 29 Jun 2023 11:43:36 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id 92923605D4;
        Thu, 29 Jun 2023 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1688064214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8cdP6cF+nwTWlyfboIiQYyzWM6TGbsre5s255hDw1E=;
        b=OGbX55DGj/xtkG/hWVz4Qo4R1i22zFNmJxp55CTfnwcpyzy+ao4f+YL/q9cUmFsKtmh3WQ
        SfRGV00+DKFU+AFks3cdLH1xvu04AOhJ1j452P0Cwd2PdgQB6gWydKc7cZXbj/KnAUW/gn
        Ox6Nxq39V7ltXPJoF8QFFi+sFdSePNc=
Received: from frank-G5.. (fttx-pool-157.180.227.241.bambit.de [157.180.227.241])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 916DD10009B;
        Thu, 29 Jun 2023 18:43:33 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Eric Woudstra <ericwouds@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: mt7986: fix emmc hs400 mode without uboot initialization
Date:   Thu, 29 Jun 2023 20:43:18 +0200
Message-Id: <20230629184318.551317-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629184318.551317-1-linux@fw-web.de>
References: <20230629184318.551317-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 79a3025b-a2bb-4026-a6d2-40902656f0e4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Woudstra <ericwouds@gmail.com>

Eric reports errors on emmc with hs400 mode when booting linux on bpi-r3
without uboot [1]. Booting with uboot does not show this because clocks
seem to be initialized by uboot.

Fix this by adding assigned-clocks and assigned-clock-parents like it's
done in uboot [2].

[1] https://forum.banana-pi.org/t/bpi-r3-kernel-fails-setting-emmc-clock-to-416m-depends-on-u-boot/15170
[2] https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/mt7986.dtsi#L287

Cc: stable@vger.kernel.org
Fixes: 513b49d19b34 ("arm64: dts: mt7986: add mmc related device nodes")
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 68539ea788df..207510abda89 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -374,6 +374,10 @@ mmc0: mmc@11230000 {
 			reg = <0 0x11230000 0 0x1000>,
 			      <0 0x11c20000 0 0x1000>;
 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			assigned-clocks = <&topckgen CLK_TOP_EMMC_416M_SEL>,
+					  <&topckgen CLK_TOP_EMMC_250M_SEL>;
+			assigned-clock-parents = <&apmixedsys CLK_APMIXED_MPLL>,
+						 <&topckgen CLK_TOP_NET1PLL_D5_D2>;
 			clocks = <&topckgen CLK_TOP_EMMC_416M_SEL>,
 				 <&infracfg CLK_INFRA_MSDC_HCK_CK>,
 				 <&infracfg CLK_INFRA_MSDC_CK>,
-- 
2.34.1

