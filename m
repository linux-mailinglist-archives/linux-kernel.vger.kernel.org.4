Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BC86EF3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbjDZL5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbjDZL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:57:50 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915AE4ECA;
        Wed, 26 Apr 2023 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1682510267;
  x=1714046267;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=/+zkU24+YOKn48BfDGvvRFLuyFTNYniTwcapIDJBP10=;
  b=WCyNnLEyQMfQnqhb5sG+kWVYtxnFCsvrchLraBW9PFj7oI2xPccOZYbG
   Oc5CyQluQmWs/zNUSRYvVtfVz8ofoEMtpvTtcjWBEr94PIE8BFOHgOb5e
   rUhBKjtK5HT3ezYHQQfZz3glSN9v7d7WlDr3qBZCedOJc3GvzqO+M4itL
   IMdIjiDh0fWreo920GErlHFGPI76caQRKsxJ2h1PcJjqSeIFEx3nBVj+i
   YWpS+LM6pJB1/TjLisq/51uGYd2SWJZ9kEm3cpK2GMGZbiy5S/J/KbVH7
   wfDf3+x8AUgVd1QKeYHxfNH5mHo4nMAMj0rxKw1EjgFCFehzMDHkKfoLZ
   Q==;
From:   Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Subject: [PATCH v3 0/2] Support for Texas Instruments OPT4001 Ambient Light
 Sensor
Date:   Wed, 26 Apr 2023 13:57:28 +0200
Message-ID: <20230323-add-opt4001-driver-v3-0-62e121dab294@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKgRSWQC/4WNzQ7CIBAGX6XhLIaf2hRPvofxsMBqObQ0S0Nqm
 r670JMnPc5uvpmNJaSAiV2bjRHmkEKcCuhTw9wA0wt58IWZEkoLrTQH73mcl1YIyT2FjMSNsQb
 Ad0ZLw8rQQkJuCSY31OkIaUGqj5nwGdajdn8UHkJaIr2PeJb1+rOTJRdcthfpnZPW9XCDNaSzi
 yOrtqz+G1QxCAsotOm7zvgvw77vH0Jfvd4OAQAA
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        <kernel@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Texas Instruments OPT4001 Ambient light sensor.

The light sensor has a i2c interface and supports continuous, oneshot and
interruptdriven measurements and has configurable conversion time and range.

This driver uses the sensors continuous mode so it always has a updated light
value available. The conversion time which is
 (integration time + time to set registers) which is used to configure
integration time through sysfs. The chip also has a configurable light
range which this driver sets to Auto where the chip chooses range itself
depending on previously read values.

Since the OPT4001 has different constants used to calculate lux values
depeding on packaging of the chip but uses the same device id, two compatible
string are used depending on the packaging, these are "ti,opt4001-picostar"
and "ti,opt4001-sot-5x3".

Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
---
Changes in v3:
- Removed unneccesary description from devicetree
- Use correct subject prefix for devicetree bindings
- No error on device id miss match
- Removed opt4001_settings as there was only one needed property int_time
- Link to v2: https://lore.kernel.org/r/20230323-add-opt4001-driver-v2-0-0bae0398669d@axis.com

Changes in v2:
- Added text about differences of sot-5x3 and picostar
- Added irq and regulator to devicetree bindings
- Added regulator support to driver
- Switched from using .remove to devm_action_or_reset
- Removed own mutex and reenabled regmaps
- Updated name in sysfs
- Added i2c_device_id
- Rename package_const to chip_info
- Link to v1: https://lore.kernel.org/r/20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com

---
Stefan Windfeldt-Prytz (2):
      dt-bindings: iio: light: Document TI OPT4001 light sensor
      iio: light: Add support for TI OPT4001 light sensor

 .../devicetree/bindings/iio/light/ti,opt4001.yaml  |  68 +++
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/opt4001.c                        | 467 +++++++++++++++++++++
 4 files changed, 547 insertions(+)
---
base-commit: 60c5238813fdfbe167eb579d58172106916b8db0
change-id: 20230323-add-opt4001-driver-99b9aad69319

Best regards,
-- 
Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>

