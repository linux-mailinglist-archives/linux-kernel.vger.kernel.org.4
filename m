Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E8D6FFFFA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 07:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbjELFop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 01:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjELFoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 01:44:44 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43A23172A;
        Thu, 11 May 2023 22:44:40 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(20700:0:AUTH_RELAY)
        (envelope-from <chiaen_wu@richtek.com>); Fri, 12 May 2023 13:44:26 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 12 May
 2023 13:44:25 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 12 May 2023 13:44:25 +0800
From:   ChiaEn Wu <chiaen_wu@richtek.com>
To:     <sre@kernel.org>, <dan.carpenter@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterwu.pub@gmail.com>, <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>
Subject: [PATCH] power: supply: rt9467: Fix passing zero to 'dev_err_probe'
Date:   Fri, 12 May 2023 13:44:23 +0800
Message-ID: <33c598f3655db56eed13a5b46a1468379f69349c.1683863629.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix passing zero to 'dev_err_probe()' in 'rt9467_request_interrupt()'

Fixes: 6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger driver")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202305111228.bHLWU6bq-lkp@intel.com/
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 drivers/power/supply/rt9467-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index 73f744a..ea33693 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -1023,7 +1023,7 @@ static int rt9467_request_interrupt(struct rt9467_chg_data *data)
 	for (i = 0; i < num_chg_irqs; i++) {
 		virq = regmap_irq_get_virq(data->irq_chip_data, chg_irqs[i].hwirq);
 		if (virq <= 0)
-			return dev_err_probe(dev, virq, "Failed to get (%s) irq\n",
+			return dev_err_probe(dev, -EINVAL, "Failed to get (%s) irq\n",
 					     chg_irqs[i].name);
 
 		ret = devm_request_threaded_irq(dev, virq, NULL, chg_irqs[i].handler,
-- 
2.7.4

