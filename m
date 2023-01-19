Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D0A672F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjASDLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjASDKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:10:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D055D5974A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:10:07 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J0xD67026187;
        Thu, 19 Jan 2023 03:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AxCd/tGfdAUukxKYoUvez6+rwBG5VJlhtV1vA+3JmQ0=;
 b=U7qDSdP2WSKkVuOcpHt+9rluNdva6S4KowuZyp2JiWtnb9jkrR5t4jRX4VD3xVsNSvJ+
 lBkhi8KNCVpRTA77FTdE8/JfMMXSPD0oi14tyjAJzqgztHq2HCKnqlKmd9xAUfN9fw1V
 7zWhcump1ultkDNGFDZtjsIsDDQYOqxxyP4HNAQuBqktzfTfguB8D8bXzc2BDCuABmhH
 2u8rdtqrQF3GxTIyPRpjwpVsrekY3TCrKcW4WGfTNgEhudSvUF1YAJfCRKL15Pj8NYva
 +n4khYhiV/YwLvXbrQyqVbI8YvJBt1qmvSp5oTjJ1HCZMAkmvsHE/+RIZc7xzcaVyKXp YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6j23gpvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 03:09:31 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30J2pXJY019126;
        Thu, 19 Jan 2023 03:09:31 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6j23gpvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 03:09:30 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30I6aPIc007521;
        Thu, 19 Jan 2023 03:09:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n3m16me6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 03:09:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30J39Qma46399872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 03:09:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 517CE20040;
        Thu, 19 Jan 2023 03:09:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D5042004B;
        Thu, 19 Jan 2023 03:09:22 +0000 (GMT)
Received: from [9.43.78.165] (unknown [9.43.78.165])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 03:09:22 +0000 (GMT)
Message-ID: <c698ef14-1151-594b-2e63-7ec4bd91d318@linux.ibm.com>
Date:   Thu, 19 Jan 2023 08:39:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-2-eric.devolder@oracle.com>
 <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
 <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nubomwF2PdTjnsfyYjY7Il4AknAk-Ntq
X-Proofpoint-ORIG-GUID: UraENucsSKNdsICQ1jfC93kg8NwytkcG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/01/23 22:53, Eric DeVolder wrote:
>
>
> On 1/8/23 23:05, Sourabh Jain wrote:
>>
>> On 09/12/22 21:06, Eric DeVolder wrote:
>>> At the outcome of this patch set, the crash_prepare_elf64_headers()
>>> is utilized on both the kexec_file_load() and kexec_load() paths. As
>>> such, need to move this function out of kexec_file.c and into a
>>> common location crash_core.c.
>>>
>>> No functionality change.
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> Acked-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>   kernel/crash_core.c | 100 
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>   kernel/kexec_file.c |  99 -------------------------------------------
>>>   2 files changed, 100 insertions(+), 99 deletions(-)
>>>
>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>> index a0eb4d5cf557..46c160d14045 100644
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -10,6 +10,7 @@
>>>   #include <linux/utsname.h>
>>>   #include <linux/vmalloc.h>
>>>   #include <linux/sizes.h>
>>> +#include <linux/kexec.h>
>>>   #include <asm/page.h>
>>>   #include <asm/sections.h>
>>> @@ -314,6 +315,105 @@ static int __init parse_crashkernel_dummy(char 
>>> *arg)
>>>   }
>>>   early_param("crashkernel", parse_crashkernel_dummy);
>>> +int crash_prepare_elf64_headers(struct crash_mem *mem, int 
>>> need_kernel_map,
>>> +              void **addr, unsigned long *sz)
>>> +{
>>> +    Elf64_Ehdr *ehdr;
>>> +    Elf64_Phdr *phdr;
>>> +    unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
>>> +    unsigned char *buf;
>>> +    unsigned int cpu, i;
>>> +    unsigned long long notes_addr;
>>> +    unsigned long mstart, mend;
>>> +
>>> +    /* extra phdr for vmcoreinfo ELF note */
>>> +    nr_phdr = nr_cpus + 1;
>>> +    nr_phdr += mem->nr_ranges;
>>> +
>>> +    /*
>>> +     * kexec-tools creates an extra PT_LOAD phdr for kernel text 
>>> mapping
>>> +     * area (for example, ffffffff80000000 - ffffffffa0000000 on 
>>> x86_64).
>>> +     * I think this is required by tools like gdb. So same physical
>>> +     * memory will be mapped in two ELF headers. One will contain 
>>> kernel
>>> +     * text virtual addresses and other will have __va(physical) 
>>> addresses.
>>> +     */
>>> +
>>> +    nr_phdr++;
>>> +    elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
>>> +    elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>> Seems like above function is out of CONFIG_KEXEC_FILE but some of the
>> structure/attributes like crash_mem and ELF_CORE_HEADER_ALIGN are
>> still defined under CONFIG_KEXEC_FILE (look for include/linux/kexec.h).
>>
>> This leads to kernel build issue when CONFIG_KEXEC_FILE is disabled.
>>
>> Thanks,
>> Sourabh Jain
>
> After looking into this for a bit, to allow hotplug without kexec_file 
> would require quite a bit of code movement. Why? Because hotplug is 
> basically built on top of (part of) the infrastructure that was needed 
> for kexec_file.
>
> I'd be inclined to suggest that KEXEC_FILE be a required dependency 
> for CRASH_HOTPLUG, ie:

Since kexec_load is deprecated I don't see any harm in doing that.

- Sourabh Jain
