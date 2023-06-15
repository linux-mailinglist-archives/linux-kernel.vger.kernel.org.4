Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7FB731EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbjFORNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjFORNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:13:30 -0400
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F488270A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=o8apgBeVbEFf/gdNMBJ4gZ0KNM+6ohNZauAFEg2dmLo=;
        b=SubMU7VgWGD8VuMblD3L94jbFI0WUHEDN638drCogRLHP8ZnaEChBmhy7HmKGZl9w9T6
        rUR+RaFep2gOfa7a2FL/q/GtHGfUF9D8LTsEQTjOcUjD99WdlNuF5CdzE9xgm3ldjhvwT9
        ufbFQc5d2qH6y6RpnMNaRy2LClUsz9cZnch+CCk23tCLt8qa3EhzMR6dA9B28zYDh2wJFX
        5e79mmHLGcg6Dl2CVy3PHWj+LRLwsewTEJHLv2hzWmw7P5JrjWk11c6MHGRL+QQsYnz/5O
        EkCm9nE+qMl4hTUq+DrzOGDlcIifIZ4cJvbrOrklXRCNVsrQeEX9+keb5d83K9NA==
Received: by filterdrecv-77869f68cc-wnrh7 with SMTP id filterdrecv-77869f68cc-wnrh7-1-648B45FE-46
        2023-06-15 17:10:22.884889446 +0000 UTC m=+3087262.537319377
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-2 (SG)
        with ESMTP
        id XoJ-0orTTC-S_Ki4s1EU2A
        Thu, 15 Jun 2023 17:10:22.683 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 5/6] phy/rockchip: inno-hdmi: force set_rate on power_on
Date:   Thu, 15 Jun 2023 17:10:23 +0000 (UTC)
Message-Id: <20230615171005.2251032-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615171005.2251032-1-jonas@kwiboo.se>
References: <20230615171005.2251032-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h2VJzEQeUwe5Z84gV?=
 =?us-ascii?Q?AySJJvspWIh+Zfn4vnFh5NfVIXakuzGVhSpi4+m?=
 =?us-ascii?Q?WuIvbNPS+EcF=2FO2cKst8p1=2FD0VNif4EupEx4XYR?=
 =?us-ascii?Q?nBHg+UwfvLSvc=2F3gobUygRxrIGZi9twEIrjSR3h?=
 =?us-ascii?Q?K27uyf81BRrdC1nK7JPWvFzXpWphCgFcS+eymO?=
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Huicong Xu <xhc@rock-chips.com>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huicong Xu <xhc@rock-chips.com>

Regular 8-bit and Deep Color video formats mainly differ in TMDS rate and
not in pixel clock rate.
When the hdmiphy clock is configured with the same pixel clock rate using
clk_set_rate() the clock framework do not signal the hdmi phy driver
to set_rate when switching between 8-bit and Deep Color.
This result in pre/post pll not being re-configured when switching between
regular 8-bit and Deep Color video formats.

Fix this by calling set_rate in power_on to force pre pll re-configuration.

Signed-off-by: Huicong Xu <xhc@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3:
- no change

 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index fe7fa9a43ec0..a1fb39af6493 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -245,6 +245,7 @@ struct inno_hdmi_phy {
 	struct clk_hw hw;
 	struct clk *phyclk;
 	unsigned long pixclock;
+	unsigned long tmdsclock;
 };
 
 struct pre_pll_config {
@@ -485,6 +486,8 @@ static int inno_hdmi_phy_power_on(struct phy *phy)
 
 	dev_dbg(inno->dev, "Inno HDMI PHY Power On\n");
 
+	inno->plat_data->clk_ops->set_rate(&inno->hw, inno->pixclock, 24000000);
+
 	ret = clk_prepare_enable(inno->phyclk);
 	if (ret)
 		return ret;
@@ -509,6 +512,8 @@ static int inno_hdmi_phy_power_off(struct phy *phy)
 
 	clk_disable_unprepare(inno->phyclk);
 
+	inno->tmdsclock = 0;
+
 	dev_dbg(inno->dev, "Inno HDMI PHY Power Off\n");
 
 	return 0;
@@ -628,6 +633,9 @@ static int inno_hdmi_phy_rk3228_clk_set_rate(struct clk_hw *hw,
 	dev_dbg(inno->dev, "%s rate %lu tmdsclk %lu\n",
 		__func__, rate, tmdsclock);
 
+	if (inno->pixclock == rate && inno->tmdsclock == tmdsclock)
+		return 0;
+
 	cfg = inno_hdmi_phy_get_pre_pll_cfg(inno, rate);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
@@ -670,6 +678,7 @@ static int inno_hdmi_phy_rk3228_clk_set_rate(struct clk_hw *hw,
 	}
 
 	inno->pixclock = rate;
+	inno->tmdsclock = tmdsclock;
 
 	return 0;
 }
@@ -781,6 +790,9 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 	dev_dbg(inno->dev, "%s rate %lu tmdsclk %lu\n",
 		__func__, rate, tmdsclock);
 
+	if (inno->pixclock == rate && inno->tmdsclock == tmdsclock)
+		return 0;
+
 	cfg = inno_hdmi_phy_get_pre_pll_cfg(inno, rate);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
@@ -820,6 +832,7 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 	}
 
 	inno->pixclock = rate;
+	inno->tmdsclock = tmdsclock;
 
 	return 0;
 }
-- 
2.40.1

