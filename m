Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB735F36CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJCT6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJCT6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:58:07 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE0748E8A;
        Mon,  3 Oct 2022 12:58:06 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id i3so7228869qkl.3;
        Mon, 03 Oct 2022 12:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5B/fRi/LbkV2jKxu+Wxg6RFA2fxjkVBUkcu/nIAHTPU=;
        b=Q4fDn4ZilPaAZUVmNepdROZClK80aJa3YiR0nRG4/t4x3/gQ6IM7O7VfoSlav8HyMo
         +3RkWnpwbc6vVQbg/8D299egt0H4YHQQW4nv8JubTbmTaQLOVQ/OOGrDSbb2sh/Qbx3U
         OgyeZ5UVg1UIqckc+2zkmKFeQrus4iRWg9D8owZ8qOC66j31Lx3mexgWtPlkOqaqU9Jb
         eGSSxQ6zHUhmVp3nGn3VZnffL1ldBRpYn9Muuy7Jj5rsDkK7rQWRA1uyP8yvoUL2Humu
         Wbcqkn5Zf004o+pPVvFo2U8jtWv3WUJ7eorHpSCso/QeCoBuUToU4enkoyNz4Yj4lBpu
         DYrg==
X-Gm-Message-State: ACrzQf0bTdrAFFOh613FYVm1nirAzfO3ItIG6dMKjpewWTdPiwwo1HCj
        AMIs067ACrCIovbKEWXpGRH9hxvmDswlXR0qitYctD4Sl1c=
X-Google-Smtp-Source: AMsMyM5iugCOsCgPpwP1+a3fnYEYNiD84qrkbT10Ti6sG/cgaf0fsNVdoOdRZ9a71xzJFWs17GY3/3bh4iTgBC7pp9Q=
X-Received: by 2002:a05:620a:2988:b0:6ce:cc3f:73b9 with SMTP id
 r8-20020a05620a298800b006cecc3f73b9mr14802010qkp.9.1664827085488; Mon, 03 Oct
 2022 12:58:05 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Oct 2022 21:57:54 +0200
Message-ID: <CAJZ5v0iD8M=qYc32EY96vYSmjTaEz=M357PVvATSQvryrzh0Gw@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
 thermal-6.1-rc1

with top-most commit 2e70ea7fb9873e642982f166bf9aaa4a6206fbec

 Merge branches 'thermal-intel' and 'thermal-drivers'

on top of commit b90cb1053190353cc30f0fef0ef1f378ccc063c5

 Linux 6.0-rc3

to receive thermal control updates for 6.1-rc1.

The most significant part of this update is the thermal control DT
initialization rework from Daniel Lezcano and the following conversion
of drivers to use the new API introduced by it.

Apart from that, the maximum number of trip points in a thermal zone
is increased and there are some fixes and code cleanups.

Specifics:

 - Rework the device tree initialization, convert the drivers to the
   new API and remove the old OF code (Daniel Lezcano).

 - Fix return value to -ENODEV when searching for a specific thermal
   zone which does not exist (Daniel Lezcano).

 - Fix the return value inspection in of_thermal_zone_find() (Dan
   Carpenter).

 - Fix kernel panic when KASAN is enabled as it detects use after
   free when unregistering a thermal zone (Daniel Lezcano).

 - Move the set_trip ops inside the therma sysfs code (Daniel Lezcano).

 - Remove unnecessary error message as it is already shown in the
   underlying function (Jiapeng Chong).

 - Rework the monitoring path and move the locks upper in the call
   stack to fix some potentials race windows (Daniel Lezcano).

 - Fix lockdep_assert() warning introduced by the lock rework (Daniel
   Lezcano).

 - Do not lock thermal zone mutex in the user space governor (Rafael
   Wysocki).

 - Revert the Mellanox 'hotter thermal zone' feature because it is
   already handled in the thermal framework core code (Daniel Lezcano).

 - Increase maximum number of trip points in the thermal core (Sumeet
   Pawnikar).

 - Replace strlcpy() with unused retval with strscpy() in the core
   thermal control code (Wolfram Sang).

 - Use module_pci_driver() macro in the int340x processor_thermal
   driver (Shang XiaoJing).

 - Use get_cpu() instead of smp_processor_id() in the intel_powerclamp
   thermal driver to prevent it from crashing and remove unused
   accounting for IRQ wakes from it (Srinivas Pandruvada).

 - Consolidate priv->data_vault checks in int340x_thermal (Rafael
   Wysocki).

 - Check the policy first in cpufreq_cooling_register() (Xuewen Yan).

 - Drop redundant error message from da9062-thermal (zhaoxiao).

 - Drop of_match_ptr() from thermal_mmio (Jean Delvare).

