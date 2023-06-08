Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2E972765D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjFHEwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjFHEwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:52:40 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED00E4A;
        Wed,  7 Jun 2023 21:52:38 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 53A345FD72;
        Thu,  8 Jun 2023 07:52:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686199956;
        bh=W+pJcKNPyHeJx9yigTrLfyd5QNmlHZFEYc5/9qUZfOI=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=OTfyvL5QuDbycRwAQXq0zp98Rg+v0Z9G8gghcP6uPGkpNwJxm/m356XZAVj9SL+UT
         9RmZhzMjDsXzYiTjgQ5zPScl/CHzwm07pl9BCp2XB/+2R70jg8h29x35Xb7nAMMr5n
         QcE+b9+rSlRixHLSH0zLqgia9rH2dBpCWkIni2s+WAL6FiWjqHS7OMyCdbjKIXpKD5
         jPoISB4FEe46xUe76nzLvdUbpG0+OsY3V+7Tr0k274QxX37WFfOBJx+fupa02KBUkS
         zXpG6lvqw6xQMXcKLCD7WTVlRntSFCW4Z0sDI6pWzinxSaN85cInj//EDbZ4WsMjgF
         oM1LU3oTVI6hQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  8 Jun 2023 07:52:35 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Meson NAND: waiting w/o wired ready/busy pin
Date:   Thu, 8 Jun 2023 07:47:26 +0300
Message-ID: <20230608044728.1328506-1-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/08 00:23:00 #21457426
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Main thing that this patchset adds is support for waiting for command
completion when there is no wired ready/busy pin. This is implemented
by using Meson specific command which operates without wired pin, but
supports interrupt driven waiting (default way for waiting without
hardware pin is 'nand_soft_waitrdy()' which uses software loop instead
of interrupt). To select which mode to use during driver initialization,
common NAND controller property is used - 'nand-rb'. It is described in
'nand-controller.yaml'. But for Meson, its description was missed in
'amlogic,meson-nand.yaml', so this patchset also adds support for it.

Patch for bindings was tested with dt_binding_check and dtbs_check.

Links:
 v1 (as two separate patches):
  https://lore.kernel.org/linux-mtd/20230606193507.35024-1-AVKrasnov@sberdevices.ru/
  https://lore.kernel.org/linux-mtd/20230607073015.1280085-1-AVKrasnov@sberdevices.ru/

 v2 (tagged as v1, but consider it as v2):
  https://lore.kernel.org/linux-mtd/20230607145026.2899547-1-AVKrasnov@sberdevices.ru/

Changelog:
 v1 -> v2:
  * Two separate patches:
    For bindings: https://lore.kernel.org/linux-mtd/20230606193507.35024-1-AVKrasnov@sberdevices.ru/
    For driver: https://lore.kernel.org/linux-mtd/20230607073015.1280085-1-AVKrasnov@sberdevices.ru/
    Now fixed/updated and combined to this patchset with v1 version.
  
  * In binding patch:
    * Invalid type of 'nand-rb' is fixed, it was 'bool', now it is 'uint32 array' as required. Also
      new declaration of 'nand-rb' contains several restrictions like number of elements and min/max
      value of elements.
    * Location of 'nand-rb' is moved from the controller object to the chip object as required.
  
  * In driver patch:
    * Update comment which describes when it is needed to send NAND_CMD_READ0 to
      leave command waiting loop.
    * Change type of 'no_rb_pin' to 'bool' as in v1. Now it is just a flag which selects
      mode to wait for command completion.

 v2 -> v3:
  * In binding patch:
    * 'minimum' property is dropped, because 'nand-rb' is unsigned.

  * In driver patch:
    * Logic of 'no_rb_pin' parsing is reworked a little bit. For example to return error
      code from 'of_property_read_u32()'.

Arseniy Krasnov (2):
  dt-bindings: nand: meson: Fix 'nand-rb' property
  mtd: rawnand: meson: waiting w/o wired ready/busy pin

 .../bindings/mtd/amlogic,meson-nand.yaml      |  6 ++
 drivers/mtd/nand/raw/meson_nand.c             | 77 ++++++++++++++++++-
 2 files changed, 79 insertions(+), 4 deletions(-)

-- 
2.35.0

