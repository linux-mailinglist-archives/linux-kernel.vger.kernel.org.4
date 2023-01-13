Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28166A56D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjAMVx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjAMVx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:53:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E81658F94;
        Fri, 13 Jan 2023 13:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673646806; x=1705182806;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G/VQved2ff+tefAVfi0iakcBPqZfQVrJ7htF8hbF9mk=;
  b=WmLNyfNptEBenlkmcC9oMLJ0gnh5lk/56TQDu9D9KEMfBctjN7+TBWkR
   OmiVnIO50KVEZQZ0aQn3VWMHkYOSlsDE1DV8rkFZK4Vu2Pb7EN0KVFwuv
   sVK/9knKK8E2A7pavP7pX3P9ewqN0DX7m1LfMPZlYr4h5IcV+etJ94ji5
   sJr3aM3nw+Fh70GS1VY9RmtpJJeAx+tneHllhf6CaZySb+hDkwgswH/Il
   tibnPTj+8UWVPdQr7nnWAsVRw/YbC4YwTNdm+hdc2NXUZvnpO8eea/ZTm
   aT1Z5LSTbnRStUCtAvvmrqUAZ9NfhKYvzSaGl9XPmAxbL+V26tn4HoCGj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="324166136"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="324166136"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:53:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="987142579"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="987142579"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2023 13:53:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5C84AE1; Fri, 13 Jan 2023 23:53:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v3 0/4] gpiolib: get rid of exessive ->of_gpio_ranges_fallback()
Date:   Fri, 13 Jan 2023 23:53:48 +0200
Message-Id: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->of_gpio_ranges_fallback() repeats the idea that lies behind
->add_pin_ranges(), while the latter covers more cases that the former
hook. Drop the former one for good.

Changelog v3:
- moved check of the property presense to GPIO library
- split out the refcount fix in a separate patch
- added cover letter

Andy Shevchenko (4):
  gpiolib: Check "gpio-ranges" before calling ->add_pin_ranges()
  pinctrl: bcm2835: Remove of_node_put() in
    bcm2835_of_gpio_ranges_fallback()
  pinctrl: bcm2835: Switch to use ->add_pin_ranges()
  Revert "gpiolib: of: Introduce hook for missing gpio-ranges"

 drivers/gpio/gpiolib-of.c             |  5 -----
 drivers/gpio/gpiolib.c                |  8 ++++++++
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 10 ++++------
 include/linux/gpio/driver.h           | 12 ------------
 4 files changed, 12 insertions(+), 23 deletions(-)

-- 
2.39.0

