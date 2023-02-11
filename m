Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223D4692F69
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 09:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBKIib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 03:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBKIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 03:38:28 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050B25BA6F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 00:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676104690; bh=U0bKiaplq61Guco79TNwC8jVqUG+62euLMzSu2HFW/E=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Pz7yfvE06NvAn06ClytV36vxnns3qn4pwWFg6ukFF3WLSwu9Wp/6XjLEVCJ1kSy/x
         t2IJurv8jQHjT/JN9IyBMblD7Vuk2EgSyPj2nsyXJWhN/wmCiNfKuxAlHTdiahBWZD
         vkgeDWvLPqzCosQ/zHgbrVZjTRBMvuuxwFoo2h6k=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 11 Feb 2023 09:38:10 +0100 (CET)
X-EA-Auth: rxPHzydya74rNLfmWzY+3kywbYLb5v43p16ZTDUoViOi8+cybvmA2qhJ+KsI13qPlokEhk0suKdVkZJQEQ1xdAncVGVkb6PD
Date:   Sat, 11 Feb 2023 14:08:01 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] soc: brcmstb: pm-arm: Remove duplicate/repeating constant
Message-ID: <Y+dT6du6Nysyd8/t@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constant DDR_PHY_RST_N is unnecessarily or'ed with itself. Remove
the redundant constant from the expression.
Issue identified using doublebitand.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: I was unable to build the change though I had the appropriate
config, arch and  cross compiler. I used the following:
	.config = bmips_stb_defconfig
	ARCH=mips
	CROSS_COMPILE=/usr/bin/mips-linux-gnu-
	BRCMSTB_PM=y

Let me know what I missed so I can build the objects myself. Thank you.


 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index d681cd24c6e1..633e715446f7 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -288,7 +288,7 @@ static inline void s5entry_method1(void)
 		/* Step 3: Channel A (RST_N = CKE = 0) */
 		tmp = readl_relaxed(ctrl.memcs[i].ddr_phy_base +
 				  ctrl.phy_a_standby_ctrl_offs);
-		tmp &= ~(DDR_PHY_RST_N | DDR_PHY_RST_N);
+		tmp &= ~DDR_PHY_RST_N;
 		writel_relaxed(tmp, ctrl.memcs[i].ddr_phy_base +
 			     ctrl.phy_a_standby_ctrl_offs);
 
@@ -296,7 +296,7 @@ static inline void s5entry_method1(void)
 		if (ctrl.phy_b_standby_ctrl_offs != DDR_PHY_NO_CHANNEL) {
 			tmp = readl_relaxed(ctrl.memcs[i].ddr_phy_base +
 					  ctrl.phy_b_standby_ctrl_offs);
-			tmp &= ~(DDR_PHY_RST_N | DDR_PHY_RST_N);
+			tmp &= ~DDR_PHY_RST_N;
 			writel_relaxed(tmp, ctrl.memcs[i].ddr_phy_base +
 				     ctrl.phy_b_standby_ctrl_offs);
 		}
-- 
2.34.1



