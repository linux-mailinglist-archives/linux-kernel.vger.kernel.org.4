Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821066FDC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjEJLNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjEJLNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:13:39 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430E0CA
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:13:36 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id EEBAC5FD25;
        Wed, 10 May 2023 14:13:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683717213;
        bh=uollVllf8CsJmg+HTzE1IZw+V5QoVIvlypA/+IRrYGE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=It8ZZOW/gp32VbD3QozcRaKQb3QujaBLVXCRqv9RgO9Mefd4Fh3AeYBnGdy5+dJfl
         kz4LtSBawef/GodO/ic8ZIBxIykvkj0ORPQH1R3Ab9XWAXSzfbWh0NoKJQmylIMQKS
         61k0xKmt6ZsXM2Ifm1CIfZ7YkKg0XA1+5oYm/7ReElIGrlArdS54UhifmCZJfrqWEF
         4ZROY+/GfKG4Qkv6TJjVDTtRhp6sbsVHRV2JK6+yL4xAEb8UAIN2B4YZRpu7CP4zZW
         m6OyjUPqVcQ3AulYMadd3hIxvijR6CDm6HB+oWZByT4H/w3waEKbehUMknpNGSZ7AW
         vK0f8Yiv+VpBA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 10 May 2023 14:13:30 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/6] refactoring and fix for Meson NAND
Date:   Wed, 10 May 2023 14:08:28 +0300
Message-ID: <20230510110835.26115-1-AVKrasnov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/10 09:03:00 #21252424
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
   errors during reads. It is done by changing 'meson_nfc_queue_rb()'
   implementation. Sequence of commands inside this function is updated.
   This patch is suggested by Liang Yang <liang.yang@amlogic.com>.

   Here is link to discussion:
   https://lore.kernel.org/linux-mtd/a9f8307a-77d7-a69f-ce11-2629909172d2@sberdevices.ru/T/#ma8097bad0228f81a3d11a14389cdec44f45b86c8

2) It moves OOB free bytes to non-protected by ECC area. Here are some
   details:

   Current OOB free bytes are 4 bytes (2 x 2 user bytes) under ECC engine.
   Here is how it looks like in the current implementation:

   [ 2B user bytes ][     14B ECC codes    ]
   [ 2B user bytes ][     14B ECC codes    ]
   [ 16B unused area, not protected by ECC ]
   [ 16B unused area, not protected by ECC ]

   All 4 user bytes are protected by ECC. This patch changes OOB free
   bytes in this way:

   [ 2B unused area ][     14B ECC codes     ]
   [ 2B unused area ][     14B ECC codes     ]
   [  16B user bytes, not protected by ECC   ]
   [  16B user bytes, not protected by ECC   ]

   Now OOB user bytes are 32 bytes instead of 4 bytes and not protected
   by ECC.

   Motivation of this layout comes from problem with JFFS2. It uses OOB
   free bytes for cleanmarkers. Each cleanmarker is 4 bytes and written
   by JFFS2 driver (small remark - cleanmarkers are always written in
   case of NAND storage for JFFS2).
   We have two ways to write this data to OOB (e.g. user bytes):

   1) ECC mode. In this case it will be ECC covered user bytes, e.g.
      writing this bytes will update ECC codes. Problem fires, when
      JFFS2 tries to write this page later - this write makes controller
      to update ECC codes again, but it is impossible to do it correctly,
      because we can't update bits from 0 to 1 (only from 1 to 0).

   2) Raw mode. In this case ECC codes won't be updated. But later, it
      will be impossible to read this page in ECC mode, because we have
      some user bytes, but ECC codes are missed.

   So let's move OOB free bytes out of ECC area. In this case we can
   read/write OOB separately in raw mode and at the same time work with
   data in ECC mode. JFFS2 is happy now. User bytes are untouched - all
   of them are ignored during non-OOB access.

   I've tested this with mount/unmount/read/write cases for JFFS2 and
   nanddump/nandwrite utlities on AXG family (A113X SoC).

   Here is link to discussion:
   https://lore.kernel.org/linux-mtd/a9f8307a-77d7-a69f-ce11-2629909172d2@sberdevices.ru/T/#m3087bd06386a7f430cd5e343e22b25d724d3e2d7

3) Changes size of OOB read access - now, in both ECC and raw modes whole
   OOB (e.g. 64 bytes) is returned to the caller.

4) Checks buffer length on accesses to NAND controller.

5) Removes useless bitwise OR with zeroes.

6) Renames device tree node's name for chip selection from "reg" to
   "cs". See commit message.

Link to v1:
https://lore.kernel.org/linux-mtd/20230412061700.1492474-1-AVKrasnov@sberdevices.ru/
Link to v2:
https://lore.kernel.org/linux-mtd/20230426073632.3905682-1-AVKrasnov@sberdevices.ru/

Arseniy Krasnov (6):
  mtd: rawnand: meson: fix command sequence for read/write
  mtd: rawnand: meson: move OOB to non-protected ECC area
  mtd: rawnand: meson: always read whole OOB bytes
  mtd: rawnand: meson: check buffer length
  mtd: rawnand: meson: remove unneeded bitwise OR with zeroes
  mtd: rawnand: meson: rename node for chip select

 drivers/mtd/nand/raw/meson_nand.c | 274 ++++++++++++++++++++++++------
 1 file changed, 222 insertions(+), 52 deletions(-)

-- 
2.35.0

