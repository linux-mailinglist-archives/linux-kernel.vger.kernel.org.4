Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D4472636E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbjFGOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240423AbjFGOzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:55:41 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086AE1734;
        Wed,  7 Jun 2023 07:55:35 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 21CBA5FD6C;
        Wed,  7 Jun 2023 17:55:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686149734;
        bh=UYxiu6ewdp+Z+G0hkR1Ih5TEv7mk3kDcVza211h23bs=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Y4ea4ubPl2EX/G3JwfBKtSLh9YDYgcegMecXoCSFyohMyMHANghdnQJ2RMue8Vm4x
         NYArtsX9kHd194A73Jhg5A9eXPGzkk1IGt0D0tGjMjjg5+UhNMIkERg1+mHEl4XuI3
         avna8yXBdJ16ZWYiPoJNwE2vhk+orOOYaKNJlQDVIQpLTPs5EAZQIsJd2LSPaJX4PE
         EuQIdfDZBQ0zjBNDWJTuuIiCzD5CFVYB/ZCDG5NpFoCViAaxNPuy8ALrX7vC7CXfQL
         /Sssye0DFy8tAqVBgijCPmbX+wmwq3xEVRoMoZ1KQVPJlSrPykNeA7aJTSLp6SayiR
         3i80P0EU3uA/Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  7 Jun 2023 17:55:31 +0300 (MSK)
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
Subject: [PATCH v1 0/2] Meson NAND: waiting w/o wired ready/busy pin
Date:   Wed, 7 Jun 2023 17:50:23 +0300
Message-ID: <20230607145026.2899547-1-AVKrasnov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/07 09:39:00 #21450961
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

Arseniy Krasnov (2):
  dt-bindings: nand: meson: Fix 'nand-rb' property
  mtd: rawnand: meson: waiting w/o wired ready/busy pin

 .../bindings/mtd/amlogic,meson-nand.yaml      |  7 ++
 drivers/mtd/nand/raw/meson_nand.c             | 82 ++++++++++++++++++-
 2 files changed, 85 insertions(+), 4 deletions(-)

-- 
2.35.0

