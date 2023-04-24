Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63736ED3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjDXRxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjDXRxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:53:34 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1506A42;
        Mon, 24 Apr 2023 10:53:29 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-94f59fbe2cbso143234566b.1;
        Mon, 24 Apr 2023 10:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682358807; x=1684950807;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSRWj85imZ4wZsrzKgLRLoGBj7rMp99ce5H4uNk76js=;
        b=do1ERKAs6lRD+5H1nYmiiPIrds1djh3UK3fzAZCf1qPSLPDrQ7KIq4KR3AePD89r5S
         fCdpo7f7AC8iBGUOrC4rO4UekbU5Vp/Ee4qNPSRUaq1EkvANBbXdKaUA58Ifgpk69q8t
         NfSbMm1794as19p6VnVAHDL9YKYz/cXu5kOrSBWHQ484WWVeRLrZw1Xz6AhKAjtSQEnR
         xg2O9ySTa32Ut72ojXXpT6anDjazHyCKHTaEVERDBHPeItDSH5VoYWVrnVMUqP+JpV+M
         xppXhzq3KEKVuk2IKy+A1VymHnNkvebeWObSjpzt2mtt6rf2ngNVUBxnVCEF6AGamNQx
         OwKw==
X-Gm-Message-State: AAQBX9dWHg0/iu9wWQB0d2+/wKdKBx4Ywbym2rGnjYhS+iotRuMB0VgI
        QPPaWthkD3UsGzGIG7p0vGrYTUEtNrfcEj6ZN9aUZXU6VBs=
X-Google-Smtp-Source: AKy350YXodtBH7hRH+MKyk5qNKHpIXLwauow8K8k5T+9mZ0tPUtHL85V/PmeMRHg7sZdc07TmdlCbBgpFYxY/iWrKqY=
X-Received: by 2002:a17:906:2a48:b0:94e:63ae:5b9b with SMTP id
 k8-20020a1709062a4800b0094e63ae5b9bmr13176776eje.7.1682358807531; Mon, 24 Apr
 2023 10:53:27 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Apr 2023 19:53:16 +0200
Message-ID: <CAJZ5v0htGCiRkSjnOGoQbViuRz==gAN2hwuFtrFK+Y8eNGy=ZA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.4-rc1

with top-most commit d3f2c402e44887e507b65d65f0d0515d46575bf5

 Merge branches 'pm-core', 'pm-sleep', 'pm-opp' and 'pm-tools'

on top of commit 6a8f57ae2eb07ab39a6f0ccad60c760743051026

 Linux 6.3-rc7

to receive power management updates for 6.4-rc1.

These update several cpufreq drivers and the cpufreq core, add sysfs
interface for exposing the time really spent in the platform low-power
state during suspend-to-idle, update devfreq (core and drivers) and
the pm-graph suite of tools and clean up code.

