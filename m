Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3C86DEBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjDLGV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDLGVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:21:23 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCC0AC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:21:18 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id BB8835FD5E;
        Wed, 12 Apr 2023 09:21:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681280475;
        bh=u85shc8UtLxBHDVt6LzqD5rR/vx0d1Zu3hb1jox2KPc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=jRSzYcXtKAvpDdJFuPpzbd8quTvf5jXkyOWPvx1u93IurGQB4HnicCsooLM0kZKc4
         utC1J8GcsiXtZZi24znZEpaLhCPH07V7fuDNNANb5e1IFYOOUrMjj5wcZZvx2UsHAW
         dWhI061Mh8CNUOfYmKNl0RbydZjA57gZT7EEKOtPfpV80KlWRLUPVObF3yCxnK82Px
         qwUWEozm3UKqV8bfOFP/vj7J2ntIniH7ClHTe9AKi39EGo/xfZTd0/+9HrLV08ZHdf
         mwATFrWEJ+56S7OILJbhHyhBeuSig/vLiin6WxtIATRAqNx7HaqYO0zri3HHeLyam+
         6PTSAQNhewUmQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 12 Apr 2023 09:21:13 +0300 (MSK)
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
Subject: [PATCH v1 0/5] refactoring and fix for Meson NAND
Date:   Wed, 12 Apr 2023 09:16:54 +0300
Message-ID: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/12 04:12:00 #21090163
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patchset adds one fix and several refactoring patches. First patch
is the most important - it fixes unstable behaviour of Meson driver, for
example random ECC errors during reads. I've tested this with mount/
unmount/read/write cases for JFFS2 and nanddump/nandwrite utlities on
AXG family (A113X SoC). Source of this update is old vendor's driver.

Other patches are refactoring and extra checks, not critical for this
driver's reliability.

Arseniy Krasnov (5):
  mtd: rawnand: meson: fix NAND access for read/write
  mtd: rawnand: meson: replace GENMASK() macro with define
  mtd: rawnand: meson: check buffer length
  mtd: rawnand: meson: clear OOB buffer before read
  mtd: rawnand: meson: remove unneeded bitwise OR with zeroes

 drivers/mtd/nand/raw/meson_nand.c | 147 ++++++++++++++++++++++++++----
 1 file changed, 127 insertions(+), 20 deletions(-)

-- 
2.35.0

