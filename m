Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070A06A6108
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjB1VMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjB1VLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:11:53 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142F52CC40;
        Tue, 28 Feb 2023 13:11:29 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D4D3B5FD09;
        Wed,  1 Mar 2023 00:11:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677618685;
        bh=pgQxgtsN8c/gxCxs+9mAc2jJsLaDMPf7RRR/AHAAC4c=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=UFEi2oVntTZ+iFJX3/2p7kX3/86556SroG1zvxiKoWsXM5qw/BOknqeFBELWjTYIy
         aSvFjIyIUv1osAeylq6GmA2i811zh4F3icqw811OSk9ZDbyqiHy0rxb7nitgL0zZ4Q
         F7tfMp8G2ECZ2v/YeSNvR+MKEl47i3no0tWjkxeZaKGgh5Axfp28iOF4ttSZ4V0mrn
         9xJFcM1bZ1BD9QdSW/POD/yVRrFCuFBSbpzzKDFs+pWhrDhwI7SqXiupgZy2K4Yy67
         zgP0dv90fXsXcVdkFcp0xWeye0YRFP/FU/WGCYM1bRiCiEcgpYMJNvZP9ysTYMrBJh
         JOpqHB87nJ0pA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  1 Mar 2023 00:11:24 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v2 0/2] leds: add aw20xx driver
Date:   Wed, 1 Mar 2023 00:10:44 +0300
Message-ID: <20230228211046.109693-1-mmkurbanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/28 15:18:00 #20903376
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
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
  aw20036 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151532_5eb65894d205a.pdf
  aw20054 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151602_5eb658b2b77cb.pdf
  aw20072 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151754_5eb659227a145.pdf

Add YAML dt-binding schema for AW200XX.

Changelog:
 v1 -> v2:
  - Remove the hardware pattern support (I will send a separate patch)
  - Support the 'led-max-microamp' property

Martin Kurbanov (2):
  dt-bindings: leds: add binding for aw200xx
  leds: add aw20xx driver

 .../testing/sysfs-class-led-driver-aw200xx    |   4 +
 .../bindings/leds/awinic,aw200xx.yaml         | 126 ++++
 drivers/leds/Kconfig                          |  10 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
 5 files changed, 790 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
 create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
 create mode 100644 drivers/leds/leds-aw200xx.c

--
2.38.1

