Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29505FF5E8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJNWEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNWEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:04:23 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1278176520;
        Fri, 14 Oct 2022 15:04:21 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 18A7B240003;
        Fri, 14 Oct 2022 22:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665785060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=C9owIX0xWqA1XVKbswZj12TMV1FoncD3STWfIWlYGAQ=;
        b=pGSOQk8zSt+BSo853hKDVV7Gs1fL/8aPpx/ENYQ/fV25zeP4unxYa6wbxGQBdwE10up46K
        UGCNc407OBE9yWU0tiaV02kNgsdCPhfQfUEMfixvLbvB3tS0OTq0S64+Kq+rrtvCB/0iXd
        Lm1KrHqcF2UeC3Lv5fyiWER5l79LHTOz2NhSUbR4lztDjMY2iCGAmXwZtl8gsKtwkGowAB
        NLE/vgBdh4WfWEQWUUWHpywirEnAzJhOZh8acj8jOqAf6aMIHjEED7+67kqHR55F8WgbDG
        CQCnIjkIGirtvAm9T/p0j9cp6Yc5Ar7SDedIL5QIpW8QSlVM1zpqtWpRwR/Pew==
Date:   Sat, 15 Oct 2022 00:04:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 6.1
Message-ID: <Y0nc49iertOPOB02@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here is the RTC subsystem pull request for 6.1. A great rework of the
isl12022 driver makes up the bulk of the changes. There is also an
important fix for CMOS and then the usual small fixes.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.1

for you to fetch changes up to e5f12a398371280649ccc9d6eb0b97fd42a5df98:

  rtc: rv3028: Fix codestyle errors (2022-10-13 23:36:52 +0200)

----------------------------------------------------------------
RTC for 6.1

Drivers:
 - switch to devm_clk_get_enabled() where relevant
 - cmos: event handler registration fix
 - isl12022: code improvements

----------------------------------------------------------------
Bryan Brattlof (2):
      rtc: k3: wait until the unlock field is not zero
      rtc: k3: detect SoC to determine erratum fix

Christophe JAILLET (4):
      rtc: mxc: Use devm_clk_get_enabled() helper
      rtc: mpfs: Use devm_clk_get_enabled() helper
      rtc: jz4740: Use devm_clk_get_enabled() helper
      rtc: k3: Use devm_clk_get_enabled() helper

Colin Ian King (1):
      rtc: ds1685: Fix spelling of function name in comment block

Emmanuel Gil Peyrot (1):
      rtc: gamecube: Always reset HW_SRNPROT after read

Geert Uytterhoeven (1):
      rtc: mpfs: Remove printing of stray CR

Ke Sun (1):
      rtc: rv3028: Fix codestyle errors

Lin Yujun (1):
      rtc: stmp3xxx: Add failure handling for stmp3xxx_wdt_register()

Rafael J. Wysocki (1):
      rtc: cmos: Fix event handler registration ordering issue

Rasmus Villemoes (8):
      rtc: isl12022: stop using deprecated devm_rtc_device_register()
      rtc: isl12022: specify range_min and range_max
      rtc: isl12022: drop a dev_info()
      rtc: isl12022: simplify some expressions
      rtc: isl12022: use %ptR
      rtc: isl12022: use dev_set_drvdata() instead of i2c_set_clientdata()
      rtc: isl12022: drop redundant write to HR register
      rtc: isl12022: switch to using regmap API

 drivers/rtc/Kconfig        |   1 +
 drivers/rtc/rtc-cmos.c     |  29 +++++---
 drivers/rtc/rtc-ds1685.c   |   2 +-
 drivers/rtc/rtc-gamecube.c |  11 ++--
 drivers/rtc/rtc-isl12022.c | 161 +++++++++++----------------------------------
 drivers/rtc/rtc-jz4740.c   |  25 +------
 drivers/rtc/rtc-mpfs.c     |  26 ++------
 drivers/rtc/rtc-mxc.c      |  27 +-------
 drivers/rtc/rtc-rv3028.c   |   5 +-
 drivers/rtc/rtc-stmp3xxx.c |   2 +
 drivers/rtc/rtc-ti-k3.c    |  56 ++++++----------
 11 files changed, 98 insertions(+), 247 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
