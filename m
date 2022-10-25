Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFAE60D3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiJYSlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiJYSk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:40:59 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289CEF617D;
        Tue, 25 Oct 2022 11:40:55 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1onOr5-0000mZ-6x; Tue, 25 Oct 2022 20:40:51 +0200
Message-ID: <6e7f32f2-5397-e0cf-4271-a9826d318996@leemhuis.info>
Date:   Tue, 25 Oct 2022 20:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US, de-DE
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Regression: starting powertop crashes my machine hard since
 838d9bb62d13 ("perf: Use sample_flags for raw_data")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1666723257;fc546857;
X-HE-SMSGID: 1onOr5-0000mZ-6x
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! Since 838d9bb62d13 ("perf: Use sample_flags for raw_data") starting
powertop makes my machine crash hard: keyboard is dead, Sysrq does not
work, and most of the time there is not even a error message on the
screen; only once in maybe ~20 cases I got the line "kernel NULL pointer
dereference, address: 0000000000000010", but nothing else.

This is on a Lenovo Thinkpad T14s Gen1 (AMD Ryzen 5 PRO 4650U) running
Fedora 37 with a vanilla kernel. Master as of a six hours ago shows the
problem (IOW: 21da7472a040 didn't fix this). Reverting 838d9bb62d13 on
top of master makes the problem go away. Applying
https://lore.kernel.org/lkml/20221020070657.21571-2-atrajeev@linux.vnet.ibm.com/
(another fix for 838d9bb62d13) didn't help. My config file is based on
the one from Fedora's 6.0.3 kernel, but stripped down with localmodconfig.

Apparently I'm not the only one hitting this problem:
https://github.com/fenrus75/powertop/issues/109

Ciao, Thorsten.

P.S.: From /proc/cpuinfo

> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 23
> model           : 96
> model name      : AMD Ryzen 5 PRO 4650U with Radeon Graphics
> stepping        : 1
> microcode       : 0x8600106
> cpu MHz         : 1397.267
> cache size      : 512 KB
> physical id     : 0
> siblings        : 12
> core id         : 0
> cpu cores       : 6
> apicid          : 0
> initial apicid  : 0
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 16
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
> mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
> fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
> extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1
> sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm
> extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit
> wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb
> cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1
> avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt
> xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local
> clzero irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock
> nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
> pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid
> overflow_recov succor smca
>
> bugs            : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass retbleed
> bogomips        : 4191.92
> TLB size        : 3072 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 48 bits physical, 48 bits virtual
> power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

Bisect log:

> git bisect start
> # status: waiting for both good and bad commits
> # bad: [1a2dcbdde82e3a5f1db9b2f4c48aa1aeba534fb2] scsi: mpt3sas: re-do lost mpt3sas DMA mask fix
> git bisect bad 1a2dcbdde82e3a5f1db9b2f4c48aa1aeba534fb2
> # status: waiting for good commit(s), bad commit known
> # good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
> git bisect good 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
> # good: [76e45035348c247a70ed50eb29a9906657e4444f] Merge tag 'for-6.1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> git bisect good 76e45035348c247a70ed50eb29a9906657e4444f
> # bad: [52abb27abfff8c5ddf44eef4d759f3d1e9f166c5] Merge tag 'slab-for-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
> git bisect bad 52abb27abfff8c5ddf44eef4d759f3d1e9f166c5
> # good: [e8bc52cb8df80c31c73c726ab58ea9746e9ff734] Merge tag 'driver-core-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> git bisect good e8bc52cb8df80c31c73c726ab58ea9746e9ff734
> # good: [f01603979a4afaad7504a728918b678d572cda9e] Merge tag 'gpio-updates-for-v6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
> git bisect good f01603979a4afaad7504a728918b678d572cda9e
> # good: [2e64066dab157ffcd0e9ec2ff631862e6e222876] Merge tag 'riscv-for-linus-6.1-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
> git bisect good 2e64066dab157ffcd0e9ec2ff631862e6e222876
> # good: [376b3275c19f83d373e841e9af2d7658693190b9] KVM: PPC: Book3S HV: Fix stack frame regs marker
> git bisect good 376b3275c19f83d373e841e9af2d7658693190b9
> # bad: [3871d93b82a4a6c1f4308064f046a544f16ada21] Merge tag 'perf-core-2022-10-07' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 3871d93b82a4a6c1f4308064f046a544f16ada21
> # bad: [7be51cc1c68dfa180ef84e71bcb4204237bb5620] perf: Fix pmu_filter_match()
> git bisect bad 7be51cc1c68dfa180ef84e71bcb4204237bb5620
> # good: [ee9db0e14b0575aa827579dc2471a29ec5fc6877] perf: Use sample_flags for txn
> git bisect good ee9db0e14b0575aa827579dc2471a29ec5fc6877
> # good: [7b084630153152239d84990ac4540c2dd360186f] perf: Use sample_flags for addr
> git bisect good 7b084630153152239d84990ac4540c2dd360186f
> # bad: [ee3e88dfec23153d0675b5d00522297b9adf657c] perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
> git bisect bad ee3e88dfec23153d0675b5d00522297b9adf657c
> # bad: [a1ebcd59430236b336428bbf8e1da16fb87d56e4] Merge branch 'v6.0-rc7'
> git bisect bad a1ebcd59430236b336428bbf8e1da16fb87d56e4
> # bad: [4674ffe2fcad45a9b164401cc0794115702326cf] perf, hw_breakpoint: Fix use-after-free if perf_event_open() fails
> git bisect bad 4674ffe2fcad45a9b164401cc0794115702326cf
> # bad: [838d9bb62d132ec3baf1b5aba2e95ef9a7a9a3cd] perf: Use sample_flags for raw_data
> git bisect bad 838d9bb62d132ec3baf1b5aba2e95ef9a7a9a3cd
> # first bad commit: [838d9bb62d132ec3baf1b5aba2e95ef9a7a9a3cd] perf: Use sample_flags for raw_data

For regzbot:

#regzbot introduced 838d9bb62d13
#regzbot title perf: starting powertop crashes machines
#regzbot link: https://github.com/fenrus75/powertop/issues/109
