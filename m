Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE09562161A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiKHOWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiKHOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:22:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D6154B14;
        Tue,  8 Nov 2022 06:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667917330; x=1699453330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qk9qwz/jghx/lz9m3Vhf8durMxo4bHUw+WpVmuVNBr4=;
  b=W3ceUzX0eDx7P0ui9icX6qPZ4B8mFM/HFNLDlLtfHDFdGWxyk0wHZtqE
   Q4EFsz8DuVwCXyAlNRmaQlktzaBzfKJjVGpdbWI/O45FVkZXOJvDfQv4D
   uQR26IPbg72rMNmg1Irk1cFB9nUyu9m9B0+qhQkP8URpdC7LXhPQYJtM8
   Sz2ZMZzVnqNum7gQlde9x5TjUNsW8TMGVTa8LbvDXoOCvmwyTv26to6WU
   0sL29vFYK4ePd0uqVhqet7ktxdZth8awidttuEJtr9em9EU0IQj9o9Obf
   eIxOIcFTaRSk6nGqmRuScijaQS9cSdriK8uTO3HftfXfT1+Efel5cMrlU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="298219285"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="298219285"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:22:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699938292"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="699938292"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2022 06:22:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5E0F915C; Tue,  8 Nov 2022 16:22:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/6] pinctrl: intel: Enable PWM optional feature
Date:   Tue,  8 Nov 2022 16:22:20 +0200
Message-Id: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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

Hans, I dared to leave your Rb tags, however the patches are slighly
differ, because of the Uwe's suggestion on how to handle the missing
headers. I hope you is okay with that. If not, please comment what
must be ammended then.

Changelog v2:
- added tag (Mika)
- added base-commit to the series, to make sure LKP can test it

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


base-commit: 3886bc3523db24814c98c57d74fe66d7a21bf40b
-- 
2.35.1

