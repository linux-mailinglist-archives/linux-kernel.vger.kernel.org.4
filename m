Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77776699631
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBPNqO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Feb 2023 08:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBPNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:46:12 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4743668F;
        Thu, 16 Feb 2023 05:45:56 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id fi26so2937928edb.7;
        Thu, 16 Feb 2023 05:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjKHIHXSdT0lhNKsCePZniV6nAox9vH8tB04oV6PELk=;
        b=b1K6hgowNAlb25nVfGtrEkSqs/Plp7sltK5Ui4J35PRCpY7Eq/2I7931gs4OxiQK+4
         lQqlcgUtpnC0oTh/ZPjC2GYnC7w2Y5Pj8DqYZefR2i/6C1eS8JenBG5ahIu5jSQXScBz
         QjNNlZUcmqM5FT/n3P3A6HugDOoTfEtOTBPa76obyro7fQjXmhSaclC5R4oMtOKUJGOe
         HdgGEVMA8MyrYyomdvOHgIuzlieESot+VFXrhvE7/8JjioyO3x9qMBxIWGKXmf7IE0yG
         i5ji8FE7BbhsRgbwxkVCPGEzXeoqZWFuvsNMFYjBJLJMdfBDVYmlTQGvS2WMahO4Pb1r
         LU6g==
X-Gm-Message-State: AO0yUKWTCRNxDoBscVSvDqeET8OMdWHjPdQwl4geKACsZfhKevuHBZK2
        PykRuGMPXV9tEFm0IfS9d7ZzNCUOfh9juTwx/T4=
X-Google-Smtp-Source: AK7set8uDK68hNtzSiLUNWJFW5+e7pRgASEq1SfvycaM3/VYeclwoOkf5/mK5/24HcNgGz5UUsVIxAF1MkkOXpDM+DA=
X-Received: by 2002:a17:907:9727:b0:8b1:3540:7632 with SMTP id
 jg39-20020a170907972700b008b135407632mr1775281ejc.2.1676555149380; Thu, 16
 Feb 2023 05:45:49 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Feb 2023 14:45:38 +0100
Message-ID: <CAJZ5v0jXnjq+zRcsvUfuS=-5brPEdXw-BrFvkD8jR7kQ_ob_ww@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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

I'm sending this ahead of time, because I will be traveling next week
and I don't want to delay the integration of the changes below just
because of my absence.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.3-rc1

with top-most commit 6828e402d06f7c574430b61c05db784cd847b19f

 thermal/drivers/st: Remove syscfg based driver

on top of commit acd7e9ee57c880b99671dd99680cb707b7b5b0ee

 thermal: intel: int340x: Add locking to int340x_thermal_get_trip_type()

to receive thermal control updates for 6.3-rc1.

The majority of changes here are related to the general switch-over to
using arrays of generic trip point structures registered along with a
thermal zone instead of trip point callbacks (this has been done mostly
by Daniel Lezcano with some help from yours truly on the Intel drivers
front).

Apart from that and the related reorganization of code, there are some
enhancements of the existing driver and a new Mediatek Low Voltage
Thermal Sensor (LVTS) driver.  The Intel powerclamp undergoes a major
rework so it will use the generic idle_inject facility for CPU idle time
injection going forward and it will take additional module parameters
for specifying the subset of CPUs to be affected by it (work done by
Srinivas Pandruvada).

Also included are assorted fixes and a whole bunch of cleanups.

