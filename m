Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7786995AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBPNZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBPNZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:25:13 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066683C78A;
        Thu, 16 Feb 2023 05:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553910; x=1708089910;
  h=from:to:cc:subject:date:message-id;
  bh=2sDAhSaGE+GsIYW5tpg7Ifxnx/c6PmJyeC9/mRyn548=;
  b=OKhdt/HJgb1ifacd9ZMQ/lX8wbs0Ol1H4iEPUxv9oN7h8jLyVyFawqMr
   KUqPp8GjY+xi3trhwsV+bFx208wogyUH+K8byl7muUSN2hbD7iLwfXnP6
   WBo6fC5JjngvpNXRhD3h9/LPmDKPHsP8R1cw3AbT4pnlzWg7ueY5zTCca
   U59Uhp8zcofJ3W1Uw7glhfpxYGP+HIZ4u6g6I5yqqhYhhzjqSTVeRyjpJ
   3YiZ0dle3NdFbcB2YsPblvNWmR9MjdHhVU9j6W2cPJ8BwjK4MAAuY3urR
   x6iL7IvXS70dEczgQ1ktQF1T7zdyngj+T7+jsjYUFDHFa4p5466brZbb4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331711603"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="331711603"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999033082"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="999033082"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga005.fm.intel.com with ESMTP; 16 Feb 2023 05:25:08 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id F3AFB15B67;
        Thu, 16 Feb 2023 18:55:07 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id EDCDF162; Thu, 16 Feb 2023 18:55:07 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/3] Introduce Intel Tangier GPIO driver
Date:   Thu, 16 Feb 2023 18:53:53 +0530
Message-Id: <20230216132356.29922-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple Intel platforms started using similar GPIO controllers.
There was a need to develop a common library driver.
Intel Tangier implements the common GPIO functionalities for
Elkhart Lake and Merrifield platforms.

This patch set introduces:

1. Intel Tangier driver that supports the common GPIO functionalities
   for Elkhart Lake and Merrifield platforms.

2. Intel Tangier adaptation for Merrifield GPIO driver.

3. GPIO driver for Elkhart Lake PSE GPIO IP.

Pandith N (3):
  gpio: tangier: Introduce tangier gpio driver
  gpio: merrifield: Adapt to tangier driver
  gpio: elkhartlake: Introduce Elkhart Lake PSE GPIO

 MAINTAINERS                     |   2 +
 drivers/gpio/Kconfig            |  24 +-
 drivers/gpio/Makefile           |   2 +
 drivers/gpio/gpio-elkhartlake.c |  94 ++++++
 drivers/gpio/gpio-merrifield.c  | 444 ++--------------------------
 drivers/gpio/gpio-tangier.c     | 505 ++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-tangier.h     | 120 ++++++++
 7 files changed, 776 insertions(+), 415 deletions(-)
 create mode 100644 drivers/gpio/gpio-elkhartlake.c
 create mode 100644 drivers/gpio/gpio-tangier.c
 create mode 100644 drivers/gpio/gpio-tangier.h

-- 
2.17.1

