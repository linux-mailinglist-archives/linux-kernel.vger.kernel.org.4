Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFC85F36C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJCTyt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Oct 2022 15:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJCTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:54:44 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755393884;
        Mon,  3 Oct 2022 12:54:41 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id mg6so2261185qvb.10;
        Mon, 03 Oct 2022 12:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jOwdzS72b3jXOhEYZB82wXppg1+nnPfXggM06hyyrQ=;
        b=1qt6mjEYU9AGf2kh2HpQMksRmjuHFrFpjbM71UGlCTP7AhaAo2Sr6ziWZhCjKeesj+
         0IKN26MBYeRGSplxIOYI3oFceav82fzhvKI73eidoC94YXGCoz3FT8ix8WdaR/ParTCE
         5pf6R2ADFwWuTxzs8vNpgOmkoQh/nSP2sEqKFkVxst+fnAyoqWy+Lj6ayAPqm5/g5KrJ
         scYQNr0lWQlbeVNIfsbJC4OeWV8RXUTuIwvFv2jhxxPpllIhhuzRh7xoeqlwek7t0bzT
         W7o4tZhKKRSvekaKNBQi4xpoJcv9zBaZ+itUckTzPKT/bSY6s8N4qIn7P/wIpqgI12Ex
         VjPg==
X-Gm-Message-State: ACrzQf3dF+wcz+BE0bIboTHUpwMOjyjwvfGHTDnDDU/xKaBYRbmUpK/l
        K63iF5xltZHD8/GoeF5pQ2OvEb23KjEzddSgfUZihWQfgWk=
X-Google-Smtp-Source: AMsMyM4YpC61W8W6pYCq7o7Q6srPaoH8Om7x1ML6xuv9ATwKtwx5hKzZtHbyvvcVfNmCW9/nrRItylnU88e5O6gdcGA=
X-Received: by 2002:a0c:9d91:0:b0:4b1:7809:4825 with SMTP id
 s17-20020a0c9d91000000b004b178094825mr11098057qvd.130.1664826880371; Mon, 03
 Oct 2022 12:54:40 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Oct 2022 21:54:29 +0200
Message-ID: <CAJZ5v0iNVCB3PKrquK2RycuZvzQgYz2dODB7hF1jvHm9o3fE3Q@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.1-rc1

with top-most commit c8efe77f23d508d62e232de612e739dbf4da4659

 Merge branch 'pnp'

on top of commit 521a547ced6477c54b4b0cc206000406c221b4d6

 Linux 6.0-rc6

to receive ACPI and PNP updates for 6.1-rc1.

These rearrange the ACPI device object initialization code (to get
rid of a redundant parent pointer from struct acpi_device among other
things), unify the _UID handling, drop support for some _OSI strings
that should not be necessary any more, add new IDs to support more
hardware and some more quirks, fix a few issues and clean up code all
over.

