Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D4E697C11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjBOMnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjBOMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:43:12 -0500
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7036695
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:43:10 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id SH7ppsWwIZBE3SH7ppDdAf; Wed, 15 Feb 2023 13:43:08 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 15 Feb 2023 13:43:08 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sebastian Reichel <sre@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: rt9467: Fix rt9467_run_aicl()
Date:   Wed, 15 Feb 2023 13:43:04 +0100
Message-Id: <2ed01020fa8a135c36dbaa871095ded47d926507.1676464968.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is spurious to bail-out on a wait_for_completion_timeout() call that
does NOT timeout.

Reverse the logic to return -ETIMEDOUT instead, in case of tiemout.

Fixes: 6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This is spurious, because if I'm right, it means that it does not work!
Testing on a real hardware is really welcomed.
---
 drivers/power/supply/rt9467-charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index 96ad0d7d3af4..bb737fd1cca6 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -598,8 +598,8 @@ static int rt9467_run_aicl(struct rt9467_chg_data *data)
 
 	reinit_completion(&data->aicl_done);
 	ret = wait_for_completion_timeout(&data->aicl_done, msecs_to_jiffies(3500));
-	if (ret)
-		return ret;
+	if (ret == 0)
+		return -ETIMEDOUT;
 
 	ret = rt9467_get_value_from_ranges(data, F_IAICR, RT9467_RANGE_IAICR, &aicr_get);
 	if (ret) {
-- 
2.34.1

