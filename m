Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C47456C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGCIDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjGCIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:03:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7EE47;
        Mon,  3 Jul 2023 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688371395; x=1719907395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ou+WLzTPwdntIetfd+7MaSPig1ii75haZd/L4ui/vkg=;
  b=ZOXK64uwmrHdZzZNy4YbhUu5rOO3LL0w5dw6AQ96Dkej/A4ZBAUJGrmu
   43iAXm1uU6xzqkE43XvqOUhQDOGelH9jXtgswURmmCuqkRX7KQ52YekWA
   oP2Dv3+g8syPk3qm0PRmZE/k32X9ZNCUVwUIUB15hk/b9cDl8ZOQsV2E+
   gYM2WYiDcTBUQnUciWoQL0+lg7o3/h5OdUHVdb6HP9FWdguGSFQsvXYQS
   bPzNEHfA5svXFpIyOV0192wtezFDe74+UbqTz9CIRyBNEyRXW2ZDi165g
   M2QrONzt6APclAg4RqQmu0Iq0cM+VvJi5dlbKoe5tX/0j91zUYp/Y1/Vr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="366303997"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="366303997"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="862994498"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="862994498"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:11 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v7 0/9] Remove .notify callback in acpi_device_ops
Date:   Mon,  3 Jul 2023 11:02:43 +0300
Message-ID: <20230703080252.2899090-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** IMPORTANT ***
This is part 1 - only drivers in acpi directory to ease up review
process. Rest of the drivers will be handled in separate patchsets.

Currently drivers support ACPI event handlers by defining .notify
callback in acpi_device_ops. This solution is suboptimal as event
handler installer installs intermediary function acpi_notify_device as a
handler in every driver. Also this approach requires extra variable
'flags' for specifying event types that the driver want to subscribe to.
Additionally this is a pre-work required to align acpi_driver with
platform_driver and eventually replace acpi_driver with platform_driver.

Remove .notify callback from the acpi_device_ops. Replace it with each
driver installing and removing it's event handlers.

This is part 1 - only drivers in acpi directory to ease up review
process.

v7:
 - fix warning by declaring acpi_nfit_remove_notify_handler() as static

v6:
 - fixed unnecessary RCT in all drivers, as it's not a purpose of
   this patch series
 - changed error label names to simplify them
 - dropped commit that remove a comma
 - squashed commit moving code for nfit
 - improved nfit driver to use devm instead of .remove()
 - re-based as Rafael changes [1] are merged already

v5:
 - rebased on top of Rafael changes [1], they're not merged yet
 - fixed rollback in multiple drivers so they don't leak resources on
   failure
 - made this part 1, meaning only drivers in acpi directory, rest of
   the drivers will be handled in separate patchsets to ease up review

v4:
 - added one commit for previously missed driver sony-laptop,
   refactored return statements, added NULL check for event installer
v3:
 - lkp still reported some failures for eeepc, fujitsu and
   toshiba_bluetooth, fix those
v2:
 - fix compilation errors for drivers

[1]: https://lore.kernel.org/linux-acpi/1847933.atdPhlSkOF@kreacher/

Michal Wilczynski (9):
  acpi/bus: Introduce wrappers for ACPICA event handler install/remove
  acpi/bus: Set driver_data to NULL every time .add() fails
  acpi/ac: Move handler installing logic to driver
  acpi/video: Move handler installing logic to driver
  acpi/battery: Move handler installing logic to driver
  acpi/hed: Move handler installing logic to driver
  acpi/nfit: Move handler installing logic to driver
  acpi/nfit: Remove unnecessary .remove callback
  acpi/thermal: Move handler installing logic to driver

 drivers/acpi/ac.c         | 29 ++++++++++++++++++-------
 drivers/acpi/acpi_video.c | 22 ++++++++++++++++---
 drivers/acpi/battery.c    | 26 +++++++++++++++++-----
 drivers/acpi/bus.c        | 30 +++++++++++++++++++++++++-
 drivers/acpi/hed.c        | 17 ++++++++++++---
 drivers/acpi/nfit/core.c  | 45 +++++++++++++++++++++++++++------------
 drivers/acpi/thermal.c    | 25 +++++++++++++++++-----
 include/acpi/acpi_bus.h   |  6 ++++++
 8 files changed, 161 insertions(+), 39 deletions(-)

-- 
2.41.0

