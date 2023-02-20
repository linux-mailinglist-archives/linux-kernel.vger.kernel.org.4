Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF769C7C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjBTJh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBTJh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:37:56 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DF161A0;
        Mon, 20 Feb 2023 01:37:54 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9429674533=fe@dev.tdt.de>)
        id 1pU2cG-0007oA-A4; Mon, 20 Feb 2023 10:37:48 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pU2cF-000W8J-F3; Mon, 20 Feb 2023 10:37:47 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 0C47124004D;
        Mon, 20 Feb 2023 10:37:47 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 73E18240040;
        Mon, 20 Feb 2023 10:37:46 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id B48CC2D1E4;
        Mon, 20 Feb 2023 10:37:45 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: [PATCH v3 0/2] leds: ledtrig-tty: add tty_led_mode xtension
Date:   Mon, 20 Feb 2023 10:37:37 +0100
Message-ID: <20230220093739.320478-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1676885868-2D6EF8D8-D70F8AA6/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here commes v3 of this series to add additional tty_led_modes.

v3:
Changes compared to the v2 patchset with
20230217094403.1574468-1-fe@dev.tdt.de are.

Addressed review comments by Greg K-H are:

tty.h:
- Fix first comment line and remark -%ENOTTY for the new function
  'tty_get_mget' to make a proper kernel doc.
- Add the return value -%ENOTTY again, I thought it was no longer needed.

v2:
Changes compared to the initial patchset with
20230213140638.620206-1-fe@dev.tdt.de are.

Addressed review comments by Jiri Slaby are:

tty.h:
- Fix compilation error because of wrong rebaseing
- Remove empty lines
- Use new 'tty_get_mget' in 'tty_tiocmget'

ledtrg-tty.c:
- Update commit description
- Use enum for tty_led_mod in struct ledtrig_tty_date
- Rename sysfs file from 'mode' to 'tty_led_mode'
- Change tty_led_mode show function to use loop instead of switch/case
- Change tty_led_mode store function to use loop instead of switch/case
- Check return value of function tty_get_mget

Florian Eckert (2):
  tty: new helper function tty_get_mget
  trigger: ledtrig-tty: add additional modes

 .../ABI/testing/sysfs-class-led-trigger-tty   |  16 ++
 drivers/leds/trigger/ledtrig-tty.c            | 146 ++++++++++++++++--
 drivers/tty/tty_io.c                          |  28 +++-
 include/linux/tty.h                           |   1 +
 4 files changed, 170 insertions(+), 21 deletions(-)

--=20
2.30.2

