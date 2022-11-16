Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC1A62C97F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiKPUD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiKPUDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:03:08 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AACA66C8F;
        Wed, 16 Nov 2022 12:02:58 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y13so18511999pfp.7;
        Wed, 16 Nov 2022 12:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU5Mwb4CLrFeMhe4gtPSXHFZzIZzSCF10R2Jay+I0+Y=;
        b=fZt/DptU/WyyXomIIYhusRu/ggtb7lQmge+tN9aC26JOHUiotfJ6pNPE0sOZsXFlHA
         SgeDoeiwbjAZfkgqTVCECcv7sWywKNuPLRdXB2lRWWgg1k051QO2wO27w3GpXYG67DmI
         FBc61+kKx9u3T8aPUbm4mWTchGz3YT6lsXgp6Ikq8d/gCmzPV1sum84ZZ8KtlSWELjkp
         s9JSmZIn2Qu5zRciJVrRw9g0Br1hI3QpPZLRyl6iZ3/4k0Cy16ZuG9/RVTWW1T4dZMma
         PQENYUq9QG6GJX+VI+8yQwhjbChPWtHurVy20PsG4eSo+W5qreGGu90lFrtHhMBdfTj2
         NvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dU5Mwb4CLrFeMhe4gtPSXHFZzIZzSCF10R2Jay+I0+Y=;
        b=55UlpKXrU8s5UcfxL/7xezdkkYCL50giCgRA5XsLitFXUKTQi3q6alnVv+8WLTnxLg
         vhDJtqFmCkju5qyu9Y17XH3L1UNwHqvog2tP/xmp/tTcpT/O4o71ctDgXCi2V3Pu8qmd
         GjGQ58tsMmigC9pZhKKwanR82vBkiLYTbW3nqz3o/SVjHmQ6bgeLLQA0sxqpFUCkoq/Y
         rqDsqnVdqiTA42/hYrnIJzlbdFTG9/x7j1TT92I04/XeMe2ku5E0jUlnJYg/GRWuEVVL
         XGudCLiwQBtG0Duxyu1KgHRb5lqpcgZXadNcBaHWpWsDpGOVGWKkq4ID0LCDNvIJxs8V
         qWpQ==
X-Gm-Message-State: ANoB5plAM/M29ka4M9tdqEPEknhTasR5sUb/5eMfOJcASDaV0sDPOGN2
        hM+MdYC8DYrfNFa9f/N6DNw=
X-Google-Smtp-Source: AA0mqf65fkbouqf7pu70romJDYuiqQRkWpQa9l+BjQMgcgn/bj4rOIJ3+Bmx2ZNSZkKx+2HoKXBR6A==
X-Received: by 2002:a05:6a00:3689:b0:563:3d81:7faf with SMTP id dw9-20020a056a00368900b005633d817fafmr24476557pfb.45.1668628978034;
        Wed, 16 Nov 2022 12:02:58 -0800 (PST)
Received: from localhost.localdomain ([103.51.72.182])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b00186a6b6350esm12423950ple.268.2022.11.16.12.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:02:57 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [linux-next-v2 5/5] arm64: dts: rockchip: Add missing of ethernet-phy-id to reset the phy on Rock 3A SBC
Date:   Wed, 16 Nov 2022 20:01:48 +0000
Message-Id: <20221116200150.4657-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116200150.4657-1-linux.amoon@gmail.com>
References: <20221116200150.4657-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MDIO description with ethernet-phy-id compatible string
which enable calling reset of the phy. The PHY will then be probed,
independent of if it can be found on the bus or not,
and that probing will enable the GPIO.

ethernet-phy-id is read from ethenet register dump reg2 and reg3.

Fix following warning.
[   12.323417] rk_gmac-dwmac fe010000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
[   12.324078] rk_gmac-dwmac fe010000.ethernet eth0: no phy at addr -1
[   12.324099] rk_gmac-dwmac fe010000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V2: new to the patch series.

alarm@rock-3a:~$ sudo ethtool -d eth0
[sudo] password for alarm:
ST GMAC Registers
GMAC Registers
Reg0  0x08072203
Reg1  0x00000000
Reg2  0x00000404
Reg3  0x00000000
Reg4  0x00000002
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 9f84a23a8789..fe36156a5017 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -585,7 +585,7 @@ &i2s2_2ch {
 
 &mdio1 {
 	rgmii_phy1: ethernet-phy@0 {
-		compatible = "ethernet-phy-ieee802.3-c22";
+		compatible = "ethernet-phy-id0000.0404", "ethernet-phy-ieee802.3-c22";
 		reg = <0x0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&eth_phy_rst>, <&eth_phy_int>;
-- 
2.38.1

