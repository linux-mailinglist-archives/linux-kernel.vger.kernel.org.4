Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A481607E87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJUTAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJUTAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:00:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6366016C22A;
        Fri, 21 Oct 2022 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666378807; x=1697914807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/h+VrN160fOhMYJNJRAgTKgEfr4ireiMY5yjWF5ws8Q=;
  b=Sp3RTOS2UGdzJGs1I5IWzW6WYOMLd8eaPhrOzYlAwh80RHFdFnteQAKN
   hL9Jw18nMHbxsgNYONNzFYntvfqh0gL8MxnVipdu72Sk36DYpZ9BNvW4N
   AWsTsrF5rI5GuUA9Sfb23+UI/tvN6RSqexFGThDrUFCM4sGydrgLFNuuQ
   R0x2PGrCrXSE7h3PCTzKTTPHSLv2WU9nK5vNNlDYYjQz4TuENmRk0uApN
   +1W1/TsvRcaMwim7JwmKzVCo4d2z3U8+x5pH9rR8n6td2DM8BB/daniHW
   /+iT65bMDUuO9bW7gvmrzzF5DU72FRBewdTjPxyO5RIycHtohLVaOynvm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="333658296"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="333658296"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 12:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="773171046"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="773171046"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2022 12:00:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BE58F107; Fri, 21 Oct 2022 22:00:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v5 0/4] spi: pxa2xx: Pass the SSP type via device property
Date:   Fri, 21 Oct 2022 22:00:14 +0300
Message-Id: <20221021190018.63646-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Changelog v5:
- added a patch to validate the SSP type
- reworked LPSS detection code to narrow its scope (Mark)
- dropped applied patches

Changelog v4:
- apply the property only for known MFD enumerated devices (Mark)

Changelog v3:
- added tags to patches 4 & 5 (Jonathan)
- massaged cover letter

Changelog v2:
- added cover letter (Mark)
- dropped applied patch

Andy Shevchenko (4):
  spi: pxa2xx: Validate the correctness of the SSP type
  spi: pxa2xx: Respect Intel SSP type given by a property
  spi: pxa2xx: Remove no more needed PCI ID table
  spi: pxa2xx: Move OF and ACPI ID tables closer to their user

 drivers/spi/spi-pxa2xx.c   | 171 ++++++++-----------------------------
 include/linux/pxa2xx_ssp.h |   1 +
 2 files changed, 37 insertions(+), 135 deletions(-)

-- 
2.35.1

