Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EA55EB97C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiI0FSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI0FSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:18:21 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D036298C8B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 22:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
        Content-Description:In-Reply-To:References:X-Debbugs-Cc;
        bh=DsO5pFYkK1Xjq0k4TZbE63CczW4L418+61sZYoyHZ0A=; b=ZYWzLATh11Vhw8dI5JY+sxclR4
        t9mzZ7yB4GDSEwIkS6EpkRp1dG8XH9E6RPR1qkObD7rwY5M7nMrh/9NZUUMydOQ3htnDyCh4CY+xQ
        vYojP4GShxCLH3zwcKGfZOqqFwYALkS673E738Nvg6G6m2e2wpLBVj8636miZpxkM8qsJzaHC2vc/
        m0G9MHNfjWcIs9zj3Ob0t0wSYM1o5f6devt2wg22+Wv5dCqmyjhrPkfHO59CBPweTOHhnTS6coOB2
        csxR3EYrBC+BLpT3nS9ddPUFyhwsTCDLYzAYZvFHIjqFi+3DOa48992br4C/qk5EWlq8SxSvkQMWj
        u4LX+rJg==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1od2yv-00BU7b-AK; Tue, 27 Sep 2022 07:18:09 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1od2yu-000Doj-1P;
        Tue, 27 Sep 2022 07:18:08 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] phy: rockchip-snps-pcie3: only look for rockchip,pipe-grf on rk3588
Date:   Tue, 27 Sep 2022 07:17:52 +0200
Message-Id: <20220927051752.53089-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rockchip,pipe-grf property is only used on rk3588, but not on
rk3568. Therefore this property is not present on rk3568 devices,
leading to the following message:

  rockchip-snps-pcie3-phy fe8c0000.phy: failed to find rockchip,pipe_grf regmap

Fix that by only looking for this property on rk3588.

Fixes: 2e9bffc4f713d ("phy: rockchip: Support PCIe v3")
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index 1917edda6b47..1dc12eb8dfd3 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -257,10 +257,15 @@ static int rockchip_p3phy_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->phy_grf);
 	}
 
-	priv->pipe_grf = syscon_regmap_lookup_by_phandle(dev->of_node,
-							 "rockchip,pipe-grf");
-	if (IS_ERR(priv->pipe_grf))
-		dev_info(dev, "failed to find rockchip,pipe_grf regmap\n");
+	if (of_device_is_compatible(np, "rockchip,rk3588-pcie3-phy")) {
+		priv->pipe_grf =
+			syscon_regmap_lookup_by_phandle(dev->of_node,
+							"rockchip,pipe-grf");
+		if (IS_ERR(priv->pipe_grf))
+			dev_info(dev, "failed to find rockchip,pipe_grf regmap\n");
+	} else {
+		priv->pipe_grf = NULL;
+	}
 
 	priv->num_lanes = of_property_read_variable_u32_array(dev->of_node, "data-lanes",
 							     priv->lanes, 2,
-- 
2.35.1

