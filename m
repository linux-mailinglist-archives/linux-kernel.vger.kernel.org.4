Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224326A84A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCBOtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCBOtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:49:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCC52D47
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:48:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDf-0003r5-84; Thu, 02 Mar 2023 15:47:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDY-001Lqo-S2; Thu, 02 Mar 2023 15:47:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDY-001ZpK-6Z; Thu, 02 Mar 2023 15:47:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andrea Ho <Andrea.Ho@advantech.com.tw>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        =?utf-8?q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Jorge Lopez <jorge.lopez2@hp.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Hung <alexhung@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shravan Sudhakar <s.shravan@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 00/29] platform/x86: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:03 +0100
Message-Id: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5397; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vRXXcogYXkMjIpSQ/PSu/mECXGaJ5NPjA8DIJa1C5dA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALaAai+lsMP2/3+M9gidrZ5BYYLoghUAKK454 KjxQhHmraiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2gAAKCRDB/BR4rcrs CVZ0B/9dzH/Lfa1PlT/p/CMMSaa7GDt3nOpeveiqPrqtyQHw44sTlijnL3AYy4GFt+ycxReQ2yT SshFNGR14rAjD3GvvASpSjaGfKhkujtNJ/WP9MiS1gmMCmZG6xd1WPVyPAAvNwTw+MKkclIpZWl +iCtWNOqHrg4GV1gCTvrgfB8Q0ys+MaBZQd4xRw/GAfxm0/XnoRfrvqVQpVbbTO6MXp8yqNok2f vzU2OEbaxVN5SqVZBUXn78z+x7mAMUNRacSWbC7US3ylMHrcR7uNA0fpRq+/n2QXf/VDg2KBaQW hk4I4gkyZ8RQNGpOgeOzJgK6o67afS6fnmAyNt9on3AIVMjk
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch series adapts the platform drivers below drivers/platform/x86
to use the .remove_new() callback. Compared to the traditional .remove()
callback .remove_new() returns no value. This is a good thing because
the driver core doesn't (and cannot) cope for errors during remove. The
only effect of a non-zero return value in .remove() is that the driver
core emits a warning. The device is removed anyhow and an early return
from .remove() usually yields a resource leak.

By changing the remove callback to return void driver authors cannot
reasonably assume any more that there is some kind of cleanup later.

All drivers touched here returned zero unconditionally in their remove
callback, so they could all be converted trivially to .remove_new().

Note that this series depends on commit 5c5a7680e67b ("platform: Provide
a remove callback that returns no value") that is already in Linus' tree
but not yet included in a tagged version.

Best regards
Uwe

Uwe Kleine-König (29):
  platform/x86: acer-wmi: Convert to platform remove callback returning void
  platform/x86: adv_swbutton: Convert to platform remove callback returning void
  platform/x86: amd: hsmp: Convert to platform remove callback returning void
  platform/x86: amd: pmc: Convert to platform remove callback returning void
  platform/x86: amd: pmf: core: Convert to platform remove callback returning void
  platform/x86: amilo-rfkill: Convert to platform remove callback returning void
  platform/x86: barco-p50-gpio: Convert to platform remove callback returning void
  platform/x86: compal-laptop: Convert to platform remove callback returning void
  platform/x86: dell: dcdbas: Convert to platform remove callback returning void
  platform/x86: dell: dell-smo8800: Convert to platform remove callback returning void
  platform/x86: hp: hp_accel: Convert to platform remove callback returning void
  platform/x86: hp: tc1100-wmi: Convert to platform remove callback returning void
  platform/x86: huawei-wmi: Convert to platform remove callback returning void
  platform/x86: ideapad-laptop: Convert to platform remove callback returning void
  platform/x86: intel: bxtwc_tmu: Convert to platform remove callback returning void
  platform/x86: intel: chtdc_ti_pwrbtn: Convert to platform remove callback returning void
  platform/x86: intel: chtwc_int33fe: Convert to platform remove callback returning void
  platform/x86: intel: hid: Convert to platform remove callback returning void
  platform/x86: intel: int0002_vgpio: Convert to platform remove callback returning void
  platform/x86: intel: int1092: intel_sar: Convert to platform remove callback returning void
  platform/x86: intel: int3472: discrete: Convert to platform remove callback returning void
  platform/x86: intel: mrfld_pwrbtn: Convert to platform remove callback returning void
  platform/x86: intel: pmc: core: Convert to platform remove callback returning void
  platform/x86: intel: telemetry: pltdrv: Convert to platform remove callback returning void
  platform/x86: intel: vbtn: Convert to platform remove callback returning void
  platform/x86: samsung-q10: Convert to platform remove callback returning void
  platform/x86: serial-multi-instantiate: Convert to platform remove callback returning void
  platform/x86: wmi: Convert to platform remove callback returning void
  platform/x86: xo1-rfkill: Convert to platform remove callback returning void

 drivers/platform/x86/acer-wmi.c                 |  5 ++---
 drivers/platform/x86/adv_swbutton.c             |  6 ++----
 drivers/platform/x86/amd/hsmp.c                 |  6 ++----
 drivers/platform/x86/amd/pmc.c                  |  5 ++---
 drivers/platform/x86/amd/pmf/core.c             |  5 ++---
 drivers/platform/x86/amilo-rfkill.c             |  5 ++---
 drivers/platform/x86/barco-p50-gpio.c           |  6 ++----
 drivers/platform/x86/compal-laptop.c            |  8 +++-----
 drivers/platform/x86/dell/dcdbas.c              |  6 ++----
 drivers/platform/x86/dell/dell-smo8800.c        |  5 ++---
 drivers/platform/x86/hp/hp_accel.c              |  5 ++---
 drivers/platform/x86/hp/tc1100-wmi.c            |  6 ++----
 drivers/platform/x86/huawei-wmi.c               |  6 ++----
 drivers/platform/x86/ideapad-laptop.c           |  6 ++----
 drivers/platform/x86/intel/bxtwc_tmu.c          |  5 ++---
 drivers/platform/x86/intel/chtdc_ti_pwrbtn.c    |  5 ++---
 drivers/platform/x86/intel/chtwc_int33fe.c      |  6 ++----
 drivers/platform/x86/intel/hid.c                | 10 ++--------
 drivers/platform/x86/intel/int0002_vgpio.c      |  5 ++---
 drivers/platform/x86/intel/int1092/intel_sar.c  |  5 ++---
 drivers/platform/x86/intel/int3472/discrete.c   |  6 ++----
 drivers/platform/x86/intel/mrfld_pwrbtn.c       |  5 ++---
 drivers/platform/x86/intel/pmc/core.c           |  5 ++---
 drivers/platform/x86/intel/telemetry/pltdrv.c   |  5 ++---
 drivers/platform/x86/intel/vbtn.c               | 10 ++--------
 drivers/platform/x86/samsung-q10.c              |  6 ++----
 drivers/platform/x86/serial-multi-instantiate.c |  6 ++----
 drivers/platform/x86/wmi.c                      |  6 ++----
 drivers/platform/x86/xo1-rfkill.c               |  5 ++---
 29 files changed, 59 insertions(+), 111 deletions(-)

base-commit: ee3f96b164688dae21e2466a57f2e806b64e8a37
-- 
2.39.1

