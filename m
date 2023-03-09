Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E50F6B20B9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjCIJyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCIJyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:54:11 -0500
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F10A630E98
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:54:06 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 4CBA972069D;
        Thu,  9 Mar 2023 10:53:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1678355597;
        bh=hPqrMI6Nr+Y1BVEsS0lL7I30RcWh2pMitvWJTo4um/M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=hItWETM3QszGQChriEl3FeAxohRxKiR8WAJzo+RWPQXQaQVWxEr5O/rh4uQV9tYOM
         25b8P4oZqg24hJyGVSs/ypDyiozXBzZVLkRXo8Qy4pUdcyY17cLWUQlq1L44+Ut4Ny
         LvgnuOzbza6tgUb00HiUgXuuUh81XuroNUZWPn1YGyfRFImTQ6mz7emSb1GvLit5Nh
         fXTk4OBT6+T1m6V+jWlanQCXSaHd9gmbymfO0/pwr7RvZfZHjtAq6pIcdpUxnc2NIc
         DohAHv6nLpE+cUwmfDlRTCqiuHeadpyZopESQfu1YoRMsPHWj0UiprlQfO0DdRP5tE
         FJGQaZ8EvEbtQ==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 9 Mar 2023 10:22:57 +0100
Received: from Stretch-CN.dh-electronics.org (10.64.6.116) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Thu, 9 Mar 2023 10:22:57 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Date:   Thu, 9 Mar 2023 10:22:54 +0100
Message-ID: <20230309092254.56279-3-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
References: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the use of IRQ optional to make the DA9061/62 usable
for designs that don't have the IRQ pin connected, because the regulator
is usable without IRQ.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@intel.com/
---
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Rebase on current next 20230209
    - Add Reviewed-by and Acked-by tags
V3: - Rebase on current next 20230307
v4: - Rebase on current next 20230309
    - Fix a missing variable change reported by kernel test robot
---
 drivers/regulator/da9062-regulator.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 1a6324001027..ae7955afce86 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -924,7 +924,7 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	struct da9062_regulator *regl;
 	struct regulator_config config = { };
 	const struct da9062_regulator_info *rinfo;
-	int irq, n, ret;
+	int n, ret;
 	int max_regulators;
 
 	switch (chip->chip_type) {
@@ -1012,12 +1012,11 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	}
 
 	/* LDOs overcurrent event support */
-	irq = platform_get_irq_byname(pdev, "LDO_LIM");
-	if (irq < 0)
-		return irq;
-	regulators->irq_ldo_lim = irq;
+	regulators->irq_ldo_lim = platform_get_irq_byname_optional(pdev, "LDO_LIM");
+	if (regulators->irq_ldo_lim < 0)
+		return 0;
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq,
+	ret = devm_request_threaded_irq(&pdev->dev, regulators->irq_ldo_lim,
 					NULL, da9062_ldo_lim_event,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					"LDO_LIM", regulators);
-- 
2.11.0

