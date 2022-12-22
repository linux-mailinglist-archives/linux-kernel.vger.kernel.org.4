Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544FF654749
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiLVUhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiLVUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:37:00 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F5520BE1;
        Thu, 22 Dec 2022 12:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=vuWOTfKuoqimGP9F3MtcglDHIino9so3a/7+/AE/35M=; b=y
        5GkQ88xn6kFPZzsT36DO5e403WKD6ikk2O+WBtCbDlRr6ImdPh4PFvJrsuVbB9zrcrTvW7y0ubk5U
        A0vs4rb6okChazf+GMm12CYOJwYo4pkBiie7Em8X+NdYrr99Yr3L5jfDSzRI87lW/yPgmxRFQ64C8
        ECdtE/LkZC5vlJck=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48920 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p8SJ7-000070-U4; Thu, 22 Dec 2022 15:36:50 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com
Date:   Thu, 22 Dec 2022 15:36:07 -0500
Message-Id: <20221222203610.2571287-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v1 0/3] iio: adc: ti-ads7924: add ADS7924 driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series adds the driver for the Texas Instruments ADS7924.

The Texas Instruments ADS7924 is a 4 channels, 12-bit analog to
digital converter (ADC) with an I2C interface.

Patch 1 adds a Kconfig comment to help differentiate between the Analog
      Devices AD7924 (SPI) and the TI ADS7924 (I2C).

Patch 2 contains the driver for the ADS7924.

Patch 3 add the dt-bindings for the ADS7924.

I have tested the driver using the Texas Instruments ADS7924EVM board connected
to a Variscite Symphony EVK with a IMX8MN NANO SOM:
  - Tested reset pin Ok
  - Tested regulator setup Ok
  - Tested reading sysfs in_voltage_scale Ok
  - Tested reading sysfs in_voltageX_raw (x=0 to 3) Ok


Thank you.

Hugo Villeneuve (3):
  iio: adc: Kconfig: add SPI interface mention to AD7924 description
  iio: adc: ti-ads7924: add ADS7924 driver
  dt-bindings: iio: adc: add ADS7924

 .../bindings/iio/adc/ti,ads7924.yaml          | 103 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  15 +-
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads7924.c                  | 514 ++++++++++++++++++
 5 files changed, 639 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
 create mode 100644 drivers/iio/adc/ti-ads7924.c


base-commit: 4652bc537a2e0b44959489f45e4684fa4f143a45
-- 
2.30.2