Specifics:

 - Rework a large bunch of drivers to use the generic thermal trip
   structure and use the opportunity to do more cleanups by removing
   unused functions from the OF code (Daniel Lezcano).

 - Remove core header inclusion from drivers (Daniel Lezcano).

 - Fix some locking issues related to the generic thermal trip rework
   (Johan Hovold).

 - Fix a crash when requesting the critical temperature on tegra, which
   is related to the generic trip point work (Jon Hunter).

 - Clean up thermal device unregistration code (Viresh Kumar).

 - Fix and clean up thermal control core initialization error code
   paths (Daniel Lezcano).

 - Relocate the trip points handling code into a separate file (Daniel
   Lezcano).

 - Make the thermal core fail registration of thermal zones and cooling
   devices if the thermal class has not been registered (Rafael Wysocki).

 - Add trip point initialization helper functions for ACPI-defined trip
   points and modify two thermal drivers to use them (Rafael Wysocki,
   Daniel Lezcano).

 - Make the core thermal control code use sysfs_emit_at() instead of
   scnprintf() where applicable (ye xingchen).

 - Consolidate code accessing the Intel TCC (Thermal Control Circuitry)
   MSRs by introducing library functions for that and making the
   TCC-related code in thermal drivers use them (Zhang Rui).

 - Enhance the x86_pkg_temp_thermal driver to support dynamic tjmax
   changes (Zhang Rui).

 - Address an "unsigned expression compared with zero" warning in the
   intel_soc_dts_iosf thermal driver (Yang Li).

 - Update comments regarding two functions in the Intel Menlow thermal
   driver (Deming Wang).

 - Use sysfs_emit_at() instead of scnprintf() in the int340x thermal
   driver (ye xingchen).

 - Make the intel_pch thermal driver support the Wellsburg PCH (Tim
   Zimmermann).

 - Modify the intel_pch and processor_thermal_device_pci thermal drivers
   use generic trip point tables instead of thermal zone trip point
   callbacks (Daniel Lezcano).

 - Add production mode attribute sysfs attribute to the int340x thermal
   driver (Srinivas Pandruvada).

 - Rework dynamic trip point updates handling and locking in the int340x
   thermal driver (Rafael Wysocki).

 - Make the int340x thermal driver use a generic trip points table
   instead of thermal zone trip point callbacks (Rafael Wysocki, Daniel
   Lezcano).

 - Clean up and improve the int340x thermal driver (Rafael Wysocki).

 - Simplify and clean up the intel_pch thermal driver (Rafael Wysocki).

 - Fix the Intel powerclamp thermal driver and make it use the common
   idle injection framework (Srinivas Pandruvada).

 - Add two module parameters, cpumask and max_idle, to the Intel powerclamp
   thermal driver to allow it to affect only a specific subset of CPUs
   instead of all of them (Srinivas Pandruvada).

 - Make the Intel quark_dts thermal driver Use generic trip point
   objects instead of its own trip point representation (Daniel
   Lezcano).

 - Add toctree entry for thermal documents and fix two issues in the
   Intel powerclamp driver documentation (Bagas Sanjaya).

 - Use strscpy() instead of strncpy() in the thermal core (Xu Panda).

 - Fix thermal_sampling_exit() (Vincent Guittot).

 - Add Mediatek Low Voltage Thermal Sensor (LVTS) driver (Balsam Chihi).

 - Add r8a779g0 RCar support to the rcar_gen3 thermal driver (Geert
   Uytterhoeven).

 - Fix useless call to set_trips() when resuming in the rcar_gen3
   thermal control driver and add interrupt support detection at init
   time to it (Niklas Söderlund).

 - Fix memory corruption in the hi3660 thermal driver (Yongqin Liu).

 - Fix include path for libnl3 in pkg-config file for libthermal (Vibhav
   Pant).

 - Remove syscfg-based driver for st as the platform is not supported
   any more (Alain Volmat).

Thanks!


---------------

Alain Volmat (1):
      thermal/drivers/st: Remove syscfg based driver

Andy Shevchenko (1):
      thermal/drivers/qcom-spmi-adc-tm5: Use asm intead of asm-generic

Bagas Sanjaya (3):
      Documentation: admin-guide: Add toctree entry for thermal docs
      Documentation: powerclamp: Escape wildcard in cpumask description
      Documentation: powerclamp: Fix numbered lists formatting

