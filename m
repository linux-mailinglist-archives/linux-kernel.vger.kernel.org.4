Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014306CC814
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjC1Qex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjC1Qeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:34:44 -0400
Received: from 9.mo562.mail-out.ovh.net (9.mo562.mail-out.ovh.net [46.105.72.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C643EA5F5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:34:42 -0700 (PDT)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
        by mo562.mail-out.ovh.net (Postfix) with ESMTPS id 955F523DE3;
        Tue, 28 Mar 2023 16:15:55 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <sven.schwermer@disruptive-technologies.com>; Tue, 28 Mar 2023 16:15:55 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.108.20.117])
        by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 7A8461FE15;
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
Subject: [PATCH v8 3/6] leds: provide devm_of_led_get_optional()
Date:   Tue, 28 Mar 2023 18:15:38 +0200
Message-ID: <20230328161541.599463-4-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328161541.599463-1-jjhiblot@traphandler.com>
References: <20230328161541.599463-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG8EX1.emp2.local (172.16.2.81) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 1349672513875425755
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehgedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepughirhgvtghtohhrgedruggvrhhprdhmrghilhdqohhuthdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedv
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version of devm_of_led_get() doesn't fail if a LED is not found.
Instead it returns a NULL pointer.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/leds/led-class.c | 25 +++++++++++++++++++++++++
 include/linux/leds.h     |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 2c0d979d0c8a..9cddcd908bce 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -295,6 +295,31 @@ struct led_classdev *__must_check devm_of_led_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_of_led_get);
 
+/**
+ * devm_of_led_get_optional - Resource-managed request of an optional LED device
+ * @dev:	LED consumer
+ * @index:	index of the LED to obtain in the consumer
+ *
+ * The device node of the device is parsed to find the requested LED device.
+ * The LED device returned from this function is automatically released
+ * on driver detach.
+ *
+ * @return a pointer to a LED device, ERR_PTR(errno) on failure and NULL if the
+ * led was not found.
+ */
+struct led_classdev *__must_check devm_of_led_get_optional(struct device *dev,
+							int index)
+{
+	struct led_classdev *led;
+
+	led = devm_of_led_get(dev, index);
+	if (IS_ERR(led) && PTR_ERR(led) == -ENOENT)
+		return NULL;
+
+	return led;
+}
+EXPORT_SYMBOL_GPL(devm_of_led_get_optional);
+
 static int led_classdev_next_name(const char *init_name, char *name,
 				  size_t len)
 {
diff --git a/include/linux/leds.h b/include/linux/leds.h
index ba4861ec73d3..41df18f42d00 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -215,6 +215,8 @@ extern struct led_classdev *of_led_get(struct device_node *np, int index);
 extern void led_put(struct led_classdev *led_cdev);
 struct led_classdev *__must_check devm_of_led_get(struct device *dev,
 						  int index);
+struct led_classdev *__must_check devm_of_led_get_optional(struct device *dev,
+						  int index);
 
 /**
  * led_blink_set - set blinking with software fallback
-- 
2.25.1

