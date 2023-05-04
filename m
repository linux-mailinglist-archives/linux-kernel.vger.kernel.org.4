Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04906F64E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjEDGXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEDGXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:23:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA97F273B
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:23:24 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3446BMAB012455;
        Thu, 4 May 2023 06:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8zP22wMYK1SkbM5RUGkAZChKldrYmxLbOP7h31tcplg=;
 b=sRJuf7LvI++fTilKYJbn0rsv3A2BU1ssn/QARur1ZgpB169KYvJD8HjLNejqQytDw7Kt
 ddh2KJ9kWkEeWBjn7d4SaqsQYfK2O4KsENjJfkGWIF0fMDdL15iTeBcybZ04dhQ1nraE
 SBz3VwbaV9SxJ6M8Ey5erfsdTPteAiMGFeQrWM62cLv+ivmD4modDPoBhEeys70F+Vm0
 edQwt5GAUUGf/DZVPLKDf4vtCIHlLv7soB6SIGl3HeQrs9q8fo+6tDpA0IhmkNffNICT
 mOpVAyQoYtHG+sneiXyhVQtItoQmUDIMCZgphDDG+JOk2iq3JsgUkCetX+rOGtGW5XLw jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qc6sk14pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 06:22:43 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3446Mhon020223;
        Thu, 4 May 2023 06:22:43 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qc6sk14ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 06:22:43 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3441cahV010613;
        Thu, 4 May 2023 06:22:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3q8tv6tnrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 06:22:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3446MbWV58655120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 May 2023 06:22:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A390E20040;
        Thu,  4 May 2023 06:22:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC89A20076;
        Thu,  4 May 2023 06:22:30 +0000 (GMT)
Received: from [9.43.36.155] (unknown [9.43.36.155])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  4 May 2023 06:22:30 +0000 (GMT)
Message-ID: <f7364a0b-d5f2-5f38-e3cb-f3d0dd6184cf@linux.ibm.com>
Date:   Thu, 4 May 2023 11:52:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v22 0/8] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230503224145.7405-1-eric.devolder@oracle.com>
From:   Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20230503224145.7405-1-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y3RnRaXugMdwOQJvW50vwU7meVk_10Li
X-Proofpoint-ORIG-GUID: -1k6iwG7zgQo2W4UntFZ84FadHkPsMDm
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_03,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040050
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/23 4:11 am, Eric DeVolder wrote:
> Once the kdump service is loaded, if changes to CPUs or memory occur,
> either by hot un/plug or off/onlining, the crash elfcorehdr must also
> be updated.
> 
> The elfcorehdr describes to kdump the CPUs and memory in the system,
> and any inaccuracies can result in a vmcore with missing CPU context
> or memory regions.
> 
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (eg. kernel, initrd, boot_params, purgatory and
> elfcorehdr) by the userspace kexec utility. In the original post I
> outlined the significant performance problems related to offloading
> this activity to userspace.
> 
> This patchset introduces a generic crash handler that registers with
> the CPU and memory notifiers. Upon CPU or memory changes, from either
> hot un/plug or off/onlining, this generic handler is invoked and
> performs important housekeeping, for example obtaining the appropriate
> lock, and then invokes an architecture specific handler to do the
> appropriate elfcorehdr update.
> 
> Note the description in patch 'crash: change crash_prepare_elf64_headers()
> to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
> enables further optimizations related to CPU plug/unplug/online/offline
> performance of elfcorehdr updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory; thus no involvement
> with userspace needed.
> 
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
> 
>   - Prevent udev from updating kdump crash kernel on hot un/plug changes.
>     Add the following as the first lines to the RHEL udev rule file
>     /usr/lib/udev/rules.d/98-kexec.rules:
> 
>     # The kernel updates the crash elfcorehdr for CPU and memory changes
>     SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>     SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> 
>     With this changeset applied, the two rules evaluate to false for
>     CPU and memory change events and thus skip the userspace
>     unload-then-reload of kdump.
> 
>   - Change to the kexec_file_load for loading the kdump kernel:
>     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>      standard_kexec_args="-p -d -s"
>     which adds the -s to select kexec_file_load() syscall.
> 
> This kernel patchset also supports kexec_load() with a modified kexec
> userspace utility. A working changeset to the kexec userspace utility
> is posted to the kexec-tools mailing list here:
> 
>   http://lists.infradead.org/pipermail/kexec/2023-May/027049.html
> 
> To use the kexec-tools patch, apply, build and install kexec-tools,
> then change the kdumpctl's standard_kexec_args to replace the -s with
> --hotplug. The removal of -s reverts to the kexec_load syscall and
> the addition of --hotplug invokes the changes put forth in the
> kexec-tools patch.

