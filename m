Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB56ED3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjDXRuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjDXRus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:50:48 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9936A78;
        Mon, 24 Apr 2023 10:50:43 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-94ea38c90ccso141416366b.1;
        Mon, 24 Apr 2023 10:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682358642; x=1684950642;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfGXBss9aY0QLvW26dpEQzBVQ6APBnBmG7IAk7EnyFk=;
        b=iBNL+NPxSWhZoeNbtr+gkQkj3Ae9Lwk6mpSiRGSTxvM03ToPtIaOAn8KAjqVfnV4jc
         x2Re/UYU6eDPWkGBsLFz3PGRkB01feRhk3ws3ROE5aBMmNIzKJsbLBPQ5AAfnl6KiKfO
         AdOfwjr0jEPb+vXwFneT+WdiYxj84qEZm0+7EG5vq7QNbf50l2KouBb+vpDgZoFdz30a
         WokJ6dTc4WMMDJ5Ly27GsY4zxcKaYzjcCwD/oj4A49WKqemJqyjkAjk/vdEXh5sXIiM8
         jKpJROl0gN0ILg9YIGJ/N1FUUaoyUxmL62V+mOckEJHKubVRr1RedLrPrlFQG6aT0FU5
         ua6Q==
X-Gm-Message-State: AAQBX9cvFhuhOmj8JTGGQqjflKuD8U34GQRyCtUqqB0CzV2YdtAZhEHy
        AMWIV3EOuHZzQJWF7YTT7oY6RdPGcCmCCUqFzZ1FPQIPNLc=
X-Google-Smtp-Source: AKy350aJeolYrMEm5Nvf6FPdpDvx1JsRn37DiDNUjJ54cjTRYFl8Btcfkx9BojQP4gW5fSJ7fxWFLGqooR3Jiccu++4=
X-Received: by 2002:a17:906:7283:b0:953:7308:56bf with SMTP id
 b3-20020a170906728300b00953730856bfmr11011806ejl.7.1682358642018; Mon, 24 Apr
 2023 10:50:42 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Apr 2023 19:50:31 +0200
Message-ID: <CAJZ5v0h7z2iy5M+eWoA6M23rYfZ+OS54FVDjWmGNze4fR45EmA@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.4-rc1

with top-most commit 5bc6b1df65c87f8dd7d0afe494a2c0b9d5c73140

 thermal: intel: int340x: Add DLVR support for RFIM control

on top of commit 117e4e5bd9d47b89777dbf6b37a709dcfe59520f

 thermal: intel: Avoid updating unsupported THERM_STATUS_CLEAR mask bits

to receive thermal control updates for 6.4-rc1.

These mostly continue to prepare the thermal control subsystem for
using unified representation of trip points, which includes cleanups,
code refactoring and similar and update several drivers (for other
reasons), which includes new hardware support.

