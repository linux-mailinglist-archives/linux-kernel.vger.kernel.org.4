Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046F56C0A87
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCTGZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCTGYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:24:52 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70BF383E2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Pm2+v
        Pq9+4ztnYCSujp7AKxWA+RN1p5trBoHgNIcDRg=; b=Ipn1jyf6jCYrfN4hF9uow
        WQ8vAJ/2jIOH4J/AqsIS0XInuV5lZzBUMI33RQu88y/4luhiD8RfQvUu28O1Q5/+
        fYZ9xLTtn4fVzhSjlKZnuvSu6m24jwLB949CmFOA1jZjWXIuJP0EIHzD4JMhW5Tv
        nemYJyLUtn6big3bI4PwyM=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wBX9egk_BdkgBASAg--.25360S2;
        Mon, 20 Mar 2023 14:24:36 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v2] misc: ti-st: st_kim: Fix use after free bug in kim_remove due  to race condition
Date:   Mon, 20 Mar 2023 14:24:35 +0800
Message-Id: <20230320062435.500109-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBX9egk_BdkgBASAg--.25360S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1kXFykXrWxKF43AFykuFg_yoW8WryDpa
        yUKrW29rWUKFyIgw4DJr4Uua43Kw47ta4YgF47Cw4fZ3s0krWYgFnFyryIvFZayFW8tr4r
        tr18ZFZxWa4DX3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziJUU8UUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXAg4U1Xl5-IBSAAAsT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kim_probe, it called st_core_init and bound &st_gdata->work_write_wakeup
with work_fn_write_wakeup.
When it calls st_tty_wakeup, it will finally call schedule_work to start
the work.

When we call kim_remove to remove the driver, there
may be a sequence as follows:

Fix it by finishing the work before cleanup in kim_remove

CPU0                  CPU1

                    |work_fn_write_wakeup
kim_remove          |
  st_core_exit      |
     kfree(st_gdata)|
                    |st_tx_wakeup
                    |//use st_gdata

Fixes: b05b7c7cc032 ("ti-st: use worker instead of calling st_int_write in wake up")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
v2:
- fix error from kernek_test-robot
---
 drivers/misc/ti-st/st_kim.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index f2f6cab97c08..497ba8d8df27 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -785,8 +785,12 @@ static int kim_remove(struct platform_device *pdev)
 	/* free the GPIOs requested */
 	struct ti_st_plat_data	*pdata = pdev->dev.platform_data;
 	struct kim_data_s	*kim_gdata;
+	struct st_data_s *st_gdata;
 
 	kim_gdata = platform_get_drvdata(pdev);
+	st_gdata = kim_gdata->core_data;
+
+	cancel_work_sync(&st_gdata->work_write_wakeup);
 
 	/*
 	 * Free the Bluetooth/FM/GPIO
@@ -800,7 +804,7 @@ static int kim_remove(struct platform_device *pdev)
 	pr_info("sysfs entries removed");
 
 	kim_gdata->kim_pdev = NULL;
-	st_core_exit(kim_gdata->core_data);
+	st_core_exit(st_gdata);
 
 	kfree(kim_gdata);
 	kim_gdata = NULL;
-- 
2.25.1