The changes look good to me. For the series..

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> 
> Regards,
> eric
> ---
> v22: 3may2023
>   - Rebased onto 6.3.0
>   - Improved support for kexec_load(), per Hari Bathini. See
>     "crash: hotplug support for kexec_load()" which is the only
>     change to this series.
>   - Applied Baoquan He's Acked-by for all other patches.
> 
> v21: 4apr2023
>   https://lkml.org/lkml/2023/4/4/1136
>   https://lore.kernel.org/lkml/20230404180326.6890-1-eric.devolder@oracle.com/
>   - Rebased onto 6.3.0-rc5
>   - Additional simplification of indentation in crash_handle_hotplug_event(),
>     per Baoquan.
> 
> v20: 17mar2023
>   https://lkml.org/lkml/2023/3/17/1169
>   https://lore.kernel.org/lkml/20230317212128.21424-1-eric.devolder@oracle.com/
>   - Rebased onto 6.3.0-rc2
>   - Defaulting CRASH_HOTPLUG for x86 to Y, per Sourabh.
>   - Explicitly initializing image->hp_action, per Baoquan.
>   - Simplified kexec_trylock() in crash_handle_hotplug_event(),
>     per Baoquan.
>   - Applied Sourabh's Reviewed-by to the series.
> 
> v19: 6mar2023
>   https://lkml.org/lkml/2023/3/6/1358
>   https://lore.kernel.org/lkml/20230306162228.8277-1-eric.devolder@oracle.com/
>   - Rebased onto 6.2.0
>   - Did away with offlinecpu, per Thomas Gleixner.
>   - Changed to CPUHP_BP_PREPARE_DYN instead of CPUHP_AP_ONLINE_DYN.
>   - Did away with elfcorehdr_index_valid, per Sourabh.
>   - Convert to for_each_possible_cpu() in crash_prepare_elf64_headers()
>     per Sourabh.
>   - Small optimization for x86 cpu changes.
> 
> v18: 31jan2023
>   https://lkml.org/lkml/2023/1/31/1356
>   https://lore.kernel.org/lkml/20230131224236.122805-1-eric.devolder@oracle.com/
>   - Rebased onto 6.2.0-rc6
>   - Renamed struct kimage member hotplug_event to hp_action, and
>     re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
>   - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
>     CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
>     is not reflected in elfcorehdr.
>   - Reworked some of the comments and commit messages to offer
>     more of the why, than what, per Thomas Gleixner.
> 
> v17: 18jan2023
>   https://lkml.org/lkml/2023/1/18/1420
>   https://lore.kernel.org/lkml/20230118213544.2128-1-eric.devolder@oracle.com/
>   - Rebased onto 6.2.0-rc4
>   - Moved a bit of code around so that kexec_load()-only builds
>     work, per Sourabh.
>   - Corrected computation of number of memory region Phdrs needed
>     when x86 memory hotplug is not enabled, per Baoquan.
> 
> v16: 5jan2023
>   https://lkml.org/lkml/2023/1/5/673
>   https://lore.kernel.org/lkml/20230105151709.1845-1-eric.devolder@oracle.com/
>   - Rebased onto 6.2.0-rc2
>   - Corrected error identified by Baoquan.
> 
> v15: 9dec2022
>   https://lkml.org/lkml/2022/12/9/520
>   https://lore.kernel.org/lkml/20221209153656.3284-1-eric.devolder@oracle.com/
>   - Rebased onto 6.1.0-rc8
>   - Replaced arch_un/map_crash_pages() with direct use of
>     kun/map_local_pages(), per Boris.
>   - Some x86 changes, per Boris.
> 
> v14: 16nov2022
>   https://lkml.org/lkml/2022/11/16/1645
>   https://lore.kernel.org/lkml/20221116214643.6384-1-eric.devolder@oracle.com/
>   - Rebased onto 6.1.0-rc5
>   - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
>     compilation of feature components, per Boris.
>   - Removed hp_action parameter to arch_crash_handle_hotplug_event()
>     as it is unused.
> 
> v13: 31oct2022
>   https://lkml.org/lkml/2022/10/31/854
>   https://lore.kernel.org/lkml/20221031193604.28779-1-eric.devolder@oracle.com/
>   - Rebased onto 6.1.0-rc3, which means converting to use the new
>     kexec_trylock() away from mutex_lock(kexec_mutex).
>   - Moved arch_un/map_crash_pages() into kexec.h and default
>     implementation using k/unmap_local_pages().
>   - Changed more #ifdef's into IS_ENABLED()
>   - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
>     into x86 crash.c as #define rather Kconfig item, per Boris.
>   - Check number of Phdrs against PN_XNUM, max possible.
> 
> v12: 9sep2022
>   https://lkml.org/lkml/2022/9/9/1358
>   https://lore.kernel.org/lkml/20220909210509.6286-1-eric.devolder@oracle.com/
>   - Rebased onto 6.0-rc4
>   - Addressed some minor formatting items, per Baoquan
> 
> v11: 26aug2022
>   https://lkml.org/lkml/2022/8/26/963
>   https://lore.kernel.org/lkml/20220826173704.1895-1-eric.devolder@oracle.com/
>   - Rebased onto 6.0-rc2
>   - Redid the rework of __weak to use asm/kexec.h, per Baoquan
>   - Reworked some comments and minor items, per Baoquan
> 
> v10: 21jul2022
>   https://lkml.org/lkml/2022/7/21/1007
>   https://lore.kernel.org/lkml/20220721181747.1640-1-eric.devolder@oracle.com/
>   - Rebased to 5.19.0-rc7
>   - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
>     for architectures not supporting this feature.
>   - Per David Hildebrand, removed the WARN_ONCE() altogether.
>   - Per David Hansen, converted to use of kmap_local_page().
>   - Per Baoquan He, replaced use of __weak with the kexec technique.
> 
> v9: 13jun2022
>   https://lkml.org/lkml/2022/6/13/3382
>   https://lore.kernel.org/lkml/20220613224240.79400-1-eric.devolder@oracle.com/
>   - Rebased to 5.18.0
>   - Per Sourabh, moved crash_prepare_elf64_headers() into common
>     crash_core.c to avoid compile issues with kexec_load only path.
>   - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
>   - Changed the __weak arch_crash_handle_hotplug_event() to utilize
>     WARN_ONCE() instead of WARN(). Fix some formatting issues.
>   - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
>     and CPUs; for use by userspace (udev) to determine if the kernel
>     performs crash hot un/plug support.
>   - Per Sourabh, moved the code detecting the elfcorehdr segment from
>     arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
>     and kexec_file_load can benefit.
>   - Updated userspace kexec-tools kexec utility to reflect change to
>     using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
>   - Updated the new proposed udev rules to reflect using the sysfs
>     attributes crash_hotplug.
> 
> v8: 5may2022
>   https://lkml.org/lkml/2022/5/5/1133
>   https://lore.kernel.org/lkml/20220505184603.1548-1-eric.devolder@oracle.com/
>   - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
>     of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
>     is not needed. Also use of IS_ENABLED() rather than #ifdef's.
>     Renamed crash_hotplug_handler() to handle_hotplug_event().
>     And other corrections.
>   - Per Baoquan, minimized the parameters to the arch_crash_
>     handle_hotplug_event() to hp_action and cpu.
>   - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
>   - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
>     to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
>     by David Hildebrand. Folded this patch into the x86
>     kexec_file_load support patch.
> 
> v7: 13apr2022
>   https://lkml.org/lkml/2022/4/13/850
>   https://lore.kernel.org/lkml/20220413164237.20845-1-eric.devolder@oracle.com/
>   - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.
> 
> v6: 1apr2022
>   https://lkml.org/lkml/2022/4/1/1203
>   https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/
>   - Reword commit messages and some comment cleanup per Baoquan.
>   - Changed elf_index to elfcorehdr_index for clarity.
>   - Minor code changes per Baoquan.
> 
> v5: 3mar2022
>   https://lkml.org/lkml/2022/3/3/674
>   https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
>   - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
>     David Hildenbrand.
>   - Refactored slightly a few patches per Baoquan recommendation.
> 
> v4: 9feb2022
>   https://lkml.org/lkml/2022/2/9/1406
>   https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
>   - Refactored patches per Baoquan suggestsions.
>   - A few corrections, per Baoquan.
> 
> v3: 10jan2022
>   https://lkml.org/lkml/2022/1/10/1212
>   https://lore.kernel.org/lkml/20220110195727.1682-1-eric.devolder@oracle.com/
>   - Rebasing per Baoquan He request.
>   - Changed memory notifier per David Hildenbrand.
>   - Providing example kexec userspace change in cover letter.
> 
> RFC v2: 7dec2021
>   https://lkml.org/lkml/2021/12/7/1088
>   https://lore.kernel.org/lkml/20211207195204.1582-1-eric.devolder@oracle.com/
>   - Acting upon Baoquan He suggestion of removing elfcorehdr from
>     the purgatory list of segments, removed purgatory code from
>     patchset, and it is signficiantly simpler now.
> 
> RFC v1: 18nov2021
>   https://lkml.org/lkml/2021/11/18/845
>   https://lore.kernel.org/lkml/20211118174948.37435-1-eric.devolder@oracle.com/
>   - working patchset demonstrating kernel handling of hotplug
>     updates to x86 elfcorehdr for kexec_file_load
> 
> RFC: 14dec2020
>   https://lkml.org/lkml/2020/12/14/532
>   https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
>   - proposed concept of allowing kernel to handle hotplug update
>     of elfcorehdr
> ---
> 
> Eric DeVolder (8):
>    crash: move a few code bits to setup support of crash hotplug
>    crash: add generic infrastructure for crash hotplug support
>    kexec: exclude elfcorehdr from the segment digest
>    crash: memory and CPU hotplug sysfs attributes
>    x86/crash: add x86 crash hotplug support
>    crash: hotplug support for kexec_load()
>    crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
>    x86/crash: optimize CPU changes
> 
>   .../admin-guide/mm/memory-hotplug.rst         |   8 +
>   Documentation/core-api/cpu_hotplug.rst        |  18 +
>   arch/x86/Kconfig                              |  13 +
>   arch/x86/include/asm/kexec.h                  |  18 +
>   arch/x86/kernel/crash.c                       | 156 +++++++-
>   drivers/base/cpu.c                            |  14 +
>   drivers/base/memory.c                         |  13 +
>   include/linux/crash_core.h                    |   9 +
>   include/linux/kexec.h                         |  63 +++-
>   include/uapi/linux/kexec.h                    |   1 +
>   kernel/crash_core.c                           | 355 ++++++++++++++++++
>   kernel/kexec.c                                |   3 +
>   kernel/kexec_core.c                           |   6 +
>   kernel/kexec_file.c                           | 187 +--------
>   kernel/ksysfs.c                               |  15 +
>   15 files changed, 674 insertions(+), 205 deletions(-)
> 