Specifics:

 - Add a thermal zone 'devdata' accessor and modify several drivers to
   use it (Daniel Lezcano).

 - Prevent drivers from using the 'device' internal thermal zone
   structure field directly (Daniel Lezcano).

 - Clean up the hwmon thermal driver (Daniel Lezcano).

 - Add thermal zone id accessor and thermal zone type accessor
   and prevent drivers from using thermal zone fields directly (Daniel
   Lezcano).

 - Clean up the acerhdf and tegra thermal drivers (Daniel Lezcano).

 - Add lower bound check for sysfs input to the x86_pkg_temp_thermal
   Intel thermal driver (Zhang Rui).

 - Add more thermal zone device encapsulation: prevent setting structure
   field directly, access the sensor device instead the thermal zone's
   device for trace, relocate the traces in drivers/thermal (Daniel
   Lezcano).

 - Use the generic trip point for the i.MX and remove the get_trip_temp
   ops (Daniel Lezcano).

 - Use the devm_platform_ioremap_resource() in the Hisilicon driver
   (Yang Li).

 - Remove R-Car H3 ES1.* handling as public has only access to the ES2
   version and the upstream support for the ES1 has been shutdown (Wolfram
   Sang).

 - Add a delay after initializing the bank in order to let the time to
   the hardware to initialize itself before reading the temperature
   (Amjad Ouled-Ameur).

 - Add MT8365 support (Amjad Ouled-Ameur).

 - Preparational cleanup and DT bindings for RK3588 support (Sebastian
   Reichel).

 - Add driver support for RK3588 (Finley Xiao).

 - Use devm_reset_control_array_get_exclusive() for the Rockchip driver
   (Ye Xingchen).

 - Detect power gated thermal zones and return -EAGAIN when reading the
   temperature (Mikko Perttunen).

 - Remove thermal_bind_params structure as it is unused (Zhang Rui)

 - Drop unneeded quotes in DT bindings allowing to run yamllint (Rob
   Herring).

 - Update the power allocator documentation according to the thermal
   trace relocation (Lukas Bulwahn).

 - Fix sensor 1 interrupt status bitmask for the Mediatek LVTS sensor
   (Chen-Yu Tsai).

 - Use the dev_err_probe() helper in the Amlogic driver (Ye Xingchen).

 - Add AP domain support to LVTS thermal controllers for mt8195
   (Balsam CHIHI).

 - Remove buggy call to thermal_of_zone_unregister() (Daniel Lezcano).

 - Make thermal_of_zone_[un]register() private to the thermal OF code
   (Daniel Lezcano).

 - Create a private copy of the thermal zone device parameters
   structure when registering a thermal zone (Daniel Lezcano).

 - Fix a kernel NULL pointer dereference in thermal_hwmon (Zhang Rui).

 - Revert recent message adjustment in thermal_hwmon (Rafael Wysocki).

 - Use of_property_present() for testing DT property presence in
   thermal control code (Rob Herring).

 - Clean up thermal_list_lock locking in the thermal core (Rafael
   Wysocki).

 - Add DLVR support for RFIM control in the int340x Intel thermal
   driver (Srinivas Pandruvada).

Thanks!


---------------

Amjad Ouled-Ameur (1):
      thermal/drivers/mediatek: Add delay after thermal banks initialization

Balsam CHIHI (2):
      dt-bindings: thermal: mediatek: Add AP domain to LVTS thermal
controllers for mt8195
      thermal/drivers/mediatek/lvts_thermal: Add AP domain for mt8195

Chen-Yu Tsai (1):
      thermal/drivers/mediatek/lvts_thermal: Fix sensor 1 interrupt
status bitmask

Daniel Lezcano (27):
      thermal/core: Add a thermal zone 'devdata' accessor
      thermal/core: Use the thermal zone 'devdata' accessor in thermal
located drivers
      thermal/core: Use the thermal zone 'devdata' accessor in hwmon
located drivers
      thermal/core: Use the thermal zone 'devdata' accessor in remaining drivers
      thermal/core: Show a debug message when get_temp() fails
      thermal: Remove debug or error messages in get_temp() ops
      thermal/hwmon: Do not set no_hwmon before calling
thermal_add_hwmon_sysfs()
      thermal/hwmon: Use the right device for devm_thermal_add_hwmon_sysfs()
      thermal: Don't use 'device' internal thermal zone structure field
      thermal/core: Add thermal_zone_device structure 'type' accessor
      thermal/drivers/spear: Don't use tz->device but pdev->dev
      thermal: Add a thermal zone id accessor
      thermal: Use thermal_zone_device_type() accessor
      thermal/drivers/da9062: Don't access the thermal zone device fields
      thermal/hwmon: Use the thermal_core.h header
      thermal/drivers/tegra: Remove unneeded lock when setting a trip point
      thermal/drivers/acerhdf: Make interval setting only at module load time
      thermal/drivers/acerhdf: Remove pointless governor test
      thermal/drivers/imx: Remove get_trip_temp ops
      thermal/drivers/imx: Use the thermal framework for the trip point
      thermal/core: Relocate the traces definition in thermal directory
      thermal/drivers/db8500: Use driver dev instead of tz->device
      thermal/drivers/stm: Don't set no_hwmon to false
      thermal/drivers/ti: Use fixed update interval
      thermal/drivers/bcm2835: Remove buggy call to thermal_of_zone_unregister
      thermal/of: Unexport unused OF functions
      thermal/core: Alloc-copy-free the thermal zone parameters structure

