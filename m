Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9669A880
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBQJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjBQJoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:44:18 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E17697;
        Fri, 17 Feb 2023 01:44:15 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=942639ee83=fe@dev.tdt.de>)
        id 1pSxHl-000Dfw-Ss; Fri, 17 Feb 2023 10:44:09 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pSxHl-000Rdg-2Z; Fri, 17 Feb 2023 10:44:09 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 93FB624004B;
        Fri, 17 Feb 2023 10:44:08 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id F0BBC240040;
        Fri, 17 Feb 2023 10:44:07 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 822432D99D;
        Fri, 17 Feb 2023 10:44:07 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: [PATCH v2 0/2] leds: ledtrig-tty: add tty_led_mode xtension
Date:   Fri, 17 Feb 2023 10:44:01 +0100
Message-ID: <20230217094403.1574468-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1676627049-0EBEFD43-FFE09A86/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here commes v2 of this series to add additional tty_led_modes.
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
 drivers/tty/tty_io.c                          |  30 +++-
 include/linux/tty.h                           |   1 +
 4 files changed, 171 insertions(+), 22 deletions(-)

--=20
2.30.2

