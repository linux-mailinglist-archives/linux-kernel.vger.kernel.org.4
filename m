Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2DC63D72B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiK3Ntt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiK3Ntq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:49:46 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298C731340;
        Wed, 30 Nov 2022 05:49:41 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NMgXn3z15zmWCf;
        Wed, 30 Nov 2022 21:48:57 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 21:49:38 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 21:49:37 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2] mmc: core: Normalize the error handling branch in sd_read_ext_regs()
Date:   Wed, 30 Nov 2022 21:49:20 +0800
Message-ID: <20221130134920.2109-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Use pr_err() to output the error message.
2. Add the description of why success 0 is returned in case
   "non-supported SD ext reg layout".

Fixes: c784f92769ae ("mmc: core: Read the SD function extension registers for power management")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mmc/core/sd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 3662bf5320ce56d..93ee53f74427c38 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1259,7 +1259,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
 	 */
 	err = sd_read_ext_reg(card, 0, 0, 0, 512, gen_info_buf);
 	if (err) {
-		pr_warn("%s: error %d reading general info of SD ext reg\n",
+		pr_err("%s: error %d reading general info of SD ext reg\n",
 			mmc_hostname(card->host), err);
 		goto out;
 	}
@@ -1273,7 +1273,12 @@ static int sd_read_ext_regs(struct mmc_card *card)
 	/* Number of extensions to be find. */
 	num_ext = gen_info_buf[4];
 
-	/* We support revision 0, but limit it to 512 bytes for simplicity. */
+	/*
+	 * We only support revision 0, and limit it to 512 bytes for simplicity.
+	 * In other cases, success 0 is returned, because the card remains
+	 * functional and all but the new features from the SD function
+	 * extensions registers can still be used.
+	 */
 	if (rev != 0 || len > 512) {
 		pr_warn("%s: non-supported SD ext reg layout\n",
 			mmc_hostname(card->host));
@@ -1288,7 +1293,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
 	for (i = 0; i < num_ext; i++) {
 		err = sd_parse_ext_reg(card, gen_info_buf, &next_ext_addr);
 		if (err) {
-			pr_warn("%s: error %d parsing SD ext reg\n",
+			pr_err("%s: error %d parsing SD ext reg\n",
 				mmc_hostname(card->host), err);
 			goto out;
 		}
-- 
2.25.1

