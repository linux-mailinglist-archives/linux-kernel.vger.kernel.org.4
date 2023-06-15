Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A63731EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbjFORMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbjFORMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:12:01 -0400
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3C91BF9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=SwUrQGtfdJAfbPGuPioQpX3ZwqUQutzSyANTQ3rAAzw=;
        b=AMwf2Hpdyvkd7i69t99g+qZJ9jtyPG9rteVAsinO8lpeNRIbbOB9Y1NHTAqw1kEUboIX
        Wp2ypBdurEoTq1nzyETIhOgWse33pC7/jmORGjvT2ccuTy6Lp75x1OxW1A7sx/QfQRbKm+
        oCw26goRml136PvKzb+ClgRrs1L5xYP4J6VSE3oQpg0GkpGrVfLf7v6ygI92QAQNXu0pfn
        8QbeZFChndwjVbMh9Un6LAL77QrYTbT65UEWvmHKIupaThEQJ4uoZGTh5bQTn4gBMZ5rf+
        o1ABoCJIAhM8tpJ/LNd7zpA+FM7UtgdicRgHwt0Ht89ZepMry/kMdFRM630qEuJg==
Received: by filterdrecv-84b96456cb-6l8hp with SMTP id filterdrecv-84b96456cb-6l8hp-1-648B45FD-25
        2023-06-15 17:10:21.532681887 +0000 UTC m=+3087112.128091413
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-2 (SG)
        with ESMTP
        id A-l5S23OQY-HMDmXz1kwpQ
        Thu, 15 Jun 2023 17:10:21.207 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 4/6] phy/rockchip: inno-hdmi: do not power on rk3328 post
 pll on reg write
Date:   Thu, 15 Jun 2023 17:10:21 +0000 (UTC)
Message-Id: <20230615171005.2251032-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615171005.2251032-1-jonas@kwiboo.se>
References: <20230615171005.2251032-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h444tarc9ufij5dRA?=
 =?us-ascii?Q?eI1cNBIYAT3oqUvqrtRFevHr5kMKRB2WdkvXiol?=
 =?us-ascii?Q?zFWREqpE=2FjoQJRA6K5mU0FvT1bQmfn4z9+iu8Tr?=
 =?us-ascii?Q?7PXSUrh0pjH8Rh7C0fOso=2Ftc4rVvlGnlxouZLaV?=
 =?us-ascii?Q?3n1gkIx2donKFMJeoVnYRwcqRTUTUJlPCQaXaS?=
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Zheng Yang <zhengyang@rock-chips.com>
Cc:     Alex Bee <knaerzche@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>
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

inno_write is used to configure 0xaa reg, that also hold the
POST_PLL_POWER_DOWN bit.
When POST_PLL_REFCLK_SEL_TMDS is configured the power down bit is not
taken into consideration.

Fix this by keeping the power down bit until configuration is complete.
Also reorder the reg write order for consistency.

Fixes: 53706a116863 ("phy: add Rockchip Innosilicon hdmi phy")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3:
- no change

 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index f027e0a2e26b..fe7fa9a43ec0 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -1020,9 +1020,10 @@ inno_hdmi_phy_rk3328_power_on(struct inno_hdmi_phy *inno,
 
 	inno_write(inno, 0xac, RK3328_POST_PLL_FB_DIV_7_0(cfg->fbdiv));
 	if (cfg->postdiv == 1) {
-		inno_write(inno, 0xaa, RK3328_POST_PLL_REFCLK_SEL_TMDS);
 		inno_write(inno, 0xab, RK3328_POST_PLL_FB_DIV_8(cfg->fbdiv) |
 			   RK3328_POST_PLL_PRE_DIV(cfg->prediv));
+		inno_write(inno, 0xaa, RK3328_POST_PLL_REFCLK_SEL_TMDS |
+			   RK3328_POST_PLL_POWER_DOWN);
 	} else {
 		v = (cfg->postdiv / 2) - 1;
 		v &= RK3328_POST_PLL_POST_DIV_MASK;
@@ -1030,7 +1031,8 @@ inno_hdmi_phy_rk3328_power_on(struct inno_hdmi_phy *inno,
 		inno_write(inno, 0xab, RK3328_POST_PLL_FB_DIV_8(cfg->fbdiv) |
 			   RK3328_POST_PLL_PRE_DIV(cfg->prediv));
 		inno_write(inno, 0xaa, RK3328_POST_PLL_POST_DIV_ENABLE |
-			   RK3328_POST_PLL_REFCLK_SEL_TMDS);
+			   RK3328_POST_PLL_REFCLK_SEL_TMDS |
+			   RK3328_POST_PLL_POWER_DOWN);
 	}
 
 	for (v = 0; v < 14; v++)
-- 
2.40.1