Specifics:

 - Fix the frequency unit in cpufreq_verify_current_freq checks()
   (Sanjay Chandrashekara).

 - Make mode_state_machine in amd-pstate static (Tom Rix).

 - Make the cpufreq core require drivers with target_index() to set
   freq_table (Viresh Kumar).

 - Fix typo in the ARM_BRCMSTB_AVS_CPUFREQ Kconfig entry (Jingyu Wang).

 - Use of_property_read_bool() for boolean properties in the pmac32
   cpufreq driver (Rob Herring).

 - Make the cpufreq sysfs interface return proper error codes on
   obviously invalid input (qinyu).

 - Add guided autonomous mode support to the AMD P-state driver (Wyes
   Karny).

 - Make the Intel P-state driver enable HWP IO boost on all server
   platforms (Srinivas Pandruvada).

 - Add opp and bandwidth support to tegra194 cpufreq driver (Sumit
   Gupta).

 - Use of_property_present() for testing DT property presence (Rob
   Herring).

 - Remove MODULE_LICENSE in non-modules (Nick Alcock).

 - Add SM7225 to cpufreq-dt-platdev blocklist (Luca Weiss).

 - Optimizations and fixes for qcom-cpufreq-hw driver (Krzysztof
   Kozlowski, Konrad Dybcio, and Bjorn Andersson).

 - DT binding updates for qcom-cpufreq-hw driver (Konrad Dybcio and
   Bartosz Golaszewski).

 - Updates and fixes for mediatek driver (Jia-Wei Chang and
   AngeloGioacchino Del Regno).

 - Use of_property_present() for testing DT property presence in the
   cpuidle code (Rob Herring).

 - Drop unnecessary (void *) conversions from the PM core (Li zeming).

 - Add sysfs files to represent time spent in a platform sleep state
   during suspend-to-idle and make AMD and Intel PMC drivers use them
   (Mario Limonciello).

 - Use of_property_present() for testing DT property presence (Rob
   Herring).

 - Add set_required_opps() callback to the 'struct opp_table', to make
   the code paths cleaner (Viresh Kumar).

 - Update the pm-graph siute of utilities to v5.11 with the following
   changes:
   * New script which allows users to install the latest pm-graph
     from the upstream github repo.
   * Update all the dmesg suspend/resume PM print formats to be able to
     process recent timelines using dmesg only.
   * Add ethtool output to the log for the system's ethernet device if
     ethtool exists.
   * Make the tool more robustly handle events where mangled dmesg or
     ftrace outputs do not include all the requisite data.

 - Make the sleepgraph utility recognize "CPU killed" messages (Xueqin
   Luo).

 - Remove unneeded SRCU selection in Kconfig because it's always set
   from devfreq core (Paul E. McKenney).

 - Drop of_match_ptr() macro from exynos-bus.c because this driver is
   always using the DT table for driver probe (Krzysztof Kozlowski).

 - Use the preferred of_property_present() instead of the low-level
   of_get_property() on exynos-bus.c (Rob Herring).

 - Use devm_platform_get_and_ioream_resource() in exyno-ppmu.c (Yang Li).

Thanks!


---------------

AngeloGioacchino Del Regno (1):
      cpufreq: mediatek: Raise proc and sram max voltage for MT7622/7623

Bartosz Golaszewski (1):
      dt-bindings: cpufreq: qcom-hw: add a compatible for sa8775p

Bjorn Andersson (1):
      cpufreq: qcom-cpufreq-hw: Revert adding cpufreq qos

Jia-Wei Chang (3):
      cpufreq: mediatek: fix passing zero to 'PTR_ERR'
      cpufreq: mediatek: fix KP caused by handler usage after
regulator_put/clk_put
      cpufreq: mediatek: raise proc/sram max voltage for MT8516

Jingyu Wang (1):
      cpufreq: Fix typo in the ARM_BRCMSTB_AVS_CPUFREQ Kconfig entry

Konrad Dybcio (4):
      cpufreq: qcom-hw: Simplify counting frequency domains
      dt-bindings: cpufreq: cpufreq-qcom-hw: Allow just 1 frequency domain
      dt-bindings: cpufreq: cpufreq-qcom-hw: Sanitize data per compatible
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCM2290

Krzysztof Kozlowski (2):
      PM / devfreq: exyos-bus: drop of_match_ptr for ID table
      cpufreq: qcom-cpufreq-hw: fix double IO unmap and resource release on exit

Li zeming (1):
      PM: core: Remove unnecessary (void *) conversions

Luca Weiss (1):
      cpufreq: Add SM7225 to cpufreq-dt-platdev blocklist

Mario Limonciello (4):
      PM: Add sysfs files to represent time spent in hardware sleep state
      platform/x86/amd: pmc: Report duration of time in hw sleep state
      platform/x86/intel/pmc: core: Always capture counters on suspend
      platform/x86/intel/pmc: core: Report duration of time in HW sleep state

Nick Alcock (2):
      kbuild, cpufreq: tegra124: remove MODULE_LICENSE in non-modules
      kbuild, cpufreq: remove MODULE_LICENSE in non-modules

Paul E. McKenney (1):
      PM / devfreq: Remove "select SRCU"

