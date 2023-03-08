Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7516B023F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCHJCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCHJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:02:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094B596630;
        Wed,  8 Mar 2023 01:02:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ay14so59058960edb.11;
        Wed, 08 Mar 2023 01:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEBnaA7Pocw3dv+NsTA6Pe6Z7NrAaUzWWBCKZZ7bpik=;
        b=XUIxg1o+QTWEt4lY8LFNcNA6q9TOsxPd5LnR7Al1Ho74+ONybkBrE9xoh0LoUg3pue
         QZTkcVjfNlU+XvVeKKuEHo61q2rU1XAxZXUi24Bh56XarWx8SHuvMp0DTVrl0//u3WnY
         0GbOqKZdiFEXG0KM2lBru/BD9MOW8abOT0PyEPP/am15BvinLSiVbGhElLK6x2sOsJvH
         Jqu0xsCKuy+J+HIcdmibFJjOpXM+uAPCGrcxY39B8DmagFo/NvB9UN3WKgWHLonF7o7f
         nbyhCEeoPKGCUbYTLAzoOtQAc04uE09bGcjkFT6XG4/a5WPJBVZQLqmLf6a9Gnk7vnhI
         a7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEBnaA7Pocw3dv+NsTA6Pe6Z7NrAaUzWWBCKZZ7bpik=;
        b=Ff0vfCpCm+hLFh+sUVom/HqGvqZUJW0rhoalIFq+ws9/FHVhV0DjqfPf7d6JkIlfEm
         P89J05lEWXg+uNObamn9TSTimHjM2jaJPBS/9QhINIRd7sn9ljUIirvZHU/74QZWE6rR
         8JZOuHVh+HiPJSIp3pkxqpCoTREknoKAdZ3rO6h4k+9CZEbYAjzpBaTvAk+Of3nk4juq
         1GwIFxHjz1aigozqNfob4N8KnX15VdV9J1vmk3UvDQv0XSmp9UyChooyG8XYxZOoDy7L
         OtulX7nTDet+rtmTit1aftCal594d2hFehjqaIqTSxAf2UW0ggYsLqm9V5F+zyisyRja
         j3tw==
X-Gm-Message-State: AO0yUKV4S7kJWjigO7sBzjzgPPZOQQFv2V/aSfVNvMUxUyn0r5n13jWQ
        Ckujy6pTp7chz3mJZ6yxU/E=
X-Google-Smtp-Source: AK7set+gK3tu0aYc3/9HyceNCeSVYp/6QHEDkpiqGlrrd+bpN+n/S46i82CZx6AQzELESatZ8dWn9g==
X-Received: by 2002:a17:906:718d:b0:8b1:81eb:158f with SMTP id h13-20020a170906718d00b008b181eb158fmr17410801ejk.62.1678266151580;
        Wed, 08 Mar 2023 01:02:31 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090643c700b008caaae1f1e1sm7153709ejn.110.2023.03.08.01.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:02:31 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] iio: light: move apds990x into proper place
Date:   Wed,  8 Mar 2023 11:02:19 +0200
Message-Id: <20230308090219.12710-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308090219.12710-1-clamor95@gmail.com>
References: <20230308090219.12710-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since now apds990x supports IIO, it should be moved here from
misc folder.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/Kconfig              | 10 ++++++++++
 drivers/iio/light/Makefile             |  1 +
 drivers/{misc => iio/light}/apds990x.c |  0
 drivers/misc/Kconfig                   | 10 ----------
 drivers/misc/Makefile                  |  1 -
 5 files changed, 11 insertions(+), 11 deletions(-)
 rename drivers/{misc => iio/light}/apds990x.c (100%)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 0d4447df7200..49c17eb72c73 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -73,6 +73,16 @@ config APDS9300
 	  To compile this driver as a module, choose M here: the
 	  module will be called apds9300.
 
+config APDS990X
+	tristate "APDS990X combined als and proximity sensors"
+	depends on I2C
+	help
+	   Say Y here if you want to build a driver for Avago APDS990x
+	   combined ambient light and proximity sensor chip.
+
+	   To compile this driver as a module, choose M here: the
+	   module will be called apds990x. If unsure, say N here.
+
 config APDS9960
 	tristate "Avago APDS9960 gesture/RGB/ALS/proximity sensor"
 	select REGMAP_I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 6f23817fae6f..f1ff7934318b 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ADUX1020)		+= adux1020.o
 obj-$(CONFIG_AL3010)		+= al3010.o
 obj-$(CONFIG_AL3320A)		+= al3320a.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
+obj-$(CONFIG_APDS990X)		+= apds990x.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
 obj-$(CONFIG_AS73211)		+= as73211.o
 obj-$(CONFIG_BH1750)		+= bh1750.o
diff --git a/drivers/misc/apds990x.c b/drivers/iio/light/apds990x.c
similarity index 100%
rename from drivers/misc/apds990x.c
rename to drivers/iio/light/apds990x.c
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 9947b7892bd5..2856b6c57ca0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -359,16 +359,6 @@ config SENSORS_BH1770
 	   To compile this driver as a module, choose M here: the
 	   module will be called bh1770glc. If unsure, say N here.
 
-config SENSORS_APDS990X
-	 tristate "APDS990X combined als and proximity sensors"
-	 depends on I2C
-	help
-	   Say Y here if you want to build a driver for Avago APDS990x
-	   combined ambient light and proximity sensor chip.
-
-	   To compile this driver as a module, choose M here: the
-	   module will be called apds990x. If unsure, say N here.
-
 config HMC6352
 	tristate "Honeywell HMC6352 compass"
 	depends on I2C
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 87b54a4a4422..3e3e510cb315 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_PHANTOM)		+= phantom.o
 obj-$(CONFIG_QCOM_COINCELL)	+= qcom-coincell.o
 obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
 obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
-obj-$(CONFIG_SENSORS_APDS990X)	+= apds990x.o
 obj-$(CONFIG_ENCLOSURE_SERVICES) += enclosure.o
 obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
 obj-$(CONFIG_SGI_XP)		+= sgi-xp/
-- 
2.37.2

