Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE86D5B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjDDJI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjDDJIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:08:09 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC98E1701;
        Tue,  4 Apr 2023 02:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680599276;
  x=1712135276;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=RzqcKnViHA1vh9MkOLSVfiaP03ZfbZpj3p4Of8+c/rY=;
  b=gdQo6A5dXxuSEZ42q1QgR4S3lyfbdz5yhM2V8oWmBFhtyQUVzpO/4VSI
   tceU50SANgGnV0AUigaEi52MJ1eq+etHdboqiBLLGxkA0kyaPeEM1Wc/V
   Qo12118LKFcFMUOJDUBB2MnUlqBDCIhWtXJCCBL4kZLm2XTy/xJKWnhL3
   /c13lqnRBDqGO71+2KPr/IC89hv1gjFBT/MGbLM+ot1glHiUQ7E72JXk/
   WE76fpgtR5A0oSURej0YgSYkUz3+3wN74V7n/jg4l49z4CodXM++hHHUY
   H+RntyCQqLIck5Q+YasNWIxx8bDoh4OFT6gNdBT5JgLofRJRyLwhWmmBv
   A==;
From:   Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Subject: [PATCH 0/2] Support for Texas Instruments OPT4001 Ambient Light
 Sensor
Date:   Tue, 4 Apr 2023 11:07:41 +0200
Message-ID: <20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN3oK2QC/x2NywrCQAwAf6XkbGAfIqy/Ih6yTbQ5uC1JKULpv
 7v1OAzD7OBiKg73YQeTTV3n1iFeBhgnam9B5c6QQsohp4zEjPOyXkOIyKabGJZSCxHfSo4Felj
 JBatRG6cz/ZCvYqdYTF76/d8ez+P4Aagybct9AAAA
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        <kernel@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Stefan Windfeldt-Prytz (2):
      dt-bindings: Document TI OPT4001 light sensor bindings
      iio: light: Add support for TI OPT4001 light sensor

 .../devicetree/bindings/iio/light/ti,opt4001.yaml  |  42 ++
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/opt4001.c                        | 487 +++++++++++++++++++++
 4 files changed, 541 insertions(+)
---
base-commit: 60c5238813fdfbe167eb579d58172106916b8db0
change-id: 20230323-add-opt4001-driver-99b9aad69319

Best regards,
-- 
Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>