Thanks!


---------------

Dan Carpenter (1):
      thermal/of: Fix error code in of_thermal_zone_find()

Daniel Lezcano (42):
      thermal/of: Rework the thermal device tree initialization
      thermal/of: Return -ENODEV instead of -EINVAL if registration fails
      thermal/of: Fix free after use in thermal_of_unregister()
      thermal/of: Make new code and old code co-exist
      thermal/drivers/rockchip: Switch to new of API
      thermal/drivers/uniphier: Switch to new of API
      thermal/drivers/generic-adc: Switch to new of API
      thermal/drivers/mmio: Switch to new of API
      thermal/drivers/tegra: Switch to new of API
      thermal/drivers/sun8i: Switch to new of API
      thermal/drivers/sprd: Switch to new of API
      thermal/drivers/broadcom: Switch to new of API
      thermal/drivers/qcom: Switch to new of API
      thermal/drivers/st: Switch to new of API
      thermal/drivers/amlogic: Switch to new of API
      thermal/drivers/armada: Switch to new of API
      thermal/drivers/db8500: Switch to new of API
      thermal/drivers/imx: Switch to new of API
      thermal/drivers/rcar: Switch to new of API
      thermal/drivers/rzg2l: Switch to new of API
      thermal/drivers/qoriq: Switch to new of API
      thermal/drivers/mtk: Switch to new of API
      thermal/drivers/banggap: Switch to new of API
      thermal/drivers/maxim: Switch to new of API
      thermal/drivers/hisilicon: Switch to new of API
      thermal/drivers/ti-soc: Switch to new of API
      ata/drivers/ahci_imx: Switch to new of thermal API
      hwmon: pm_bus: core: Switch to new of thermal API
      hwmon/drivers/core: Switch to new of thermal API
      iio/drivers/sun4i_gpadc: Switch to new of thermal API
      Input: sun4i-ts - switch to new of thermal API
      regulator/drivers/max8976: Switch to new of thermal API
      thermal/drivers/samsung: Switch to new of thermal API
      thermal/core: Move set_trip_temp ops to the sysfs code
      thermal/of: Remove old OF code
      thermal/core: Rearm the monitoring only one time
      thermal/core: Rework the monitoring a bit
      thermal/governors: Group the thermal zone lock inside the
throttle function
      thermal/core: Move the thermal zone lock out of the governors
      thermal/core: Move the mutex inside the
thermal_zone_device_update() function
      thermal/core: Fix lockdep_assert() warning
      Revert "mlxsw: core: Add the hottest thermal zone detection"

Jean Delvare (1):
      thermal/drivers/thermal_mmio: Drop of_match_ptr()

Jiapeng Chong (1):
      thermal/drivers/qcom/spmi-adc-tm5: Remove unnecessary print
function dev_err()

Jilin Yuan (1):
      thermal: Drop duplicate words from comments

Rafael J. Wysocki (2):
      thermal: gov_user_space: Do not lock thermal zone mutex
      thermal: int340x_thermal: Consolidate priv->data_vault checks

Shang XiaoJing (1):
      thermal: int340x: processor_thermal: Use module_pci_driver() macro

Srinivas Pandruvada (2):
      thermal: intel_powerclamp: Use get_cpu() instead of
smp_processor_id() to avoid crash
      thermal: intel_powerclamp: Remove accounting for IRQ wakes

Sumeet Pawnikar (1):
      thermal: core: Increase maximum number of trip points

Wolfram Sang (1):
      thermal: move from strlcpy() with unused retval to strscpy()

