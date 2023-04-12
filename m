Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D526DF961
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjDLPLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDLPLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:11:32 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC2759F3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:11:28 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aebd0.dynamic.kabel-deutschland.de [95.90.235.208])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C14D560027FE8;
        Wed, 12 Apr 2023 17:11:26 +0200 (CEST)
Message-ID: <21a09968-296b-5b21-8079-6d9d4e0769d4@molgen.mpg.de>
Date:   Wed, 12 Apr 2023 17:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: AMD EPYC 25 (19h): Hardware Error: Machine Check: 0 Bank 17:
 d42040000000011b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


On a Dell PowerEdge R7525 with AMD EPYC 7763 64-Core Processor, Linux 
5.15.94 logs the machine check exceptions (MCE) below:

```
[5154053.127240] mce: [Hardware Error]: Machine check events logged
[5154053.133711] mce: [Hardware Error]: CPU 3: Machine Check: 0 Bank 17: 
d42040000000011b
[5154053.141948] mce: [Hardware Error]: TSC 0 ADDR b3cbdbbc0 PPIN 
2b615bef7f48098 SYND 6bd210000a801002 IPID 9600650f00
[5154053.152893] mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 
1679213602 SOCKET 0 APIC 6 microcode a001173
[5608214.292978] mce: [Hardware Error]: Machine check events logged
[5608214.299771] mce: [Hardware Error]: CPU 3: Machine Check: 0 Bank 17: 
d42040000000011b
[5608214.308066] mce: [Hardware Error]: TSC 0 ADDR b3cbdbbc0 PPIN 
2b615bef7f48098 SYND 6bd210000a801002 IPID 9600650f00
[5608214.319102] mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 
1679667766 SOCKET 0 APIC 6 microcode a001173
[5707500.646385] mce: [Hardware Error]: Machine check events logged
[5707500.652973] mce: [Hardware Error]: CPU 3: Machine Check: 0 Bank 17: 
d42041000000011b
[5707500.661238] mce: [Hardware Error]: TSC 0 ADDR b3cbdbbc0 PPIN 
2b615bef7f48098 SYND 6bd210000a801002 IPID 9600650f00
[5707500.672271] mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 
1679767053 SOCKET 0 APIC 6 microcode a001173
[5810063.788078] mce: [Hardware Error]: Machine check events logged
[5810063.794698] mce: [Hardware Error]: CPU 3: Machine Check: 0 Bank 17: 
d42041000000011b
[5810063.803126] mce: [Hardware Error]: TSC 0 ADDR b3cbdbbc0 PPIN 
2b615bef7f48098 SYND 6bd210000a801002 IPID 9600650f00
[5810063.814264] mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 
1679869617 SOCKET 0 APIC 6 microcode a001173
```

Does GNU/Linux offer a way to decode this automatically?


Kind regards,

Paul


PS:

```
$ lscpu
Architecture:            x86_64
   CPU op-mode(s):        32-bit, 64-bit
   Address sizes:         48 bits physical, 48 bits virtual
   Byte Order:            Little Endian
CPU(s):                  256
   On-line CPU(s) list:   0-255
Vendor ID:               AuthenticAMD
   Model name:            AMD EPYC 7763 64-Core Processor
     CPU family:          25
     Model:               1
     Thread(s) per core:  2
     Core(s) per socket:  64
     Socket(s):           2
     Stepping:            1
     Frequency boost:     enabled
     CPU max MHz:         3529.0520
     CPU min MHz:         1500.0000
     BogoMIPS:            4890.81
     Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep 
mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx 
mmxext fxsr_o
                          pt pdpe1gb rdtscp lm constant_tsc rep_good 
nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor 
ssse3 fma
                           cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt 
aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm 
sse4a mi
                          salignsse 3dnowprefetch osvw ibs skinit wdt 
tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 
cdp_l3 in
                          vpcid_single hw_pstate ssbd mba ibrs ibpb 
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 invpcid cqm rdt_a rdseed adx 
smap clflus
                          hopt clwb sha_ni xsaveopt xsavec xgetbv1 
xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf 
xsaveerptr rd
                          pru wbnoinvd amd_ppin arat npt lbrv svm_lock 
nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter 
pfthreshold
                           v_vmsave_vmload vgif v_spec_ctrl umip pku 
ospke vaes vpclmulqdq rdpid overflow_recov succor smca
Virtualization features:
   Virtualization:        AMD-V
Caches (sum of all):
   L1d:                   4 MiB (128 instances)
   L1i:                   4 MiB (128 instances)
   L2:                    64 MiB (128 instances)
   L3:                    512 MiB (16 instances)
NUMA:
   NUMA node(s):          8
   NUMA node0 CPU(s):     0-15,128-143
   NUMA node1 CPU(s):     16-31,144-159
   NUMA node2 CPU(s):     32-47,160-175
   NUMA node3 CPU(s):     48-63,176-191
   NUMA node4 CPU(s):     64-79,192-207
   NUMA node5 CPU(s):     80-95,208-223
   NUMA node6 CPU(s):     96-111,224-239
   NUMA node7 CPU(s):     112-127,240-255
Vulnerabilities:
   Itlb multihit:         Not affected
   L1tf:                  Not affected
   Mds:                   Not affected
   Meltdown:              Not affected
   Mmio stale data:       Not affected
   Retbleed:              Not affected
   Spec store bypass:     Mitigation; Speculative Store Bypass disabled 
via prctl and seccomp
   Spectre v1:            Mitigation; usercopy/swapgs barriers and 
__user pointer sanitization
   Spectre v2:            Mitigation; Retpolines, IBPB conditional, 
IBRS_FW, STIBP always-on, RSB filling, PBRSB-eIBRS Not affected
   Srbds:                 Not affected
   Tsx async abort:       Not affected
```
