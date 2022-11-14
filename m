Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA11F628636
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiKNQzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237241AbiKNQz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:55:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E9DF5AA;
        Mon, 14 Nov 2022 08:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668444926; x=1699980926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M6xwFRmS3IyNVoaS+vhR82fQz0pwRrgP4cE9Lksst1o=;
  b=jGVrtGiHRqm8h/9jsVJYh9qGeuTCzgMcewgUMZKqOQpTRqIrztRPEsLz
   4yXx3tg1xP8AusMbC1/KRjIC6Htkb+Gm8m/24RoGfRr/7NWPkQVT24vN8
   vdWOd0Rcgv8szeYdNEXoE/6hY4XlnjmuvllJovqvq2/YWPAwyfwXPWueJ
   FNd5m+3ZUhpMHt3tkeEo+HTtEpNvbE1bVNAzCFD0uILobVOt0LQGh2SVl
   h1FDt7FnQe4PZAWn4DL6LPFPDP44cRTALvQNyq/6M7XPLryS4TjPhiMfA
   NVc3pstRJboznllZd7LcbZIgP6QtJh4tTiKGcsY0bdnZHmbDfaCfLF/mI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295382822"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295382822"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:55:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727593539"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727593539"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2022 08:55:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CE3202F3; Mon, 14 Nov 2022 18:55:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 0/7] pinctrl: intel: Enable PWM optional feature
Date:   Mon, 14 Nov 2022 18:55:38 +0200
Message-Id: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a continuation of the previously applied PWM LPSS cleanup series.
Now, we would like to enable PWM optional feature that may be embedded
into Intel pin control IPs (starting from Sky Lake platforms).

I would like to route this via Intel pin control tree with issuing
an immutable branch for both PINCTRL and PWM subsystems, but I'm
open for other suggestions.

Hans, I dared to leave your Rb tags, however the patches are slightly
differ, because of the Uwe's suggestion on how to handle the missing
headers. I hope you are okay with that. If not, please comment what
must be amended then.

Changelog v4:
- added patch "Rename pwm_lpss_probe() --> devm_pwm_lpss_probe()"

Changelog v3:
- added tags (Uwe, Linus, Thierry)
- fixed some spelling issues in the commit messages
- changed a paragraph in the commit message of the patch 3 (Uwe)
- replaced -ENODEV check with IS_REACHABLE() in the patch 6 (Uwe)

Changelog v2:
- added tag (Mika)
- added base-commit to the series, to make sure LKP can test it

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Andy Shevchenko (7):
  pwm: Add a stub for devm_pwmchip_add()
  pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
  pwm: lpss: Include headers we are the direct user of
  pwm: lpss: Allow other drivers to enable PWM LPSS
  pwm: lpss: Rename pwm_lpss_probe() --> devm_pwm_lpss_probe()
  pwm: lpss: Add devm_pwm_lpss_probe() stub
  pinctrl: intel: Enumerate PWM device when community has a capability

 drivers/pinctrl/intel/pinctrl-intel.c      | 32 ++++++++++++++++
 drivers/pwm/pwm-lpss-pci.c                 |  2 +-
 drivers/pwm/pwm-lpss-platform.c            |  2 +-
 drivers/pwm/pwm-lpss.c                     |  8 ++--
 drivers/pwm/pwm-lpss.h                     | 34 ++++-------------
 include/linux/platform_data/x86/pwm-lpss.h | 44 ++++++++++++++++++++++
 include/linux/pwm.h                        |  5 +++
 7 files changed, 95 insertions(+), 32 deletions(-)
 create mode 100644 include/linux/platform_data/x86/pwm-lpss.h


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.35.1

