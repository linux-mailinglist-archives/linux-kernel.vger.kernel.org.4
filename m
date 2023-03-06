Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8323D6ACE7C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCFTzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:55:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61F4498BC;
        Mon,  6 Mar 2023 11:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132528; x=1709668528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rJbAmhmUdx0JelsNJpxwI+8sXh4dnVKq5IyabupyZfA=;
  b=mblZ2de527gh53k+vBCqNAehzVRtVi/nORv8SHfo3vbP4lMfVhkfx/zu
   2badh940vDWiXMZcEU66ZVS+n/NlBR2vhP96nlCdg8kfBziJnqVXrBEB8
   OObo7+qp0g2ri7l18qGjpKlpOSSoWni0g2V+5sm9OmaGBo8HFI3o2vYSU
   2jqPz8VY6GUWtuDfxaFB2MliFmguPojGmRxGa/clNj6XudOFn1/et2eOy
   gbaXHsBEEuW4/a94JrhwaTUUO+jKuP8ZinLRNOeA7zHzgePURtyCOGkz2
   nPzY5rUNml5lkNsNpM0DtpEFOHEemQxb3hxvwqRpnOxW7eMRfoYRkEqs3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400483827"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="400483827"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="1005549547"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="1005549547"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2023 11:55:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A373814F; Mon,  6 Mar 2023 21:56:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
Subject: [PATCH v1 00/16] gpio: Use string_choices.h
Date:   Mon,  6 Mar 2023 21:55:40 +0200
Message-Id: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use string_choices.h in the GPIO drivers and library.
It has been tested on x86_64 and (semi-)compile tested
over all.

Andy Shevchenko (16):
  lib/string_helpers: Add missing header files to MAINTAINERS database
  lib/string_helpers: Split out string_choices.h
  lib/string_choices: Add str_high_low() helper
  lib/string_choices: Add str_input_output() helper
  gpiolib: Utilize helpers from string_choices.h
  gpio: adnp: Utilize helpers from string_choices.h
  gpio: brcmstb: Utilize helpers from string_choices.h
  gpio: crystalcove: Utilize helpers from string_choices.h
  gpio: grgpio: Utilize helpers from string_choices.h
  gpio: mvebu: Utilize helpers from string_choices.h
  gpio: pl061: Utilize helpers from string_choices.h
  gpio: stmpe: Utilize helpers from string_choices.h
  gpio: wcove: Utilize helpers from string_choices.h
  gpio: wm831x: Utilize helpers from string_choices.h
  gpio: wm8994: Utilize helpers from string_choices.h
  gpio: xra1403: Utilize helpers from string_choices.h

 MAINTAINERS                     |  3 ++
 drivers/gpio/gpio-adnp.c        | 24 ++++----------
 drivers/gpio/gpio-brcmstb.c     |  3 +-
 drivers/gpio/gpio-crystalcove.c | 17 +++++-----
 drivers/gpio/gpio-grgpio.c      |  3 +-
 drivers/gpio/gpio-mvebu.c       | 27 +++++++---------
 drivers/gpio/gpio-pl061.c       |  4 +--
 drivers/gpio/gpio-stmpe.c       | 19 +++++------
 drivers/gpio/gpio-wcove.c       | 15 ++++-----
 drivers/gpio/gpio-wm831x.c      |  5 +--
 drivers/gpio/gpio-wm8994.c      |  6 ++--
 drivers/gpio/gpio-xra1403.c     |  5 +--
 drivers/gpio/gpiolib-sysfs.c    |  3 +-
 drivers/gpio/gpiolib.c          | 13 ++++----
 include/linux/string_choices.h  | 56 +++++++++++++++++++++++++++++++++
 include/linux/string_helpers.h  | 26 +--------------
 16 files changed, 125 insertions(+), 104 deletions(-)
 create mode 100644 include/linux/string_choices.h

-- 
2.39.1

