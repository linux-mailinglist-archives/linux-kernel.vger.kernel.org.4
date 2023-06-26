Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EA673E655
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFZRW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFZRWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:22:06 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F181737;
        Mon, 26 Jun 2023 10:21:19 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b588fa06d3so8274301fa.1;
        Mon, 26 Jun 2023 10:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800077; x=1690392077;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0NFK3bIzJw7mW5pDYP2ijBF42cv8/YJMAyl3keIVo0=;
        b=FyP7qPIUWR6GmrSrExCIwjuxIGsz+4ypqnOz5ylJTuDaryeD+4MCGMeyomTL2JhQKK
         TjgntezXmBjOZAHe72PbwWVDBznXhaOAFfgzMv1StyUxv57XJtWtBwLL2J/Aoeqsrrza
         B4iJqBpxDUA0NC9tDnSm8QDpIV9QWAHKaXOoT8IVuwv8KxaXnoe/Vgxe8RXDhcCEC9f4
         R1zu0cHjJQ7tczw0obFPlTrRGVrTAQhr/sjqletaK+10kxNw9nH1H6ueJ1wQXWkcKYRz
         K/edo55SyVm6eXjsV/En5am9nescZ0Mu8j8cyM079sFMjBqPbFN/EFupzM3k60uk72Lw
         wLIQ==
X-Gm-Message-State: AC+VfDwuARY8z6craIZTNXgUycvmvPyaaHFKzRNpUskjt4BMeS+d/pYi
        kO9T/vqPT7bo4PlsNTdzuOMVOlJC6P3aiwxVdRhaOb3447U=
X-Google-Smtp-Source: ACHHUZ5wM3KMQkoJzpiQ/jDzp6syPhH05tRYzUUgqSlGJl88uXy+OP1R9Lk3w9wfsxK1NNSzzqgkVBRRcogqTmRPL8Q=
X-Received: by 2002:a05:651c:10ac:b0:2b5:c230:fd35 with SMTP id
 k12-20020a05651c10ac00b002b5c230fd35mr3191106ljn.5.1687800076911; Mon, 26 Jun
 2023 10:21:16 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Jun 2023 19:21:06 +0200
Message-ID: <CAJZ5v0iQk8ytZ0953_HCWU6Vr62J9UeC8Z9pirOHAfjpbvcOfg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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
 pm-6.5-rc1

with top-most commit c89a27f4f8fbf4dcbaf1738b42b8c68e160d7cda

 Merge branch 'powercap'

on top of commit 45a3e24f65e90a047bef86f927ebdc4c710edaa1

 Linux 6.4-rc7

to receive power management updates for 6.5-rc1.

