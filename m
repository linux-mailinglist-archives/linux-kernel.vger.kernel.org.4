Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729F06C4790
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCVK0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCVK0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:26:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4335D8A5;
        Wed, 22 Mar 2023 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679480787; x=1711016787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7zRvA7Uxcl1VdNgMi/XZ56/MUgIfsPqcnnBow1c4txA=;
  b=RhAmWKKeTJ3XS3/+vd89NYn6YF3Tks+tdvTpzQ9tl66XqWNRcJ2GVvoH
   MEMFTmw8WNMJz3OOGaHuKqGbAIOHan/OHqAc9e9/t9NRy97g1h3KuNvIh
   qmW+Ceyhyg3UbBS+uqK0/ZV7EOWgO5Oj9Cz6UONhX8us6UbGC0F4xE3vE
   ilaGxd4HRr53S4ME/9hEJLe7C1IyFALQqSOgvpcZb6WBCbTWyP5iH1UyW
   FCNYnunVsvyqtroQor4zwlF5TbociXixlT9H/+65QBw/86RiVVobQafFP
   f3FuejIS2eH0nAKHCrGMFZmC2rcKl+NvJ+IVagLICjlm/GRCaXSzEcezq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="327558080"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="327558080"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 03:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="750982183"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="750982183"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2023 03:26:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1C2241CC; Wed, 22 Mar 2023 12:26:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/2] ACPI: SPCR: Prefix error messages with FW_BUG
Date:   Wed, 22 Mar 2023 12:22:57 +0200
Message-Id: <20230322102258.27390-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The table values that are not defined in the specification are
considered non-fatal errors in the code. However, they are for
sure the bugs in the firmware. Point this out in the message by
prefixing them with FW_BUG.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/spcr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 1eabfcd122ee..01d29ebdb9c2 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -110,12 +110,12 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 		u32 bit_width = table->serial_port.access_width;
 
 		if (bit_width > ACPI_ACCESS_BIT_MAX) {
-			pr_err("Unacceptable wide SPCR Access Width.  Defaulting to byte size\n");
+			pr_err(FW_BUG "Unacceptable wide SPCR Access Width. Defaulting to byte size\n");
 			bit_width = ACPI_ACCESS_BIT_DEFAULT;
 		}
 		switch (ACPI_ACCESS_BIT_WIDTH((bit_width))) {
 		default:
-			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
+			pr_err(FW_BUG "Unexpected SPCR Access Width. Defaulting to byte size\n");
 			fallthrough;
 		case 8:
 			iotype = "mmio";
-- 
2.40.0.1.gaa8946217a0b