Fabien Parent (2):
      dt-bindings: thermal: mediatek: Add binding documentation for MT8365 SoC
      thermal/drivers/mediatek: Add support for MT8365 SoC

Finley Xiao (1):
      thermal/drivers/rockchip: Support RK3588 SoC in the thermal driver

Lukas Bulwahn (1):
      MAINTAINERS: adjust entry in THERMAL/POWER_ALLOCATOR after header movement

Markus Schneider-Pargmann (1):
      thermal/drivers/mediatek: Control buffer enablement tweaks

Mikko Perttunen (1):
      thermal/drivers/tegra-bpmp: Handle offline zones

Rafael J. Wysocki (2):
      thermal: thermal_hwmon: Revert recent message adjustment
      thermal: core: Clean up thermal_list_lock locking

Rob Herring (2):
      thermal: Use of_property_present() for testing DT property presence
      dt-bindings: thermal: Drop unneeded quotes

Sebastian Reichel (6):
      thermal/drivers/rockchip: Simplify getting match data
      thermal/drivers/rockchip: Simplify clock logic
      thermal/drivers/rockchip: Use dev_err_probe
      thermal/drivers/rockchip: Simplify channel id logic
      thermal/drivers/rockchip: Support dynamic sized sensor array
      dt-bindings: rockchip-thermal: Support the RK3588 SoC compatible

Srinivas Pandruvada (1):
      thermal: intel: int340x: Add DLVR support for RFIM control

Wolfram Sang (1):
      thermal/drivers/rcar_gen3_thermal: Remove R-Car H3 ES1.* handling

Yang Li (1):
      thermal/drivers/hisi: Use devm_platform_ioremap_resource()

Ye Xingchen (2):
      thermal/drivers/rockchip: use devm_reset_control_array_get_exclusive()
      thermal: amlogic: Use dev_err_probe()

Zhang Rui (3):
      thermal: intel: x86_pkg_temp_thermal: Add lower bound check for
sysfs input
      thermal: thermal_hwmon: Fix a kernel NULL pointer dereference
      thermal/core: Remove thermal_bind_params structure

