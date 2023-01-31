Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1663B682CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjAaMhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAaMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:37:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D534298F9;
        Tue, 31 Jan 2023 04:37:06 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.165.226])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F0A346602E28;
        Tue, 31 Jan 2023 12:37:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675168625;
        bh=60U5+6/yjtOTkeqXbdeBD+8rsPW/2ChMIbYlgd/SfhI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=akYwYidOn7urqbXxl4kI9hM/YCJxtNNeXXXqZBC9Io6K5oa/fbpjDG7Sr4I2km9rh
         7TDqgb/3Nv0TxfscOMk09/tM19cNLdSEJTBAdsPbB9r03+k4bF0JpCfasBEmF705O0
         swjcJwsjSe6efOfY/5WCDsmjnyanG+h9b5vs6Mmsfa1TrYNA2BKpZTe/n9W01HBl0E
         oivPzBiveosn9/pUtPwpI+PT2DndwHV7fH2DhouV/n4+AFxdhddApCG2uKl/m3jwlt
         TECaY7t/rFXnSdLgiZk/mUnznjLkb1LauwDoRc52N0cbK8b8ooGmzMoY/vksRkE/lf
         pxGIKT/vXqXMw==
Message-ID: <1fcf162c-bde4-d982-5fa4-8317e7ba878b@collabora.com>
Date:   Tue, 31 Jan 2023 17:36:57 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/11] Implement AMD Pstate EPP Driver
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
References: <20230131090016.3970625-1-perry.yuan@amd.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230131090016.3970625-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 2:00 PM, Perry Yuan wrote:
> Hi all,
> 
> This patchset implements one new AMD CPU frequency driver
> `amd-pstate-epp` instance for better performance and power control.
> CPPC has a parameter called energy preference performance (EPP).
> The EPP is used in the CCLK DPM controller to drive the frequency that a core
> is going to operate during short periods of activity.
> EPP values will be utilized for different OS profiles (balanced, performance, power savings).
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
Really sorry to interrupt. But I want to test this driver on my system. I'm
not sure how to measure the energy consumed in a specific benchmark
duration. Please can you share the name of the tool or script which has
been used to measure power/energy consumed over the benchmark duration? Any
pointer or reference would be very helpful.

