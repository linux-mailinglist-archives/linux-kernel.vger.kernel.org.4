Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E75562463E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiKJPoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiKJPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:44:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF82252AE;
        Thu, 10 Nov 2022 07:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668095093; x=1699631093;
  h=from:to:cc:subject:date:message-id;
  bh=nlKIOdil/fjz+KRNJqhEwk0FHnHiC1E0308KaAWp//Q=;
  b=lQXaT+wVBq+DdxsZWlwSLJnUtUdz++OT2Rd7ntYVUHH/kl5uOTaogqWH
   ymQY08A4EEmF/5g5kFtDiRbLmPNl8OYCXhOOiKdNBMeE8Ja/T19bPwE/f
   Kqe/pIxQL0SwUeVzDwkopfjZ7jXETTvglzToDLT3HCrYL/9wkZzocoYU2
   sNxom5psbgHYU8bwL6Bu1SkIdXVtrG9M8HQ+qFO2jJokxTT4UDIiYAM/v
   IsF3OXY+6YhV50tXNB5QofksSf/uVDVjU24Ra+fHvnxtmkia+HOa77yF/
   c87r/jlszqBilv15EUUgDkn2ypBnvXDGHzw5Lgx7dJxYUvADH3cvxnzy9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="308965149"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="308965149"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 07:44:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="762323092"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="762323092"
Received: from kkgame-x299-aorus-gaming-3-pro.itwn.intel.com ([10.5.253.159])
  by orsmga004.jf.intel.com with ESMTP; 10 Nov 2022 07:44:51 -0800
From:   Kane Chen <kane.chen@intel.com>
To:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com,
        kane.chen@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: PM: Print full acpi path while adding power resource dev
Date:   Thu, 10 Nov 2022 23:39:24 +0800
Message-Id: <20221110153924.18258-1-kane.chen@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging boot time issue, it's hard to know what power
resource device kernel is initializing.

It's very helpful to print full path so that ppl don't
need to guess what device is under init. Especially the system
has more than 2 power resource have same name

Before:
[    0.194348] ACPI: PM: Power Resource [RTD3]
[    0.274127] ACPI: PM: Power Resource [RTD3]
[    0.275086] ACPI: PM: Power Resource [PR00]
[    0.438261] ACPI: PM: Power Resource [PR01]

After:
[    0.204875] ACPI: \_SB_.PCI0.RP01.RTD3: [Power Resource]
[    0.284273] ACPI: \_SB_.PCI0.RP08.RTD3: [Power Resource]
[    0.285231] ACPI: \_SB_.PCI0.I2C3.H016.PR00: [Power Resource]
[    0.446410] ACPI: \_SB_.PCI0.SPI1.CRFP.PR01: [Power Resource]

Signed-off-by: Kane Chen <kane.chen@intel.com>
Change-Id: I075146e574aa0d5bfd2f97e3da5f73061af6888a
---
 drivers/acpi/power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index f2588aba8421e..23507d29f0006 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -967,7 +967,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	if (acpi_power_get_state(resource, &state_dummy))
 		__acpi_power_on(resource);
 
-	pr_info("%s [%s]\n", acpi_device_name(device), acpi_device_bid(device));
+	acpi_handle_info(handle, "New power resource\n");
 
 	result = acpi_tie_acpi_dev(device);
 	if (result)
-- 
2.17.1

