Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A995738CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjFURRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFURQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:16:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55925129
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:16:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9CEF1063;
        Wed, 21 Jun 2023 10:17:40 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C0633F663;
        Wed, 21 Jun 2023 10:16:55 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.clark@arm.com, mike.leach@linaro.org, nathan@kernel.org,
        quic_hazha@quicinc.com, suzuki.poulose@arm.com,
        u.kleine-koenig@pengutronix.de, yangyicong@hisilicon.com,
        coresight@lists.linaro.org
Subject: [GIT PULL] coresight: updates for v6.5
Date:   Wed, 21 Jun 2023 18:16:08 +0100
Message-Id: <20230621171608.573041-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please find the changes for coresight and hwtracing subsystem, targeting v6.5.
Please note that, I have pulled James' devm_krealloc_array() patch -

 ( commit d388f06aced3 "devres: Provide krealloc_array" )

- into the coresight tree from your driver-core-next, for CTI module refcount
fixes depend on it.

Please let me know if this looks alright and kindly pull if it is fine.

Kind regards
Suzuki



The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v6.5

for you to fetch changes up to 6c50384ef8b94a527445e3694ae6549e1f15d859:

  hwtracing: hisi_ptt: Fix potential sleep in atomic context (2023-06-21 11:52:39 +0100)

----------------------------------------------------------------
coresight: Updates for v6.5

CoreSight and hwtracing subsystem updates for v6.5 includes:

 - Fixes to the CTI module reference leaks. This involves,
   redesign of how the helper devices are tracked and CTI
   devices have been converted to helper devices.
 - Fix removal of the trctraceidr file from sysfs for ETMs.
 - Match all ETMv4 instances based on the ETMv4 architected
   registers and the CoreSight Component ID (CID), than having
   to add individual PIDs for CPUs.
 - Add support for Dummy CoreSight source and sink drivers.
 - Add James Clark as Reviewer for the CoreSight kernel drivers
 - Fixes to HiSilicon PCIe Tune and Trace Device driver

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

----------------------------------------------------------------
Hao Zhang (3):
      Coresight: Add coresight dummy driver
      dt-bindings: arm: Add support for Coresight dummy trace
      Documentation: trace: Add documentation for Coresight Dummy Trace

James Clark (14):
      devres: Provide krealloc_array
      coresight: Fix loss of connection info when a module is unloaded
      coresight: Use enum type for cs_mode wherever possible
      coresight: Change name of pdata->conns
      coresight: Rename nr_outports to nr_outconns
      coresight: Rename connection members to make the direction explicit
      coresight: Dynamically add connections
      coresight: Store pointers to connections rather than an array of them
      coresight: Simplify connection fixup mechanism
      coresight: Store in-connections as well as out-connections
      coresight: Make refcount a property of the connection
      coresight: Refactor out buffer allocation function for ETR
      coresight: Enable and disable helper devices adjacent to the path
      coresight: Fix CTI module refcount leak by making it a helper device

Mike Leach (1):
      coresight: etm4x: Fix missing trctraceidr file in sysfs

Nathan Chancellor (1):
      coresight: dummy: Update type of mode parameter in dummy_{sink,source}_enable()

Suzuki K Poulose (2):
      coresight: etm4x: Match all ETM4 instances based on DEVARCH and DEVTYPE
      MAINTAINERS: coresight: Add James Clark as Reviewer

Uwe Kleine-König (1):
      coresight: etm4x: Make etm4_remove_dev() return void

Yicong Yang (5):
      hwtracing: hisi_ptt: Factor out filter allocation and release operation
      hwtracing: hisi_ptt: Add support for dynamically updating the filter list
      hwtracing: hisi_ptt: Export available filters through sysfs
      hwtracing: hisi_ptt: Advertise PERF_PMU_CAP_NO_EXCLUDE for PTT PMU
      hwtracing: hisi_ptt: Fix potential sleep in atomic context

 Documentation/ABI/testing/sysfs-devices-hisi_ptt   |  52 ++
 .../bindings/arm/arm,coresight-dummy-sink.yaml     |  73 +++
 .../bindings/arm/arm,coresight-dummy-source.yaml   |  71 +++
 Documentation/driver-api/driver-model/devres.rst   |   1 +
 Documentation/trace/coresight/coresight-dummy.rst  |  32 ++
 Documentation/trace/hisi-ptt.rst                   |  12 +-
 MAINTAINERS                                        |   1 +
 drivers/hwtracing/coresight/Kconfig                |  11 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-catu.c       |  21 +-
 drivers/hwtracing/coresight/coresight-core.c       | 623 +++++++++++----------
 drivers/hwtracing/coresight/coresight-cti-core.c   |  52 +-
 drivers/hwtracing/coresight/coresight-cti-sysfs.c  |   4 +-
 drivers/hwtracing/coresight/coresight-cti.h        |   4 +-
 drivers/hwtracing/coresight/coresight-dummy.c      | 163 ++++++
 drivers/hwtracing/coresight/coresight-etb10.c      |  13 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   4 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |   6 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  20 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  27 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |  26 +-
 drivers/hwtracing/coresight/coresight-platform.c   | 269 ++++-----
 drivers/hwtracing/coresight/coresight-priv.h       |  36 +-
 drivers/hwtracing/coresight/coresight-replicator.c |  23 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   6 +-
 drivers/hwtracing/coresight/coresight-sysfs.c      |  17 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  26 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 110 ++--
 drivers/hwtracing/coresight/coresight-tmc.h        |   2 +
 drivers/hwtracing/coresight/coresight-tpda.c       |  23 +-
 drivers/hwtracing/coresight/coresight-tpdm.c       |   4 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |   7 +-
 drivers/hwtracing/coresight/coresight-trbe.c       |   3 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c         |  11 +-
 drivers/hwtracing/coresight/ultrasoc-smb.h         |   2 +-
 drivers/hwtracing/ptt/hisi_ptt.c                   | 454 +++++++++++++--
 drivers/hwtracing/ptt/hisi_ptt.h                   |  56 ++
 include/linux/coresight.h                          | 127 +++--
 include/linux/device.h                             |  11 +
 39 files changed, 1662 insertions(+), 742 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
 create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c