Balsam CHIHI (3):
      thermal/drivers/mediatek: Relocate driver to mediatek folder
      dt-bindings: thermal: mediatek: Add LVTS thermal controllers
      thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver

Daniel Golle (2):
      thermal/drivers/mtk: Use function pointer for raw_to_mcelsius
      thermal/drivers/mtk: Add support for MT7986 and MT7981

Daniel Lezcano (41):
      thermal/core: Add a generic thermal_zone_get_trip() function
      thermal/sysfs: Always expose hysteresis attributes
      thermal/core: Add a generic thermal_zone_set_trip() function
      thermal/core/governors: Use thermal_zone_get_trip() instead of
ops functions
      thermal/of: Use generic thermal_zone_get_trip() function
      thermal/of: Remove unused functions
      thermal/drivers/exynos: Use generic thermal_zone_get_trip() function
      thermal/drivers/exynos: of_thermal_get_ntrips()
      thermal/drivers/exynos: Replace of_thermal_is_trip_valid() by
thermal_zone_get_trip()
      thermal/drivers/tegra: Use generic thermal_zone_get_trip() function
      thermal/drivers/uniphier: Use generic thermal_zone_get_trip() function
      thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
      thermal/drivers/qcom: Use generic thermal_zone_get_trip() function
      thermal/drivers/armada: Use generic thermal_zone_get_trip() function
      thermal/drivers/rcar_gen3: Use the generic function to get the
number of trips
      thermal/of: Remove of_thermal_get_ntrips()
      thermal/of: Remove of_thermal_is_trip_valid()
      thermal/of: Remove of_thermal_set_trip_hyst()
      thermal/of: Remove of_thermal_get_crit_temp()
      thermal/drivers/st: Use generic trip points
      thermal/drivers/imx: Use generic thermal_zone_get_trip() function
      thermal/drivers/rcar: Use generic thermal_zone_get_trip() function
      thermal/drivers/broadcom: Use generic thermal_zone_get_trip() function
      thermal/drivers/da9062: Use generic thermal_zone_get_trip() function
      thermal/drivers/ti: Remove unused macros
ti_thermal_get_trip_value() / ti_thermal_trip_is_valid()
      thermal/drivers/acerhdf: Use generic thermal_zone_get_trip() function
      thermal/drivers/cxgb4: Use generic thermal_zone_get_trip() function
      thermal/intel/int340x: Replace parameter to simplify
      thermal/drivers/intel: Use generic thermal_zone_get_trip() function
      thermal/drivers/exynos: Fix NULL pointer dereference when
getting the critical temp
      wifi: iwlwifi: Use generic thermal_zone_get_trip() function
      thermal/drivers/mellanox: Use generic thermal_zone_get_trip() function
      thermal/drivers/qcom: Remove duplicate set next trip point interrupt code
      thermal/drivers/armada: Use the thermal_zone_get_crit_temp()
      thermal: intel: intel_pch: Use generic trip points
      thermal/core: Fix unregistering netlink at thermal init time
      thermal/core: Remove unneeded ida_destroy()
      thermal/core: Move the thermal trip code to a dedicated file
      thermal: intel: processor_thermal_device_pci: Use generic trip point
      thermal: intel: quark_dts: Use generic trip points
      thermal: Remove core header inclusion from drivers

Deming Wang (1):
      thermal: intel: menlow: Update function descriptions

Dmitry Baryshkov (14):
      dt-bindings: thermal: tsens: add msm8956 compat
      dt-bindings: thermal: tsens: support per-sensor calibration cells
      dt-bindings: thermal: tsens: add per-sensor cells for msm8974
      thermal/drivers/tsens: Drop unnecessary hw_ids
      thermal/drivers/tsens: Drop msm8976-specific defines
      thermal/drivers/tsens: Sort out msm8976 vs msm8956 data
      thermal/drivers/tsens: fix slope values for msm8939
      thermal/drivers/tsens: limit num_sensors to 9 for msm8939
      thermal/drivers/tsens: Support using nvmem cells for calibration data
      thermal/drivers/tsens: Support using nvmem cells for msm8974 calibration
      thermal/drivers/tsens: Rework legacy calibration data parsers
      thermal/drivers/tsens: Drop single-cell code for mdm9607
      thermal/drivers/tsens: Drop single-cell code for msm8939
      thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956

