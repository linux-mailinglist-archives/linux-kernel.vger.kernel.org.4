Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7886F2B53
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 00:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjD3WL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 18:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjD3WLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 18:11:55 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD7125
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 15:11:53 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6A07420002;
        Sun, 30 Apr 2023 22:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682892712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=S0PUlY9cWCsgaEVIJLp36/CNwq+4HYBHE9hsb/7K+jY=;
        b=JKFHbnn0HjZJRK5DbCHEELOHeT8yAPecugKohzLt2cxZdE7/A6S04KtQ4vUbzaZvCuB4WU
        r8PwFwH8kQdT4Ypkg/WK8UEyjAzU2i0gu0X1X8lyGm4qYWlogaWFqurt9UX59XIEEyiv9X
        kOW9LgJgplF9x4p5bckpbIfne/fpzk3fQ7TY7pMzoYE0MmAnk0o6mndJb5gTbmGgqyUC3/
        z8KF67FHMZdkBdOz/6klOdqzKFN0ynhz14uf9nEEPE4sc5Iq9eBUjiFJPCGe8pmcCKJQ5m
        4LRfFDBhqKXuEGJf8ac/EaY0/yiWs/eCr/oONTNoOtYYQ+LxQyCO2UbkrT+fXw==
Date:   Mon, 1 May 2023 00:11:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.4
Message-ID: <20230430221151c27da7d9@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the i3c subsytem pull request for 6.4. Most of the changes are
there to support a new driver, mostly reusing the existing DW driver.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.4

for you to fetch changes up to 6b496a94c5905fca7879bc0dc438a47de40b7d4f:

  i3c: ast2600: set variable ast2600_i3c_ops storage-class-specifier to static (2023-04-30 23:50:26 +0200)

----------------------------------------------------------------
I3C for 6.4

Subsystem:
 - OF alias bus numbering
 - convert to platform remove callback returning void

New driver: AST2600 controller, based on Synopsys DesignWare IP

Drivers:
 - dw: add infrastructure to support different platform integrations

----------------------------------------------------------------
Andy Shevchenko (1):
      i3c: Correct reference to the I²C device data type

Jeremy Kerr (11):
      i3c: dw: use bus mode rather than device reg for conditional tCAS setting
      i3c: dw: Add infrastructure for platform-specific implementations
      dt-bindings: i3c: Add AST2600 i3c controller
      i3c: ast2600: Add AST2600 platform-specific driver
      i3c: Allow OF-alias-based persistent bus numbering
      i3c: dw: Create a generic fifo read function
      i3c: dw: Turn DAT array entry into a struct
      i3c: dw: Add support for in-band interrupts
      i3c: dw: Add a platform facility for IBI PEC workarounds
      i3c: ast2600: enable IBI support
      i3c: ast2600: fix register setting for 545 ohm pullups

Krzysztof Kozlowski (1):
      i3c: dw: drop of_match_ptr for ID table

Matt Johnston (1):
      i3c: dw: Return the length from a read priv_xfer

Tom Rix (1):
      i3c: ast2600: set variable ast2600_i3c_ops storage-class-specifier to static

Uwe Kleine-König (5):
      i3c: Make i3c_master_unregister() return void
      i3c: dw: Convert to platform remove callback returning void
      i3c: cdns: Convert to platform remove callback returning void
      i3c: mipi-i3c-hci: Convert to platform remove callback returning void
      i3c: svc: Convert to platform remove callback returning void

 .../bindings/i3c/aspeed,ast2600-i3c.yaml           |  72 ++++
 MAINTAINERS                                        |   6 +
 drivers/i3c/master.c                               |  36 +-
 drivers/i3c/master/Kconfig                         |  14 +
 drivers/i3c/master/Makefile                        |   1 +
 drivers/i3c/master/ast2600-i3c-master.c            | 189 +++++++++
 drivers/i3c/master/dw-i3c-master.c                 | 435 ++++++++++++++++++---
 drivers/i3c/master/dw-i3c-master.h                 |  84 ++++
 drivers/i3c/master/i3c-master-cdns.c               |  11 +-
 drivers/i3c/master/mipi-i3c-hci/core.c             |   6 +-
 drivers/i3c/master/svc-i3c-master.c                |  11 +-
 include/linux/i3c/master.h                         |   5 +-
 12 files changed, 779 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
 create mode 100644 drivers/i3c/master/ast2600-i3c-master.c
 create mode 100644 drivers/i3c/master/dw-i3c-master.h

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
