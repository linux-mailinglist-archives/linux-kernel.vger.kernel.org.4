Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260706BF8E5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCRISf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCRISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:18:31 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C526D5B9C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=R6Pig
        HiiBwTtJAt6wF4POpu3Up9Ey4iqAzf3m+gNp9g=; b=OmQBc2rBQ4u16V53iQvd0
        uTwEN783dw5cQBi5k0Wh2BiQdEcAKJpCKNHOKQs0F0F8PeYU3vkCP+9nb1d4ESLp
        HXs+N2dlc5YUd2NF0l5omlPx+x4DR1kCo+24RITJqMjmuI+tEyOrTzf+zI+MYJFy
        VG5sr78CAZrcVcyIWXCQlc=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wCnrUascxVkDUZnAQ--.44039S2;
        Sat, 18 Mar 2023 16:17:48 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH RESEND] misc: ti-st: st_kim: Fix use after free bug in kim_remove due to race condition
Date:   Sat, 18 Mar 2023 16:17:43 +0800
Message-Id: <20230318081743.797531-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnrUascxVkDUZnAQ--.44039S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1kXFykXrWxKF4fJF1DWrg_yoW8Wr1Dpa
        yjgrW29rW8KFWIqw4DJr4Uua42kw47t34YgF47Cw43Z34YkrWYgFnFvryIvFZayFZ5tr4F
        yr18ZrZxWa9rZ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziBT5ZUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXBA2U1Xl5+NHrgAAs0
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/misc/ti-st/st_kim.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index f2f6cab97c08..160258a78c7b 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -785,9 +785,12 @@ static int kim_remove(struct platform_device *pdev)
 	/* free the GPIOs requested */
 	struct ti_st_plat_data	*pdata = pdev->dev.platform_data;
 	struct kim_data_s	*kim_gdata;
+	struct st_data_s *st_gdata = kim_gdata->core_data;
 
 	kim_gdata = platform_get_drvdata(pdev);
 
+	cancel_work_sync(&st_gdata->work_write_wakeup);
+
 	/*
 	 * Free the Bluetooth/FM/GPIO
 	 * nShutdown gpio from the system
@@ -800,7 +803,7 @@ static int kim_remove(struct platform_device *pdev)
 	pr_info("sysfs entries removed");
 
 	kim_gdata->kim_pdev = NULL;
-	st_core_exit(kim_gdata->core_data);
+	st_core_exit(st_gdata);
 
 	kfree(kim_gdata);
 	kim_gdata = NULL;
-- 
2.25.1