Geert Uytterhoeven (2):
      dt-bindings: thermal: rcar-gen3-thermal: Add r8a779g0 support
      thermal/drivers/rcar_gen3: Add support for R-Car V4H

Johan Hovold (3):
      thermal/drivers/qcom: Fix set_trip_temp() deadlock
      thermal/drivers/tegra: Fix set_trip_temp() deadlock
      thermal/drivers/qcom: Fix lock inversion

Jon Hunter (1):
      thermal/drivers/tegra: Fix crash when getting critical temp

Krzysztof Kozlowski (1):
      dt-bindings: thermal: qcom-spmi-adc-tm5: add qcom,adc-tm7

Niklas Söderlund (3):
      thermal/drivers/rcar_gen3_thermal: Do not call set_trips() when resuming
      thermal/drivers/rcar_gen3_thermal: Create device local ops struct
      thermal/drivers/rcar_gen3_thermal: Fix device initialization

Rafael J. Wysocki (19):
      thermal: ACPI: Add ACPI trip point routines
      thermal: Fail object registration if thermal class is not registered
      thermal: ACPI: Initialize trips if temperature is out of range
      thermal: intel: int340x: Rework updating trip points
      thermal: intel: int340x: Use zone lock for synchronization
      thermal: intel: int340x: Use generic trip points table
      thermal: ACPI: Make helpers retrieve temperature only
      thermal: intel: int340x: Assorted minor cleanups
      thermal: intel: int340x: Rename variable in int340x_thermal_zone_add()
      thermal: intel: int340x: Drop pointless cast to unsigned long
      thermal: intel: int340x: Improve int340x_thermal_set_trip_temp()
      thermal: intel: intel_pch: Make pch_wpt_add_acpi_psv_trip() return int
      thermal: intel: intel_pch: Eliminate redundant return pointers
      thermal: intel: intel_pch: Rename device operations callbacks
      thermal: intel: intel_pch: Eliminate device operations object
      thermal: intel: intel_pch: Fold two functions into their callers
      thermal: intel: intel_pch: Fold suspend and resume routines into
their callers
      thermal: intel: intel_pch: Rename board ID symbols
      thermal: intel: intel_pch: Drop struct board_info

Randy Dunlap (3):
      thermal/drivers/mtk_thermal: Fix kernel-doc function name
      thermal/drivers/rockchip: Fix kernel-doc warnings
      thermal/drivers/uniphier: Use regular comment syntax

Srinivas Pandruvada (9):
      thermal: intel: int340x: Add production mode attribute
      thermal: intel: powerclamp: Fix cur_state for multi package system
      powercap: idle_inject: Export symbols
      powercap: idle_inject: Add update callback
      thermal: intel: powerclamp: Use powercap idle-inject feature
      thermal: intel: powerclamp: Return last requested state as cur_state
      thermal: intel: powerclamp: Fix duration module parameter
      Documentation: admin-guide: Move intel_powerclamp documentation
      thermal: intel: powerclamp: Add two module parameters

Tim Zimmermann (1):
      thermal: intel: intel_pch: Add support for Wellsburg PCH

Vibhav Pant (1):
      tools/lib/thermal: Fix include path for libnl3 in pkg-config file.

Vincent Guittot (1):
      tools/lib/thermal: Fix thermal_sampling_exit()

Viorel Suman (2):
      thermal/drivers/imx_sc_thermal: Fix the loop condition
      thermal/drivers/imx_sc_thermal: Add iMX8QM sensors

Viresh Kumar (2):
      thermal: core: Move cdev cleanup to thermal_release()
      thermal: core: Use device_unregister() instead of device_del/put()

