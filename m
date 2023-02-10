Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB55692A64
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjBJWoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjBJWn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:43:58 -0500
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FD1840CB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676069004; bh=Fv7mdRF7zrNYaJl5woVp1AOj9fUSqYs11PzimZb+a/g=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=qZZ3sezLnixcvTQCrbSIpe0uyU1jvFK2NdrLRDb1UniXiboT5EyHcdp1Yoid5ynpS
         F4u3tyJkRxuUcgazaQv5rPj1Nd2vdKr4QtbJDRupifBsEmAcsWysdBaVKq7Xk6qyX5
         2dBU2hCc6tFLqd48HurfVGiL44vHX+02BQ2M5Peu2vxNDcb0Dkli9Zk774lns3eCag
         3NnLg0TSBhaJZhgMPOto0zqXHv7BhiNVep4CjmTnHnpwFlClO0ukFk+zkkW2/t3DEt
         5pyQ1hLECpNbimMFRvRGfpCQigAZ+8TnM6y24B7kdJ01csKm/OALCcfD4ppo0QqnDG
         SzvcGeLGeReRw==
Received: from localhost (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 7FFF95005A5;
        Fri, 10 Feb 2023 22:43:23 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Alain Volmat <avolmat@me.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: st: miphy28lp: use _poll_timeout functions for waits
Date:   Fri, 10 Feb 2023 23:43:08 +0100
Message-Id: <20230210224309.98452-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rwSaJ4iJr33dmSTHIojCHJT7tlX8GQwb
X-Proofpoint-GUID: rwSaJ4iJr33dmSTHIojCHJT7tlX8GQwb
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2020-02-14=5F02,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=851
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302100195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces _poll_timeout functions usage instead of
wait loops waiting for a status bit.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/phy/st/phy-miphy28lp.c | 42 ++++++++--------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
index 068160a34f5c..e30305b77f0d 100644
--- a/drivers/phy/st/phy-miphy28lp.c
+++ b/drivers/phy/st/phy-miphy28lp.c
@@ -9,6 +9,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -484,19 +485,11 @@ static inline void miphy28lp_pcie_config_gen(struct miphy28lp_phy *miphy_phy)
 
 static inline int miphy28lp_wait_compensation(struct miphy28lp_phy *miphy_phy)
 {
-	unsigned long finish = jiffies + 5 * HZ;
 	u8 val;
 
 	/* Waiting for Compensation to complete */
-	do {
-		val = readb_relaxed(miphy_phy->base + MIPHY_COMP_FSM_6);
-
-		if (time_after_eq(jiffies, finish))
-			return -EBUSY;
-		cpu_relax();
-	} while (!(val & COMP_DONE));
-
-	return 0;
+	return readb_relaxed_poll_timeout(miphy_phy->base + MIPHY_COMP_FSM_6,
+					  val, val & COMP_DONE, 1, 5 * USEC_PER_SEC);
 }
 
 
@@ -805,7 +798,6 @@ static inline void miphy28lp_configure_usb3(struct miphy28lp_phy *miphy_phy)
 
 static inline int miphy_is_ready(struct miphy28lp_phy *miphy_phy)
 {
-	unsigned long finish = jiffies + 5 * HZ;
 	u8 mask = HFC_PLL | HFC_RDY;
 	u8 val;
 
@@ -816,21 +808,14 @@ static inline int miphy_is_ready(struct miphy28lp_phy *miphy_phy)
 	if (miphy_phy->type == PHY_TYPE_SATA)
 		mask |= PHY_RDY;
 
-	do {
-		val = readb_relaxed(miphy_phy->base + MIPHY_STATUS_1);
-		if ((val & mask) != mask)
-			cpu_relax();
-		else
-			return 0;
-	} while (!time_after_eq(jiffies, finish));
-
-	return -EBUSY;
+	return readb_relaxed_poll_timeout(miphy_phy->base + MIPHY_STATUS_1,
+					  val, (val & mask) == mask, 1,
+					  5 * USEC_PER_SEC);
 }
 
 static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
 {
 	struct miphy28lp_dev *miphy_dev = miphy_phy->phydev;
-	unsigned long finish = jiffies + 5 * HZ;
 	u32 val;
 
 	if (!miphy_phy->osc_rdy)
@@ -839,17 +824,10 @@ static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
 	if (!miphy_phy->syscfg_reg[SYSCFG_STATUS])
 		return -EINVAL;
 
-	do {
-		regmap_read(miphy_dev->regmap,
-				miphy_phy->syscfg_reg[SYSCFG_STATUS], &val);
-
-		if ((val & MIPHY_OSC_RDY) != MIPHY_OSC_RDY)
-			cpu_relax();
-		else
-			return 0;
-	} while (!time_after_eq(jiffies, finish));
-
-	return -EBUSY;
+	return regmap_read_poll_timeout(miphy_dev->regmap,
+					miphy_phy->syscfg_reg[SYSCFG_STATUS],
+					val, val & MIPHY_OSC_RDY, 1,
+					5 * USEC_PER_SEC);
 }
 
 static int miphy28lp_get_resource_byname(struct device_node *child,
-- 
2.34.1