Rob Herring (5):
      cpufreq: Use of_property_present() for testing DT property presence
      opp: Use of_property_present() for testing DT property presence
      PM / devfreq: exynos: Use of_property_present() for testing DT
property presence
      cpuidle: Use of_property_present() for testing DT property presence
      cpufreq: pmac32: Use of_property_read_bool() for boolean properties

Sanjay Chandrashekara (1):
      cpufreq: use correct unit when verify cur freq

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Enable HWP IO boost for all servers

Sumit Gupta (1):
      cpufreq: tegra194: add OPP support and set bandwidth

Todd Brandt (1):
      pm-graph: Update to v5.11

Tom Rix (1):
      cpufreq: amd-pstate: Make varaiable mode_state_machine static

Viresh Kumar (3):
      OPP: Handle all genpd cases together in _set_required_opps()
      OPP: Move required opps configuration to specialized callback
      cpufreq: drivers with target_index() must set freq_table

Wyes Karny (6):
      ACPI: CPPC: Add min and max perf register writing support
      ACPI: CPPC: Add auto select register read/write support
      Documentation: cpufreq: amd-pstate: Move amd_pstate param to
alphabetical order
      cpufreq: amd-pstate: Add guided autonomous mode
      cpufreq: amd-pstate: Add guided mode control support via sysfs
      Documentation: cpufreq: amd-pstate: Update amd_pstate status
sysfs for guided

Xueqin Luo (1):
      PM: tools: sleepgraph: Recognize "CPU killed" messages

Yang Li (1):
      PM / devfreq: exynos-ppmu: Use devm_platform_get_and_ioremap_resource()

qinyu (1):
      cpufreq: warn about invalid vals to scaling_max/min_freq interfaces

---------------

 Documentation/ABI/testing/sysfs-power              |  29 ++++
 Documentation/admin-guide/kernel-parameters.txt    |  40 +++--
 Documentation/admin-guide/pm/amd-pstate.rst        |  31 +++-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 119 +++++++++++++-
 drivers/acpi/cppc_acpi.c                           | 118 +++++++++++++-
 drivers/base/power/main.c                          |  12 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/amd-pstate.c                       | 175 +++++++++++++++------
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +-
 drivers/cpufreq/cpufreq.c                          |  13 +-
 drivers/cpufreq/freq_table.c                       |   8 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   |   2 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   4 +-
 drivers/cpufreq/intel_pstate.c                     |  11 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |  98 +++++++-----
 drivers/cpufreq/pmac32-cpufreq.c                   |   6 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  54 +------
 drivers/cpufreq/scmi-cpufreq.c                     |   2 +-
 drivers/cpufreq/tegra124-cpufreq.c                 |   1 -
 drivers/cpufreq/tegra194-cpufreq.c                 | 156 ++++++++++++++++--
 drivers/cpufreq/tegra20-cpufreq.c                  |   2 +-
 drivers/cpuidle/cpuidle-psci-domain.c              |   2 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c                |   6 +-
 drivers/devfreq/Kconfig                            |   1 -
 drivers/devfreq/event/exynos-ppmu.c                |   3 +-
 drivers/devfreq/exynos-bus.c                       |   4 +-
 drivers/opp/core.c                                 |  78 +++++----
 drivers/opp/of.c                                   |   7 +-
 drivers/opp/opp.h                                  |   4 +
 drivers/platform/x86/amd/pmc.c                     |   6 +-
 drivers/platform/x86/intel/pmc/core.c              |  17 +-
 drivers/platform/x86/intel/pmc/core.h              |   4 +-
 include/acpi/cppc_acpi.h                           |  11 ++
 include/linux/amd-pstate.h                         |   2 +
 include/linux/cpufreq.h                            |   1 +
 include/linux/suspend.h                            |   8 +
 kernel/power/main.c                                |  59 +++++--
 tools/power/pm-graph/README                        |   2 +-
 tools/power/pm-graph/install_latest_from_github.sh |  38 +++++
 tools/power/pm-graph/sleepgraph.py                 |  58 ++++---
 40 files changed, 895 insertions(+), 302 deletions(-)
