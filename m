Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3616B2CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCISLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCISK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:10:59 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B990E8CE3;
        Thu,  9 Mar 2023 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MbP/r
        M8Rc/DiEdJHJClQCoN2UOe8VkwrD7GNpwsewxM=; b=B1m6xNYnsi2cnw3RSN8k/
        ULKWcyyr+tyIh4tInDbtjZkJbVzH+/Xyh8nZtYdnmIN49dVOmbPKtK72FHLZUEiS
        O4ye5R7g74/9Q+Q448PFVr/Z6Dc94LV/+nlu9bA9cOwHoQZ5nXT497PICxUNnT8L
        ztSVEASiWczKuHDpw9bT/c=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g2-3 (Coremail) with SMTP id _____wC3vyceIQpklqXqCg--.13222S2;
        Fri, 10 Mar 2023 02:10:38 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     support.opensource@diasemi.com
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] power: supply: da9150: Fix use after free bug in da9150_charger_remove due to race condition
Date:   Fri, 10 Mar 2023 02:10:36 +0800
Message-Id: <20230309181036.262674-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3vyceIQpklqXqCg--.13222S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy7trWftr1kJF1furyUKFg_yoW8GFy5p3
        98Cr98Kr48tFWUtF1Dtw17WFyUGa43C34Yyr4xGw45Aw13Zr4jqr1rGFnxKFy7Jr4xAF42
        qFsaq3yIqF98WrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaiiDUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzgAtU2I0XlTmVAAAse
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In da9150_charger_probe, &charger->otg_work is bound with
da9150_charger_otg_work. da9150_charger_otg_ncb may be
called to start the work.

If we remove the module which will call da9150_charger_remove
 to make cleanup, there may be a unfinished work. The possible
  sequence is as follows:

Fix it by canceling the work before cleanup in the mtk_jpeg_remove

CPU0                  CPUc1

                    |da9150_charger_otg_work
da9150_charger_remove      |
power_supply_unregister  |
device_unregister   |
power_supply_dev_release|
kfree(psy)          |
                    |
                    | 	power_supply_changed(charger->usb);
                    |   //use
Fixes: c1a281e34dae ("power: Add support for DA9150 Charger")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/power/supply/da9150-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index 14da5c595dd9..41b68f2f6ed8 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -642,6 +642,7 @@ static int da9150_charger_remove(struct platform_device *pdev)
 	struct da9150_charger *charger = platform_get_drvdata(pdev);
 	int irq;
 
+	cancel_work_sync(&charger->otg_work);
 	/* Make sure IRQs are released before unregistering power supplies */
 	irq = platform_get_irq_byname(pdev, "CHG_VBUS");
 	free_irq(irq, charger);
-- 
2.25.1

