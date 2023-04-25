Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF76EE063
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjDYKbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjDYKbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:31:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B5719AB;
        Tue, 25 Apr 2023 03:31:42 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q5JDf42SQzKtLX;
        Tue, 25 Apr 2023 18:30:42 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 18:31:39 +0800
Subject: Re: [PATCH v2] perf/core: Fix perf_sample_data not properly
 initialized for different swevents in perf_tp_event()
To:     <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, kernel test robot <yujie.liu@intel.com>
References: <202304250929.efef2caa-yujie.liu@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <0701d0b2-1cf4-6485-8566-1be8bfee82f5@huawei.com>
Date:   Tue, 25 Apr 2023 18:31:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <202304250929.efef2caa-yujie.liu@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/4/25 9:30, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> 
> commit: 05c59c1290536838e52ecc12022d49421edd596c ("[PATCH v2] perf/core: Fix perf_sample_data not properly initialized for different swevents in perf_tp_event()")
> url: https://github.com/intel-lab-lkp/linux/commits/Yang-Jihong/perf-core-Fix-perf_sample_data-not-properly-initialized-for-different-swevents-in-perf_tp_event/20230419-105225
> base: https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git perf/core
> patch link: https://lore.kernel.org/all/20230419024832.181874-1-yangjihong1@huawei.com/
> patch subject: [PATCH v2] perf/core: Fix perf_sample_data not properly initialized for different swevents in perf_tp_event()
> 
> in testcase: phoronix-test-suite
> version:
> with following parameters:
> 
> 	need_x: true
> 	test: jxrendermark-1.2.4
> 	option_a: Transformed Texture Paint
> 	option_b: 1024x1024
> 	cpufreq_governor: performance
> 
> test-description: The Phoronix Test Suite is the most comprehensive testing and benchmarking platform available that provides an extensible framework for which new tests can be easily added.
> test-url: http://www.phoronix-test-suite.com/
> 
> compiler: gcc-11
> test machine: 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz (Coffee Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202304250929.efef2caa-yujie.liu@intel.com
> 
> 
> [   68.743429][ T1498] BUG: kernel NULL pointer dereference, address: 0000000000000402
> [   68.751129][ T1498] #PF: supervisor read access in kernel mode
> [   68.756992][ T1498] #PF: error_code(0x0000) - not-present page
> [   68.762853][ T1498] PGD 0 P4D 0
> [   68.766101][ T1498] Oops: 0000 [#1] SMP PTI
> [   68.770307][ T1498] CPU: 0 PID: 1498 Comm: wait Tainted: G S                 6.3.0-rc1-00525-g05c59c129053 #1
> [   68.780261][ T1498] Hardware name: Dell Inc. OptiPlex 7060/0C96W1, BIOS 1.4.2 06/11/2019
> [ 68.788385][ T1498] RIP: 0010:perf_tp_event (kernel/events/core.c:10049 kernel/events/core.c:10072 kernel/events/core.c:10060 kernel/events/core.c:10150)
> [ 68.793552][ T1498] Code: e0 01 00 00 01 0f 85 c5 00 00 00 41 f6 87 00 01 00 00 20 74 0d f6 83 88 00 00 00 03 0f 84 ae 00 00 00 48 8b 84 24 90 00 00 00 <48> 8b 70 10 49 8b 87 80 02 00 00 48 85 c0 49 0f 44 c7 48 8b b8 00
> All code
> ========
>     0:	e0 01                	loopne 0x3
>     2:	00 00                	add    %al,(%rax)
>     4:	01 0f                	add    %ecx,(%rdi)
>     6:	85 c5                	test   %eax,%ebp
>     8:	00 00                	add    %al,(%rax)
>     a:	00 41 f6             	add    %al,-0xa(%rcx)
>     d:	87 00                	xchg   %eax,(%rax)
>     f:	01 00                	add    %eax,(%rax)
>    11:	00 20                	add    %ah,(%rax)
>    13:	74 0d                	je     0x22
>    15:	f6 83 88 00 00 00 03 	testb  $0x3,0x88(%rbx)
>    1c:	0f 84 ae 00 00 00    	je     0xd0
>    22:	48 8b 84 24 90 00 00 	mov    0x90(%rsp),%rax
>    29:	00
>    2a:*	48 8b 70 10          	mov    0x10(%rax),%rsi		<-- trapping instruction
>    2e:	49 8b 87 80 02 00 00 	mov    0x280(%r15),%rax
>    35:	48 85 c0             	test   %rax,%rax
>    38:	49 0f 44 c7          	cmove  %r15,%rax
>    3c:	48                   	rex.W
>    3d:	8b                   	.byte 0x8b
>    3e:	b8                   	.byte 0xb8
> 	...
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	48 8b 70 10          	mov    0x10(%rax),%rsi
>     4:	49 8b 87 80 02 00 00 	mov    0x280(%r15),%rax
>     b:	48 85 c0             	test   %rax,%rax
>     e:	49 0f 44 c7          	cmove  %r15,%rax
>    12:	48                   	rex.W
>    13:	8b                   	.byte 0x8b
>    14:	b8                   	.byte 0xb8
> 	...
> [   68.813083][ T1498] RSP: 0018:ffffc90002693c00 EFLAGS: 00010046
> [   68.819031][ T1498] RAX: 00000000000003f2 RBX: ffff888853e29cc0 RCX: 000000000000000f
> [   68.826894][ T1498] RDX: 00000000000005da RSI: 0000000000000000 RDI: 0000000000010000
> [   68.834758][ T1498] RBP: ffffc90002693db0 R08: ffff888853e29cc0 R09: ffffe8ffffa0dca8
> [   68.842621][ T1498] R10: 00000000000003f2 R11: 0000000000000000 R12: 0000000000000001
> [   68.850484][ T1498] R13: ffffe8ffffa1f120 R14: 0000000000000000 R15: ffff88811b247020
> [   68.858348][ T1498] FS:  0000000000000000(0000) GS:ffff888853e00000(0000) knlGS:0000000000000000
> [   68.867169][ T1498] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   68.873637][ T1498] CR2: 0000000000000402 CR3: 000000087b418004 CR4: 00000000003706f0
> [   68.881501][ T1498] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   68.889366][ T1498] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   68.897233][ T1498] Call Trace:
> [   68.900395][ T1498]  <TASK>
> [ 68.903206][ T1498] ? perf_trace_sched_wakeup_template (include/trace/events/sched.h:141 (discriminator 11))
> [ 68.909330][ T1498] ? ttwu_do_activate (arch/x86/include/asm/preempt.h:85 include/trace/events/sched.h:178 kernel/sched/core.c:3685 kernel/sched/core.c:3712)
> [ 68.914232][ T1498] ? try_to_wake_up (kernel/sched/core.c:4279)
> [ 68.918962][ T1498] ? update_load_avg (kernel/sched/fair.c:3863 kernel/sched/fair.c:4198)
> [ 68.923689][ T1498] perf_trace_sched_switch (include/trace/events/sched.h:222)
> [ 68.929032][ T1498] __schedule (arch/x86/include/asm/preempt.h:85 include/trace/events/sched.h:222 kernel/sched/core.c:6619)
> [ 68.933246][ T1498] do_task_dead (kernel/sched/core.c:6641)
> [ 68.937456][ T1498] do_exit (include/trace/events/sched.h:333 kernel/exit.c:860)
> [ 68.941410][ T1498] ? do_sys_openat2 (fs/open.c:1358)
> [ 68.946056][ T1498] do_group_exit (kernel/exit.c:1001)
> [ 68.950358][ T1498] __x64_sys_exit_group (kernel/exit.c:1030)
> [ 68.955267][ T1498] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> [ 68.959565][ T1498] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> [   68.965340][ T1498] RIP: 0033:0x43dc26
> [ 68.969110][ T1498] Code: Unable to access opcode bytes at 0x43dbfc.
> 
> Code starting with the faulting instruction
> ===========================================
> [   68.975489][ T1498] RSP: 002b:00007ffcbf3b4fd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> [   68.983788][ T1498] RAX: ffffffffffffffda RBX: 00000000004a93d0 RCX: 000000000043dc26
> [   68.991652][ T1498] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> [   68.999515][ T1498] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffffc0
> [   69.007379][ T1498] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004a93d0
> [   69.015242][ T1498] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
> [   69.023109][ T1498]  </TASK>
> [   69.026010][ T1498] Modules linked in: sg ip_tables overlay rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver btrfs blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm sd_mod t10_pi irqbypass crct10dif_pclmul crc64_rocksoft_generic crc32_pclmul crc64_rocksoft crc32c_intel crc64 ghash_clmulni_intel i915 sha512_ssse3 drm_buddy intel_gtt drm_display_helper rapl drm_kms_helper mei_wdt syscopyarea ahci sysfillrect intel_cstate libahci sysimgblt mei_me wmi_bmof intel_wmi_thunderbolt ttm i2c_designware_platform intel_uncore video mei idma64 libata i2c_designware_core drm intel_pch_thermal wmi intel_pmc_core acpi_pad
> [   69.086955][ T1498] CR2: 0000000000000402
> [   69.090993][ T1498] ---[ end trace 0000000000000000 ]---
> 
> 

data->raw->frag.data may be accessed in perf_tp_event_match().
we may need to init sample_data and then go through swevent hlist to 
prevent reference of NULL pointer.

I will send the v3 version. Please check whether the solution is OK.

Thanks,
Yang
