Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3E7097F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjESNFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjESNEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:04:50 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB3D8;
        Fri, 19 May 2023 06:04:46 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 547AD5FFBF;
        Fri, 19 May 2023 16:04:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684501483;
        bh=HCxGQu5Ziev+/+dwkAk9uiRJEtmR/ivN/N2cwWC5VjA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=reXJ6mUVe2iieQBpPvHF8R4YbJvTI/CcvfLfvRbHlRPY+rrbZrsXxgK8VM0UbQIz8
         IQLMFEqX9aNnWwyid0tZvWr67lRMzo0j6Rj8MxRR4hNOuXD3un9ruaXFM3KQrPG2Ek
         ymCouz+W49XbpGnjbXa7RVudHbgTyvxeAyOsHpFjtus9k0DEX9ldm6P/o2l3fw3IOi
         ks5rbsBgv9Zx2QrUmbkYm+xgm+pcp5uzc11RaFy143rZCt4rXFXmVMEcFDk070RkfT
         fKTad92aCJ8NSc39x5GYVxBAAwRIgzfO3uq51SXR6yhe9i2TTZmUB1kH+objJmz4yC
         PgwcGgQKdcDnQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 19 May 2023 16:04:42 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v5 0/2] leds: add aw20xx driver
Date:   Fri, 19 May 2023 16:04:01 +0300
Message-ID: <20230519130403.212479-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/19 06:43:00 #21342157
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for AWINIC AW20036/AW20054/AW20072 LED
driver programmed via an I2C interface.

This driver supports following AW200XX features:
  - Individual 64-level DIM currents

Datasheet:
  aw20036 - https://www.awinic.com/en/productDetail/AW20036QNR#tech-docs
  aw20054 - https://www.awinic.com/en/productDetail/AW20054QNR#tech-docs
  aw20072 - https://www.awinic.com/en/productDetail/AW20072QNR#tech-docs

Add YAML dt-binding schema for AW200XX.

Changelog:
v4 -> v5:
  - Cosmetic changes (rename aw200xx_probe_dt() to aw200xx_probe_fw()
    and etc)

v3 -> v4:
  - Calculate the value of imax instead of retrieving it from a table
  - Cosmetic changes

v2 -> v3:
  - Update datasheet links
  - Make cosmetic changes as Andy suggested at [1]

v1 -> v2:
  - Remove the hardware pattern support (I will send a separate patch)
  - Support the 'led-max-microamp' property

[1] https://lore.kernel.org/all/20230228211046.109693-1-mmkurbanov@sberdevices.ru/

Martin Kurbanov (2):
  dt-bindings: leds: add binding for aw200xx
  leds: add aw20xx driver

 .../testing/sysfs-class-led-driver-aw200xx    |   5 +
 .../bindings/leds/awinic,aw200xx.yaml         | 126 ++++
 drivers/leds/Kconfig                          |  13 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-aw200xx.c                   | 594 ++++++++++++++++++
 5 files changed, 739 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
 create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
 create mode 100644 drivers/leds/leds-aw200xx.c

--
2.40.0

