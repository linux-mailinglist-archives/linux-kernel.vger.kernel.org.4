Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D83B5EE690
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiI1UVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiI1UUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:20:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDE2BEB;
        Wed, 28 Sep 2022 13:20:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v1so12653546plo.9;
        Wed, 28 Sep 2022 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=MXeDMHLUELvAe5XHkVOHWbbRpG/jdLEqo2Af5kPyfsY=;
        b=lmuWvWSR3NxhmCJZK82ALeaL/obSiEchFl+ZNxDMEfaFmAnf1RzfYEEZfLlfukLf8p
         31UphFnM01eC4l3vOvPGFceusnYeijgz4vMha4kA241PPDeSNTY6ucAUQCdF1JzJxAyC
         75NPrQgKfIw74AgguDxZRbSnP27DJDbEf8Co3prInoui3a87eDPdTjOQxR5Y6MPAy7Zh
         SN2LM6fRxQvKyS12FEH+R0w/I0gDYtReBafcfbjxDUU01moQh/W/0kc1V35Mrk1Pvtro
         JscL6eaH4lWdJQ0bg15EfOIUAkRhwPMCvzmLRdO9ZSZ+q5WkkcqyDLb3McMgOCFV54xS
         1e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MXeDMHLUELvAe5XHkVOHWbbRpG/jdLEqo2Af5kPyfsY=;
        b=TXw8wlBmx1FOMjutxhXdfCJQpJT1Q41DOYextcbR/N3X3t/rzWeENynmro8MfarZs9
         3tCjyt136OR62f3CBmVXSQFffwqKc/lBvuGbbmudxir6U+istiaA1w1SGV/7MRwjw4DH
         BmHymhH/SoBw3Cb0XePYL3cyqoBgViKzmNc/zPUZyKgMofNl8+bGalD9p1SdFYyXgmSH
         rQ8BKylBwf4k8NsE88LrAVnwlOaqAqx9gVEmwrFt7AllJCqwlARlBOI5W3X8mw/0/CdW
         xy0crE5us26i1RQ5e+pDjezEi72zPkAOh8trCJTo8sCvx3BSJmrdhaNC6y4wOwk7XnpH
         u3Ow==
X-Gm-Message-State: ACrzQf3dRyFFIXxKLYzqo5tCSiUTlYShVmYmdyOboze/GYni6kUivnwO
        02+YZ/TZJ9Xwo+Zc2IrVDeGoScW/ynI=
X-Google-Smtp-Source: AMsMyM6ZCPhOlFf9kNCBJe5F8CGDMSRmVni7H4heKCaETLCjc0CJ92R4sIOebBq1IJQXNnmbx2bFcw==
X-Received: by 2002:a17:90b:1bc7:b0:202:52ce:a1d with SMTP id oa7-20020a17090b1bc700b0020252ce0a1dmr12538209pjb.110.1664396422061;
        Wed, 28 Sep 2022 13:20:22 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1a91:59b8:faf:7b4f])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b00179c99eb815sm4197815plg.33.2022.09.28.13.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:20:21 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:20:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: st: stop abusing of_get_named_gpio()
Message-ID: <YzSsgoVoJn4+mSpv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin descriptions for this chip only look like standard GPIO device tree
descriptions, while in fact they contain additional data (in excess of
number of cells specified in description of gpio controllers). They also
refer to only pins/gpios belonging to the driver and not to arbitrary
gpio in the system.

Because we want to stop exporting OF-specific handlers from gpiolib-of,
let's parse the pin reference ourself instead of trying to call
of_get_named_gpio().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Just compiled, not tested on real hardware.

 drivers/pinctrl/pinctrl-st.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 0fea71fd9a00..cf7f9cbe6044 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -12,7 +12,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h> /* of_get_named_gpio() */
 #include <linux/of_address.h>
 #include <linux/gpio/driver.h>
 #include <linux/regmap.h>
@@ -1162,6 +1161,31 @@ static void st_parse_syscfgs(struct st_pinctrl *info, int bank,
 	return;
 }
 
+static int st_pctl_dt_calculate_pin(struct st_pinctrl *info,
+				    phandle bank, unsigned int offset)
+{
+	struct device_node *np;
+	struct gpio_chip *chip;
+	int retval = -EINVAL;
+	int i;
+
+	np = of_find_node_by_phandle(bank);
+	if (!np)
+		return -EINVAL;
+
+	for (i = 0; i < info->nbanks; i++) {
+		chip = &info->banks[i].gpio_chip;
+		if (chip->of_node == np) {
+			if (offset < chip->ngpio)
+				retval = chip->base + offset;
+			break;
+		}
+	}
+
+	of_node_put(np);
+	return retval;
+}
+
 /*
  * Each pin is represented in of the below forms.
  * <bank offset mux direction rt_type rt_delay rt_clk>
@@ -1175,6 +1199,8 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 	struct device *dev = info->dev;
 	struct st_pinconf *conf;
 	struct device_node *pins;
+	phandle bank;
+	unsigned int offset;
 	int i = 0, npins = 0, nr_props, ret = 0;
 
 	pins = of_get_child_by_name(np, "st,pins");
@@ -1214,9 +1240,9 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 		conf = &grp->pin_conf[i];
 
 		/* bank & offset */
-		be32_to_cpup(list++);
-		be32_to_cpup(list++);
-		conf->pin = of_get_named_gpio(pins, pp->name, 0);
+		bank = be32_to_cpup(list++);
+		offset = be32_to_cpup(list++);
+		conf->pin = st_pctl_dt_calculate_pin(info, bank, offset);
 		conf->name = pp->name;
 		grp->pins[i] = conf->pin;
 		/* mux */
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Dmitry
