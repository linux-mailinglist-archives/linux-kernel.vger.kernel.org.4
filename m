Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8E2700265
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbjELITm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbjELITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:19:40 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CD01FC8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683879578; x=1715415578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HNvzrh3FezI6IAN3gOCwPdgB08P8jCqMVS6nDIz1CWY=;
  b=jtIRWk6RbGhjN/UOzWbBI6HkeoJyTKqoTjqXQUo5ooRfONKLZLCfZ682
   xXmNlzMZ1gufszV3X4QiGa0dZvrebmUO2XZkZZkv0RuGvKbh9gzy8W7Ce
   rJl1lsxzu7mz7r9nfq7i2Qhs0hVQVS/5kpLTF2g/l3YNxWg/MiE4sn8W9
   Hm80XYeH+NeGR+1+zqEgpZqrHCa/05zaqDToUVQPlKGHhyzBEfWWCpPnV
   gZshADtM056TqEYoz4/dmMRc3NfJRbF0cJZLl/x6+QGKzVtlsPMam6ens
   7ZYbe+jMhNIK8Tn1mrLNJUWh+82S9hod6+Ao7nu9He6T60kIhq1OWpA98
   A==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677538800"; 
   d="scan'208";a="30871215"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 May 2023 10:19:37 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 12 May 2023 10:19:37 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 12 May 2023 10:19:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683879577; x=1715415577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HNvzrh3FezI6IAN3gOCwPdgB08P8jCqMVS6nDIz1CWY=;
  b=pCr9ZekA8CmcxPm7AFo7ed6m88Tz7Z6XFhabgLc34Y4FoXM64kxxMw/n
   ea5Lrg3wwWlI/WTEoafQzye2cOXXFRidAgzp5BvqQTrUrZcF51wsxBcuS
   +xg4WUNjFZzKnhYsbbqN8vbEJIhwwztBFWziVtfeSxkicpKAaA7Wc+7mM
   g0U/ws7keL7mOU0YiCL+a3LS+o4tWLFgDtnCOjtCJ8JOq4HZC28JVcihM
   NnXNRzMH7ceynM52Fx6plb3o7aJDpFN6FRBYR+rEy3iZBFesaKzOcecqM
   L+cNubaM2gnRX51IKNtv2Mu4icNufnTvY/11Ov+AX4jExrmUt77vHFnTa
   A==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677538800"; 
   d="scan'208";a="30871214"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 May 2023 10:19:37 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id D84F9280056;
        Fri, 12 May 2023 10:19:36 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] regulator: pca9450: Fix BUCK2 enable_mask
Date:   Fri, 12 May 2023 10:19:34 +0200
Message-Id: <20230512081935.2396180-1-alexander.stein@ew.tq-group.com>
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
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v3:
* Added Frieder's R-b
* Rebase directly onto next-20230512

 drivers/regulator/pca9450-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 9f2e33a5a69e..91bfb7e026c9 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -264,7 +264,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
@@ -502,7 +502,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
-- 
2.34.1

