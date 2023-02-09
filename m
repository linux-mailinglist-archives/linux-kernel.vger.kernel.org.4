Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CF169061C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBILI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBILIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:08:23 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73C64268B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:08:21 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 535EB5E972;
        Thu,  9 Feb 2023 12:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1675940869;
        bh=coWQwRg2rue2zvnmiMjsKb1UY8225zzHmoCBOjlpM6c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=On8IodrYmL27ETqQGCMBYPmwVcLNqksMDQRl8vr8eTwtVCWjNwK4qJKons/XzvSkN
         N9mTgYmerP0hdvKZUiLwn083OeWHQwOl+WI4iLI1xmrJIx2qZH9ISUP4RucbcC4Kqt
         Ybcq3376v6ZWrzbAGU1mNruGEY/cRP93DRu33yMQ1FJTCqNRrzg3Z9Vbbufn6zlGw4
         wckKQOo8RhUgeEVbJni/Lnw+G/FTlmU0dFuo/pH4/MeU7fjZtaFbybZQ8X0dBQCjqz
         nDargxLpnNUwdXAzWj+L+bhvOeal5Y2LuW1e0IBcOmOb58/rXccfWkYV9EZ0Cre6M/
         Ye6r+YvdzifhA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Thu, 9 Feb 2023 11:52:34 +0100
Received: from Stretch-CN.dh-electronics.org (10.64.6.116) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21 via Frontend Transport; Thu, 9 Feb 2023 11:52:34 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/2] regulator: da9062: Make the use of IRQ optional
Date:   Thu, 9 Feb 2023 11:51:44 +0100
Message-ID: <20230209105144.9351-2-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20230209105144.9351-1-cniedermaier@dh-electronics.com>
References: <20230209105144.9351-1-cniedermaier@dh-electronics.com>
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
---
 drivers/regulator/da9062-regulator.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 1a6324001027..653e1844dd61 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1012,10 +1012,9 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	}
 
 	/* LDOs overcurrent event support */
-	irq = platform_get_irq_byname(pdev, "LDO_LIM");
-	if (irq < 0)
-		return irq;
-	regulators->irq_ldo_lim = irq;
+	regulators->irq_ldo_lim = platform_get_irq_byname_optional(pdev, "LDO_LIM");
+	if (regulators->irq_ldo_lim < 0)
+		return 0;
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 					NULL, da9062_ldo_lim_event,
-- 
2.11.0

