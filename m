Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4954D63DA40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiK3QK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiK3QKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:10:52 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E96384DD7;
        Wed, 30 Nov 2022 08:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1669824647; x=1701360647;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=0mlIFYiGzcmnF4ANRP+d5+8eu+s9EbbdJXDr2otTJLw=;
  b=fSYCNNh0Pu0zGDq7WnmLCeUajlLjuLSKXj6ikATlF65K1dMkmzBUZfW/
   roGBjmgNVvCnS8WTpY/f3cdo1LVISlAz2Qc3dapXSND/6dXDriXuHDav0
   qVTmN8YRey1wQYgyAz3Bukj7NrrBiQChdSLgV3pb/RPLstNQ+E5Q1I1Du
   Y=;
X-IronPort-AV: E=Sophos;i="5.96,206,1665446400"; 
   d="scan'208";a="156449488"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:10:47 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 5A0E6610BE;
        Wed, 30 Nov 2022 16:10:46 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 30 Nov 2022 16:10:45 +0000
Received: from [192.168.21.241] (10.43.162.134) by
 EX19D002UWC004.ant.amazon.com (10.13.138.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.20;
 Wed, 30 Nov 2022 16:10:45 +0000
Message-ID: <9b23e9d4-7c7a-a74f-3a6b-939a4a469c2b@amazon.com>
Date:   Wed, 30 Nov 2022 08:10:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Content-Language: en-US
To:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <lenb@kernel.org>
CC:     <surajjs@amazon.com>
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
Subject: Using nr_cpus breaks no_turbo setting of pstate driver
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D35UWB004.ant.amazon.com (10.43.161.230) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Having some issue with my mails failing to deliver. So trying once 
again after disabling HTML."


Hi Srinivas/Len,


I have been doing some testing on m5zn.metal AWS instances which 
provides 48 vcpus and 192GB memory.

Test includes loading all cpus with maximum capacity (using stress) and 
observing the frequency after enabling and disabling turbo frequencies. 
Intel_pstate is enabled with hwp.


lscpu output for reference:

*# lscpu*
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              48
On-line CPU(s) list: 0-47
Thread(s) per core:  2
Core(s) per socket:  12
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               85
Model name:          Intel(R) Xeon(R) Platinum 8252C CPU @ 3.80GHz
Stepping:            7
CPU MHz:             3800.000
CPU max MHz:         4500.0000
CPU min MHz:         1200.0000
BogoMIPS:            7600.00
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            1024K
L3 cache:            25344K
NUMA node0 CPU(s):   0-11,24-35
NUMA node1 CPU(s):   12-23,36-47
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe 
syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts 
rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq 
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid 
dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx 
f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 
invpcid_single intel_ppin ssbd mba ibrs ibpb stibp ibrs_enhanced 
tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 
avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx 
smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec 
xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm 
ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req pku ospke 
avx512_vnni md_clear flush_l1d arch_capabilities

When testing with all cpus online I don't see any issue. CPUs reach 
turbo frequency when intel_pstate/no_turbo is disabled and stay below 
turbo frequencies when no_turbo is enabled as expected.

However, issue occurs when I boot with nr_cpus argument specifying less 
than 48 cpus. e.g. cmdline:


*/# cat /proc/cmdline/*/
/mmio_stale_data=off mds=off tsx=off tsx_async_abort=off 
intel_idle.max_cstate=0 
BOOT_IMAGE=/boot/vmlinuz-5.10.154-119.671.amzn2.x86_64 
root=UUID=d8605abb-d6cd-4a46-a657-b6bd206da2ab ro console=tty0 
console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 
nvme_core.io_timeout=4294967295 rd.emergency=poweroff 
rd.shell=0*nr_cpus=24 intel_idle.max_cstate=1 processor.max_cstate=1*

# echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
# turbostat


^CPackage       Core CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz IRQ     
SMI     POLL C1      POLL%   C1%     CPU%c1  CPU%c6  CoreTmp PkgTmp  
Pkg%pc2 Pkg%pc6 PkgWatt RAMWatt PKG_%   RAM_%
-       -       -       4370    99.76   4381    3800    6374 0       
0       0       0.00    0.00    0.24    0.00    96 96      0.00    
0.00    479.79  69.20   0.00    0.00
0       0       0       4292    99.93   4295    3800    266 0       
0       0       0.00    0.00    0.07    0.00    88 96      0.00    
0.00    239.89  33.62   0.00    0.00
0       2       1       4292    99.92   4295    3800    270 0       
0       0       0.00    0.00    0.08    0.00    92
0       4       2       4292    99.92   4295    3800    264 0       
0       0       0.00    0.00    0.08    0.00    92
0       8       3       4292    99.93   4295    3800    268 0       
0       0       0.00    0.00    0.07    0.00    90
0       9       4       4292    99.93   4295    3800    264 0       
0       0       0.00    0.00    0.07    0.00    91
0       10      5       4292    99.92   4295    3800    264 0       
0       0       0.00    0.00    0.08    0.00    92
0       11      6       4292    99.92   4295    3800    265 0       
0       0       0.00    0.00    0.08    0.00    96
0       17      7       4292    99.93   4295    3800    266 0       
0       0       0.00    0.00    0.07    0.00    91
0       19      8       4292    99.93   4295    3800    266 0       
0       0       0.00    0.00    0.07    0.00    91
0       25      9       4292    99.92   4295    3800    264 0       
0       0       0.00    0.00    0.08    0.00    91
0       26      10      4292    99.92   4295    3800    264 0       
0       0       0.00    0.00    0.08    0.00    93
0       27      11      4292    99.92   4295    3800    264 0       
0       0       0.00    0.00    0.08    0.00    94
1       1       12      4449    99.61   4466    3800    264 0       
0       0       0.00    0.00    0.39    0.00    80 88      0.00    
0.00    239.90  35.58   0.00    0.00
1       2       13      4448    99.60   4466    3800    264 0       
0       0       0.00    0.00    0.40    0.00    86
1       3       14      4449    99.61   4466    3800    267 0       
0       0       0.00    0.00    0.39    0.00    81
1       8       15      4449    99.61   4466    3800    264 0       
0       0       0.00    0.00    0.39    0.00    79
1       9       16      4448    99.60   4466    3800    264 0       
0       0       0.00    0.00    0.40    0.00    79
1       10      17      4449    99.61   4466    3800    264 0       
0       0       0.00    0.00    0.39    0.00    83
1       17      18      4448    99.60   4466    3800    264 0       
0       0       0.00    0.00    0.40    0.00    82
1       18      19      4449    99.61   4466    3800    281 0       
0       0       0.00    0.00    0.39    0.00    80
1       19      20      4449    99.61   4466    3800    264 0       
0       0       0.00    0.00    0.39    0.00    83
1       20      21      4448    99.59   4466    3800    264 0       
0       0       0.00    0.00    0.41    0.00    83
1       25      22      4448    99.60   4466    3800    264 0       
0       0       0.00    0.00    0.40    0.00    81
1       27      23      4448    99.59   4466    3800    265 0       
0       0       0.00    0.00    0.41    0.00    88

/
/

As part of the turbostat output I could see that pstate driver is 
setting the hints correctly in MSR_HWP_REQUEST. But somehow these limits 
are not being honored by HWP logic.


cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
cpu0: MSR_HWP_CAPABILITIES: 0x070c262d (high 45 guar 38 eff 12 low 7)
*cpu0: MSR_HWP_REQUEST: 0x00002626 (min 38 max 38 des 0 epp 0x0 window 
0x0 pkg 0x0)*
cpu0: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 
window 0x0)
cpu0: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, 
No-Excursion_Min)

