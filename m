Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952CC73DC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjFZKzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFZKzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:55:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B42EBF;
        Mon, 26 Jun 2023 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687776921; x=1719312921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7j4yl9//AlIQHBsAQFAONaFjaBtU08iLE1n/Hhxb8Cs=;
  b=eR8JwvDTHmT/RSeKp4pfYGCWRhLtg9jjMqePJ7fIzUZKTAIfuTN32yFk
   NF0VmKDHq+636ZyXHPuC8TeCusBBfYgmqqKpYArFP6nK3B/D2AEnGTWIz
   f3zYYYxN+xV6AhhyHny6XPHLaHBuWrkGAhK8vkwRlIcJ4LTHygC+ivZz/
   SGRBW0SAhX8Of0D0+IJDPOaF/VFAX7eFgqNOdS1SxbGEiPCZcdqB7msKR
   AsGZ3NOaJ5hVqI/y7HCah7x0aVWNSvWtojNI2EAIBUoq76BEMnpGzvW2k
   dBunIABQUk5gyHsb/fhm3IAdAN1EMOL0OeArQ8rVG32qg0/gNLCdhjX6l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="364687672"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="364687672"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 03:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="806003299"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="806003299"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jun 2023 03:55:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9D31E118; Mon, 26 Jun 2023 13:55:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: scan: Move acpi_root to internal header
Date:   Mon, 26 Jun 2023 13:55:27 +0300
Message-Id: <20230626105527.59921-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler is not happy about handling of acpi_root variable:

  ...drivers/acpi/bus.c:37:20: warning: symbol 'acpi_root' was not declared. Should it be static?

Move it's definition to the internal header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/internal.h | 2 ++
 drivers/acpi/scan.c     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 95501a148591..f4148dc50b9c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -11,6 +11,8 @@
 
 #include <linux/idr.h>
 
+extern struct acpi_device *acpi_root;
+
 int early_acpi_osi_init(void);
 int acpi_osi_init(void);
 acpi_status acpi_os_initialize1(void);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1c3e1e2bb0b5..e75ed9123931 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -24,8 +24,6 @@
 
 #include "internal.h"
 
-extern struct acpi_device *acpi_root;
-
 #define ACPI_BUS_CLASS			"system_bus"
 #define ACPI_BUS_HID			"LNXSYBUS"
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
-- 
2.40.0.1.gaa8946217a0b

