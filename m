Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68535745CCA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjGCND3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGCND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:03:27 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA4CE58;
        Mon,  3 Jul 2023 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688389406;
  x=1719925406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TYt/Wl7+6P6oL1evdV9w4Bhsj/jfKiJKvoP0+SizWS4=;
  b=JtlM+ApUukjKIlguhjLewKD6MRYJTL27Bu+It9yOmfNXWwmfGfRSA22w
   oR2XyRn868kTvSWtdbVIqixMndiBTwpgs2zTKJCYBKmuDft34EAI3EdGi
   ZBf1J+yo5yUnF29WicA15El3Ar4gh60W/WedADbkKhu8r+7dyu3pt3WGL
   JV+MJNxV/0T7IzQrKxeMKRhcvNQNKhEf9igR5T3ldaZUVlbYLTfVfnDwo
   BFNmyG00B3joq3ZQMWLlVqsDxLd0vxaUIFHLOAOUOwHUC6ZU4bhqT0P9e
   zFBFA2fQ644SyomydKQpOv7QQZKhljoLio9ONew179yTtuKYjmMP5mr6i
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Jacek Anaszewski" <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Lee Jones" <lee@kernel.org>
CC:     <kernel@axis.com>, Astrid Rost <astrid.rost@axis.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] led: led-class: Read max-brightness from devicetree
Date:   Mon, 3 Jul 2023 15:03:13 +0200
Message-ID: <20230703130313.548519-3-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230703130313.548519-1-astrid.rost@axis.com>
References: <20230703130313.548519-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, the maximum brightness is determined by the hardware, and this
property is not required. This property is used to set a software limit.
It could happen that an LED is made so bright that it gets damaged or
causes damage due to restrictions in a specific system, such as mounting
conditions.
Note that this flag is mainly used for PWM-LEDs, where it is not possible
to map brightness to current. Drivers for other controllers should use
led-max-microamp.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/leds/led-class.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 9255bc11f99d..ce652abf9336 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -457,6 +457,10 @@ int led_classdev_register_ext(struct device *parent,
 			if (fwnode_property_present(init_data->fwnode,
 						    "retain-state-shutdown"))
 				led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
+
+			fwnode_property_read_u32(init_data->fwnode,
+				"max-brightness",
+				&led_cdev->max_brightness);
 		}
 	} else {
 		proposed_name = led_cdev->name;
-- 
2.30.2

