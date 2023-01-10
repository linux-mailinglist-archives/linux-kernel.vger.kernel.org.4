Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1BF664582
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjAJQBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjAJQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:01:43 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F2530573;
        Tue, 10 Jan 2023 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=miFsq10evK2AUsR0ohqfQseYfNauPyzSoumO+BvoMYU=; b=F
        X8J+peFwvKS3vlVoXjARlbrVFsqvE/tfKJcHv/QlPGisWjZ3u87JcuLU5ydkOQqPkNzUSlPxE83Qs
        ZbVNYXcnqbIWlNMiRlUM+vFbUOpmVwwbblgpF0RM4CEL/dotGu+GLceUuozy3aKoQiLW4ST26MDtL
        eSMypOEg1jGZ+DVg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41140 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pFH48-0007oY-UB; Tue, 10 Jan 2023 11:01:33 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com
Date:   Tue, 10 Jan 2023 11:01:22 -0500
Message-Id: <20230110160124.3853593-1-hugo@hugovil.com>
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
Subject: [PATCH v2 0/2] iio: adc: ti-ads7924: add Texas Instruments ADS7924 driver
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

Patch 1 contains the driver for the ADS7924.

Patch 2 add the dt-bindings for the ADS7924.

I have tested the driver using the Texas Instruments ADS7924EVM board connected
to a Variscite Symphony EVK with a IMX8MN NANO SOM:
  - Tested reset pin Ok
  - Tested regulator setup Ok
  - Tested reading sysfs in_voltage_scale Ok
  - Tested reading sysfs in_voltageX_raw (x=0 to 3) Ok

Thank you.

Link: [v1] https://lore.kernel.org/linux-iio/20221222203610.2571287-1-hugo@hugovil.com/#t

Changes for V2:
- Dropped patch "iio: adc: Kconfig: add SPI interface mention to AD7924
  description"
- Fixed comments style
- Removed unused defines/variables/etc related to buffered support (no buffered
  support for the moment).
- Convert of-specific code to use the generic firmware property accessors in
  include/linux/property.h.
- Use FIELD_GET / FIELD_PREP for bit operations/defines
- Simplified conversion result registers definitions/usage.
- Now using mutex lock/unlock only for INFO_RAW switch branch
- Use dev_err_probe() in all return paths of ads7924_probe()
- Removed ads7924_remove() after adding callbacks with
  devm_add_action_or_reset().
- Change iio_device_register() to devm_iio_device_register().
- Add the legacy i2c_device_id table
- DT bindings: reorder entries, fix indentation,improve comments, add interrupt
  line

Hugo Villeneuve (2):
  iio: adc: ti-ads7924: add Texas Instruments ADS7924 driver
  dt-bindings: iio: adc: add Texas Instruments ADS7924

 .../bindings/iio/adc/ti,ads7924.yaml          | 104 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads7924.c                  | 492 ++++++++++++++++++
 5 files changed, 615 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
 create mode 100644 drivers/iio/adc/ti-ads7924.c


base-commit: bfcae956d9b50ea0e221cefc171604c569017d7e
-- 
2.30.2