These add Intel TPMI ((Topology Aware Register and PM Capsule Interface)
support to the power capping subsystem, extend the intel_idle driver to
work in VM guests where MWAIT is not available, extend the system-wide
power management diagnostics, fix bugs and clean up code.

Specifics:

 - Introduce power capping core support for Intel TPMI (Topology Aware
   Register and PM Capsule Interface) and a TPMI interface driver for
   Intel RAPL (Zhang Rui, Dan Carpenter).

 - Fix CONFIG_IOSF_MBI dependency in the Intel RAPL power capping
   driver (Zhang Rui).

 - Fix invalid initialization for pl4_supported field in the Intel RAPL
   power capping driver (Sumeet Pawnikar).

 - Clean up the intel_idle driver, make it work with VM guests that
   cannot use the MWAIT instruction and address the case in which the
   host may enter a deep idle state when the guest is idle (Arjan van
   de Ven).

 - Prevent cpufreq drivers that provide the ->adjust_perf() callback
   without a ->fast_switch() one which is used as a fallback from the
   former in some cases (Wyes Karny).

 - Fix some issues related to the AMD P-state cpufreq driver (Mario
   Limonciello, Wyes Karny).

 - Fix the energy_performance_preference attribute handling in the
   intel_pstate driver in passive mode (Tero Kristo).

 - Fix the handling of pm_suspend_target_state when CONFIG_PM is unset
   (Kai-Heng Feng).

 - Correct spelling mistake in a comment in the hibernation code (Wang
   Honghui).

 - Add arch_resume_nosmt() prototype to avoid a "missing prototypes"
   build warning (Arnd Bergmann).

 - Restrict pm_pr_dbg() to system-wide power transitions and use it in
   a few additional places (Mario Limonciello).

 - Drop verification of in-params from genpd_add_device() and ensure
   that all of its callers will do it (Ulf Hansson).

 - Prevent possible integer overflows from occurring in
   genpd_parse_state() (Nikita Zhandarovich).

 - Reorder fields in 'struct devfreq_dev_status' to reduce its size
   somewhat (Christophe JAILLET).

 - Ensure that the Exynos PPMU driver is already loaded before the
   Exynos Bus driver starts probing so as to avoid a possible freeze
   loading of the kernel modules (Marek Szyprowski).

 - Fix variable deferencing before NULL check in the mtk-cci devfreq
   driver (Sukrut Bellary).

Thanks!


---------------

Arjan van de Ven (4):
      intel_idle: refactor state->enter manipulation into its own function
      intel_idle: clean up the (new) state_update_enter_method function
      intel_idle: Add support for using intel_idle in a VM guest using just hlt
      intel_idle: Add a "Long HLT" C1 state for the VM guest mode

Arnd Bergmann (1):
      PM: suspend: add a arch_resume_nosmt() prototype

Christophe JAILLET (1):
      PM / devfreq: Reorder fields in 'struct devfreq_dev_status'

Dan Carpenter (1):
      powercap: RAPL: Fix a NULL vs IS_ERR() bug

Kai-Heng Feng (1):
      PM: suspend: Fix pm_suspend_target_state handling for !CONFIG_PM

Marek Szyprowski (1):
      PM / devfreq: exynos: add Exynos PPMU as a soft module dependency

Mario Limonciello (8):
      include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume
      ACPI: x86: Add pm_debug_messages for LPS0 _DSM state tracking
      pinctrl: amd: Use pm_pr_dbg to show debugging messages
      platform/x86/amd: pmc: Use pm_pr_dbg() for suspend related messages
      cpufreq: amd-pstate: Set default governor to schedutil
      ACPI: CPPC: Add definition for undefined FADT preferred PM profile value
      cpufreq: amd-pstate: Set a fallback policy based on preferred_profile
      cpufreq: amd-pstate: Add a kernel config option to set default mode

Nikita Zhandarovich (1):
      PM: domains: fix integer overflow issues in genpd_parse_state()

Sukrut Bellary (1):
      PM / devfreq: mtk-cci: Fix variable deferencing before NULL check

Sumeet Pawnikar (1):
      powercap: RAPL: fix invalid initialization for pl4_supported field

Tero Kristo (1):
      cpufreq: intel_pstate: Fix energy_performance_preference for passive

Ulf Hansson (1):
      PM: domains: Move the verification of in-params from genpd_add_device()

Wang Honghui (1):
      PM: hibernate: Correct spelling mistake in a comment

Wyes Karny (3):
      cpufreq: Fail driver register if it has adjust_perf without fast_switch
      cpufreq: amd-pstate: Write CPPC enable bit per-socket
      cpufreq: amd-pstate: Make amd-pstate EPP driver name hyphenated

Zhang Rui (16):
      powercap: intel_rapl: Remove unused field in struct rapl_if_priv
      powercap: intel_rapl: Allow probing without CPUID match
      powercap: intel_rapl: Support per Interface rapl_defaults
      powercap: intel_rapl: Support per Interface primitive information
      powercap: intel_rapl: Support per domain energy/power/time unit
      powercap: intel_rapl: Use index to initialize primitive information
      powercap: intel_rapl: Change primitive order
      powercap: intel_rapl: Use bitmap for Power Limits
      powercap: intel_rapl: Cleanup Power Limits support
      powercap: intel_rapl: Add support for lock bit per Power Limit
      powercap: intel_rapl: Remove redundant cpu parameter
      powercap: intel_rapl: Make cpu optional for rapl_package
      powercap: intel_rapl: Introduce RAPL I/F type
      powercap: intel_rapl: Introduce core support for TPMI interface
      powercap: intel_rapl: Introduce RAPL TPMI interface driver
      powercap: RAPL: Fix CONFIG_IOSF_MBI dependency

---------------

 drivers/acpi/x86/s2idle.c                          |  52 +-
 drivers/base/power/domain.c                        |  15 +-
 drivers/base/power/wakeup.c                        |   5 -
 drivers/cpufreq/Kconfig                            |   2 +-
 drivers/cpufreq/Kconfig.x86                        |  17 +
 drivers/cpufreq/amd-pstate.c                       | 131 ++-
 drivers/cpufreq/cpufreq.c                          |   3 +-
 drivers/cpufreq/intel_pstate.c                     |   2 +
 drivers/devfreq/exynos-bus.c                       |   1 +
 drivers/devfreq/mtk-cci-devfreq.c                  |   3 +-
 drivers/idle/intel_idle.c                          | 231 +++++-
 drivers/pinctrl/pinctrl-amd.c                      |   6 +-
 drivers/platform/x86/amd/pmc.c                     |   4 +-
 drivers/powercap/Kconfig                           |  18 +-
 drivers/powercap/Makefile                          |   1 +
 drivers/powercap/intel_rapl_common.c               | 883 ++++++++++++---------
 drivers/powercap/intel_rapl_msr.c                  |  31 +-
 drivers/powercap/intel_rapl_tpmi.c                 | 325 ++++++++
 .../intel/int340x_thermal/processor_thermal_rapl.c |  11 +-
 include/acpi/actbl.h                               |   3 +-
 include/linux/amd-pstate.h                         |   4 +-
 include/linux/cpufreq.h                            |   5 +-
 include/linux/devfreq.h                            |   3 +-
 include/linux/intel_rapl.h                         |  40 +-
 include/linux/suspend.h                            |  14 +-
 kernel/power/main.c                                |   6 +
 kernel/power/snapshot.c                            |   2 +-
 27 files changed, 1324 insertions(+), 494 deletions(-)
