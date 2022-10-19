Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB8E604AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiJSPLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiJSPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:10:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A5892F6F;
        Wed, 19 Oct 2022 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666191854; x=1697727854;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jBd+m75aH3eu6jFU/XbmoI0uYN2YkZ1EVWvqGphS/uY=;
  b=HSrEybaJ7ZqxbuRbKCc9hcgpIHyQrHoLNBhHKxP9xcfxn8lR4PDA7iOo
   20eySBXuhezJrMywdGVVmd1Gm0I/bQszYXBmXesBge792pyVLf57IXfwS
   Qk/nFD4UubUY76g1tr+j5xnICaC0tCoSnP40n9lGT/JFgIUpZG5APLxqt
   t4CVkf4I60ezpKpxqNHPncOe/toh/2quHaOFggJ7kwMAlOjNC8hyX1PFw
   U7j4mFN4T1I6FtvZUJlpY0e1MrO5IM5or7YmIpXpcQNdI9hsKZODh6hZS
   LifUSK4h23XI7YKUoEkVL6nf6UoHLdJrfFkRs2bW+vP+V6B7MkYlGlCRq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306425600"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306425600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 08:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="771826788"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="771826788"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Oct 2022 08:04:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 78BA113F; Wed, 19 Oct 2022 18:04:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/5] spi: pxa2xx: Pass the SSP type via device property
Date:   Wed, 19 Oct 2022 18:04:25 +0300
Message-Id: <20221019150430.27142-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the SPI PXA2xx devices on Intel platforms can be instantiated 
via the following paths:

 1) as ACPI LPSS device on Haswell, Bay Trail and Cherry Trail
 2) as ACPI LPSS device on the Sky Lake and newer
 3) as PCI LPSS device on Haswell, Bay Trail and Cherry Trail
 4) as PCI LPSS device on the Sky Lake and newer
 5) as PCI device via ID table

Each of this case provides some platform related data differently,
i.e.:
 1) via drivers/acpi/acpi_lpss.c and drivers/spi/spi-pxa2xx.c;
 2) via drivers/mfd/intel-lpss-acpi.c;
 3) via drivers/spi/spi-pxa2xx-pci.c;
 4) via drivers/mfd/intel-lpss-pci.c and drivers/spi/spi-pxa2xx.c;
 5) via drivers/spi/spi-pxa2xx-pci.c;

This approach has two downsides:

a) there is no data propagated in the case #2 because we can't have
   two or more drivers to match the same ACPI ID and hence some cases
   are still not supported (Sky Lake and Cannon Lake ACPI enabled
   LPSS);

a) the data is duplicated over two drivers in case #4 and, besides
   to be a bloatware, it is error prone (e.g. Lakefield has a wrong
   data right now due to missed PCI entry in the spi-pxa2xx.c);

This series fixes the downsides, and enables previously unsupported
cases. On top of that it has a coupole of cleanups (patches 4 and 5).

Changelog v2:
- added cover letter (Mark)
- dropped applied patch

Andy Shevchenko (5):
  spi: pxa2xx: Respect Intel SSP type given by a property
  spi: pxa2xx: Remove no more needed PCI ID table
  spi: pxa2xx: Remove no more needed driver data
  spi: pxa2xx: Move OF and ACPI ID tables closer to their user
  spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()

 drivers/spi/spi-pxa2xx.c   | 170 +++++++------------------------------
 include/linux/pxa2xx_ssp.h |   1 +
 2 files changed, 30 insertions(+), 141 deletions(-)

-- 
2.35.1