I tried the same experiment after disabling hwp by 
specifying*intel_pstate=no_hwp*in cmdline. In this case the pstate 
driver seems to be selecting pstates correctly.

^CPackage       Core CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz IRQ     
SMI     POLL C1      POLL%   C1%     CPU%c1  CPU%c6  CoreTmp PkgTmp  
Pkg%pc2 Pkg%pc6 PkgWatt RAMWatt PKG_%   RAM_%
-       -       -       3800    100.00  3800    3800    1646 0       
0       0       0.00    0.00    0.00    0.00    85 85      0.00    
0.00    328.38  62.14   0.00    0.00
0       0       0       3800    100.00  3800    3800    66 0       
0       0       0.00    0.00    0.00    0.00    85 85      0.00    
0.00    175.42  36.96   0.00    0.00
0       0       24      3800    100.00  3800    3800    70 0       
0       0       0.00    0.00    0.00
0       1       1       3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    82
0       2       2       3800    100.00  3800    3800    67 0       
0       0       0.00    0.00    0.00    0.00    84
0       3       3       3800    100.00  3800    3800    67 0       
0       0       0.00    0.00    0.00    0.00    83
0       4       4       3800    100.00  3800    3800    68 0       
0       0       0.00    0.00    0.00    0.00    85
0       8       5       3800    100.00  3800    3800    68 0       
0       0       0.00    0.00    0.00    0.00    83
0       9       6       3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    85
0       10      7       3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    82
0       11      8       3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    84
0       17      9       3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    83
0       18      10      3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    83
0       27      11      3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    85
1       0       12      3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    66 68      0.00    
0.00    152.95  25.18   0.00    0.00
1       2       13      3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    65
1       4       14      3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    68
1       8       15      3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    63
1       9       16      3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    65
1       10      17      3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    64
1       17      18      3800    100.00  3800    3800    66 0       
0       0       0.00    0.00    0.00    0.00    63
1       18      19      3800    100.00  3800    3800    66 0       
0       0       0.00    0.00    0.00    0.00    63
1       19      20      3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    63
1       20      21      3800    100.00  3800    3800    66 0       
0       0       0.00    0.00    0.00    0.00    66
1       25      22      3800    100.00  3800    3800    65 0       
0       0       0.00    0.00    0.00    0.00    64
1       27      23      3800    100.00  3800    3800    67 0       
0       0       0.00    0.00    0.00    0.00    67

[root@ip-172-31-36-94 ec2-user]# cat 
/sys/devices/system/cpu/intel_pstate/no_turbo
1


Thanks,
Rishabh

