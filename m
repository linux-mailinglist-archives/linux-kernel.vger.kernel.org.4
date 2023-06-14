Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46E3730B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbjFNXSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjFNXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:18:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C871268B;
        Wed, 14 Jun 2023 16:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686784685; x=1718320685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mZEV4pzNF7qcMP4rnNrl0WbDZ2Lf7enx6Xmx0FofGFI=;
  b=n/ztUJvCcym7ndIL/aoxAfTbEv+GI02KUrj9MKdCcN+wbg/FLGjTMJ69
   6eyXjhjcx9Io1f+isSRsJXd53iz1HTowz8w3V9Xt0Rkzr88G3Xahw1Nbo
   Ww7drGSQFflrI+LTHq+ynHEmxPONN8a/WidndGVkBFtfP8KAYZnBZPQ2v
   U2yhosdxzo/rNQttFEmdvAPhsFQfQmh9geTLIeOs4BXR4lhIQDMEWTMJT
   MBYvD0iiMuV18zA1kdc2m7TN1DHVmxs86bTZy93a0Eivy7tDO+aA2Iul/
   aeoKd8CoEthk96dOIJteHT7Ws5E0cfcccgYxLv65k/DUCeWXOgHFymG20
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="424648049"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="424648049"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 16:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="715387934"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="715387934"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2023 16:14:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CBF9C1E8; Thu, 15 Jun 2023 02:14:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/4] gpio: aggregator: Incorporate gpio-delay functionality
Date:   Thu, 15 Jun 2023 02:14:42 +0300
Message-Id: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Please, test and comment!

In v2:
- split as a series
- covered CONFIG_OF_GPIO=n case
- removed the gpio-delay
- moved gpio-delay Kconfig help to the comment in the code

Not in v2:
- updated DT description to note about long timeouts in atomic mode
- sysfs hiding for gpio-delay functionality
- used msleep(): the documentation is _against_ this

Andy Shevchenko (4):
  gpio: aggregator: Remove CONFIG_OF and of_match_ptr() protections
  gpio: aggregator: Support delay for setting up individual GPIOs
  gpio: aggregator: Set up a parser of delay line parameters
  gpio: delay: Remove duplicative functionality

 drivers/gpio/Kconfig           |   9 --
 drivers/gpio/Makefile          |   1 -
 drivers/gpio/gpio-aggregator.c | 109 ++++++++++++++++++++--
 drivers/gpio/gpio-delay.c      | 164 ---------------------------------
 4 files changed, 103 insertions(+), 180 deletions(-)
 delete mode 100644 drivers/gpio/gpio-delay.c

-- 
2.40.0.1.gaa8946217a0b