Xuewen Yan (1):
      thermal: cpufreq_cooling: Check the policy first in
cpufreq_cooling_register()

zhaoxiao (1):
      thermal: da9062-thermal: Drop redundant error message

---------------

 drivers/ata/ahci_imx.c                             |   15 +-
 drivers/hwmon/hwmon.c                              |   14 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |   10 +-
 drivers/hwmon/scpi-hwmon.c                         |   14 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |   14 +-
 drivers/input/touchscreen/sun4i-ts.c               |   10 +-
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |   77 +-
 drivers/regulator/max8973-regulator.c              |   10 +-
 drivers/thermal/amlogic_thermal.c                  |   16 +-
 drivers/thermal/armada_thermal.c                   |   12 +-
 drivers/thermal/broadcom/bcm2711_thermal.c         |   14 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |   14 +-
 drivers/thermal/broadcom/brcmstb_thermal.c         |   20 +-
 drivers/thermal/broadcom/ns-thermal.c              |   50 +-
 drivers/thermal/broadcom/sr-thermal.c              |   16 +-
 drivers/thermal/cpufreq_cooling.c                  |   12 +-
 drivers/thermal/da9062-thermal.c                   |    5 +-
 drivers/thermal/db8500_thermal.c                   |    8 +-
 drivers/thermal/gov_bang_bang.c                    |   10 +-
 drivers/thermal/gov_fair_share.c                   |    3 +-
 drivers/thermal/gov_power_allocator.c              |   20 +-
 drivers/thermal/gov_step_wise.c                    |   10 +-
 drivers/thermal/gov_user_space.c                   |    5 +-
 drivers/thermal/hisi_thermal.c                     |   14 +-
 drivers/thermal/imx8mm_thermal.c                   |   14 +-
 drivers/thermal/imx_sc_thermal.c                   |   14 +-
 .../intel/int340x_thermal/int3400_thermal.c        |    5 +-
 .../int340x_thermal/processor_thermal_device_pci.c |   13 +-
 .../processor_thermal_device_pci_legacy.c          |   13 +-
 drivers/thermal/intel/intel_powerclamp.c           |   27 +-
 drivers/thermal/k3_bandgap.c                       |   12 +-
 drivers/thermal/k3_j72xx_bandgap.c                 |   12 +-
 drivers/thermal/max77620_thermal.c                 |    8 +-
 drivers/thermal/mtk_thermal.c                      |   10 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   23 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   12 +-
 drivers/thermal/qcom/tsens.c                       |   16 +-
 drivers/thermal/qoriq_thermal.c                    |   12 +-
 drivers/thermal/rcar_gen3_thermal.c                |   16 +-
 drivers/thermal/rcar_thermal.c                     |   13 +-
 drivers/thermal/rockchip_thermal.c                 |   14 +-
 drivers/thermal/rzg2l_thermal.c                    |   10 +-
 drivers/thermal/samsung/exynos_tmu.c               |   24 +-
 drivers/thermal/sprd_thermal.c                     |   18 +-
 drivers/thermal/st/stm_thermal.c                   |   18 +-
 drivers/thermal/sun8i_thermal.c                    |   14 +-
 drivers/thermal/tegra/soctherm.c                   |   21 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c         |   19 +-
 drivers/thermal/tegra/tegra30-tsensor.c            |   12 +-
 drivers/thermal/thermal-generic-adc.c              |   10 +-
 drivers/thermal/thermal_core.c                     |   80 +-
 drivers/thermal/thermal_core.h                     |    4 +-
 drivers/thermal/thermal_helpers.c                  |   73 +-
 drivers/thermal/thermal_hwmon.c                    |    2 +-
 drivers/thermal/thermal_mmio.c                     |   19 +-
 drivers/thermal/thermal_of.c                       | 1148 +++++++-------------
 drivers/thermal/thermal_sysfs.c                    |   11 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   16 +-
 drivers/thermal/uniphier_thermal.c                 |   10 +-
 include/linux/thermal.h                            |   87 +-
 60 files changed, 835 insertions(+), 1388 deletions(-)
