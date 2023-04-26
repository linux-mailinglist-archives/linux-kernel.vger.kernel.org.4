Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665026EEF75
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbjDZHlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbjDZHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:41:12 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786DF30F1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:41:10 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D3ADB5FD6E;
        Wed, 26 Apr 2023 10:41:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682494868;
        bh=kH/83HIe7gsu4U9b3IuFMWDR2wI8ee/0EC6PkeDFzmU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=SUngLhDqkuszemhCr2x9A+KNk8qzjMksyz4wnTJcvasJ0eJyXTyERFugEJOKXvECM
         cpBJEZ4mvjO5vk9A41bVxBD9sDPaDBeiR9TY4xDFUQp5jkdTiKY07+wopi/Xh+v3AS
         EAoCWRZEL09NC36XGx7DQjq7/uPdgfUqzELyX/pz+68nvONqgBthCDn2+Ko0u42QhP
         9NLfUHCW17wFGaZ2fnIjeA0DcyUAmP1iKttZah9f2pvtsx+j7I1gNdVzNtVH/kw1sS
         fEF7Wml4jSk1JvOVaxjoJ4YkKu1GEhS9dRt3KBZUui51kaawg5JfnhBYUU+9MqtoF4
         9cAdd3hDDyCaA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 26 Apr 2023 10:41:07 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] refactoring and fix for Meson NAND
Date:   Wed, 26 Apr 2023 10:36:26 +0300
Message-ID: <20230426073632.3905682-1-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/26 04:45:00 #21166225
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

Hello,

this patchset does several things:

1) It fixes unstable behaviour of Meson driver, for example random ECC
   errors during reads. It is done by changing command sequence to access
   NAND controller. Source of this update is old vendor's driver.

2) It changes OOB layout by moving it out of ECC area. Current OOB data
   is 4 bytes (2 x 2 user bytes) under ECC engine. Here is how OOB looks
   in the current implementation:

   [ 2B user bytes ][     14B ECC codes    ]
   [ 2B user bytes ][     14B ECC codes    ]
   [ 16B unused area, not protected by ECC ]
   [ 16B unused area, not protected by ECC ]

   All 4 user bytes are protected by ECC. This patch changes OOB layout
   in this way:

   [ 2B unused area ][    14B ECC codes    ]
   [ 2B unused area ][    14B ECC codes    ]
   [  16B OOB area, not protected by ECC   ]
   [  16B OOB area, not protected by ECC   ]

   Now OOB is 32 bytes instead of 4 bytes and not protected by ECC.
   Origin of this layout comes from problem with JFFS2. It uses OOB for
   cleanmarkers. Each cleanmarker is 4 bytes and written by JFFS2 driver.
   We have two ways to write this data to OOB (e.g. user bytes):

   1) ECC mode. In this case it will be ECC covered user bytes, e.g.
      writing this bytes will update ECC codes. Problem fires, when
      JFFS2 tries to write this page later - this write makes controller
      to update ECC codes again, but it is impossible to do it correctly,
      because we can't update bits from 0 to 1 (only from 1 to 0).

   2) Raw mode. In this case ECC codes won't be updated. But later, it
      will be impossible to read this page in ECC mode, because we have
      some user bytes, but ECC codes are missed.

   So let's move OOB out of ECC area. In this case we can read/write OOB
   separately in raw mode and at the same time work with data in ECC
   mode. JFFS2 is happy now. User bytes are untouched - all of them
   are ignored during non-OOB access.

   Also this patch changes size of OOB data during read. Now whole OOB
   is read (including unused user bytes, ECC codes and OOB data itself).

   I've tested this with mount/unmount/read/write cases for JFFS2 and
   nanddump/nandwrite utlities on AXG family (A113X SoC).

3) Renames device tree node's name for chip selection from "reg" to
   "cs". See commit message.

4) Checks buffer length on accesses to NAND controller.

5) Removes useless bitwise OR with zeroes.

Link to v1:
https://lore.kernel.org/linux-mtd/20230412061700.1492474-1-AVKrasnov@sberdevices.ru/

Arseniy Krasnov (5):
  mtd: rawnand: meson: fix NAND access for read/write
  mtd: rawnand: meson: move OOB to non-protected ECC area
  mtd: rawnand: meson: check buffer length
  mtd: rawnand: meson: remove unneeded bitwise OR with zeroes
  mtd: rawnand: meson: rename node for chip select

 drivers/mtd/nand/raw/meson_nand.c | 406 +++++++++++++++++++++++++-----
 1 file changed, 347 insertions(+), 59 deletions(-)

-- 
2.35.0

