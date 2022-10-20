Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D4A6065BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJTQ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiJTQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:26:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922A16392;
        Thu, 20 Oct 2022 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666283178; x=1697819178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L1PpsyQD3YIK+QP7eDAPlt7fNZIEOmcOxOCOyV/CAlg=;
  b=FhUfgggrV43MyhyaVgEEf7+W26+vyJiWjcDG8VQwQvzbqNoEy3PCvEok
   Jq3+iqz8BjwZajyg+s3oflBiwL4+FFb3IK2yuVqmLcWgQP14jndXlMLWb
   gTVl17mcmpw5zK2LnAdWkVJI29RBUmFgNRhrv7iLEjrxte8B/TbfpGJiD
   2e3arBjQFbXdDTjVLkyGc9HvMCycsS2t8Gx8cb7wYhV493CedTPDHyGVG
   1K6fOWiUyDnm+4hcht+EYx3NOuTG28K/yH+L7eYFuZ5uf+f+v3NRjadzM
   rRUYOAlM23CVWg336795ff8ptvyv6PkKB8tXZOmEH0kml9MWh9yS2ZjDv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287164938"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="287164938"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:26:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="581004363"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="581004363"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2022 09:26:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A2394291; Thu, 20 Oct 2022 19:26:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/5] spi: pxa2xx: Pass the SSP type via device property
Date:   Thu, 20 Oct 2022 19:26:26 +0300
Message-Id: <20221020162631.68914-1-andriy.shevchenko@linux.intel.com>
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

Changelog v3:
- added tags to patches 4 & 5 (Jonathan)
- massaged cover letter

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

