Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E43731A78
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbjFONvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344514AbjFONv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:51:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477471BDB;
        Thu, 15 Jun 2023 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837085; x=1718373085;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MIuQ8cWazJW6GW0lML8T2aU1uWp7mxrZSU8mCIOK4QI=;
  b=WHOIEtU/bMCnojbca1zarmN02vFLkp6lePbfzzq1Q2OBraW+xzNvnSj2
   5QKiGPqUmNfAU6vSOPKP89Q/s/VrT6GcR64lmi02fMacSfoAbUTUko3Fb
   uisBvze9pltaMbOV8T3T6VBxgSircxechoOC/J9qbG4zl4sys5fJJOup4
   xsV9M72ajq943gj68J+HwGhbXJVPxePeId5mO1ly+Uh3K71EDOFJIyie1
   CNWvyXRAwvQvRX2Mx6UCqdYl0FOOggeT+sWHORVLOMIounfmIaFBZ79EX
   YTMKEsfV9RgjFX2HoCjaNBC4Vg6yUZ7SYyjN+P6TJ/tB2rGyBQcPo+Qa9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361404907"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="361404907"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802338786"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="802338786"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 06:20:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4093A379; Thu, 15 Jun 2023 16:20:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 0/5] gpio: aggregator: Incorporate gpio-delay functionality
Date:   Thu, 15 Jun 2023 16:20:18 +0300
Message-Id: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly appeared gpio-delay module enables external signal delay lines
that may be connected to the GPIOs. But at the same time it copies the
GPIO forwarder functionality. Besides that the approach does not scale.
If we would have another external component, we would need yet another
driver. That's why I think, and seems others support me, better to
enable such a functionality inside GPIO aggregator driver.

Patch 1 is a cleanup that may be applied independently on the decision
about the rest.

Please, test and comment! Alexander, I would appreciate your tag.

In v3:
- added new patch 3 to prevent device removal from sysfs
- switched to feature in driver data instead of "compatible" (Geert)
- applied tags (Geert, Linus)
- left DT bindings untouched, can be amended later on

In v2:
- split as a series
- covered CONFIG_OF_GPIO=n case
- removed the gpio-delay
- moved gpio-delay Kconfig help to the comment in the code
- left udelay() call untouched as recommended by documentation

Andy Shevchenko (5):
  gpio: aggregator: Remove CONFIG_OF and of_match_ptr() protections
  gpio: aggregator: Support delay for setting up individual GPIOs
  gpio: aggregator: Prevent collisions between DT and user device IDs
  gpio: aggregator: Set up a parser of delay line parameters
  gpio: delay: Remove duplicative functionality

 drivers/gpio/Kconfig           |   9 --
 drivers/gpio/Makefile          |   1 -
 drivers/gpio/gpio-aggregator.c | 113 +++++++++++++++++++++--
 drivers/gpio/gpio-delay.c      | 164 ---------------------------------
 4 files changed, 106 insertions(+), 181 deletions(-)
 delete mode 100644 drivers/gpio/gpio-delay.c

-- 
2.40.0.1.gaa8946217a0b

