Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B35745E71
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjGCOXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGCOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:23:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4221E54;
        Mon,  3 Jul 2023 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688394189; x=1719930189;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vjx0VlxZEZ07YZ5Kla57Lmn6980ed+GxL6WPVwXJIYw=;
  b=XGOTnZO8s8rqk4t+E3qLpNv55k0KzAzDUssFaDnbtD2UjqIDEI4haRrh
   /f8kLJrwEADLnpuBHVE5bJYCrxCB5uX5NaAHky93B2iS2TIzAFCKEI4sQ
   cx09nnCZYhgZsbUykkVEb9ax+S8Vg0S65hAbzmUVM8WB6X6ppScKP43Bq
   z+RyLPIe3YQDctk6rcSKzpS+lvSlMif4+Ou/U4kMp75lvY9Fp4ov7lQZ3
   xxFa6j2EZehJLtZ6xiGb2rC0JWOJQKaItAGyd6xsBFncYEvlub0C/RA6M
   3gSEVkf5d3ufhU3ctEVP77y3wtponiUYdm+nS4WIqDCONRV7IbMVqvLj2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="347681264"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="347681264"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 07:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="783917060"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="783917060"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2023 07:23:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B4A22170; Mon,  3 Jul 2023 17:23:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/3] gpiolib: Avoid modifying GPIO chip fwnode
Date:   Mon,  3 Jul 2023 17:23:05 +0300
Message-Id: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally the GPIO chip data structure has to be constant.
In real life it's not true, but we can make it closer to
that. Hence the series.

Bart, the idea is that this series has to land immediately after
v6.5-rc1 is out so we will have longer time to fix downsides and
regressions found, if any.

Benjamin, thank you for testing!

Changelog v2:
- replaced open coded device_match_acpi_handle()
- corrected commit message due to above change
- added tag (Benjamin)

Andy Shevchenko (3):
  gpiolib: of: Don't use GPIO chip fwnode in of_gpiochip_*()
  gpiolib: acpi: Don't use GPIO chip fwnode in acpi_gpiochip_find()
  gpiolib: Do not alter GPIO chip fwnode member

 drivers/gpio/gpiolib-acpi.c |  2 +-
 drivers/gpio/gpiolib-of.c   |  6 +++---
 drivers/gpio/gpiolib.c      | 16 ++++++++--------
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