---------------

 .../bindings/thermal/amlogic,thermal.yaml          |   2 +-
 .../devicetree/bindings/thermal/imx-thermal.yaml   |   4 +-
 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 .../devicetree/bindings/thermal/qoriq-thermal.yaml |   4 +-
 .../bindings/thermal/rockchip-thermal.yaml         |   1 +
 Documentation/driver-api/thermal/intel_dptf.rst    |  46 ++-
 Documentation/driver-api/thermal/sysfs-api.rst     |  40 ---
 MAINTAINERS                                        |   2 +-
 drivers/acpi/thermal.c                             |  18 +-
 drivers/ata/ahci_imx.c                             |   2 +-
 drivers/hwmon/hwmon.c                              |   4 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |   2 +-
 drivers/hwmon/scmi-hwmon.c                         |   4 +-
 drivers/hwmon/scpi-hwmon.c                         |   2 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |   2 +-
 drivers/input/touchscreen/sun4i-ts.c               |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |   4 +-
 drivers/platform/x86/acerhdf.c                     |  19 +-
 drivers/power/supply/power_supply_core.c           |   2 +-
 drivers/regulator/max8973-regulator.c              |   2 +-
 drivers/thermal/Makefile                           |   3 +-
 drivers/thermal/amlogic_thermal.c                  |  11 +-
 drivers/thermal/armada_thermal.c                   |  14 +-
 drivers/thermal/broadcom/bcm2711_thermal.c         |   3 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |   7 +-
 drivers/thermal/broadcom/brcmstb_thermal.c         |   8 +-
 drivers/thermal/broadcom/ns-thermal.c              |   2 +-
 drivers/thermal/broadcom/sr-thermal.c              |   2 +-
 drivers/thermal/cpufreq_cooling.c                  |   4 +-
 drivers/thermal/da9062-thermal.c                   |  13 +-
 drivers/thermal/db8500_thermal.c                   |   9 +-
 drivers/thermal/devfreq_cooling.c                  |   2 +-
 drivers/thermal/dove_thermal.c                     |   7 +-
 drivers/thermal/gov_fair_share.c                   |   2 +-
 drivers/thermal/gov_power_allocator.c              |   2 +-
 drivers/thermal/gov_step_wise.c                    |   2 +-
 drivers/thermal/hisi_thermal.c                     |   9 +-
 drivers/thermal/imx8mm_thermal.c                   |   6 +-
 drivers/thermal/imx_sc_thermal.c                   |   9 +-
 drivers/thermal/imx_thermal.c                      |  70 ++---
 .../intel/int340x_thermal/int3400_thermal.c        |   2 +-
 .../intel/int340x_thermal/int340x_thermal_zone.c   |   4 +-
 .../int340x_thermal/processor_thermal_device.c     |   3 +-
 .../int340x_thermal/processor_thermal_device.h     |   1 +
 .../int340x_thermal/processor_thermal_device_pci.c |   6 +-
 .../intel/int340x_thermal/processor_thermal_rfim.c |  92 +++++-
 drivers/thermal/intel/intel_pch_thermal.c          |   2 +-
 drivers/thermal/intel/intel_quark_dts_thermal.c    |   6 +-
 drivers/thermal/intel/intel_soc_dts_iosf.c         |  13 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |  12 +-
 drivers/thermal/k3_bandgap.c                       |   4 +-
 drivers/thermal/k3_j72xx_bandgap.c                 |   2 +-
 drivers/thermal/kirkwood_thermal.c                 |   7 +-
 drivers/thermal/max77620_thermal.c                 |   6 +-
 drivers/thermal/mediatek/auxadc_thermal.c          | 111 +++++--
 drivers/thermal/mediatek/lvts_thermal.c            | 110 +++++--
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   6 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   6 +-
 drivers/thermal/qcom/tsens.c                       |   6 +-
 drivers/thermal/qoriq_thermal.c                    |   4 +-
 drivers/thermal/rcar_gen3_thermal.c                |  57 +---
 drivers/thermal/rcar_thermal.c                     |   8 +-
 drivers/thermal/rockchip_thermal.c                 | 332 ++++++++++++++-------
 drivers/thermal/rzg2l_thermal.c                    |   3 +-
 drivers/thermal/samsung/exynos_tmu.c               |   4 +-
 drivers/thermal/spear_thermal.c                    |  10 +-
 drivers/thermal/sprd_thermal.c                     |   2 +-
 drivers/thermal/st/st_thermal.c                    |   5 +-
 drivers/thermal/st/stm_thermal.c                   |   5 +-
 drivers/thermal/sun8i_thermal.c                    |   4 +-
 drivers/thermal/tegra/soctherm.c                   |   6 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c         |  15 +-
 drivers/thermal/tegra/tegra30-tsensor.c            |  31 +-
 drivers/thermal/thermal-generic-adc.c              |   7 +-
 drivers/thermal/thermal_core.c                     | 172 +++--------
 drivers/thermal/thermal_helpers.c                  |   6 +-
 drivers/thermal/thermal_hwmon.c                    |   5 +-
 drivers/thermal/thermal_hwmon.h                    |   4 +-
 drivers/thermal/thermal_mmio.c                     |   2 +-
 drivers/thermal/thermal_of.c                       |   8 +-
 .../thermal.h => drivers/thermal/thermal_trace.h   |   6 +
 .../thermal/thermal_trace_ipa.h                    |   6 +
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  20 +-
 drivers/thermal/uniphier_thermal.c                 |   2 +-
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  10 +
 include/linux/thermal.h                            |  74 ++---
 88 files changed, 852 insertions(+), 721 deletions(-)
