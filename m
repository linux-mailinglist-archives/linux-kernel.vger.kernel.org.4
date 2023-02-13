Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19116947F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBMOZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBMOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:25:02 -0500
X-Greylist: delayed 1087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Feb 2023 06:25:01 PST
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663871114C;
        Mon, 13 Feb 2023 06:25:01 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9422104eba=fe@dev.tdt.de>)
        id 1pRZTj-000EkA-Uo; Mon, 13 Feb 2023 15:06:47 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pRZTi-000Eju-Vh; Mon, 13 Feb 2023 15:06:47 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 9934424004B;
        Mon, 13 Feb 2023 15:06:46 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 12088240040;
        Mon, 13 Feb 2023 15:06:46 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 7FF132C02C;
        Mon, 13 Feb 2023 15:06:45 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: [PATCH 0/2] leds: ledtrig-tty: mode xtension
Date:   Mon, 13 Feb 2023 15:06:36 +0100
Message-ID: <20230213140638.620206-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1676297207-027EA4CC-6CEF58A5/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch set adds the possibility to change the tty trigger
modes. Until now, the LED is flashed when data is transmitted. With a
legacy serial interface there are additional signal lines.
If this line changes then the LED is turned on/off.

CTS: Clear To Send       -> DCE is ready to accept data from the DTE
DSR: Data Set Ready      -> DCE is ready to receive and send data.
CAR: Data Carrier Detect -> DCE is receiving a carrier from a remote DCE.
RNG: Ring Indicator      -> DCE has detected an incoming ring on the line=
.

Florian Eckert (2):
  tty: new helper function tty_get_mget
  leds: trigger: ledtrig-tty: add additional modes

 .../ABI/testing/sysfs-class-led-trigger-tty   |  16 ++
 drivers/leds/trigger/ledtrig-tty.c            | 148 ++++++++++++++++--
 drivers/tty/tty_io.c                          |  32 +++-
 include/linux/tty.h                           |   3 +-
 4 files changed, 176 insertions(+), 23 deletions(-)

--=20
2.30.2

