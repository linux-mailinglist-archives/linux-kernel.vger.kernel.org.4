Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD45D6E0F04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjDMNkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjDMNkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:40:23 -0400
X-Greylist: delayed 634 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 06:37:48 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4081BBBB;
        Thu, 13 Apr 2023 06:37:47 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 615C112BE4A8;
        Thu, 13 Apr 2023 15:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1681391881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Oao65Nki1CkTSME8kkBazOhgfBe66eQgZrsXuv+svs=;
        b=qX36+PaXql+aoU/beJqTsUREkn+4kc+qQU6s/chL9k3xUpF6drO8NNecm4P9BkEExGAYe7
        fxLCmGtaOQFBl8dqY1Tbxzrt/M1+QszOI+3QQQTagSpV682ZkH81jWve1wL5HygeTeOi+N
        EXFJ1EDitD2DPnzQtZlhk3Kl+R7P/1I=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org,
        K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] arch/x86: Set L2 Cache ID on AMD processors
Date:   Thu, 13 Apr 2023 15:17:59 +0200
Message-ID: <1730486.opmyjpaWMg@natalenko.name>
In-Reply-To: <20230410163527.1626-1-kprateek.nayak@amd.com>
References: <20230410163527.1626-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On pond=C4=9Bl=C3=AD 10. dubna 2023 18:35:25 CEST K Prateek Nayak wrote:
> commit 66558b730f253 ("sched: Add cluster scheduler level for x86")
> defined cluster on x86 as the set of threads sharing the same L2 cache.
> cluster_id on x86, maps to the l2c_id which currently only Intel
> processors set.
>=20
> This series sets the l2c_id on AMD processors with X86_FEATURE_TOPOEXT,
> using the extended APIC ID and the "Cache Properties (L2)" CPUID
> (0x8000001D EAX). On AMD processors without X86_FEATURE_TOPOEXT, current
> behavior will continue.
>=20
> Following are the changes in value reported by
> "/sys/devices/system/cpu/cpuX/topology/cluster_id" on a 2P Milan system
> (2 x 64C/128T) where L2 is per-core level and SMT sibling of CPU (X) is
> CPU ((X + 128) % 256).
>=20
> - tip:x86/core
>=20
>   $ for i in {0..255}; do\
>       echo -n "CPU$i cluster_id: ";\
>       cat /sys/devices/system/cpu/cpu$i/topology/cluster_id;\
>     done;
>=20
>     CPU0 cluster_id: 65535
>     CPU1 cluster_id: 65535
>     CPU2 cluster_id: 65535
>     CPU3 cluster_id: 65535
>     CPU4 cluster_id: 65535
>     ...
>     CPU254 cluster_id: 65535
>     CPU255 cluster_id: 65535
>=20
> - tip:x86/core + this series
>=20
>   $ for i in {0..255}; do\
>       echo -n "CPU$i cluster_id: ";\
>       cat /sys/devices/system/cpu/cpu$i/topology/cluster_id;\
>     done;
>=20
>     CPU0 cluster_id: 0
>     CPU1 cluster_id: 1
>     CPU2 cluster_id: 2
>     CPU3 cluster_id: 3
>     CPU4 cluster_id: 4
>     CPU5 cluster_id: 5
>     CPU6 cluster_id: 6
>     CPU7 cluster_id: 7
>     CPU8 cluster_id: 8
>     ...
>     CPU126 cluster_id: 126
>     CPU127 cluster_id: 127
>     CPU128 cluster_id: 0
>     CPU129 cluster_id: 1
>     CPU130 cluster_id: 2
>     CPU131 cluster_id: 3
>     CPU132 cluster_id: 4
>     CPU133 cluster_id: 5
>     CPU134 cluster_id: 6
>     CPU135 cluster_id: 7
>     CPU136 cluster_id: 8
>     ...
>     CPU254 cluster_id: 126
>     CPU255 cluster_id: 127
>=20
> Note: Hygon, theoretically, should be able to set the l2c_id using the
> same cacheinfo_amd_init_l2c_id() function being added in Patch 1. Since
> I do not have access to a Hygon machine to verify my theory, ccing Hygon
> maintainer Pu Wen <puwen@hygon.cn> for l2c_id enablement on Hygon.
>=20
> The series also adds documentation for clusters on x86 platforms and
> applies cleanly on top of tip:x86/core at commit ce3ba2af9695
> ("x86: Suppress KMSAN reports in arch_within_stack_frames()")
>=20
> ---
> K Prateek Nayak (2):
>   arch/x86: Set L2 Cache ID on AMD and Hygon processors
>   x86/Documentation: Add documentation about cluster
>=20
>  Documentation/x86/topology.rst   | 31 +++++++++++++++++++++
>  arch/x86/include/asm/cacheinfo.h |  1 +
>  arch/x86/kernel/cpu/amd.c        |  1 +
>  arch/x86/kernel/cpu/cacheinfo.c  | 47 ++++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/hygon.c      |  1 +
>  5 files changed, 81 insertions(+)

