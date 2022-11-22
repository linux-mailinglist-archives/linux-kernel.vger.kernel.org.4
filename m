Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E917633A75
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiKVKsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiKVKrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:47:45 -0500
X-Greylist: delayed 2685 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 02:45:46 PST
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC455260B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:45:46 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 94D265E8DA;
        Tue, 22 Nov 2022 11:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669113916;
        bh=8/2f5/wC+/WGNHGQUshaA3bZxyQCSCGtdkYvUN/IFBU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=d0pAPsyx7FPGn/eNalj7eNSN59LveKCoxIMgBAcP39a/PeiZjs/FvjowB79czqDwe
         O/FvySr5W7qrzTZsdJ1B6nzL35t2W6He+qlLPyDdfJNlh0OhOhJHGs6kA7ZiHz6EPF
         fLuieF/pXlTKS0RymiJgYAjDWYbTCz6Pq3mIxHKIjWubTZCvdqSOjGXFS0jBByru/Q
         /DT5Htx1z3SzFd96MagBQpVPA/ljjzySYZ/PHNR9EUT3rFMNVGWVHdRUGvylGfWnBC
         yOIQH3GSDSuZUiQnB2DemqMRII+tBOVve78r8Yd60HO2vma94Bygb804+5O4sar+sX
         agJdTtLwaQe2A==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 22 Nov 2022 11:00:04 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Tue, 22 Nov 2022 11:00:03 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "Support Opensource" <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] regulator: da9062: Make the use of IRQ optional
Date:   Tue, 22 Nov 2022 10:58:33 +0100
Message-ID: <20221122095833.3957-4-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20221122095833.3957-1-cniedermaier@dh-electronics.com>
References: <20221122095833.3957-1-cniedermaier@dh-electronics.com>
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

