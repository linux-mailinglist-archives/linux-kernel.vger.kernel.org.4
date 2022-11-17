Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7548862E10E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiKQQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiKQQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:05:00 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCFB43874;
        Thu, 17 Nov 2022 08:04:57 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.143.168])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 34E5D13CAD692;
        Thu, 17 Nov 2022 17:04:56 +0100 (CET)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 17 Nov
 2022 17:04:55 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee.jones@linaro.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <bjorn.andersson@linaro.org>, <andy.shevchenko@gmail.com>,
        <jacek.anaszewski@gmail.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v6 3/6] leds: provide devm_of_led_get_optional()
Date:   Thu, 17 Nov 2022 17:04:44 +0100
Message-ID: <20221117160447.294491-4-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117160447.294491-1-jjhiblot@traphandler.com>
References: <20221117160447.294491-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 6604528854974872027
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrgeekgdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepudetveelveevgffgvdeuffffjefhheehueeitdegtdejgefhheeuuddugeeffeeunecukfhppeduvdejrddtrddtrddupdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlvggvrdhjohhnvghssehlihhnrghrohdrohhrghdpphgrvhgvlhesuhgtfidrtgiipdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpshhvvghnrdhstghhfigvrhhmvghrseguihhsrhhuphhtihhvvgdqthgvtghhnhholhhoghhivghsrdgtohhmpdhkrhiihihsiihtohhfrdhkohiilhhofihskhhiodgutheslhhinhgrrhhordhorhhgpdhjohhhrghnodhlihhnrghroheskhgvrhhnvghlrdhorhhgpdhmrghrihhjnhdrshhuihhjthgvnhesshhomhgrih
 hnlhhinhgvrdhorhhgpdgsjhhorhhnrdgrnhguvghrshhsohhnsehlihhnrghrohdrohhrghdprghnugihrdhshhgvvhgthhgvnhhkohesghhmrghilhdrtghomhdpjhgrtggvkhdrrghnrghsiigvfihskhhisehgmhgrihhlrdgtohhmpdhlihhnuhigqdhlvggushesvhhgvghrrdhkvghrnhgvlhdrohhrghdpuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhohedvkedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