Specifics:

 - Reimplement acpi_get_pci_dev() using the list of physical devices
   associated with the given ACPI device object (Rafael Wysocki).

 - Rename ACPI device object reference counting functions (Rafael
   Wysocki).

 - Rearrange ACPI device object initialization code (Rafael Wysocki).

 - Drop parent field from struct acpi_device (Rafael Wysocki).

 - Extend the int3472-tps68470 driver to support multiple consumers
   of a single TPS68470 along with the requisite framework-level
   support (Daniel Scally).

 - Filter out non-memory resources in is_memory(), add a helper
   function to find all memory type resources of an ACPI device object
   and use that function in 3 places (Heikki Krogerus).

 - Add IRQ override quirks for Asus Vivobook K3402ZA/K3502ZA and ASUS
   model S5402ZA (Tamim Khan, Kellen Renshaw).

 - Fix acpi_dev_state_d0() kerneldoc (Sakari Ailus).

 - Fix up suspend-to-idle support on ASUS Rembrandt laptops (Mario
   Limonciello).

 - Clean up ACPI platform devices support code (Andy Shevchenko, John
   Garry).

 - Clean up ACPI bus management code (Andy Shevchenko, ye xingchen).

 - Add support for multiple DMA windows with different offsets to the
   ACPI device enumeration code and use it on LoongArch (Jianmin Lv).

 - Clean up the ACPI LPSS (Intel SoC) driver (Andy Shevchenko).

 - Add a quirk for Dell Inspiron 14 2-in-1 for StorageD3Enable (Mario
   Limonciello).

 - Drop unused dev_fmt() and redundant 'HMAT' prefix from the HMAT
   parsing code (Liu Shixin).

 - Make ACPI FPDT parsing code avoid calling acpi_os_map_memory() on
   invalid physical addresses (Hans de Goede).

 - Silence missing-declarations warning related to Apple device
   properties management (Lukas Wunner).

 - Disable frequency invariance in the CPPC library if registers used
   by cppc_get_perf_ctrs() are accessed via PCC (Jeremy Linton).

 - Add ACPI disabled check to acpi_cpc_valid() (Perry Yuan).

 - Fix Tx acknowledge in the PCC address space handler (Huisong Li).

 - Use wait_for_completion_timeout() for PCC mailbox operations (Huisong
   Li).

 - Release resources on PCC address space setup failure path (Rafael
   Mendonca).

 - Remove unneeded result variables from APEI code (ye xingchen).

 - Print total number of records found during BERT log parsing (Dmitry
   Monakhov).

 - Drop support for 3 _OSI strings that should not be necessary any
   more and update documentation on custom _OSI strings so that adding
   new ones is not encouraged any more (Mario Limonciello).

 - Drop unneeded result variable from ec_write() (ye xingchen).

 - Remove the leftover struct acpi_ac_bl from the ACPI AC driver (Hanjun
   Guo).

 - Reorder symbols to get rid of a few forward declarations in the ACPI
   fan driver (Uwe Kleine-König).

 - Add Toshiba Satellite/Portege Z830 ACPI backlight quirk (Arvid
   Norlander).

 - Add ARM DMA-330 controller to the supported list in the ACPI AMBA
   driver (Vijayenthiran Subramaniam).

 - Drop references to non-functional 01.org/linux-acpi web site from
   MAINTAINERS and Kconfig help texts (Rafael Wysocki).

 - Replace strlcpy() with unused retval with strscpy() in the ACPI
   support code (Wolfram Sang).

 - Do not initialize ret in main() in the pfrut utility (Shi junming).

 - Drop useless ACPI DSDT override documentation (Rafael Wysocki).

 - Fix a few typos and wording mistakes in the ACPI device enumeration
   documentation (Jean Delvare).

 - Introduce acpi_dev_uid_to_integer() to convert a _UID string into an
   integer value (Andy Shevchenko).

 - Use acpi_dev_uid_to_integer() in several places to unify _UID
   handling (Andy Shevchenko).

 - Drop unused pnpid32_to_pnpid() declaration from  PNP code (Gaosheng
   Cui).

Thanks!


---------------

Andy Shevchenko (16):
      ACPI: bus: Drop kernel doc annotation from acpi_bus_notify()
      ACPI: bus: Refactor ACPI matching functions for better readability
      ACPI: platform: Get rid of redundant 'else'
      ACPI: platform: Remove redundant print on -ENOMEM
      ACPI: platform: Use sizeof(*pointer) instead of sizeof(type)
      ACPI: platform: Sort forbidden_id_list[] in ascending order
      ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as integer
      ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()
      ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
      i2c: amd-mp2-plat: Refactor _UID handling to use acpi_dev_uid_to_integer()
      i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
      perf: qcom_l2_pmu: Refactor _UID handling to use acpi_dev_uid_to_integer()
      spi: pxa2xx: Refactor _UID handling to use acpi_dev_uid_to_integer()
      efi/dev-path-parser: Refactor _UID handling to use
acpi_dev_uid_to_integer()
      ACPI: LPSS: Replace loop with first entry retrieval
      ACPI: LPSS: Deduplicate skipping device in acpi_lpss_create_device()

Arvid Norlander (1):
      ACPI: video: Add Toshiba Satellite/Portege Z830 quirk

Daniel Scally (5):
      ACPI: scan: Add acpi_dev_get_next_consumer_dev()
      ACPI: bus: Add iterator for dependent devices
      platform/x86: int3472: Support multiple clock consumers
      platform/x86: int3472: Support multiple gpio lookups in board data
      platform/x86: int3472: Add board data for Surface Go2 IR camera

Dmitry Monakhov (1):
      ACPI: APEI: Add BERT error log footer

Gaosheng Cui (1):
      PNPBIOS: remove unused pnpid32_to_pnpid() declaration

Hanjun Guo (1):
      ACPI: AC: Remove the leftover struct acpi_ac_bl

Hans de Goede (1):
      ACPI: tables: FPDT: Don't call acpi_os_map_memory() on invalid
phys address

