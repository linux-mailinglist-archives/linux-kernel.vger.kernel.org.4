Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81D5FBDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJKWUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJKWUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:20:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA0819288;
        Tue, 11 Oct 2022 15:19:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i6so9468869pli.12;
        Tue, 11 Oct 2022 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmBiYRqhYAVz/iDBLu767wNTrndRtXfULgkers/pTPY=;
        b=LzE6t/3cYXnz2rTGxT9MEheD177QZHKBRMNwdbzh2qcf6GTNoab8z2SXezuoF/pr9E
         SrA8lRn5sGGBsjyEJ7gU+PIcdNT7XJvt6ijJLSbYqBfwtEi2omKfkkI1/DfR8X4bmgE/
         8sUYIQ4/L45L7wmSRObPBjq0cYMXzoqenO1YEu+uw7tN5hMtcDs5QNlxSNj703ocl9jf
         +vyCjPwKcdqgubHQUZqmPgts3J29IZ7TosjSSMdOTHR7L6idZvlF2Vs3ZfIUuyrEwssp
         ob/VDLP11hZtizqNHa9ahkaRTl1FKIEwyTF05BWFy3nFdwT3I8xdORUzKyR2xxky2q6Z
         xqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmBiYRqhYAVz/iDBLu767wNTrndRtXfULgkers/pTPY=;
        b=OAMuugGE25o4pCybHLQsil8ythpL1thFuXjE8cZNlwHsTTedEDtgtyw8POwakg0eBV
         NX62lUklqlW0yNp0cMFbxTSfSYHb92foRu6DiIxVXwD/jPLGNQeIY73fI2eo/akIY1LG
         ZZlxX39N4p+xJhTJb9Lgnz99LHi8up/8/o8sBdL/eRoKO0kdlTWw+TV2HgZRF2YgwUVc
         VqT4m8Wzsw3JZR/gCu8u0PPqbJggZiWLIRQBTag9Hu8UouX0L6euybeiwe/22BCTnk9g
         btPaDsiJVyZCRn5VBGKdECRBv9Y62I3jN7EuaiIii8o8O5svto3GvPg4exRbIhf+dxmB
         a3FA==
X-Gm-Message-State: ACrzQf2Ro6smqOP2JzrYG66DlKOwzGpMQ3tXQ/npR2Qv5bQy2i2ED9ne
        ke7oPO5ql9uhSX7XWmrEQsU=
X-Google-Smtp-Source: AMsMyM725fhf87/+WnaBpOk4R+NTkdn8r6+mCYjks1ooHWHnlSaf2qQoW6rM0O/XPoNgCLcuRPbkWw==
X-Received: by 2002:a17:90b:1b0b:b0:20d:7c31:e75d with SMTP id nu11-20020a17090b1b0b00b0020d7c31e75dmr1440019pjb.101.1665526791137;
        Tue, 11 Oct 2022 15:19:51 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:becc:db10:eb45:dc35])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090ab70600b0020d39ffe987sm60151pjr.50.2022.10.11.15.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:19:50 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 7/7] gpiolib: of: add quirk for phy reset polarity for Freescale Ethernet
Date:   Tue, 11 Oct 2022 15:19:35 -0700
Message-Id: <20221011-gpiolib-quirks-v1-7-e01d9d3e7b29@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings for Freescale Fast Ethernet Controller use a separate
property "phy-reset-active-high" to specify polarity of its phy
gpio line. To allow converting the driver to gpiod API we need
to add this quirk to gpiolib.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 3200d705fbe3..c3d3fe4d927c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -231,6 +231,33 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 	    !strcmp(propname, "snps,reset-gpio") &&
 	    of_property_read_bool(np, "snps,reset-active-low"))
 		*flags |= OF_GPIO_ACTIVE_LOW;
+
+	/*
+	 * Freescale Fast Ethernet Controller uses a separate property to
+	 * describe polarity of the phy reset line.
+	 */
+	if (IS_ENABLED(CONFIG_FEC)) {
+		static const char * const fec_devices[] = {
+			"fsl,imx25-fec",
+			"fsl,imx27-fec",
+			"fsl,imx28-fec",
+			"fsl,imx6q-fec",
+			"fsl,mvf600-fec",
+			"fsl,imx6sx-fec",
+			"fsl,imx6ul-fec",
+			"fsl,imx6mq-fec",
+			"fsl,imx6qm-fec",
+			"fsl,s32v234-fec",
+			NULL
+		};
+
+		if (!strcmp(propname, "phy-reset-gpios") &&
+		    of_device_compatible_match(np, fec_devices)) {
+			bool active_high = of_property_read_bool(np,
+						"phy-reset-active-high");
+			of_gpio_quirk_polarity(np, active_high, flags);
+		}
+	}
 }
 
 /**

-- 
b4 0.11.0-dev-5166b
