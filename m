Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B07B63C81A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiK2TU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbiK2TTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:19:42 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AD05F87A;
        Tue, 29 Nov 2022 11:19:17 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4NMBwF45yFz9sRK;
        Tue, 29 Nov 2022 20:19:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1669749549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGrzYWQrAwwfmLuQBqWF2JwudEzolu/N6baLuODWvFs=;
        b=PqVXZFb7eZy983Ymy+Z2c44l4+27Ubu0nMYOCrWYgvLlGdTyzskD1wMTZxTHx2mXy3fa0p
        6iCCRgNuhh7jANMKPWl/y6AK6897hKRLi5dUEnNTuYIaDTeRtXSEAFkvzgKpI3EOWpJNrt
        GajqRxEqt11EVlfh1NtmgxFvZFtl76C80dBaHe+Yx/NZco3ZJwcAUsS6Wo0dnZ/PfNNPn7
        u3rXKvCFz0deDaHb5LmUBttxSkMR244gCUcH7W4ews++f6lzS3aJv1o7sNqW4bdOJaOmYW
        XaDibscVhLpVSxzw1rA/Pxb0xKq5Ute6HEXzcjEMChpCxyMNvRv9KvQcs+DZqA==
Message-ID: <b88062da-4653-f9f7-d086-fbb69b970ed6@mailbox.org>
Date:   Tue, 29 Nov 2022 19:19:00 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/9] Implement AMD Pstate EPP Driver
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221128170314.2276636-1-perry.yuan@amd.com>
Content-Language: en-US
From:   Tor Vic <torvic9@mailbox.org>
In-Reply-To: <20221128170314.2276636-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: r1kzspcy3nhpto64fj3ye9rjfa3rmgmw
X-MBO-RS-ID: b3a6487917d98e052dc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28.11.22 17:03, Perry Yuan wrote:
> Hi all,
> 
> This patchset implements one new AMD CPU frequency driver
> "amd-pstate-epp” instance for better performance and power control.
> CPPC has a parameter called energy preference performance (EPP).
> The EPP is used in the CCLK DPM controller to drive the frequency that a core
> is going to operate during short periods of activity.
> EPP values will be utilized for different OS profiles (balanced, performance, power savings).

Hi,

what is the correct way to use this?
On my Zen2 machine, I passed "amd_pstate=active" to my cmdline, which 
seems to work correctly according to the following cpupower output:

   analyzing CPU 0:
     driver: amd_pstate_epp
     CPUs which run at the same hardware frequency: 0
     CPUs which need to have their frequency coordinated by software: 0
     maximum transition latency:  Cannot determine or is not supported.
     hardware limits: 550 MHz - 4.67 GHz
     available cpufreq governors: performance powersave
     current policy: frequency should be within 550 MHz and 4.67 GHz.
                   The governor "powersave" may decide which speed to use
                   within this range.
     current CPU frequency: Unable to call hardware
     current CPU frequency: 550 MHz (asserted by call to kernel)
     boost state support:
       Supported: yes
       Active: no

(above was in idle state - under full load I get the expected 4.1-4.2 GHz)

But is it correct that it uses the "powersave" governor?
If I try to change the governor with

   sudo $PATHTOEXEC/cpupower frequency-set -g schedutil

I will get an error (ondemand and schedutil are built-in):

   Setting cpu: 0
   Error setting new values. Common errors:
   - Do you have proper administration rights? (super-user?)
   - Is the governor you requested available and modprobed?
   - Trying to set an invalid policy?
   - Trying to set a specific frequency, but userspace governor is not 
available,
      for example because of hardware which cannot be set to a specific 
frequency
      or because the userspace governor isn't loaded?

Maybe this should be clarified in more detail.

Cheers,
Tor Vic