Heikki Krogerus (5):
      ACPI: resource: Filter out the non memory resources in is_memory()
      ACPI: resource: Add helper function acpi_dev_get_memory_resources()
      ACPI: APD: Use the helper acpi_dev_get_memory_resources()
      ACPI: LPSS: Use the helper acpi_dev_get_memory_resources()
      usb: typec: intel_pmc_mux: Use the helper acpi_dev_get_memory_resources()

Huisong Li (2):
      ACPI: PCC: replace wait_for_completion()
      ACPI: PCC: Fix Tx acknowledge in the PCC address space handler

Jean Delvare (1):
      ACPI: docs: enumeration: Fix a few typos and wording mistakes

Jeremy Linton (1):
      ACPI: CPPC: Disable FIE if registers in PCC regions

Jianmin Lv (2):
      ACPI: scan: Support multiple DMA windows with different offsets
      LoongArch: Use acpi_arch_dma_setup() and remove ARCH_HAS_PHYS_TO_DMA

John Garry (1):
      ACPI: platform: Use PLATFORM_DEVID_NONE in acpi_create_platform_device()

Kellen Renshaw (1):
      ACPI: resource: Add ASUS model S5402ZA to quirks

Liu Shixin (1):
      ACPI: HMAT: Drop unused dev_fmt() and redundant 'HMAT' prefix

Lukas Wunner (1):
      ACPI: property: Silence missing-declarations warning in apple.c

Mario Limonciello (14):
      ACPI: OSI: Remove Linux-Dell-Video _OSI string
      ACPI: OSI: Remove Linux-Lenovo-NV-HDMI-Audio _OSI string
      ACPI: OSI: Remove Linux-HPI-Hybrid-Graphics _OSI string
      ACPI: OSI: Update Documentation on custom _OSI strings
      ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1 for StorageD3Enable
      ACPI: x86: s2idle: Move _HID handling for AMD systems into structures
      ACPI: x86: s2idle: If a new AMD _HID is missing assume Rembrandt
      ACPI: x86: s2idle: Add module parameter to prefer Microsoft GUID
      ACPI: x86: s2idle: Add a quirk for ASUS TUF Gaming A17 FA707RE
      ACPI: x86: s2idle: Add a quirk for ASUS ROG Zephyrus G14
      ACPI: x86: s2idle: Add a quirk for Lenovo Slim 7 Pro 14ARH7
      ACPI: x86: s2idle: Add a quirk for ASUSTeK COMPUTER INC. ROG Flow X13
      ACPI: x86: s2idle: Fix a NULL pointer dereference
      ACPI: x86: s2idle: Add another ID to s2idle_dmi_table

Perry Yuan (1):
      ACPI: CPPC: Add ACPI disabled check to acpi_cpc_valid()

Rafael J. Wysocki (13):
      ACPI: Rename acpi_bus_get/put_acpi_device()
      ACPI: scan: Rename acpi_bus_get_parent() and rearrange it
      ACPI: scan: Rearrange initialization of ACPI device objects
      ACPI: scan: Eliminate __acpi_device_add()
      ACPI: Drop parent field from struct acpi_device
      ACPI: PM: Fix NULL argument handling in acpi_device_get/set_power()
      ACPI: Drop redundant acpi_dev_parent() header
      ACPI: property: Use acpi_dev_parent()
      ACPI: PCI: Rework acpi_get_pci_dev()
      ACPI: DPTF: Drop stale link from Kconfig help
      ACPI: docs: Drop useless DSDT override documentation
      ACPI: Kconfig: Drop link to https://01.org/linux-acpi
      MAINTAINERS: Drop records pointing to 01.org/linux-acpi

Rafael Mendonca (1):
      ACPI: PCC: Release resources on address space setup failure path

Sakari Ailus (1):
      ACPI: PM: Fix acpi_dev_state_d0() kerneldoc

Shi junming (1):
      ACPI: tools: pfrut: Do not initialize ret in main()

Tamim Khan (1):
      ACPI: resource: Skip IRQ override on Asus Vivobook K3402ZA/K3502ZA

Uwe Kleine-König (1):
      ACPI: fan: Reorder symbols to get rid of a few forward declarations

Vijayenthiran Subramaniam (1):
      ACPI: AMBA: Add ARM DMA-330 controller to the supported list

Wolfram Sang (1):
      ACPI: move from strlcpy() with unused retval to strscpy()

ye xingchen (3):
      ACPI: bus: Remove the unneeded result variable
      ACPI: EC: Drop unneeded result variable from ec_write()
      ACPI: APEI: Remove unneeded result variables