Xu Panda (1):
      thermal/drivers/armada: Use strscpy() to instead of strncpy()

Yang Li (1):
      thermal: intel: Fix unsigned comparison with less than zero

Yangtao Li (1):
      thermal/drivers/sun8i: Convert to use macro

Yongqin Liu (1):
      thermal/drivers/hisi: Drop second sensor hi3660

Zhang Rui (6):
      thermal/intel: Introduce Intel TCC library
      thermal/int340x/processor_thermal: Use Intel TCC library
      thermal/intel/intel_soc_dts_iosf: Use Intel TCC library
      thermal/intel/intel_tcc_cooling: Use Intel TCC library
      thermal/x86_pkg_temp_thermal: Use Intel TCC library
      thermal/x86_pkg_temp_thermal: Add support for handling dynamic tjmax

ye xingchen (11):
      thermal/drivers/brcmstb_thermal: Use
devm_platform_get_and_ioremap_resource()
      thermal/drivers/bcm2835: Use devm_platform_get_and_ioremap_resource()
      thermal/drivers/dove: Use devm_platform_get_and_ioremap_resource()
      thermal/drivers/armada: Use devm_platform_get_and_ioremap_resource()
      thermal/drivers/mtk_thermal: Use devm_platform_get_and_ioremap_resource()
      thermal/drivers/rockchip: Use devm_platform_get_and_ioremap_resource()
      thermal/drivers/thermal_mmio: Use devm_platform_get_and_ioremap_resource()
      thermal/drivers/kirkwood: Use devm_platform_get_and_ioremap_resource()
      thermal/drivers/spear: Use devm_platform_get_and_ioremap_resource()
      thermal: int340x_thermal: Use sysfs_emit_at() instead of scnprintf()
      thermal: core: Use sysfs_emit_at() instead of scnprintf()

