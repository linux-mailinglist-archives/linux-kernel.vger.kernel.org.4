Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B62707296
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEQTxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEQTxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:53:00 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78E759E1;
        Wed, 17 May 2023 12:52:56 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 244BE5FD46;
        Wed, 17 May 2023 22:52:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684353174;
        bh=+c1or6lx/0BL441qXDPsYyKqZz6WlSg7vowBaqLWfAQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Z9XJXBRio82SW1XoyBQ8lC17AfugmYVIdqt8O52cehW5xd60P+u1Li4jDqBv+W8y7
         5riHRJZdAqkmFdoj0ThfPYOg3NYZ2Ts3yKH9AWv7gESQlqEOqLdmt/FqLtJgrfcF3+
         bq4xvddWmnyylxB1RurtUV25LeljzBTEDXhV/h5HtPdHFaFoVH6s5GesR6TovRj1CG
         bBFnCPZarfbtq/aHb5TiQFvUmvbAt6shbVp4+uZB1y8VcjqvB9rYktUAaBRm2e4Oyi
         99SmW0ofXknFPAgiEhdbalmSSFgHp7k/umO1wrvwWTSBdkKPP5wkKuT5uUjrd0BDhx
         fsCZ/4vX0IaSQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 17 May 2023 22:52:53 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v4 0/2] leds: add aw20xx driver
Date:   Wed, 17 May 2023 22:52:36 +0300
Message-ID: <20230517195238.34069-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/17 11:04:00 #21328336
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
 drivers/leds/leds-aw200xx.c                   | 593 ++++++++++++++++++
 5 files changed, 738 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
 create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
 create mode 100644 drivers/leds/leds-aw200xx.c

--
2.40.0

