Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C1F606916
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJTTo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJTToq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:44:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340083C8FF;
        Thu, 20 Oct 2022 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666295085; x=1697831085;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cDRbvPGMB4daHpf4H0/xcqTeuiVnp6lHkMnNi54s/1I=;
  b=buXWpudEq7k8plZFKn/EZuw/i588rwx0xQi5IXWqkLQhLmuQW5ENLTbs
   BZOAAqANxExccZo0VK2xK+w3WVb48LfB8o9YUvbVgBWSoy2Q6LzHr5nrl
   r1JH5D+Unt9I8prI9HZuheURQ1Go1RQW9slliUQiXdFSD/l8exb4WBHqf
   +iLpXvdR6tAZRSDF0UHNwd7yhTblTpyi17fQUxY4Qh/0FMU/VZqNptoAg
   dLAZH2pHr5Cm2iWlYIP5ZU3rikA52T8EIZ52XdrIW4czoBeiExtNFMBB1
   wMZEUVJjQbuz6Vh69ldQdReLfa7WwViiz/lGswM2tXSsPilvvv6rTZJ62
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305559079"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="305559079"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 12:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630031800"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="630031800"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 20 Oct 2022 12:44:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DA0E3107; Thu, 20 Oct 2022 22:45:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 0/5] spi: pxa2xx: Pass the SSP type via device property
Date:   Thu, 20 Oct 2022 22:44:55 +0300
Message-Id: <20221020194500.10225-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the SPI PXA2xx devices on Intel platforms can be instantiated
via the following paths:
 1) as ACPI LPSS device on Haswell, Bay Trail and Cherry Trail;
 2) as ACPI LPSS device on the Sky Lake and newer;
 3) as PCI LPSS device on Haswell, Bay Trail and Cherry Trail;
 4) as PCI LPSS device on the Sky Lake and newer;
 5) as PCI device via ID table.

Each of these cases provides some platform related data differently,
i.e.:
 1) via drivers/acpi/acpi_lpss.c and drivers/spi/spi-pxa2xx.c
 2) via drivers/mfd/intel-lpss-acpi.c
 3) via drivers/spi/spi-pxa2xx-pci.c
 4) via drivers/mfd/intel-lpss-pci.c and drivers/spi/spi-pxa2xx.c
 5) via drivers/spi/spi-pxa2xx-pci.c

This approach has two downsides:

a) there is no data propagated in the case #2 because we can't have
   two or more drivers to match the same ACPI ID and hence some cases
   are still not supported (Sky Lake and newer ACPI enabled LPSS);

b) the data is duplicated over two drivers in the cases #1 & #4 and,
   besides to be a bloatware, it is error prone (e.g. Lakefield has
   a wrong data right now due to missed PCI entry in the spi-pxa2xx.c).

This series fixes the downsides, and enables previously unsupported
cases. On top of that it has a couple of cleanups (patches 4 and 5).

Changelog v4:
- apply the property only for known MFD enumerated devices (Mark)

Changelog v3:
- added tags to patches 4 & 5 (Jonathan)
- massaged cover letter

Changelog v2:
- added cover letter (Mark)
- dropped applied patch

Andy Shevchenko (5):
  spi: pxa2xx: Respect Intel SSP type given by a property
  spi: pxa2xx: Remove no more needed PCI ID table
  spi: pxa2xx: Move OF and ACPI ID tables closer to their user
  spi: pxa2xx: Consistently use dev variable in pxa2xx_spi_init_pdata()
  spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()

 drivers/spi/spi-pxa2xx.c   | 186 ++++++++-----------------------------
 include/linux/pxa2xx_ssp.h |   1 +
 2 files changed, 41 insertions(+), 146 deletions(-)

-- 
2.35.1

