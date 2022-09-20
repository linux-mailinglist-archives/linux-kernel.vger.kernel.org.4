Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06B55BD9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiITCDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiITCDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:03:25 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D9957226;
        Mon, 19 Sep 2022 19:03:22 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id OBX00117;
        Tue, 20 Sep 2022 10:03:17 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 20 Sep 2022 10:03:16 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] watchdog: Check dev_set_name() return value
Date:   Mon, 19 Sep 2022 22:03:12 -0400
Message-ID: <20220920020312.2383-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201622.home.langchao.com (10.100.2.22)
tUid:   202292010031793cf6e2e6a568da9d6006a596f7ea805
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that dev_set_name() returns -ENOMEM, catch and handle this.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/watchdog/watchdog_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 54903f3c851e..744b2ab75288 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1015,7 +1015,11 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 	wd_data->dev.groups = wdd->groups;
 	wd_data->dev.release = watchdog_core_data_release;
 	dev_set_drvdata(&wd_data->dev, wdd);
-	dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
+	err = dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
+	if (err) {
+		put_device(&wd_data->dev);
+		return err;
+	}
 
 	kthread_init_work(&wd_data->work, watchdog_ping_work);
 	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-- 
2.27.0