---------------

 Documentation/admin-guide/acpi/dsdt-override.rst   |  13 --
 Documentation/firmware-guide/acpi/enumeration.rst  |  16 +-
 Documentation/firmware-guide/acpi/osi.rst          |  25 ++-
 MAINTAINERS                                        |   3 -
 arch/loongarch/Kconfig                             |   1 -
 arch/loongarch/kernel/dma.c                        |  52 +++---
 arch/loongarch/kernel/setup.c                      |   2 +-
 drivers/acpi/Kconfig                               |   4 -
 drivers/acpi/ac.c                                  |   5 -
 drivers/acpi/acpi_amba.c                           |   6 +-
 drivers/acpi/acpi_apd.c                            |   9 +-
 drivers/acpi/acpi_fpdt.c                           |  22 +++
 drivers/acpi/acpi_lpss.c                           |  69 ++++----
 drivers/acpi/acpi_pcc.c                            |  28 +++-
 drivers/acpi/acpi_platform.c                       |  22 ++-
 drivers/acpi/acpi_video.c                          |  18 ++-
 drivers/acpi/apei/apei-base.c                      |   5 +-
 drivers/acpi/apei/bert.c                           |   3 +
 drivers/acpi/apei/erst.c                           |   6 +-
 drivers/acpi/arm64/dma.c                           |  28 ++--
 drivers/acpi/bus.c                                 |  37 ++---
 drivers/acpi/cppc_acpi.c                           |  45 ++++++
 drivers/acpi/device_pm.c                           |  38 +++--
 drivers/acpi/dptf/Kconfig                          |   3 -
 drivers/acpi/ec.c                                  |   6 +-
 drivers/acpi/fan_core.c                            |  58 ++++---
 drivers/acpi/internal.h                            |   6 +-
 drivers/acpi/irq.c                                 |   4 +-
 drivers/acpi/numa/hmat.c                           |  25 ++-
 drivers/acpi/osi.c                                 |  24 ---
 drivers/acpi/pci_root.c                            |  75 ++-------
 drivers/acpi/power.c                               |  11 +-
 drivers/acpi/processor_idle.c                      |   8 +-
 drivers/acpi/property.c                            |  13 +-
 drivers/acpi/resource.c                            |  46 ++++++
 drivers/acpi/sbs.c                                 |   2 +-
 drivers/acpi/sbshc.c                               |   2 +-
 drivers/acpi/scan.c                                | 179 +++++++++++----------
 drivers/acpi/utils.c                               |  30 +++-
 drivers/acpi/x86/apple.c                           |   1 +
 drivers/acpi/x86/s2idle.c                          | 147 ++++++++++++++---
 drivers/acpi/x86/utils.c                           |  33 +++-
 drivers/base/arch_topology.c                       |   2 +-
 drivers/clk/clk-tps68470.c                         |  13 +-
 drivers/cpufreq/amd-pstate.c                       |   2 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  27 +++-
 drivers/firmware/efi/dev-path-parser.c             |  10 +-
 drivers/hv/vmbus_drv.c                             |   3 +-
 drivers/hwmon/acpi_power_meter.c                   |   2 +-
 drivers/i2c/busses/i2c-amd-mp2-plat.c              |  27 ++--
 drivers/i2c/busses/i2c-mlxbf.c                     |  20 +--
 drivers/perf/arm_dsu_pmu.c                         |   4 +-
 drivers/perf/qcom_l2_pmu.c                         |  10 +-
 drivers/perf/qcom_l3_pmu.c                         |   3 +-
 drivers/platform/x86/intel/int3472/common.c        |   2 +-
 drivers/platform/x86/intel/int3472/tps68470.c      |  76 +++++++--
 drivers/platform/x86/intel/int3472/tps68470.h      |   3 +-
 .../x86/intel/int3472/tps68470_board_data.c        |  54 ++++++-
 drivers/pnp/pnpbios/pnpbios.h                      |   1 -
 drivers/spi/spi-pxa2xx.c                           |  37 ++---
 drivers/spi/spi.c                                  |   2 +-
 drivers/thunderbolt/acpi.c                         |   2 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |  11 +-
 include/acpi/acpi_bus.h                            |  34 +++-
 include/acpi/cppc_acpi.h                           |   5 +
 include/linux/acpi.h                               |  18 ++-
 include/linux/platform_data/tps68470.h             |   7 +-
 tools/power/acpi/tools/pfrut/pfrut.c               |   2 +-
 68 files changed, 904 insertions(+), 603 deletions(-)
