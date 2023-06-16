Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34CF732D35
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245062AbjFPKQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244477AbjFPKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:16:30 -0400
X-Greylist: delayed 613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jun 2023 03:16:28 PDT
Received: from 5.mo562.mail-out.ovh.net (5.mo562.mail-out.ovh.net [46.105.48.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BEAAC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:16:28 -0700 (PDT)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
        by mo562.mail-out.ovh.net (Postfix) with ESMTPS id 847CF23F68;
        Fri, 16 Jun 2023 09:57:55 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <andy.shevchenko@gmail.com>; Fri, 16 Jun 2023 09:57:55 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.109.138.83])
        by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4A9DD1FE53;
        Fri, 16 Jun 2023 09:57:55 +0000 (UTC)
Received: from traphandler.com (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Jun
 2023 11:57:54 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v9 2/5] leds: provide devm_of_led_get_optional()
Date:   Fri, 16 Jun 2023 11:57:43 +0200
Message-ID: <20230616095746.872220-3-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616095746.872220-1-jjhiblot@traphandler.com>
References: <20230616095746.872220-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS3.emp2.local (172.16.1.3) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 3612731328970570119
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvgedgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepudetveelveevgffgvdeuffffjefhheehueeitdegtdejgefhheeuuddugeeffeeunecukfhppedtrddtrddtrddtpdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopeguihhrvggtthhorhegrdguvghrphdrmhgrihhlqdhouhhtrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhlvggushesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeivd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index 6dae56b914fe..eb1a8494dc5b 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -402,6 +402,31 @@ void led_remove_lookup(struct led_lookup_data *led_lookup)
 }
 EXPORT_SYMBOL_GPL(led_remove_lookup);
 
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
index 50b2f8f153fb..95311c70d95c 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -270,6 +270,8 @@ extern struct led_classdev *of_led_get(struct device_node *np, int index);
 extern void led_put(struct led_classdev *led_cdev);
 struct led_classdev *__must_check devm_of_led_get(struct device *dev,
 						  int index);
+struct led_classdev *__must_check devm_of_led_get_optional(struct device *dev,
+						  int index);
 
 /**
  * led_blink_set - set blinking with software fallback
-- 
2.34.1

