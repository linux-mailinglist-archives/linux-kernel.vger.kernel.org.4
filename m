Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F584717374
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjEaCCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjEaCCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:02:45 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7CEEC;
        Tue, 30 May 2023 19:02:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjvXqog_1685498559;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VjvXqog_1685498559)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 10:02:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     pavel@ucw.cz
Cc:     lee@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] leds: cht-wcove: Fix an unsigned comparison which can never be negative
Date:   Wed, 31 May 2023 10:02:38 +0800
Message-Id: <20230531020238.102684-1-yang.lee@linux.alibaba.com>
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

The return value from the call to cht_wc_leds_find_freq() is int.
However, the return value is being assigned to an unsigned
int variable 'ctrl', so making it an int.

Eliminate the following warning:
drivers/leds/leds-cht-wcove.c:236 cht_wc_leds_set_effect() warn: unsigned 'ctrl' is never less than zero.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5341
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/leds/leds-cht-wcove.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/leds/leds-cht-wcove.c b/drivers/leds/leds-cht-wcove.c
index 0cfebee98910..10afd03164b4 100644
--- a/drivers/leds/leds-cht-wcove.c
+++ b/drivers/leds/leds-cht-wcove.c
@@ -223,8 +223,7 @@ static int cht_wc_leds_set_effect(struct led_classdev *cdev,
 				  u8 effect)
 {
 	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
-	unsigned int ctrl;
-	int ret;
+	int ctrl, ret;
 
 	mutex_lock(&led->mutex);
 
-- 
2.20.1.7.g153144c

