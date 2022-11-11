Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D4962619A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiKKSnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiKKSnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:43:13 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B923B6;
        Fri, 11 Nov 2022 10:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668192192; x=1699728192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g2fp4ZjeEc/fAnq0ko+qR0fprFFwUsmoz2HO2reOwM4=;
  b=Fp11YnQ2EnBe0TceRR2Zyz8x826VDPqAJiWNBjB+bOv1Fn88UILiEKnb
   +UTppoCJIV/qw5vEt8jibkXFTrSDyiYyo1cO2ADCppiV+rcxJ2i1vQqJg
   GId3YriF6b4UrRcicTdK7gT+LruFmgJJZkD+daztFfdED7PD0ipCEh9HI
   YZ5/jQDg9byvyGYkqsnErhejoC9BgimZTY3Locx/NhgawXV9v+ABjqViM
   1a8dsnoKpQ7LXiFEV7gRRce2cJNzaAItP6z4lQ3ScpOdD+6gOLobpUFj7
   0CMEvkWC+H4rdqYjWsvNJemKGsn2pJJaLgLV/7Df9sxFWkU3fVqhZvGmQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="309274049"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="309274049"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:43:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="632103058"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="632103058"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2022 10:43:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 04C63F7; Fri, 11 Nov 2022 20:43:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 0/6] pinctrl: intel: Enable PWM optional feature
Date:   Fri, 11 Nov 2022 20:43:22 +0200
Message-Id: <20221111184328.58108-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Andy Shevchenko (6):
  pwm: Add a stub for devm_pwmchip_add()
  pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
  pwm: lpss: Include headers we are the direct user of
  pwm: lpss: Allow other drivers to enable PWM LPSS
  pwm: lpss: Add pwm_lpss_probe() stub
  pinctrl: intel: Enumerate PWM device when community has a capability

 drivers/pinctrl/intel/pinctrl-intel.c         | 32 +++++++++++++++
 drivers/pwm/pwm-lpss.c                        |  2 +-
 drivers/pwm/pwm-lpss.h                        | 34 ++++-----------
 .../linux/platform_data/x86}/pwm-lpss.h       | 41 ++++++++-----------
 include/linux/pwm.h                           |  5 +++
 5 files changed, 64 insertions(+), 50 deletions(-)
 copy {drivers/pwm => include/linux/platform_data/x86}/pwm-lpss.h (51%)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.35.1

