Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4AF6CC7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjC1QZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjC1QYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:24:51 -0400
X-Greylist: delayed 532 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 09:24:49 PDT
Received: from 3.mo562.mail-out.ovh.net (3.mo562.mail-out.ovh.net [46.105.33.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C12FE39C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:24:49 -0700 (PDT)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
        by mo562.mail-out.ovh.net (Postfix) with ESMTPS id 3E62A23DB5;
        Tue, 28 Mar 2023 16:15:55 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <sven.schwermer@disruptive-technologies.com>; Tue, 28 Mar 2023 16:15:55 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.108.4.35])
        by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 213B31FE53;
        Tue, 28 Mar 2023 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 28 Mar
 2023 18:15:54 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee.jones@linaro.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <andy.shevchenko@gmail.com>, <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v8 2/6] leds: class: simplify the implementation of devm_of_led_get()
Date:   Tue, 28 Mar 2023 18:15:37 +0200
Message-ID: <20230328161541.599463-3-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328161541.599463-1-jjhiblot@traphandler.com>
References: <20230328161541.599463-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG8EX1.emp2.local (172.16.2.81) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 1349672517243845083
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehgedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepughirhgvtghtohhrgedruggvrhhprdhmrghilhdqohhuthdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedv
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_add_action_or_reset() helper.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/leds/led-class.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 6a8ea94834fa..2c0d979d0c8a 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -258,11 +258,9 @@ void led_put(struct led_classdev *led_cdev)
 }
 EXPORT_SYMBOL_GPL(led_put);
 
-static void devm_led_release(struct device *dev, void *res)
+static void devm_led_release(void *cdev)
 {
-	struct led_classdev **p = res;
-
-	led_put(*p);
+	led_put(cdev);
 }
 
 /**
@@ -280,7 +278,7 @@ struct led_classdev *__must_check devm_of_led_get(struct device *dev,
 						  int index)
 {
 	struct led_classdev *led;
-	struct led_classdev **dr;
+	int ret;
 
 	if (!dev)
 		return ERR_PTR(-EINVAL);
@@ -289,15 +287,9 @@ struct led_classdev *__must_check devm_of_led_get(struct device *dev,
 	if (IS_ERR(led))
 		return led;
 
-	dr = devres_alloc(devm_led_release, sizeof(struct led_classdev *),
-			  GFP_KERNEL);
-	if (!dr) {
-		led_put(led);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	*dr = led;
-	devres_add(dev, dr);
+	ret = devm_add_action_or_reset(dev, devm_led_release, led);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return led;
 }
-- 
2.25.1