> 
> AMD Energy Performance Preference (EPP) provides a hint to the hardware
> if software wants to bias toward performance (0x0) or energy efficiency (0xff)
> The lowlevel power firmware will calculate the runtime frequency according to the EPP preference
> value. So the EPP hint will impact the CPU cores frequency responsiveness.
> 
> We use the RAPL interface with "perf" tool to get the energy data of the package power.
> Performance Per Watt (PPW) Calculation:
> 
> The PPW calculation is referred by below paper:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fdam%2Fdevelop%2Fexternal%2Fus%2Fen%2Fdocuments%2Fperformance-per-what-paper.pdf&amp;data=04%7C01%7CPerry.Yuan%40amd.com%7Cac66e8ce98044e9b062708d9ab47c8d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637729147708574423%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=TPOvCE%2Frbb0ptBreWNxHqOi9YnVhcHGKG88vviDLb00%3D&amp;reserved=0
> 
> Below formula is referred from below spec to measure the PPW:
> 
> (F / t) / P = F * t / (t * E) = F / E,
> 
> "F" is the number of frames per second.
> "P" is power measured in watts.
> "E" is energy measured in joules.
> 
> Gitsouce Benchmark Data on ROME Server CPU
> +------------------------------+------------------------------+------------+------------------+
> | Kernel Module                | PPW (1 / s * J)              |Energy(J) | PPW Improvement (%)|
> +==============================+==============================+============+==================+
> | acpi-cpufreq:schedutil       | 5.85658E-05                  | 17074.8    | base             |
> +------------------------------+------------------------------+------------+------------------+
> | acpi-cpufreq:ondemand        | 5.03079E-05                  | 19877.6    | -14.10%          |
> +------------------------------+------------------------------+------------+------------------+
> | acpi-cpufreq:performance     | 5.88132E-05                  | 17003      | 0.42%            |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:ondemand          | 4.60295E-05                  | 21725.2    | -21.41%          |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:schedutil         | 4.70026E-05                  | 21275.4    | -19.7%           |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:performance       | 5.80094E-05                  | 17238.6    | -0.95%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP:performance              | 5.8292E-05                   | 17155      | -0.47%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP: balance performance:    | 6.71709E-05                  | 14887.4    | 14.69%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP:power                    | 6.66951E-05                  | 4993.6     | 13.88%           |
> +------------------------------+------------------------------+------------+------------------+
> 
> Tbench Benchmark Data on ROME Server CPU
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | Kernel Module                               | PPW MB / (s * J)  |Throughput(MB/s)| Energy (J)|PPW Improvement(%)|
> +=============================================+===================+==============+=============+==================+
> | acpi_cpufreq: schedutil                     | 46.39             | 17191        | 37057.3     | base             |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | acpi_cpufreq: ondemand                      | 51.51             | 19269.5      | 37406.5     | 11.04 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | acpi_cpufreq: performance                   | 45.96             | 17063.7      | 37123.7     | -0.74 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: performance(0)               | 54.46             | 20263.1      | 37205       | 17.87 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: balance performance          | 55.03             | 20481.9      | 37221.5     | 19.14 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: balance_power                | 54.43             | 20245.9      | 37194.2     | 17.77 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: power(255)                   | 54.26             | 20181.7      | 37197.4     | 17.40 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: schedutil                       | 48.22             | 17844.9      | 37006.6     | 3.80 %           |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: ondemand                        | 61.30             | 22988        | 37503.4     | 33.72 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: performance                     | 54.52             | 20252.6      | 37147.8     | 17.81 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> 
> changes from v4:
>   * rebase driver based on the v6.1-rc7
>   * remove the builtin changes patch because pstate driver has been
>     changed to builtin type by another thread patch
>   * update Documentation: amd-pstate: add amd pstate driver mode introduction
>   * replace sprintf with sysfs_emit() instead.
>   * fix typo for cppc_set_epp_perf() in cppc_acpi.h header
> 
> changes from v3:
>   * add one more document update patch for the active and passive mode
>     introducion.
>   * drive most of the feedbacks from Mario
>   * drive feedback from Rafael for the cppc_acpi driver.
>   * remove the epp raw data set/get function
>   * set the amd-pstate drive by passing kernel parameter
>   * set amd-pstate driver disabled by default if no kernel parameter
>     input from booting
>   * get cppc_set_auto_epp and cppc_set_epp_perf combined
>   * pick up reviewed by flag from Mario
> 
> changes from v2:
>   * change pstate driver as builtin type from module
>   * drop patch "export cpufreq cpu release and acquire"
>   * squash patch of shared mem into single patch of epp implementation
>   * add one new patch to support frequency boost control
>   * add patch to expose driver working status checking
>   * rebase driver into v6.1-rc4 kernel release
>   * move some declaration to amd-pstate.h
>   * drive feedback from Mario for the online/offline patch
>   * drive feedback from Mario for the suspend/resume patch
>   * drive feedback from Ray for the cppc_acpi and some other patches
>   * drive feedback from Nathan for the epp patch
> 
> changes from v1:
>   * rebased to v6.0
>   * drive feedbacks from Mario for the suspend/resume patch
>   * drive feedbacks from Nathan for the EPP support on msr type
>   * fix some typos and code style indent problems
>   * update commit comments for patch 4/7
>   * change the `epp_enabled` module param name to `epp`
>   * set the default epp mode to be false
>   * add testing for the x86_energy_perf_policy utility patchset(will
>     send that utility patchset with another thread)
> 
> v4: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
> v3: https://lore.kernel.org/all/20221107175705.2207842-1-Perry.Yuan@amd.com/
> v2: https://lore.kernel.org/all/20221010162248.348141-1-Perry.Yuan@amd.com/
> v1: https://lore.kernel.org/all/20221009071033.21170-1-Perry.Yuan@amd.com/
> 
> Perry Yuan (9):
>    ACPI: CPPC: Add AMD pstate energy performance preference cppc control
>    Documentation: amd-pstate: add EPP profiles introduction
>    cpufreq: amd_pstate: implement Pstate EPP support for the AMD
>      processors
>    cpufreq: amd_pstate: implement amd pstate cpu online and offline
>      callback
>    cpufreq: amd-pstate: implement suspend and resume callbacks
>    cpufreq: amd-pstate: add frequency dynamic boost sysfs control
>    cpufreq: amd_pstate: add driver working mode status sysfs entry
>    Documentation: amd-pstate: add amd pstate driver mode introduction
>    Documentation: introduce amd pstate active mode kernel command line
>      options
> 
>   .../admin-guide/kernel-parameters.txt         |   7 +
>   Documentation/admin-guide/pm/amd-pstate.rst   |  45 +-
>   drivers/acpi/cppc_acpi.c                      | 114 ++-
>   drivers/cpufreq/amd-pstate.c                  | 872 +++++++++++++++++-
>   include/acpi/cppc_acpi.h                      |  12 +
>   include/linux/amd-pstate.h                    |  82 ++
>   6 files changed, 1118 insertions(+), 14 deletions(-)
> 
