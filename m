Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6414A608046
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJUUv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJUUvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:51:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C192764CC;
        Fri, 21 Oct 2022 13:51:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A48161F77;
        Fri, 21 Oct 2022 20:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68873C433D6;
        Fri, 21 Oct 2022 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385472;
        bh=RKpA4nt2U2YtYq4jXSxCZ103mCSzFSOLruLsahkGkQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATNDWpNNHQ+NeNht462jziPxEpW1xCz2zbxLXKlES+y1EMkj4t7dB7MOE5xaLmuK2
         KC+l2nk5PeVoky3qImkBFpFijHtkU70BS1/iFs4HUi59+bG2oIQBjno7tUgFw0kNpD
         vXjGC2i+3bCc2rGlToBb4AzR8JaeKin8rJ0R7dA5h7ReeX97lUavHtNKG4/JRNwLPh
         Tx2YFKo06BAJnv5Mt2pkVjiNKSJNtw60IbajbwNHM4zxMDx8C9JhQn15aijpwien1V
         p6nQYOfZ0NQMIua8X/tl5yMkBSUkFy3tkztF6QNR6YWd2WOosFvyjw5g5ru2UggZYr
         582vkGi+zz+0w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 17/21] input: remove s3c24xx touchscreen driver
Date:   Fri, 21 Oct 2022 22:27:50 +0200
Message-Id: <20221021203329.4143397-17-arnd@kernel.org>
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

The s3c24xx SoC support and its adc driver was removed, so this driver
has no remaining users.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/Kconfig      |  12 -
 drivers/input/touchscreen/Makefile     |   1 -
 drivers/input/touchscreen/s3c2410_ts.c | 464 -------------------------
 3 files changed, 477 deletions(-)
 delete mode 100644 drivers/input/touchscreen/s3c2410_ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 4fde2b93b990..4d451640a223 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -462,18 +462,6 @@ config TOUCHSCREEN_IPROC
 	  To compile this driver as a module, choose M here: the
 	  module will be called bcm_iproc_tsc.
 
-config TOUCHSCREEN_S3C2410
-	tristate "Samsung S3C2410/generic touchscreen input driver"
-	depends on ARCH_S3C24XX || SAMSUNG_DEV_TS
-	depends on S3C_ADC
-	help
-	  Say Y here if you have the s3c2410 touchscreen.
-
-	  If unsure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called s3c2410_ts.
-
 config TOUCHSCREEN_S6SY761
 	tristate "Samsung S6SY761 Touchscreen driver"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 533a80ad054c..eb53d652c935 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -73,7 +73,6 @@ obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
 obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
 obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+= pixcir_i2c_ts.o
 obj-$(CONFIG_TOUCHSCREEN_RM_TS)		+= raydium_i2c_ts.o
-obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+= s3c2410_ts.o
 obj-$(CONFIG_TOUCHSCREEN_S6SY761)	+= s6sy761.o
 obj-$(CONFIG_TOUCHSCREEN_SILEAD)	+= silead.o
 obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)	+= sis_i2c.o
diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
deleted file mode 100644
index 2e70c0b79444..000000000000
-- 
2.29.2

