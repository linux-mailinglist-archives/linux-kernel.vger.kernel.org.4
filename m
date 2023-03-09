Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807D56B2C4C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjCIRsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCIRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:48:00 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BF91FB242;
        Thu,  9 Mar 2023 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=52mtL
        hd0shVd0/pdU2xNkr+LALperEX6L2D16EJNEBM=; b=AzrVh8YyzCuflDZLcxGk2
        pbykbwRaJyAKII3aTvCd9PXb3DKnnFVq7VqJjseevpnVSaT3+cRnH4146cPXwXtK
        qX2qNmgCMCHfhDRyZTWx5vRSr7rKs12aN9mQFVkkcx7v6+hJ/9K3SV4SY/2Yz6+a
        ByogpjwSmCwri7D5THPZTM=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wDndZqyGwpkzfPcCg--.19913S2;
        Fri, 10 Mar 2023 01:47:30 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] power: supply: bq24190: Fix use after free bug in bq24190_remove due to race condition
Date:   Fri, 10 Mar 2023 01:47:28 +0800
Message-Id: <20230309174728.233732-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDndZqyGwpkzfPcCg--.19913S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy3CFW7AF4fKFWfWw45ZFb_yoW8XrWDpw
        s3Gr90ka1Fqayj9a1Dta12vFy5Ga45GryrCrZ7Gw17ZwnxW39rt34DJF13Gry7Jrn3Xa1I
        v3s3t3y7KF9xKrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziJ73PUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXRgtU1WBo2xwDQAAsd
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In bq24190_probe, &bdi->input_current_limit_work is bound
with bq24190_input_current_limit_work. When external power
changed, it will call bq24190_charger_external_power_changed
 to start the work.

If we remove the module which will call bq24190_remove to make
cleanup, there may be a unfinished work. The possible
sequence is as follows:

CPU0                  CPUc1

                    |bq24190_input_current_limit_work
bq24190_remove      |
power_supply_unregister  |
device_unregister   |
power_supply_dev_release|
kfree(psy)          |
                    |
                    | power_supply_get_property_from_supplier
                    |   //use

Fix it by finishing the work before cleanup in the bq24190_remove

Fixes: 97774672573a ("power_supply: Initialize changed_work before calling device_add")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/power/supply/bq24190_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index be34b9848450..de67b985f0a9 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1906,6 +1906,7 @@ static void bq24190_remove(struct i2c_client *client)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 	int error;
 
+	cancel_delayed_work_sync(&bdi->input_current_limit_work);
 	error = pm_runtime_resume_and_get(bdi->dev);
 	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-- 
2.25.1

