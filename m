Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6FD744244
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjF3SeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjF3SeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:34:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBB93C2F;
        Fri, 30 Jun 2023 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688150043; x=1719686043;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6dY982Mr/5uNfVzcCmI9s4pEPFMijBn6f5CaQvhuhwQ=;
  b=Fw1y2TCDtGKufpH1Ojny9LCjVoMUFlmoy5D9aZ031huoUCGB3ds1SP4c
   pDqz5Ovet7JgYYVG/cu0lykmknFdl6ApQtPAm1/lZKqZszZo9hO0x6+fh
   rcg6X5hetQmSLIkUsV26puQrZ1tpxP6MYThvX7sSEiCGAq9dZJQPTP7/A
   i0IlWZwkha834bRSeeHQ/vYwMVoME99wWXvks46M0styE5oMmLSG0Z2I9
   nPl4eul6DqManUaT0HrUTDD8SYhlk5UFiU84NzV3Z1QH0+tsuXYz/3qBL
   XECH0Is0sniaEQ69iYQmpdPffCu1kyqsFhcy4PxnPbYAyUia6rKaJZvno
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="365949887"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="365949887"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 11:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="717896406"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="717896406"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 11:33:59 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v6 0/9] Remove .notify callback in acpi_device_ops
Date:   Fri, 30 Jun 2023 21:33:35 +0300
Message-ID: <20230630183344.891077-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

