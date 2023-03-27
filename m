Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42656C9AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjC0FF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0FFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:05:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B4D5AA;
        Sun, 26 Mar 2023 22:05:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E5AC4B3;
        Sun, 26 Mar 2023 22:06:37 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9EDD3F73F;
        Sun, 26 Mar 2023 22:05:46 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     scclevenger@os.amperecomputing.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/5] coresight: etm4x: Migrate ACPI AMBA devices to platform driver
Date:   Mon, 27 Mar 2023 10:35:32 +0530
Message-Id: <20230327050537.30861-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight ETM4x devices could be accessed either via MMIO (handled via
amba_driver) or CPU system instructions (handled via platform driver). But
this has the following issues :

  - Each new CPU comes up with its own PID and thus we need to keep on
    adding the "known" PIDs to get it working with AMBA driver. While
    the ETM4 architecture (and CoreSight architecture) defines way to
    identify a device as ETM4. Thus older kernels  won't be able to
    "discover" a newer CPU, unless we add the PIDs.

  - With ACPI, the ETM4x devices have the same HID to identify the device
    irrespective of the mode of access. This creates a problem where two
    different drivers (both AMBA based driver and platform driver) would
    hook into the "HID" and could conflict. e.g., if AMBA driver gets
    hold of a non-MMIO device, the probe fails. If we have single driver
    hooked into the given "HID", we could handle them seamlessly,
    irrespective of the mode of access.

  - CoreSight is heavily dependent on the runtime power management. With
    ACPI, amba_driver doesn't get us anywhere with handling the power
    and thus one need to always turn the power ON to use them. Moving to
    platform driver gives us the power management for free.

Due to all of the above, we are moving the MMIO based etm4x devices to be
supported via platform driver. The series makes the existing platform
driver generic to handle both type of the access modes. Although existing
AMBA driver would still continue to support DT based etm4x MMIO devices.

The series applies on 6.3-rc4.

Changes in V2:

- Enables ACPI etm4x device support in the existing platform driver
- Dropped last two patches from the series
- Dropped redundant 'devarch' checking from is_etm4x_device()
- Renamed updated is_etm4x_device() as is_etm4x_devtype()
- Fixed arguments in fallback stub for etm4_check_arch_features()
- Tagged etm4_dev_pm_ops with etm4_platform_driver
- Updated the comment for coresight_get_enable_apb_pclk() helper
- Updated the comment for new 'pclk' element in struct etm4_drvdata
- Dropped the clock when devm_ioremap_resource() fails
- Convert IS_ERR() into a direct pointer check in etm4_remove_platform_dev()
- Dropped "arm,coresight-etm4x" compatible property from etm4_match[]

Changes in V1:

https://lore.kernel.org/all/20230317030501.1811905-1-anshuman.khandual@arm.com/

Cc: Steve Clevenger <scclevenger@os.amperecomputing.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (4):
  coresight: etm4x: Allocate and device assign 'struct etmv4_drvdata' earlier
  coresight: etm4x: Drop iomem 'base' argument from etm4_probe()
  coresight: etm4x: Drop pid argument from etm4_probe()
  coresight: etm4x: Change etm4_platform_driver driver for MMIO devices

Suzuki Poulose (1):
  coresight: etm4x: Add ACPI support in platform driver

 drivers/acpi/acpi_amba.c                      |   1 -
 .../coresight/coresight-etm4x-core.c          | 114 ++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.h |   4 +
 include/linux/coresight.h                     |  59 +++++++++
 4 files changed, 154 insertions(+), 24 deletions(-)

-- 
2.25.1

