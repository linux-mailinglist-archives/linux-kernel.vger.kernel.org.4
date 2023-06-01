Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79B571F3BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjFAUTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjFAUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:18:59 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E82189;
        Thu,  1 Jun 2023 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=y3U29OdGYnWI7nRjUE4swAS8wMfZs8WQacOrKlYJv4E=; b=NpuWCONxJ3EBAx+spoqZnQLQMQ
        SUlRvNHUGrLvuPG5q9SnMUBMYX3K71rwUyIZzYWhIyDSyfTyRIkIFbS5XV1NkxdZhJVbnH/97BfPL
        0mZm1hqZHCAdKAuD4xX8pk0F6bvdFIKzA9QDWhjYzdbOUicGhWGDSxEzOYVfNr6hPC+0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:39204 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q4okx-000686-ED; Thu, 01 Jun 2023 16:18:48 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu,  1 Jun 2023 16:18:35 -0400
Message-Id: <20230601201844.3739926-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v6 0/9] serial: sc16is7xx: fix GPIO regression and rs485 improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series mainly fixes a GPIO regression and improve RS485 flags and
properties detection from DT.

It now also includes various small fixes and improvements that were previously
sent as separate patches, but that made testing everything difficult.

Patch 1 fixes an issue with init of first port during probing.

Patch 2 fixes an issue when debugging IOcontrol register, but it is also
necessary for patch "fix regression with GPIO configuration" to work.

Patch 3 is a refactor of GPIO registration code in preparation for patch 5.

Patches 4 and 5 fix a GPIO regression by (re)allowing to choose GPIO function
for GPIO pins shared with modem status lines.

Patch 6 fixes a bug with the output value when first setting the GPIO direction.

Patch 7 allows to read common rs485 device-tree flags and properties.

Patch 8 introduces a delay after a reset operation to respect datasheet
timing recommandations.

Patch 9 improves comments about chip variants.

I have tested the changes on a custom board with two SC16IS752 DUART using a
Variscite IMX8MN NANO SOM.

Thank you.

Link: [v1] https://lkml.org/lkml/2023/5/17/967
      [v1] https://lkml.org/lkml/2023/5/17/777
      [v1] https://lkml.org/lkml/2023/5/17/780
      [v1] https://lkml.org/lkml/2023/5/17/785
      [v1] https://lkml.org/lkml/2023/5/17/1311
      [v2] https://lkml.org/lkml/2023/5/18/516
      [v3] https://lkml.org/lkml/2023/5/25/7
      [v4] https://lkml.org/lkml/2023/5/29/656

Changes for V3:
- Integrated all patches into single serie to facilitate debugging and tests.
- Reduce number of exported GPIOs depending on new property
  nxp,modem-control-line-ports
- Added additional example in DT bindings

Changes for V4:
- Increase reset post delay to relax scheduler.
- Put comments patches at the end.
- Remove Fixes tag for patch "mark IOCONTROL register as volatile".
- Improve commit messages after reviews.
- Fix coding style issues after reviews.
- Change GPIO registration to always register the maximum number of GPIOs
  supported by the chip, but maks-out GPIOs declared as modem control lines.
- Add patch to refactor GPIO registration.
- Remove patch "serial: sc16is7xx: fix syntax error in comments".
- Remove patch "add dump registers function"

Changes for V5:
- Change patch order to facilitate stable backport(s).
- Change duplicate device addresses in DT binding examples.
- Use GENMASK for bit masks.
- Replace of_property_for_each_u32() with device_property_read_u32_array
- Add "Cc: stable..." tags

Changes for V6:
- Fix compilation bug introduced by patch 3

Hugo Villeneuve (9):
  serial: sc16is7xx: fix broken port 0 uart init
  serial: sc16is7xx: mark IOCONTROL register as volatile
  serial: sc16is7xx: refactor GPIO controller registration
  dt-bindings: sc16is7xx: Add property to change GPIO function
  serial: sc16is7xx: fix regression with GPIO configuration
  serial: sc16is7xx: fix bug when first setting GPIO direction
  serial: sc16is7xx: add call to get rs485 DT flags and properties
  serial: sc16is7xx: add post reset delay
  serial: sc16is7xx: improve comments about variants

 .../bindings/serial/nxp,sc16is7xx.txt         |  46 +++++
 drivers/tty/serial/sc16is7xx.c                | 168 +++++++++++++-----
 2 files changed, 174 insertions(+), 40 deletions(-)


base-commit: 929ed21dfdb6ee94391db51c9eedb63314ef6847
-- 
2.30.2

