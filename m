Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52365614EAB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiKAP4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKAP42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:56:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEB8381;
        Tue,  1 Nov 2022 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667318187; x=1698854187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rt/S8ugIyQc8CcEgszJLJMjilUawwEzDrxItMe6ZNY0=;
  b=g/LIc4ZrHnVTXnL99ZiFlbm2nfFiEiE/v2RnUGpJ+AjBvXUOutWM7SKY
   fDMS+mdXySVXn+5o2l/WABroRAakf+OQyJFUzH6LzXqwe3qLAeQWRVZqk
   fSsj6yZrHpl3wtOZ7Z471pUXQXl/GunZZ6AnufLTADrKLIQ29hyqvDPQ5
   WxBVCEF6G2K3VadzjM5xRNApMRkSYthqQTxEcTgw2mpqRi0Pz8QAA88mA
   R/fo4bachhXlii2bCkLrj7TjLH8JjOulV1i4ViX+Sety3/WlKlKIGe/Hh
   /kYQgq1AwMotMLSRPevan3zbrfYPkDRAFvefy7K3/a6gOmvEEb9egd+jX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="292474804"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="292474804"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="776537914"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="776537914"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2022 08:56:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5F6BFF7; Tue,  1 Nov 2022 17:56:47 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 0/6] pinctrl: intel: Enable PWM optional feature
Date:   Tue,  1 Nov 2022 17:56:36 +0200
Message-Id: <20221101155642.52575-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a continuation of the previously applied PWM LPSS clean up.
Now, we would like to enable PWM optional feature that may be embedded
into Intel pin control IPs (starting from Sky Lake platforms).

I would like to route this via Intel pin control tree with issuing
an immutable branch for both PINCTRL and PWM subsystems, but I'm
open for other suggestions.

Hans, I dared to leave your Rb tags, however the patches are slighly
differ, because of the Uwe's suggestion on how to handle the missing
headers. I hope you is okay with that. If not, please comment what
must be ammended then.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Andy Shevchenko (6):
  pwm: Add a stub for devm_pwmchip_add()
  pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
  pwm: lpss: Include headers we are direct user of
  pwm: lpss: Allow other drivers to enable PWM LPSS
  pwm: lpss: Add pwm_lpss_probe() stub
  pinctrl: intel: Enumerate PWM device when community has a capabilitty

 drivers/pinctrl/intel/pinctrl-intel.c         | 29 +++++++++++++
 drivers/pwm/pwm-lpss.c                        |  2 +-
 drivers/pwm/pwm-lpss.h                        | 34 ++++-----------
 .../linux/platform_data/x86}/pwm-lpss.h       | 41 ++++++++-----------
 include/linux/pwm.h                           |  5 +++
 5 files changed, 61 insertions(+), 50 deletions(-)
 copy {drivers/pwm => include/linux/platform_data/x86}/pwm-lpss.h (51%)

-- 
2.35.1

