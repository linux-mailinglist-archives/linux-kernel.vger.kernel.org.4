Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81096700471
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbjELJ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240588AbjELJ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:58:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A07A11634;
        Fri, 12 May 2023 02:57:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1601CFEC;
        Fri, 12 May 2023 02:58:42 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C95813F5A1;
        Fri, 12 May 2023 02:57:54 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH v2 00/17] Introduce runtime modifiable Energy Model
Date:   Fri, 12 May 2023 10:57:26 +0100
Message-Id: <20230512095743.3393563-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set adds a new feature which allows to modify Energy Model (EM)
power values at runtime. It will allow to better reflect power model of
a recent SoCs and silicon. Different characteristics of the power usage
can be leveraged and thus better decisions made during task placement in EAS.

It's part of feature set know as Dynamic Energy Model. It has been presented
and discussed recently at OSPM2023 [3]. This patch set implements the 1st
improvement for the EM.

The concepts:
1. The CPU power usage can vary due to the workload that it's running or due
to the temperature of the SoC. The same workload can use more power when the
temperature of the silicon has increased (e.g. due to hot GPU or ISP).
In such situation or EM can be adjusted and reflect the fact of increased
power usage. That power increase is due to a factor called static power
(sometimes called simply: leakage). The CPUs in recent SoCs are different.
We have heterogeneous SoCs with 3 (or even 4) different microarchitectures.
They are also built differently with High Performance (HP) cells or
Low Power (LP) cells. They are affected by the temperature increase
differently: HP cells have bigger leakage. The SW model can leverage that
knowledge.
2. It is also possible to change the EM to better reflect the currently
running workload. Usually the EM is derived from some average power values
taken from experiments with benchmark (e.g. Dhrystone). The model derived
from such scenario might not represent properly the workloads usually running
on the device. Therefore, runtime modification of the EM allows to switch to
a different model, when there is a need.
3. The EM can be adjusted after boot, when all the modules are loaded and
more information about the SoC is available e.g. chip binning. This would help
to better reflect the silicon characteristics. Thus, this EM modification
API allows it now. It wasn't possible in the past and the EM had to be
'set in stone'.

Some design details:
The internal mechanisms for the memory allocation are handled internally in the 
EM. Kernel modules can just call the new API to update the EM data and the 
new memory would be provided and owned by the EM. The EM memory is used by
EAS, which impacts those design decisions. The EM writers are protected by
a mutex. This new runtime modified EM table is protected using RCU mechanism,
which fits the current EAS hot path (which already uses RCU read lock).
The unregister API handles only non-CPU (e.g. GPU, ISP) devices and uses the
same mutex as EM modifiers to make sure the memory is safely freed.

More detailed explanation and background can be found in presentations
during LPC2022 [1][2] or in the documentation patches.

Changelog:
v2:
- solved build warning of unused variable in patch 13/17 when EM is
  not compiled in, e.g. on Intel platform for this cpufreq_cooling
- re-based on top of v6.4-rc1
v1:
- implementation can be found here [4]

Regards,
Lukasz Luba

[1] https://lpc.events/event/16/contributions/1341/attachments/955/1873/Dynamic_Energy_Model_to_handle_leakage_power.pdf
[2] https://lpc.events/event/16/contributions/1194/attachments/1114/2139/LPC2022_Energy_model_accuracy.pdf
[3] https://www.youtube.com/watch?v=2C-5uikSbtM&list=PL0fKordpLTjKsBOUcZqnzlHShri4YBL1H
[4] https://lore.kernel.org/lkml/20230314103357.26010-1-lukasz.luba@arm.com/

Lukasz Luba (17):
  PM: EM: Refactor em_cpufreq_update_efficiencies() arguments
  PM: EM: Find first CPU online while updating OPP efficiency
  PM: EM: Refactor em_pd_get_efficient_state() to be more flexible
  PM: EM: Create a new function em_compute_costs()
  trace: energy_model: Add trace event for EM runtime modifications
  PM: EM: Add update_power() callback for runtime modifications
  PM: EM: Check if the get_cost() callback is present in
    em_compute_costs()
  PM: EM: Introduce runtime modifiable table
  PM: EM: Add RCU mechanism which safely cleans the old data
  PM: EM: Add runtime update interface to modify EM power
  PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
  PM: EM: Add argument to get_cost() for runtime modification
  PM: EM: Refactor struct em_perf_domain and add default_table
  Documentation: EM: Add a new section about the design
  Documentation: EM: Add a runtime modifiable EM design description
  Documentation: EM: Add example with driver modifying the EM
  Documentation: EM: Describe the API of runtime modifications

 Documentation/power/energy-model.rst | 134 +++++++++++-
 drivers/cpufreq/cppc_cpufreq.c       |   2 +-
 drivers/powercap/dtpm_cpu.c          |  27 ++-
 drivers/powercap/dtpm_devfreq.c      |  23 +-
 drivers/thermal/cpufreq_cooling.c    |  23 +-
 drivers/thermal/devfreq_cooling.c    |  23 +-
 include/linux/energy_model.h         |  93 ++++++--
 include/trace/events/energy_model.h  |  46 ++++
 kernel/power/energy_model.c          | 305 +++++++++++++++++++++++----
 9 files changed, 580 insertions(+), 96 deletions(-)
 create mode 100644 include/trace/events/energy_model.h

-- 
2.25.1

