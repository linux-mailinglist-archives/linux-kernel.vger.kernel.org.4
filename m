Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2D6FDF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbjEJN56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbjEJN5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:57:53 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB16940C2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683727046; x=1715263046;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BNO8j0t7vrgZ1nvARmVdOCS3hKJzVJZROdkILgcw9ZY=;
  b=WMZK1ybdguumHhgGMj95cE3BzPUbKpHnJzEPbrdqZzd1/O21kqrPNMh8
   e+I5ikO7u0Ue9QnMzdm5U53K224oayA+5Zwcf9gpxY4+zAApchnHuokvR
   P3VfhDBdtcDRvG4+OyK+hfJr5hMMxyYP2gh3ALgKT4f7walxYzWtdpSWp
   2dVQqrczDukCtg6ZVdpDiT6Wue65uv2HoeKSPSVH+ViVmJMo+5p/11mib
   uYvsPmXg44vvWzETJIX4qWHh3kBDJYfQXCRFmWYrRe4y6Touz49konA6B
   X4GxPz5as3BW0kjJoQ0QOJ3VWBSxbDqJWbYPtsNDZ9cgr9hk+By1cE6QP
   g==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677538800"; 
   d="scan'208";a="30832415"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 May 2023 15:57:19 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 10 May 2023 15:57:19 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 10 May 2023 15:57:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683727039; x=1715263039;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BNO8j0t7vrgZ1nvARmVdOCS3hKJzVJZROdkILgcw9ZY=;
  b=lUQprymsvrx/B+2iIGoKZJYQZCA6dT11iY8Gs8Wo+wNji65/71bau6k+
   lTlzhx2wPSo8bbJlKpVbie5TzeQvXfusuudPn5lQA+EcNy6f4FC4XP6Sh
   ERXnLWEt73RNZROt8Y0+pGJvtb+D62ogoxU9NAppFRwKf6WUNsdbowRIk
   0fDRzfE1NkXaNmCWKgmCaaehEA4HUaJ5HHSV0pbVugK58Ao1zwz1euWn4
   WAOKFJ2ItHLnOIUAXUxRTpSSBTOuQrwtPe6cwjW3V6TMGUgkNEqzXr4zS
   AFBj1TWJQFQFM1rO3280pK2jMCbt9008+7mvQQDr6/gzm7onkjaEYUmI7
   A==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677538800"; 
   d="scan'208";a="30832414"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 May 2023 15:57:19 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2841F280056;
        Wed, 10 May 2023 15:57:19 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] regulator: pca9450: Fix BUCK2 enable_mask
Date:   Wed, 10 May 2023 15:57:18 +0200
Message-Id: <20230510135718.2268529-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a copy & paste error.
No functional change intended, BUCK1_ENMODE_MASK equals BUCK2_ENMODE_MASK.

Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
Originally-from: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Explicitly mention in the commit message that there is no functional
  change

This diff is extracted from a downstream commit authored by Robin Gong.

 drivers/regulator/pca9450-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 9d0ed87f7e32..4983163130c6 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -265,7 +265,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
@@ -509,7 +509,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
-- 
2.34.1

