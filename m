Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5859262D8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbiKQLIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbiKQLID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:08:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BE06AECA;
        Thu, 17 Nov 2022 03:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668683275; x=1700219275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q/yxfRZ31XbA8GZUusYpG1deAjqkNJJIHGUThuhmAhw=;
  b=ibMe4WNgKh1eQIsmm1sLLYZtVDLRKM95eCP01fDqW6J8/+4kvB20NGL7
   Hs9eyhHVL3wZVX744xCFImtSedwatIJfEa+mWh05sD6fFZK7FUrgOJj1A
   Ng43tJ4irs1avQahc33JpHIRW1tfX4r+bOu/1RDKBS9JaCQsoEznFovJ3
   xWKHWRjOQo+QZtZ9p2sBAHNOBzkPdOSO23MInaE+HjEEjvZvdEHFKfZwy
   A5/Te5eUcOkCxCyzx+IIB9JbO+uI9YOxudJkngNsjCiuS8Zx9deGh5I1w
   zzO5tPW/37Yhxs54HohZMzAfqGKDkrZLf2ma/7JW+Z8I8rgKFZeFRO+1v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314638708"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="314638708"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 03:07:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="617572312"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="617572312"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 17 Nov 2022 03:07:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B4CCD2B7; Thu, 17 Nov 2022 13:08:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 0/7] pinctrl: intel: Enable PWM optional feature
Date:   Thu, 17 Nov 2022 13:07:59 +0200
Message-Id: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

Uwe, the patches 3 and 6 still need your blessing.

Changelog v5:
- added more tags (Uwe)
- avoid moving struct pwm_lpss_chip in patch 3 (Uwe)
- simplified error checking in intel_pinctrl_probe_pwm() (Uwe)

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

 drivers/pinctrl/intel/pinctrl-intel.c      | 29 ++++++++++++++
 drivers/pwm/pwm-lpss-pci.c                 |  2 +-
 drivers/pwm/pwm-lpss-platform.c            |  2 +-
 drivers/pwm/pwm-lpss.c                     |  8 ++--
 drivers/pwm/pwm-lpss.h                     | 26 ++-----------
 include/linux/platform_data/x86/pwm-lpss.h | 44 ++++++++++++++++++++++
 include/linux/pwm.h                        |  5 +++
 7 files changed, 88 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/platform_data/x86/pwm-lpss.h


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.35.1

