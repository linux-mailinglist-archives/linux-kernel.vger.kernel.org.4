Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ECE74383B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjF3JX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF3JWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:22:53 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6DA35AE;
        Fri, 30 Jun 2023 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688116972;
  x=1719652972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uE5OMXYXB2+yRj3yLCn944N+1hg6y2gWCtsPAuJlZKY=;
  b=I1MV2no0SiofVx6QIEjjSboQ/PHgESH5ZmRNOg3KEDUGQmg7XcV9Z0d8
   V8v8/jyFGQmh4E6lHGKbMpNaPe06NUt0rKYb30zzNzjz7lN4oemplIX+5
   5NibNpNgaCeyKehwRWRAf9Cpin/IooOE1oryx33uIXY709ZMNGU0SCvSY
   5WyL0rE3hbbDbUPQ2XOjkkCwZStW003c1D4d1SkqxUOOnnSdpNeJENmtE
   1WiWldN2Xk/nI8BFqCbKqtidxiPjQtJctKwdHKgOXc7l91xfQUPYj5wpR
   atiSoJVuQ3vAez6b8RYPLlD6QABir2TN7d/yBjmsJ4CGjYUZ/LukgjPDP
   g==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Jacek Anaszewski" <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Lee Jones" <lee@kernel.org>
CC:     <kernel@axis.com>, Astrid Rost <astrid.rost@axis.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] led: led-class: Read max-brightness from devicetree
Date:   Fri, 30 Jun 2023 11:22:46 +0200
Message-ID: <20230630092248.4146169-2-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230630092248.4146169-1-astrid.rost@axis.com>
References: <20230630092248.4146169-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add max-brightness in order to reduce the current on the connected LEDs.
Normally, the maximum brightness is determined by the hardware, and this
property is not required. This property is used to set a software limit.
It could happen that an LED is made so bright that it gets damaged or
causes damage due to restrictions in a specific system, such as mounting
conditions. Note that led-max-microamp should be preferably used, if it
is supported by the controller.

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

