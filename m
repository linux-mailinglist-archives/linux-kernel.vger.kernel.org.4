Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE446AFD5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCHDYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjCHDY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:24:28 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE5C79EF44;
        Tue,  7 Mar 2023 19:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ntwhd
        jE/sHLAxtS+ZiRSctZFsw4NJ79vU/OFPfulIjI=; b=VNWeQte1QssCEBc7lDlJ5
        zLJ1gAnOqZQhj9IM04BGP29hgBrPD5mYgLyYM8DnFBhSJh0CTJGXGLkSWP+0JmPH
        Q6kC4vV5WakrC9nIh/yMW5ppc5jbXs0pHhgJ+KW7ncJCFuuTwWm5olAeepN0Ghig
        HQSnwlaqKtdX/QgNll/sf0=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wCn1V22_wdkytYmCg--.7170S2;
        Wed, 08 Mar 2023 11:23:34 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     mchehab@kernel.org
Cc:     wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] media: cedrus: fix use after free bug in cedrus_remove due to race condition
Date:   Wed,  8 Mar 2023 11:23:33 +0800
Message-Id: <20230308032333.1893394-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCn1V22_wdkytYmCg--.7170S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw15uF4fAw45Wry5GF45KFg_yoW8JFykpa
        y5Ka4UCayUtF4Yg3y7Ar18ZF15W34I93WSg34xJwn2qas5Jr1xXr1rta47Jw1DZa9Ykw4a
        vF15J340qws7AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaZXrUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXRcsU1WBo1oioQAAsb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cedrus_probe, dev->watchdog_work is bound with cedrus_watchdog function.
In cedrus_device_run, it will started by schedule_delayed_work. If there is
unfinished work in cedrus_remove, there may be a race condition and trigger
UAF bug.

CPU0                  CPU1

                    |cedrus_watchdog
cedrus_remove       |
  v4l2_m2m_release  |
  kfree(m2m_dev)    |
                    |
                    | v4l2_m2m_get_curr_priv
                    |   m2m_dev //use

Fix it by canceling the worker in cedrus_remove.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index a43d5ff66716..c95d011c0817 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -546,7 +546,7 @@ static int cedrus_probe(struct platform_device *pdev)
 static int cedrus_remove(struct platform_device *pdev)
 {
 	struct cedrus_dev *dev = platform_get_drvdata(pdev);
-
+	cancel_delayed_work(&dev->watchdog_work);
 	if (media_devnode_is_registered(dev->mdev.devnode)) {
 		media_device_unregister(&dev->mdev);
 		v4l2_m2m_unregister_media_controller(dev->m2m_dev);
-- 
2.25.1

