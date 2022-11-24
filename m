Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3BF638058
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiKXUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXUtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:49:11 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39B17F59B;
        Thu, 24 Nov 2022 12:49:06 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id AEBCA5FD23;
        Thu, 24 Nov 2022 23:49:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669322943;
        bh=brM4h7l+r2/qt2dvTAPRhbdaOdy/VOj12fwkLSiJtlA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=LIjhVO/u7qZCJIdXKZjrooAIdzS4uBkKIzYg1NbdB+tfQUyL6hVZn+Q6AQJwAqRNo
         cj2W+0mcj4vzg4HsWHtW91/ViKHji51SplS265eNHjSdnMckTU1Dhgc1xeXmGFVamx
         sCX2QMp7qEBw7YwZP3CKKdUEMpHBkfDL3cQvGQ89+5pbvwCVHlId4p09PxlNu18jUp
         3W87X+K5FJbL2sVrfYABvT6IU5LqKUqzGBXA1lTSR/xr8IpKnyM/j8jih/BjL42WvH
         0d1tjhhPEgLKGFIoZo2nlDj77HAM5iGbhrXv4zBUxQdwEVvqKuJlGKLKxNg29014Ec
         lFMkKoIhml/Rg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 24 Nov 2022 23:49:02 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v1 0/2] leds: add aw20xx driver
Date:   Thu, 24 Nov 2022 23:48:05 +0300
Message-ID: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/24 17:43:00 #20605348
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for AWINIC AW20036/AW20054/AW20072 LED
driver programmed via an I2C interface.

This driver supports following AW200XX features:
  - 3 pattern controllers for auto breathing or group dimming control
  - Individual 64-level DIM currents
  - Interrupt output, low active

Datasheet:
  aw20036 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151532_5eb65894d205a.pdf
  aw20054 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151602_5eb658b2b77cb.pdf
  aw20072 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151754_5eb659227a145.pdf

Add YAML dt-binding schema for AW200XX.

Martin Kurbanov (2):
  dt-bindings: leds: add binding for aw200xx
  leds: add aw20xx driver

 .../bindings/leds/leds-aw200xx.yaml           |  110 ++
 Documentation/leds/leds-aw200xx.rst           |  274 ++++
 drivers/leds/Kconfig                          |   10 +
 drivers/leds/Makefile                         |    1 +
 drivers/leds/leds-aw200xx.c                   | 1113 +++++++++++++++++
 include/dt-bindings/leds/leds-aw200xx.h       |   48 +
 6 files changed, 1556 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-aw200xx.yaml
 create mode 100644 Documentation/leds/leds-aw200xx.rst
 create mode 100644 drivers/leds/leds-aw200xx.c
 create mode 100644 include/dt-bindings/leds/leds-aw200xx.h

--
2.38.1

