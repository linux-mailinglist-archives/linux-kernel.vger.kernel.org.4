Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00A717643
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjEaFgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjEaFgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:36:21 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62345D9;
        Tue, 30 May 2023 22:36:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjwC2E9_1685511360;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VjwC2E9_1685511360)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 13:36:15 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     pavel@ucw.cz
Cc:     lee@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] leds: flash: leds-qcom-flash: Fix an unsigned comparison which can never be negative
Date:   Wed, 31 May 2023 13:35:59 +0800
Message-Id: <20230531053559.5702-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'count' is defined as unsigned type, so the following if
statement is invalid, we can modify the type of count to int.
if (count <= 0) {
	dev_err(dev, "No led-sources specified\n");
	return -ENODEV;
}

./drivers/leds/flash/leds-qcom-flash.c:546:5-10: WARNING: Unsigned expression compared with zero: count <= 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5344
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/leds/flash/leds-qcom-flash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index c8d41a3caf38..b089ca1a1901 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -538,9 +538,9 @@ static int qcom_flash_register_led_device(struct device *dev,
 	struct led_init_data init_data;
 	struct led_classdev_flash *flash = &led->flash;
 	struct led_flash_setting *brightness, *timeout;
-	u32 count, current_ua, timeout_us;
+	u32 current_ua, timeout_us;
 	u32 channels[4];
-	int i, rc;
+	int i, rc, count;
 
 	count = fwnode_property_count_u32(node, "led-sources");
 	if (count <= 0) {
-- 
2.20.1.7.g153144c