I'm assuming that the energy(J) has been measured with some X tool for the
duration of gitsource benchmark run. I want to try and reproduce these
results on AMD machines I've here.

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
> changes from v11:
>  * rebase to latest linux-pm/bleeding-edge kernel tree
>  * fix the CI build warning issue
>  * pick up RB flag from Wyes
> 
> changes from v10:
>  * pick up all new ack flas added by Ray
>  * pick up Review-By flag added by Wyes
>  * pick up Test-By flags added by Wyes
>  * move the EPP macro definition to amd_pstate.h and drop the common
>    code patch
>  * add amd_perf_ctl_reset() in epp init code as well
>  * As the warning which reminded by 0day, change amd_pstate_get_epp(cpudata, value)
>    to amd_pstate_get_epp(cpudata, 0).
> 
> changes from v8:
>  * drive all the feedbacks from Mario and change the codes in this
>   version
>  * drive all the feedbacks from Ray and change the codes in this
>   version
>  * pick up all the R-B flags from Mario
>  * pick up all the R-B flags from Ray
>  * drop boost/refresh_freq_limits callback
>  * reuse policy->driver_data to store amd_cpudata struct
>  * use switch-case in the driver mode switching function
>  * add Kconfig dependency the INTEL_PSTATE for AMD_PSTATE build
>  * fix some other code format and typos
> 
> changes from v7:
>  * remove  iowait boost functions code
>  * pick up ack by flag from Huang Ray.
>  * add one new patch to support multiple working modes in the amd_pstate_param(),aligned with Wyse 
>  * drop the patch "[v7 08/13] cpufreq: amd-pstate: add frequency dynamic boost sysfs control"
>  * replace the cppc_get_epp_caps() with new cppc_get_epp_perf() wihch is
>    more simple to use
>  * remove I/O wait boost code from amd_pstate_update_status()
>  * replace cppc_active var with enum type AMD_PSTATE_ACTIVE
>  * squash amd_pstate_epp_verify_policy() into sigle function
>  * remove "amd pstate" string from the pr_err, pr_debug logs info
>  * rework patch [v7 03/13], move the common EPP profiles declaration
>    into cpufreq.h which will be used by amd-pstate and intel-pstate
>  * combine amd psate init functions.
>  * remove epp_powersave from amd-pstate.h and dropping the codes.
>  * move amd_pstate_params{} from amd-pstate.h into amd-pstate.c
>  * drive some other feedbacks from huang ray 
> 
> changes from v6:
>  * fix one legacy kernel hang issue when amd-pstate driver unregistering
>  * add new documentation to introduce new global sysfs attributes
>  * use sysfs_emit_at() to print epp profiles array
>  * update commit info for patch v6 patch 1/11 as Mario sugguested.
>  * trying to add the EPP profiles into cpufreq.h, but it will cause lots
>    of build failues,continue to keep cpufreq_common.h used in v7
>  * update commit info using amd-pstate as prefix same as before.
>  * remove CONFIG_ACPI for the header as Ray suggested.
>  * move amd_pstate_kobj to where it is used in patch "add frequency dynamic boost sysfs control"
>  * drive feedback removing X86_FEATURE_CPPC check for the epp init from Huang Ray 
>  * drive feedback from Mario
>  
> change from v5:
>  * add one common header `cpufreq_commoncpufreq_common` to extract EPP profiles 
>    definition for amd and intel pstate driver.
>  * remove the epp_off value to avoid confusion.
>  * convert some other sysfs sprintf() function with sysfs_emit() and add onew new patch
>  * add acpi pm server priofile detection to enable dynamic boost control
>  * fix some code format with checkpatch script
>  * move the EPP profile declaration into common header file `cpufreq_common.h`
>  * fix commit typos
> 
> changes from v4:
>  * rebase driver based on the v6.1-rc7
>  * remove the builtin changes patch because pstate driver has been
>    changed to builtin type by another thread patch
>  * update Documentation: amd-pstate: add amd pstate driver mode introduction 
>  * replace sprintf with sysfs_emit() instead.
>  * fix typo for cppc_set_epp_perf() in cppc_acpi.h header
> 
> changes from v3:
>  * add one more document update patch for the active and passive mode
>    introducion.
>  * drive most of the feedbacks from Mario
>  * drive feedback from Rafael for the cppc_acpi driver.
>  * remove the epp raw data set/get function
>  * set the amd-pstate drive by passing kernel parameter
>  * set amd-pstate driver disabled by default if no kernel parameter
>    input from booting
>  * get cppc_set_auto_epp and cppc_set_epp_perf combined
>  * pick up reviewed by flag from Mario
> 
> changes from v2:
>  * change pstate driver as builtin type from module
>  * drop patch "export cpufreq cpu release and acquire"
>  * squash patch of shared mem into single patch of epp implementation
>  * add one new patch to support frequency boost control
>  * add patch to expose driver working status checking
>  * rebase driver into v6.1-rc4 kernel release
>  * move some declaration to amd-pstate.h
>  * drive feedback from Mario for the online/offline patch
>  * drive feedback from Mario for the suspend/resume patch
>  * drive feedback from Ray for the cppc_acpi and some other patches
>  * drive feedback from Nathan for the epp patch
> 
> changes from v1:
>  * rebased to v6.0
>  * drive feedbacks from Mario for the suspend/resume patch
>  * drive feedbacks from Nathan for the EPP support on msr type
>  * fix some typos and code style indent problems
>  * update commit comments for patch 4/7
>  * change the `epp_enabled` module param name to `epp`
>  * set the default epp mode to be false
>  * add testing for the x86_energy_perf_policy utility patchset(will
>    send that utility patchset with another thread)
> 
> v11: https://lore.kernel.org/lkml/20230118075210.447418-1-perry.yuan@amd.com/
> v10:https://lore.kernel.org/lkml/20230106061420.95715-1-perry.yuan@amd.com/
> v9: https://lore.kernel.org/lkml/20221225163442.2205660-1-perry.yuan@amd.com/
> v8: https://lore.kernel.org/lkml/20221219064042.661122-1-perry.yuan@amd.com/
> v7: https://lore.kernel.org/lkml/20221208111852.386731-1-perry.yuan@amd.com/
> v6: https://lore.kernel.org/lkml/20221202074719.623673-1-perry.yuan@amd.com/
> v5: https://lore.kernel.org/lkml/20221128170314.2276636-1-perry.yuan@amd.com/
> v4: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
> v3: https://lore.kernel.org/all/20221107175705.2207842-1-Perry.Yuan@amd.com/
> v2: https://lore.kernel.org/all/20221010162248.348141-1-Perry.Yuan@amd.com/
> v1: https://lore.kernel.org/all/20221009071033.21170-1-Perry.Yuan@amd.com/
> 
> 
> Perry Yuan (10):
>   ACPI: CPPC: Add AMD pstate energy performance preference cppc control
>   Documentation: amd-pstate: add EPP profiles introduction
>   cpufreq: amd-pstate: implement Pstate EPP support for the AMD
>     processors
>   cpufreq: amd-pstate: implement amd pstate cpu online and offline
>     callback
>   cpufreq: amd-pstate: implement suspend and resume callbacks
>   cpufreq: amd-pstate: add driver working mode switch support
>   Documentation: amd-pstate: add amd pstate driver mode introduction
>   Documentation: introduce amd pstate active mode kernel command line
>     options
>   cpufreq: amd-pstate: convert sprintf with sysfs_emit()
>   Documentation: amd-pstate: introduce new global sysfs attributes
> 
> Wyes Karny (1):
>   cpufreq: amd-pstate: optimize driver working mode selection in
>     amd_pstate_param()
> 
>  .../admin-guide/kernel-parameters.txt         |   7 +
>  Documentation/admin-guide/pm/amd-pstate.rst   |  74 +-
>  drivers/acpi/cppc_acpi.c                      |  67 ++
>  drivers/cpufreq/amd-pstate.c                  | 705 +++++++++++++++++-
>  include/acpi/cppc_acpi.h                      |  12 +
>  include/linux/amd-pstate.h                    |  32 +
>  6 files changed, 876 insertions(+), 21 deletions(-)
> 

-- 
BR,
Muhammad Usama Anjum
