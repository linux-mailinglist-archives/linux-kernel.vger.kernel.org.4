Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD91B657493
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiL1JUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiL1JUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:20:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E523F7F;
        Wed, 28 Dec 2022 01:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672219237; x=1703755237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bum+WdvrzI3wejg9qWLst8ugJ79dtlVwig+FFitYkUY=;
  b=LI+6qLAm6gE7vKqtru1QOkh+wrtYWaHh04Qb3+6theBUufBLQFkBuaf3
   mqlKcvhUQK8KdlJr2sM4TVJAB6Qdg4tvTDSO7p3HJ3rj8JPNEOpe2QJoQ
   ssE1L3aHVTSVPnuFV4Z3C1xWSbY5XZ/ZRPvxGeqqFpPwVHo3G3EZCG0Nz
   QkPxzo6YWByz7w0MJBY66Gn9cDfx+/54hm2JLM6wQXxLvCZ0Wn8ZHHTvS
   3hLXDIBHCTyvZCHva7rFgVdZT1ubu0KHrt7Y1ufx3AOpr4l8VHJwAtU0i
   MeSrKlyISad04GKPdLp0ZXhuIrwG9atZYkw7nzsm7qUYa2BZCbc3D3NHt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="348041417"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="348041417"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 01:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="721737242"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="721737242"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 28 Dec 2022 01:20:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 02102159; Wed, 28 Dec 2022 11:20:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <treding@nvidia.com>
Subject: [rft, PATCH v4 0/3] gpiolib: eventual of_node retirement
Date:   Wed, 28 Dec 2022 11:20:42 +0200
Message-Id: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all GPIO library users are converted to use fwnode,
Drop redundant field from struct gpio_chip and accompanying
code.

Bart, I prefer this series to go as soon as possible if you
have no objection. Or even as v6.2 material.

Thierry, can you please test it once again, so we will be sure
there is no breakage for OF platforms?

Cc: Thierry Reding <treding@nvidia.com>

v4: added couple of additional patches to the bundle that missed
    the merge window by one or another reason

v3: rebased against latest Linux Next: expected not to fail now
    (Also keeping in mind Thierry's report, so reworked a bit)

v2: resent against latest Linux Next: expected not to fail now
    (Linux Next has no more users of of_node member of gpio_chip)

v1: to test for now (using CIs and build bots) what is left unconverted
    (Expected to fail in some configurations!)

Andy Shevchenko (3):
  gpiolib: Introduce gpio_device_get() and gpio_device_put()
  gpiolib: Get rid of not used of_node member
  gpiolib: sort header inclusion alphabetically

 drivers/gpio/gpiolib-acpi.c | 10 -------
 drivers/gpio/gpiolib-acpi.h |  4 ---
 drivers/gpio/gpiolib-cdev.c | 21 ++++++-------
 drivers/gpio/gpiolib-of.c   | 25 ++++------------
 drivers/gpio/gpiolib-of.h   |  5 ----
 drivers/gpio/gpiolib.c      | 60 +++++++++++++++++--------------------
 drivers/gpio/gpiolib.h      | 10 +++++++
 include/linux/gpio/driver.h |  7 -----
 8 files changed, 51 insertions(+), 91 deletions(-)


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.35.1

