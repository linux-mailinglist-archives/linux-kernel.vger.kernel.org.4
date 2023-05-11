Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D606FEC62
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjEKHJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbjEKHId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:08:33 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8A9EE;
        Thu, 11 May 2023 00:08:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ViJa3FM_1683788900;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0ViJa3FM_1683788900)
          by smtp.aliyun-inc.com;
          Thu, 11 May 2023 15:08:21 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     pavel@ucw.cz
Cc:     lee@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] leds: trigger: netdev: NULL check before dev_{put, hold}
Date:   Thu, 11 May 2023 15:08:20 +0800
Message-Id: <20230511070820.52731-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call netdev_{put, hold} of dev_{put, hold} will check NULL,
so there is no need to check before using dev_{put, hold},
remove it to silence the warnings:

./drivers/leds/trigger/ledtrig-netdev.c:291:3-10: WARNING: NULL check before dev_{put, hold} functions is not needed.
./drivers/leds/trigger/ledtrig-netdev.c:401:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4929
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 305eb543ba84..92de22be5f1c 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -287,8 +287,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		trigger_data->carrier_link_up = netif_carrier_ok(dev);
 		fallthrough;
 	case NETDEV_REGISTER:
-		if (trigger_data->net_dev)
-			dev_put(trigger_data->net_dev);
+		dev_put(trigger_data->net_dev);
 		dev_hold(dev);
 		trigger_data->net_dev = dev;
 		break;
@@ -397,8 +396,7 @@ static void netdev_trig_deactivate(struct led_classdev *led_cdev)
 
 	cancel_delayed_work_sync(&trigger_data->work);
 
-	if (trigger_data->net_dev)
-		dev_put(trigger_data->net_dev);
+	dev_put(trigger_data->net_dev);
 
 	kfree(trigger_data);
 }
-- 
2.20.1.7.g153144c

