Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9B9608031
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJUUsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJUUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:48:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102582A1FD8;
        Fri, 21 Oct 2022 13:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01A43B80C82;
        Fri, 21 Oct 2022 20:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B1AC433C1;
        Fri, 21 Oct 2022 20:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666384986;
        bh=ZRuew8H2IVJtQjPQ4OtZq012SU14YGDgRtLmhljfjrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eesCGvG7neRIWHjJcwV8I0J5EG54Zcp/smPrxCPTmMnPeBVp7LypHS2z3LnODC6z/
         muzPRa29R10CvlzhrjBPgi+qnuGzktVGLd0RKb+YScId60v3lexcWg6dZksBHAYaQV
         qWV8AQxDp9K01KoH3Skb3V8zhBW5LTelAOiFqvxF8qM+Yj1C3PP+kccQv0EvdI4zow
         EPhTZ56GSoMLm4yHS+My0mvQ14S4IV50bndPNRxDUmjddmnkYjWHBzlFEUVFmj9JPG
         TY90A8TAUcTvcyiY8xAFtRDmwX6Xpr3V/wv/a8ImvgFsA6IkmGd4D8VlNdUXaV5E0M
         9BanHS4Kch5Zw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org
Subject: [PATCH 08/21] hwmon: remove s3c driver
Date:   Fri, 21 Oct 2022 22:27:41 +0200
Message-Id: <20221021203329.4143397-8-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The s3c adc driver was removed along with the s3c24xx platform, so the
hwmon driver is orphaned and can be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwmon/Kconfig     |  17 --
 drivers/hwmon/Makefile    |   1 -
 drivers/hwmon/s3c-hwmon.c | 379 --------------------------------------
 3 files changed, 397 deletions(-)
 delete mode 100644 drivers/hwmon/s3c-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 7ac3daaf59ce..c98a068b5be2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1729,23 +1729,6 @@ config SENSORS_SHTC1
 	  This driver can also be built as a module. If so, the module
 	  will be called shtc1.
 
-config SENSORS_S3C
-	tristate "Samsung built-in ADC"
-	depends on S3C_ADC
-	help
-	  If you say yes here you get support for the on-board ADCs of
-	  the Samsung S3C24XX, S3C64XX and other series of SoC
-
-	  This driver can also be built as a module. If so, the module
-	  will be called s3c-hwmon.
-
-config SENSORS_S3C_RAW
-	bool "Include raw channel attributes in sysfs"
-	depends on SENSORS_S3C
-	help
-	  Say Y here if you want to include raw copies of all the ADC
-	  channels in sysfs.
-
 config SENSORS_SIS5595
 	tristate "Silicon Integrated Systems Corp. SiS5595"
 	depends on PCI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 11d076cad8a2..b5a401ce3285 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -173,7 +173,6 @@ obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
 obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
-obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
 obj-$(CONFIG_SENSORS_SBTSI)	+= sbtsi_temp.o
 obj-$(CONFIG_SENSORS_SBRMI)	+= sbrmi.o
 obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
deleted file mode 100644
index 70ae665db477..000000000000
-- 
2.29.2