Having the following CPU:

```
Architecture:            x86_64
CPU op-mode(s):        32-bit, 64-bit
Address sizes:         48 bits physical, 48 bits virtual
Byte Order:            Little Endian
CPU(s):                  32
On-line CPU(s) list:   0-31
Vendor ID:               AuthenticAMD
Model name:            AMD Ryzen 9 5950X 16-Core Processor
CPU family:          25
Model:               33
Thread(s) per core:  2
Core(s) per socket:  16
Socket(s):           1
Stepping:            2
=46requency boost:     enabled
CPU(s) scaling MHz:  37%
CPU max MHz:         5084,0000
CPU min MHz:         550,0000
BogoMIPS:            6789,07
=46lags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
 mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt=
 pdpe1gb rdtscp lm constant_
tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulq=
dq monitor ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f=
16c r
drand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnow=
prefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perf=
ctr_l
lc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgs=
base bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a rdseed adx smap clflushopt =
clwb
sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total c=
qm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock=
 nrip
_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshol=
d avic v_vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpi=
d ove
rflow_recov succor smca fsrm
Virtualization features:
Virtualization:        AMD-V
Caches (sum of all):
L1d:                   512 KiB (16 instances)
L1i:                   512 KiB (16 instances)
L2:                    8 MiB (16 instances)
L3:                    64 MiB (2 instances)
NUMA:
NUMA node(s):          1
NUMA node0 CPU(s):     0-31
Vulnerabilities:
Itlb multihit:         Not affected
L1tf:                  Not affected
Mds:                   Not affected
Meltdown:              Not affected
Mmio stale data:       Not affected
Retbleed:              Not affected
Spec store bypass:     Mitigation; Speculative Store Bypass disabled via pr=
ctl
Spectre v1:            Mitigation; usercopy/swapgs barriers and __user poin=
ter sanitization
Spectre v2:            Mitigation; Retpolines, IBPB conditional, IBRS_FW, S=
TIBP always-on, RSB filling, PBRSB-eIBRS Not affected
Srbds:                 Not affected
Tsx async abort:       Not affected
```

Without the series:

```
/sys/devices/system/cpu/cpu0/topology/cluster_id:65535
/sys/devices/system/cpu/cpu1/topology/cluster_id:65535
/sys/devices/system/cpu/cpu2/topology/cluster_id:65535
/sys/devices/system/cpu/cpu3/topology/cluster_id:65535
/sys/devices/system/cpu/cpu4/topology/cluster_id:65535
/sys/devices/system/cpu/cpu5/topology/cluster_id:65535
/sys/devices/system/cpu/cpu6/topology/cluster_id:65535
/sys/devices/system/cpu/cpu7/topology/cluster_id:65535
/sys/devices/system/cpu/cpu8/topology/cluster_id:65535
/sys/devices/system/cpu/cpu9/topology/cluster_id:65535
/sys/devices/system/cpu/cpu10/topology/cluster_id:65535
/sys/devices/system/cpu/cpu11/topology/cluster_id:65535
/sys/devices/system/cpu/cpu12/topology/cluster_id:65535
/sys/devices/system/cpu/cpu13/topology/cluster_id:65535
/sys/devices/system/cpu/cpu14/topology/cluster_id:65535
/sys/devices/system/cpu/cpu15/topology/cluster_id:65535
/sys/devices/system/cpu/cpu16/topology/cluster_id:65535
/sys/devices/system/cpu/cpu17/topology/cluster_id:65535
/sys/devices/system/cpu/cpu18/topology/cluster_id:65535
/sys/devices/system/cpu/cpu19/topology/cluster_id:65535
/sys/devices/system/cpu/cpu20/topology/cluster_id:65535
/sys/devices/system/cpu/cpu21/topology/cluster_id:65535
/sys/devices/system/cpu/cpu22/topology/cluster_id:65535
/sys/devices/system/cpu/cpu23/topology/cluster_id:65535
/sys/devices/system/cpu/cpu24/topology/cluster_id:65535
/sys/devices/system/cpu/cpu25/topology/cluster_id:65535
/sys/devices/system/cpu/cpu26/topology/cluster_id:65535
/sys/devices/system/cpu/cpu27/topology/cluster_id:65535
/sys/devices/system/cpu/cpu28/topology/cluster_id:65535
/sys/devices/system/cpu/cpu29/topology/cluster_id:65535
/sys/devices/system/cpu/cpu30/topology/cluster_id:65535
/sys/devices/system/cpu/cpu31/topology/cluster_id:65535
```

With the series:

```
/sys/devices/system/cpu/cpu0/topology/cluster_id:0
/sys/devices/system/cpu/cpu1/topology/cluster_id:1
/sys/devices/system/cpu/cpu2/topology/cluster_id:2
/sys/devices/system/cpu/cpu3/topology/cluster_id:3
/sys/devices/system/cpu/cpu4/topology/cluster_id:4
/sys/devices/system/cpu/cpu5/topology/cluster_id:5
/sys/devices/system/cpu/cpu6/topology/cluster_id:6
/sys/devices/system/cpu/cpu7/topology/cluster_id:7
/sys/devices/system/cpu/cpu8/topology/cluster_id:8
/sys/devices/system/cpu/cpu9/topology/cluster_id:9
/sys/devices/system/cpu/cpu10/topology/cluster_id:10
/sys/devices/system/cpu/cpu11/topology/cluster_id:11
/sys/devices/system/cpu/cpu12/topology/cluster_id:12
/sys/devices/system/cpu/cpu13/topology/cluster_id:13
/sys/devices/system/cpu/cpu14/topology/cluster_id:14
/sys/devices/system/cpu/cpu15/topology/cluster_id:15
/sys/devices/system/cpu/cpu16/topology/cluster_id:0
/sys/devices/system/cpu/cpu17/topology/cluster_id:1
/sys/devices/system/cpu/cpu18/topology/cluster_id:2
/sys/devices/system/cpu/cpu19/topology/cluster_id:3
/sys/devices/system/cpu/cpu20/topology/cluster_id:4
/sys/devices/system/cpu/cpu21/topology/cluster_id:5
/sys/devices/system/cpu/cpu22/topology/cluster_id:6
/sys/devices/system/cpu/cpu23/topology/cluster_id:7
/sys/devices/system/cpu/cpu24/topology/cluster_id:8
/sys/devices/system/cpu/cpu25/topology/cluster_id:9
/sys/devices/system/cpu/cpu26/topology/cluster_id:10
/sys/devices/system/cpu/cpu27/topology/cluster_id:11
/sys/devices/system/cpu/cpu28/topology/cluster_id:12
/sys/devices/system/cpu/cpu29/topology/cluster_id:13
/sys/devices/system/cpu/cpu30/topology/cluster_id:14
/sys/devices/system/cpu/cpu31/topology/cluster_id:15
```

Hence,

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