---------------

 Documentation/admin-guide/index.rst                |    1 +
 Documentation/admin-guide/thermal/index.rst        |    8 +
 .../thermal/intel_powerclamp.rst                   |   35 +-
 .../bindings/thermal/mediatek,lvts-thermal.yaml    |  142 +++
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |    1 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |  153 ++-
 .../bindings/thermal/rcar-gen3-thermal.yaml        |    3 +
 Documentation/driver-api/thermal/index.rst         |    1 -
 Documentation/driver-api/thermal/intel_dptf.rst    |    3 +
 MAINTAINERS                                        |    1 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |    2 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c |   39 +-
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  209 +---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |   71 +-
 drivers/platform/x86/acerhdf.c                     |   73 +-
 drivers/powercap/idle_inject.c                     |   59 +-
 drivers/thermal/Kconfig                            |   18 +-
 drivers/thermal/Makefile                           |    7 +-
 drivers/thermal/amlogic_thermal.c                  |    1 -
 drivers/thermal/armada_thermal.c                   |   32 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |   11 +-
 drivers/thermal/broadcom/brcmstb_thermal.c         |    4 +-
 drivers/thermal/da9062-thermal.c                   |   52 +-
 drivers/thermal/dove_thermal.c                     |    7 +-
 drivers/thermal/gov_bang_bang.c                    |   37 +-
 drivers/thermal/gov_fair_share.c                   |   18 +-
 drivers/thermal/gov_power_allocator.c              |   51 +-
 drivers/thermal/gov_step_wise.c                    |   22 +-
 drivers/thermal/hisi_thermal.c                     |   18 +-
 drivers/thermal/imx8mm_thermal.c                   |    1 -
 drivers/thermal/imx_sc_thermal.c                   |    9 +-
 drivers/thermal/imx_thermal.c                      |   72 +-
 drivers/thermal/intel/Kconfig                      |   11 +
 drivers/thermal/intel/Makefile                     |    1 +
 drivers/thermal/intel/int340x_thermal/Kconfig      |    2 +
 .../intel/int340x_thermal/int3400_thermal.c        |   58 +-
 .../intel/int340x_thermal/int3403_thermal.c        |    2 +-
 .../intel/int340x_thermal/int340x_thermal_zone.c   |  352 +++---
 .../intel/int340x_thermal/int340x_thermal_zone.h   |   17 +-
 .../int340x_thermal/processor_thermal_device.c     |  129 +--
 .../int340x_thermal/processor_thermal_device_pci.c |   53 +-
 drivers/thermal/intel/intel_hfi.c                  |    3 +-
 drivers/thermal/intel/intel_menlow.c               |   12 +-
 drivers/thermal/intel/intel_pch_thermal.c          |  410 +++----
 drivers/thermal/intel/intel_powerclamp.c           |  545 +++++----
 drivers/thermal/intel/intel_quark_dts_thermal.c    |   55 +-
 drivers/thermal/intel/intel_soc_dts_iosf.c         |   35 +-
 drivers/thermal/intel/intel_tcc.c                  |  139 +++
 drivers/thermal/intel/intel_tcc_cooling.c          |   37 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |  176 +--
 drivers/thermal/kirkwood_thermal.c                 |    4 +-
 drivers/thermal/mediatek/Kconfig                   |   37 +
 drivers/thermal/mediatek/Makefile                  |    2 +
 .../{mtk_thermal.c => mediatek/auxadc_thermal.c}   |  151 ++-
 drivers/thermal/mediatek/lvts_thermal.c            | 1224 ++++++++++++++++++++
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |    3 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   45 +-
 drivers/thermal/qcom/tsens-v0_1.c                  |  655 +++--------
 drivers/thermal/qcom/tsens-v1.c                    |  340 ++----
 drivers/thermal/qcom/tsens.c                       |  219 +++-
 drivers/thermal/qcom/tsens.h                       |   46 +-
 drivers/thermal/qoriq_thermal.c                    |    1 -
 drivers/thermal/rcar_gen3_thermal.c                |   43 +-
 drivers/thermal/rcar_thermal.c                     |   53 +-
 drivers/thermal/rockchip_thermal.c                 |   10 +-
 drivers/thermal/samsung/exynos_tmu.c               |   65 +-
 drivers/thermal/spear_thermal.c                    |    4 +-
 drivers/thermal/st/Kconfig                         |    4 -
 drivers/thermal/st/Makefile                        |    1 -
 drivers/thermal/st/st_thermal.c                    |   47 +-
 drivers/thermal/st/st_thermal_syscfg.c             |  174 ---
 drivers/thermal/st/stm_thermal.c                   |    1 -
 drivers/thermal/sun8i_thermal.c                    |    4 +-
 drivers/thermal/tegra/soctherm.c                   |   35 +-
 drivers/thermal/tegra/tegra30-tsensor.c            |   18 +-
 drivers/thermal/thermal_acpi.c                     |  117 ++
 drivers/thermal/thermal_core.c                     |  145 ++-
 drivers/thermal/thermal_core.h                     |   28 +-
 drivers/thermal/thermal_helpers.c                  |   70 +-
 drivers/thermal/thermal_mmio.c                     |    4 +-
 drivers/thermal/thermal_netlink.c                  |   24 +-
 drivers/thermal/thermal_netlink.h                  |    3 +
 drivers/thermal/thermal_of.c                       |  116 --
 drivers/thermal/thermal_sysfs.c                    |  135 +--
 drivers/thermal/thermal_trip.c                     |  182 +++
 drivers/thermal/ti-soc-thermal/ti-thermal.h        |   15 -
 drivers/thermal/uniphier_thermal.c                 |   31 +-
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    |   19 +
 include/linux/idle_inject.h                        |    3 +
 include/linux/intel_tcc.h                          |   18 +
 include/linux/thermal.h                            |   19 +
 tools/lib/thermal/libthermal.pc.template           |    2 +-
 tools/lib/thermal/sampling.c                       |    2 +-
 94 files changed, 4143 insertions(+), 3176 deletions(-)
