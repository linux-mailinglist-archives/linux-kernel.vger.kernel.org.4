Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC46B9803
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjCNOa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCNOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:30:30 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DE22C654;
        Tue, 14 Mar 2023 07:30:24 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C80C55FD62;
        Tue, 14 Mar 2023 15:03:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678795380;
        bh=jjpy6DCx05VoZ+mAapsIt74dyDOi6BiXXaYW1L+8OeA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=BO+/6xXjLHbfTrjKomCsZYI90orCZj9neHT8C1hHGvIPQ5VW71qVlKae+s2OlRSaJ
         a77fNW+BdVVSDx9ad7XeSr3DN/cUkRcKSmlZbwk9VA1eXJAhH2YaNprKhqOCQ1VoIC
         b4zH7dn25Jpa5xOpzTKBu/n7J6QlCb+8S8SCgYrotnX6xe4kfd+Fm2cBHE0BgAEGh6
         5kxd3g+/dswG4DrB1W1wXilDCLpmXuGYh2TfarTplCgw8h3odAe7JFS7CXc2iO9xOQ
         hagpVkJeCAeWaMRC/Lccm4toesY7/6czghogjLGpr4ZEFA3DjZ4SoJL9yaMcsbiqQz
         oJKpbcfXTJn1g==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 14 Mar 2023 15:02:59 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <devicetree@vger.kernel.org>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v3 0/2] leds: add aw20xx driver
Date:   Tue, 14 Mar 2023 15:02:50 +0300
Message-ID: <20230314120252.48263-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.37.2
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/14 06:01:00 #20942017
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/leds/Kconfig                          |  14 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-aw200xx.c                   | 638 ++++++++++++++++++
 5 files changed, 784 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
 create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
 create mode 100644 drivers/leds/leds-aw200xx.c

--
2.37.2

