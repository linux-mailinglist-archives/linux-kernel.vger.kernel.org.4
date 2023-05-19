Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4250A708F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 07:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjESFWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 01:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjESFWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 01:22:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78F39E52;
        Thu, 18 May 2023 22:22:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7CCD1FB;
        Thu, 18 May 2023 22:22:48 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.71.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47C673F762;
        Thu, 18 May 2023 22:21:56 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
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
        linux-acpi@vger.kernel.org
Subject: [PATCH V3 0/6] coresight: etm4x: Migrate ACPI AMBA devices to platform driver
Date:   Fri, 19 May 2023 10:51:43 +0530
Message-Id: <20230519052149.1367814-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Due to all of the above, we are moving ACPI MMIO based etm4x devices to be
supported via tha platform driver. The series makes the existing platform
driver generic to handle both type of the access modes. Although existing
AMBA driver would still continue to support DT based etm4x MMIO devices.
Although some problems still remain, such as manually adding PIDs for all
new AMBA DT based devices.

The series applies on 6.4-rc2.

Changes in V3:

- Returned from etm4_check_arch_features() for non iomem devices 
- Renamed ETM_DEVTYPE_ETMv4x_ARCH as CS_DEVTYPE_PE_TRACE
- Renamed is_etm4x_devtype() as is_devtype_cpu_trace()
- Added a patch to ignore the absence of graph connections

Changes in V2:

https://lore.kernel.org/all/20230327050537.30861-1-anshuman.khandual@arm.com/

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

Cc: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
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

Suzuki K Poulose (2):
  coresight: etm4x: Add ACPI support in platform driver
  coresight: platform: acpi: Ignore the absence of graph

 drivers/acpi/acpi_amba.c                      |   1 -
 .../coresight/coresight-etm4x-core.c          | 122 ++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.h |   4 +
 .../hwtracing/coresight/coresight-platform.c  |   6 +-
 include/linux/coresight.h                     |  59 +++++++++
 5 files changed, 166 insertions(+), 26 deletions(-)

-- 
2.25.1

