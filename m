Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C4709C79
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjESQbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjESQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:31:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E84CA;
        Fri, 19 May 2023 09:31:13 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JBfjsB011872;
        Fri, 19 May 2023 16:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yZ+c8uZcJrlAlno5FxTnPElzATRQ31IF/+qQxmh4X7Y=;
 b=JXYLKwcI2GbfAQOyp3pqNSg6DjU0Y7APV0UkqvAq+7mPhE6jU2niZ2R4O5GEnV8Jv3vY
 GKGhPl9R8u8z9GTQRJNoPGaU+0mzwGn4MRHzlqrkBUJqPBmbmvIdtKopPW+l45x2R2N4
 N53tfhOYno5CyDkZBijlZR00Ad7cvVpDEdEpXoDABtsI85/Pq3Lm9EQeADaOgh7BPKhU
 vCAzv/tTJH7NrLUDiiqElo6FSx31LTwIxiOoWrGKsGUnDbsEy4Z69PrEn6OpGxkbbO+u
 mhtvqcavuyOXh7qnKKh25rs7jG7FJgFRefJwgVrMfeYuSSMcB+UmlbDChCuJ2ha23dwu fw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp4ccs7tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 16:29:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JGSxwm014994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 16:28:59 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 09:28:57 -0700
Message-ID: <16562305-3bc0-c69f-0cb5-1b9da1014f19@quicinc.com>
Date:   Fri, 19 May 2023 10:28:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [patch V4 36/37] x86/smpboot: Support parallel startup of
 secondary CPUs
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     <x86@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <xen-devel@lists.xenproject.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        <linux-csky@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, <linux-parisc@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20230512203426.452963764@linutronix.de>
 <20230512205257.411554373@linutronix.de>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230512205257.411554373@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l2X6Bcn3k_Nws-GO_lVKOQ5EQSj3BbaM
X-Proofpoint-ORIG-GUID: l2X6Bcn3k_Nws-GO_lVKOQ5EQSj3BbaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190140
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/2023 3:07 PM, Thomas Gleixner wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> In parallel startup mode the APs are kicked alive by the control CPU
> quickly after each other and run through the early startup code in
> parallel. The real-mode startup code is already serialized with a
> bit-spinlock to protect the real-mode stack.
> 
> In parallel startup mode the smpboot_control variable obviously cannot
> contain the Linux CPU number so the APs have to determine their Linux CPU
> number on their own. This is required to find the CPUs per CPU offset in
> order to find the idle task stack and other per CPU data.
> 
> To achieve this, export the cpuid_to_apicid[] array so that each AP can
> find its own CPU number by searching therein based on its APIC ID.
> 
> Introduce a flag in the top bits of smpboot_control which indicates that
> the AP should find its CPU number by reading the APIC ID from the APIC.
> 
> This is required because CPUID based APIC ID retrieval can only provide the
> initial APIC ID, which might have been overruled by the firmware. Some AMD
> APUs come up with APIC ID = initial APIC ID + 0x10, so the APIC ID to CPU
> number lookup would fail miserably if based on CPUID. Also virtualization
> can make its own APIC ID assignements. The only requirement is that the
> APIC IDs are consistent with the APCI/MADT table.
> 
> For the boot CPU or in case parallel bringup is disabled the control bits
> are empty and the CPU number is directly available in bit 0-23 of
> smpboot_control.
> 
> [ tglx: Initial proof of concept patch with bitlock and APIC ID lookup ]
> [ dwmw2: Rework and testing, commit message, CPUID 0x1 and CPU0 support ]
> [ seanc: Fix stray override of initial_gs in common_cpu_up() ]
> [ Oleksandr Natalenko: reported suspend/resume issue fixed in
>    x86_acpi_suspend_lowlevel ]
> [ tglx: Make it read the APIC ID from the APIC instead of using CPUID,
>    	split the bitlock part out ]
> 
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Co-developed-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Michael Kelley <mikelley@microsoft.com>
> ---

I pulled in this change via the next tree, tag next-20230519 and I get a 
build failure using the x86_64_defconfig -

   DESCEND objtool
   INSTALL libsubcmd_headers
   CALL    scripts/checksyscalls.sh
   AS      arch/x86/kernel/head_64.o
arch/x86/kernel/head_64.S: Assembler messages:
arch/x86/kernel/head_64.S:261: Error: missing ')'
arch/x86/kernel/head_64.S:261: Error: junk `UL<<10)' after expression
   CC      arch/x86/kernel/head64.o
   CC      arch/x86/kernel/ebda.o
   CC      arch/x86/kernel/platform-quirks.o
scripts/Makefile.build:374: recipe for target 
'arch/x86/kernel/head_64.o' failed
make[3]: *** [arch/x86/kernel/head_64.o] Error 1
make[3]: *** Waiting for unfinished jobs....
scripts/Makefile.build:494: recipe for target 'arch/x86/kernel' failed
make[2]: *** [arch/x86/kernel] Error 2
scripts/Makefile.build:494: recipe for target 'arch/x86' failed
make[1]: *** [arch/x86] Error 2
make[1]: *** Waiting for unfinished jobs....
Makefile:2026: recipe for target '.' failed
make: *** [.] Error 2

This is with GCC 5.4.0, if it matters.

Reverting this change allows the build to move forward, although I also 
need to revert "x86/smpboot/64: Implement 
arch_cpuhp_init_parallel_bringup() and enable it" for the build to fully 
succeed.

I'm not familiar with this code, and nothing obvious stands out to me. 
What can I do to help root cause this?

-Jeff
