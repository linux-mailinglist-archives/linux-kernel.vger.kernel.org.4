Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DC36BDF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCQDF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCQDFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:05:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D8D426B1;
        Thu, 16 Mar 2023 20:05:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1582A4B3;
        Thu, 16 Mar 2023 20:06:05 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC2623F64C;
        Thu, 16 Mar 2023 20:05:15 -0700 (PDT)
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
Subject: [PATCH 0/7] coresight: etm4x: Migrate AMBA devices to platform driver
Date:   Fri, 17 Mar 2023 08:34:54 +0530
Message-Id: <20230317030501.1811905-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
driver generic to handle both type of the access modes. With that we can
also remove the etm4x amba driver.

Finally, we need a way to make sure the new driver gets control of the
ETM4x device on a DT based system. CoreSight devices have always had the
"arm,primecell" in the compatible list. But the way this is handled
currently in OF code is a bit messy. The ETM4x devices are identified by
"arm,coresight-etm4x". The platform driver can never get a chance to probe
these devices, since the "arm,primecell" takes priority and is hard-coded
in the OF code. We have two options here :

1) Remove the arm,primecell from all DTS. This is fine for "new" kernels
with this change. But, for existing boards, using an older kernel will
break. Thus, is not preferred.

2) Add a white list of "compatibles" where the "priority" of the
"arm,primecell" can be ignored.

The series implements (2) above and applies on 6.3-rc2.

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

Anshuman Khandual (6):
  coresight: etm4x: Allocate and device assign 'struct etmv4_drvdata' earlier
  coresight: etm4x: Drop iomem 'base' argument from etm4_probe()
  coresight: etm4x: Drop pid argument from etm4_probe()
  coresight: etm4x: Change etm4_platform_driver driver for MMIO devices
  of/platform: Skip coresight etm4x devices from AMBA bus
  coresight: etm4x: Drop the AMBA driver

Suzuki Poulose (1):
  coresight: etm4x: Add ACPI support in platform driver

 drivers/acpi/acpi_amba.c                      |   1 -
 .../coresight/coresight-etm4x-core.c          | 171 ++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
 drivers/of/platform.c                         |  10 +-
 include/linux/coresight.h                     |  56 ++++++
 5 files changed, 143 insertions(+), 98 deletions(-)

-- 
2.25.1

