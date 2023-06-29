Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC97427A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjF2Nrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjF2Nr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:47:29 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8C63588;
        Thu, 29 Jun 2023 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688046448;
  x=1719582448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oivdCWpWhN5qlKpC0P4lDqtzGqA01OdlG871VKH1xqo=;
  b=dcB3N3vJOErNkhoE9GwVIDVeXO7huEOSnu+DuNlqFd4W756O7uDRQCXS
   7bbT/lQt+YROd1O4R/nNR4EJMwBUSag/IefoBQEXmntjDRe52gu19+hTe
   IGnqN+flLM+mI1GYKfU6zwuWnVjrR8fGHoSc61zx6En99ZJ19yI92d058
   CGQcGV50qgY515Z3bSxTt5fsRmbzQoO+NXqQHlLML0q8K1I7NYLdnTG95
   qlSEBhmf10fDvGJuzR7PAnuGhaDFJPoJZ+888fmvgFIU02uJx+/OWjjNr
   09EvE/HOLHD3OMQhnqZUweDswbXHUUudnf3iYK7F4CuSRbNR+yW2YLcPQ
   Q==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Dan Murphy <dmurphy@ti.com>, Andrew Davis <afd@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
CC:     <kernel@axis.com>, Astrid Rost <astrid.rost@axis.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] led: leds-lp50xx: Add max-brightness as in leds-pwm
Date:   Thu, 29 Jun 2023 15:47:21 +0200
Message-ID: <20230629134722.3908637-2-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230629134722.3908637-1-astrid.rost@axis.com>
References: <20230629134722.3908637-1-astrid.rost@axis.com>
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

Add max-brightness in order to reduce the current on the connected LEDs.
Normally, the maximum brightness is determined by the hardware, and this
property is not required. This property is used to set a software limit.
It could happen that an LED is made so bright that it gets damaged or
causes damage due to restrictions in a specific system, such as mounting
conditions.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/leds/leds-lp50xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 28d6b39fa72d..1cb54c0524a1 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -502,6 +502,8 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 		led->mc_cdev.num_colors = num_colors;
 		led->mc_cdev.subled_info = mc_led_info;
 		led_cdev = &led->mc_cdev.led_cdev;
+		fwnode_property_read_u32(child, "max-brightness",
+					 &led_cdev->max_brightness);
 		led_cdev->brightness_set_blocking = lp50xx_brightness_set;
 
 		ret = devm_led_classdev_multicolor_register_ext(priv->dev,
-- 
2.30.2

