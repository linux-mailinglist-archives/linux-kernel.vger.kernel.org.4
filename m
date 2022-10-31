Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26294613500
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiJaL4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJaL4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:56:23 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AEADD85;
        Mon, 31 Oct 2022 04:56:22 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 273F780CD;
        Mon, 31 Oct 2022 11:46:50 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Georgi Vlaev <g-vlaev@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/3] Make TI dmtimer features more usable
Date:   Mon, 31 Oct 2022 13:56:10 +0200
Message-Id: <20221031115613.56229-1-tony@atomide.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The TI dmtimer has been using a custom API to expose some hardware timer
features for PWM and remoteproc so far with struct omap_dm_timer_ops. It
seems that for most part we can nowadays replace most of the custom API
with chained interrupts and clock provider features.

There are lots of the dmtimer instances on TI SoCs, some have tens of
them. Some timers have an IO pad available, which means the timers could
be used as clock output for an external device with a 50% duty cycle. The
timers also have input capture capability, but that is not currently
supported. There have been some patches posted earlier for the PWM capture
support though.

These patches are against v6.1-rc2, and need also the following pending
patch:

[PATCH] clocksource/drivers/timer-ti-dm: Clear settings on probe and free

For am6, these patches depend on the pending dts changes posted earlier:

[PATCH v3 0/2] Configure dmtimers for am65
[PATCH 1/2] arm64: dts: ti: k3-am62: Add general purpose timers for am62

I have only lightly tested this so far to make sure I get clock output on
k3-am625-sk on TIMER_IO2 at user expansion connector pin 10. I have not
worried at all so far about disabling the legacy API if used with
interrupts and clock framework.

Regards,

Tony


Tony Lindgren (3):
  clocksource/drivers/timer-ti-dm: Add lock for register access
  clocksource/drivers/timer-ti-dm: Implement chained irq
  clocksource/drivers/timer-ti-dm: Add clock provider support

 drivers/clocksource/timer-ti-dm.c | 591 +++++++++++++++++++++++++++++-
 drivers/pwm/pwm-omap-dmtimer.c    |   1 +
 include/clocksource/timer-ti-dm.h |   2 +
 3 files changed, 578 insertions(+), 16 deletions(-)

-- 
2.37.3
