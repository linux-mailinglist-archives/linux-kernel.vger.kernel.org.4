Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF54C715787
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjE3HsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjE3Hrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:47:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92140F3;
        Tue, 30 May 2023 00:47:06 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U7TchY016713;
        Tue, 30 May 2023 07:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZpcHDZDWblUj44cxQI7N7BsV6xz7H1WgFRESaho8JCY=;
 b=EpnrpQaKOmEvmU2I7k3NI1OaaOiN5tZY+yuWcLuY0W6GVSh1xZlo+1tNOZtc/wiPT+YU
 qahGi6YGlRhmlyAmmOTcsw/o0S3CGptDX6lESXARY58ooacRGSpGayBKS2w7sEw3O/MB
 a2Nqtu+cRAUrViIja2z/HjwPSwsXlUKF1VqB22V58Ffi/9YV9/YHUfSyrWjyVjsKPUgv
 tn53aHHApffzJcZQ3wWlD5LzDNy7VEGj8Fqh9zHcUmYrSkEr7y8WCdSkjbHJedlGr/hA
 Jc6XgcIaIU65HDKU1CULypkYxfCZHjngKeytPA9rsRRqwyMmzuP8SmjUG0sh1mbyG7yT PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwct70fjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 07:45:06 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34U7TlDF017442;
        Tue, 30 May 2023 07:45:05 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwct70fh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 07:45:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U5TfSi021888;
        Tue, 30 May 2023 07:45:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g59b8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 07:45:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34U7j0s84981390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 07:45:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2D0B20043;
        Tue, 30 May 2023 07:45:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F26320040;
        Tue, 30 May 2023 07:45:00 +0000 (GMT)
Received: from [9.152.212.239] (unknown [9.152.212.239])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 07:45:00 +0000 (GMT)
Message-ID: <0075d8a9-2df4-86eb-8171-8995f59904e0@linux.ibm.com>
Date:   Tue, 30 May 2023 09:45:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
To:     Marc Zyngier <maz@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Nathan Chancellor <nathan@kernel.org>, namhyung@kernel.org,
        eranian@google.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, bp@alien8.de, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, kvmarm@lists.linux.dev
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-4-ravi.bangoria@amd.com>
 <20230524214133.GA2359762@dev-arch.thelio-3990X>
 <f02c78e2-34b9-4985-640a-279dae1004a9@amd.com> <ZG8KLbZSECiYaKFc@linux.dev>
 <20230525142031.GU83892@hirez.programming.kicks-ass.net>
 <ZG+FLdP2kkfI1m2Z@linux.dev>
 <CAP-5=fWYbzmTETgqJ11y22=JaXDM0gnb4qR6KYeRGmFXw08f-Q@mail.gmail.com>
 <86jzwtdhmk.wl-maz@kernel.org>
 <CAP-5=fVW6KbUbbEfF3mEFvTfFDC5yKSjSpa+w3D55dG3CNUERw@mail.gmail.com>
 <86h6rxd3gh.wl-maz@kernel.org>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <86h6rxd3gh.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ppNikiQ3tamMC7fotzsEoqutl8Y94htH
X-Proofpoint-ORIG-GUID: 5mdJ7FG5-E7JpA2pmsw4ejsREHtyfAnA
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_04,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/23 20:38, Marc Zyngier wrote:
> On Sat, 27 May 2023 18:00:13 +0100,
> Ian Rogers <irogers@google.com> wrote:
>>
>> On Sat, May 27, 2023 at 6:32 AM Marc Zyngier <maz@kernel.org> wrote:
>>>
>>> On Sat, 27 May 2023 00:00:47 +0100,
>>> Ian Rogers <irogers@google.com> wrote:
>>>>
>>>> On Thu, May 25, 2023 at 8:56 AM Oliver Upton <oliver.upton@linux.dev> wrote:
>>>>>
>>>>> On Thu, May 25, 2023 at 04:20:31PM +0200, Peter Zijlstra wrote:
>>>>>> On Thu, May 25, 2023 at 07:11:41AM +0000, Oliver Upton wrote:
>>>>>>
>>>>>>> The PMUv3 driver does pass a name, but it relies on getting back an
>>>>>>> allocated pmu id as @type is -1 in the call to perf_pmu_register().
>>>>>>>
>>>>>>> What actually broke is how KVM probes for a default core PMU to use for
>>>>>>> a guest. kvm_pmu_probe_armpmu() creates a counter w/ PERF_TYPE_RAW and
>>>>>>> reads the pmu from the returned perf_event. The linear search had the
>>>>>>> effect of eventually stumbling on the correct core PMU and succeeding.
>>>>>>>
>>>>>>> Perf folks: is this WAI for heterogenous systems?
>>>>>>
>>>>>> TBH, I'm not sure. hetero and virt don't mix very well AFAIK and I'm not
>>>>>> sure what ARM64 does here.
>>>>>>
>>>>>> IIRC the only way is to hard affine things; that is, force vCPU of
>>>>>> 'type' to the pCPU mask of 'type' CPUs.
>>>>>
>>>>> We provide absolutely no illusion of consistency across implementations.
>>>>> Userspace can select the PMU type, and then it is a userspace problem
>>>>> affining vCPUs to the right pCPUs.
>>>>>
>>>>> And if they get that wrong, we just bail and refuse to run the vCPU.
>>>>>
>>>>>> If you don't do that; or let userspace 'override' that, things go
>>>>>> sideways *real* fast.
>>>>>
>>>>> Oh yeah, and I wish PMUs were the only problem with these hetero
>>>>> systems...
>>>>
>>>> Just to add some context from what I understand. There are inbuilt
>>>> type numbers for PMUs:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/include/uapi/linux/perf_event.h?h=perf-tools-next#n34
>>>> so the PMU generally called /sys/devices/cpu should have type 4 (ARM
>>>> give it another name). For heterogeneous ARM there is a single PMU and
>>>> the same events are programmed regardless of whether it is a big or a
>>>> little core - the cpumask lists all CPUs.
>>>
>>> I think you misunderstood the way heterogeneous arm64 systems are
>>> described . Each CPU type gets its own PMU type, and its own event
>>> list. Case in point:
>>>
>>> $ grep . /sys/devices/*pmu/{type,cpus}
>>> /sys/devices/apple_avalanche_pmu/type:9
>>> /sys/devices/apple_blizzard_pmu/type:8
>>> /sys/devices/apple_avalanche_pmu/cpus:4-9
>>> /sys/devices/apple_blizzard_pmu/cpus:0-3
>>>
>>> Type 4 (aka PERF_EVENT_RAW) is AFAICT just a way to encode the raw
>>> event number, nothing else.
>>
>> Which PMU will a raw event open on?
> 
> On the PMU that matches the current CPU.
> 
>> Note, the raw events don't support
>> the extended type that is present in PERF_TYPE_HARDWARE and
>> PERF_TYPE_HW_CACHE:
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/include/uapi/linux/perf_event.h#n41
>> as the bits are already in use for being just plain config values.
> 
> I'm not sure how relevant this is to the numbering of PMUs on arm64.
> 
>> I suspect not being type 4 is a bug on apple ARM here.
> 
> If that's a bug on this machine, it's a bug on all machines, at which
> point it is the de-facto API:
> 
> $ grep . /sys/devices/armv8*/{type,cpus}
> /sys/devices/armv8_cortex_a53/type:8
> /sys/devices/armv8_cortex_a72/type:9
> /sys/devices/armv8_cortex_a53/cpus:0-3
> /sys/devices/armv8_cortex_a72/cpus:4-5
> 
> See, non-Apple HW. And now for a system with homogeneous CPUs:
> 
> $ grep . /sys/devices/armv8*/{type,cpus}
> /sys/devices/armv8_pmuv3_0/type:8
> /sys/devices/armv8_pmuv3_0/cpus:0-159
> 
> Still no type 4. I could go on for hours, I have plenty of HW around
> me!
> 
> So whatever your source of information is, it doesn't match reality.
> Our PMUs are numbered arbitrarily, and have been so for... a very long
> time. At least since perf_pmu_register has supported dynamic
> registration (see 2e80a82a49c4c).
> 
> Thanks,
> 
> 	M.
> 


I agree with Marc,
on s390 we have 5 different PMUs and all have arbitrary numbers
and have totally different features:

# ll /sys/devices/{cpum,pai}*/type
-r--r--r-- 1 root root 4096 May 30 09:33 /sys/devices/cpum_cf_diag/type
-r--r--r-- 1 root root 4096 May 30 09:33 /sys/devices/cpum_cf/type
-r--r--r-- 1 root root 4096 May 30 09:33 /sys/devices/cpum_sf/type
-r--r--r-- 1 root root 4096 May 30 09:33 /sys/devices/pai_crypto/type
-r--r--r-- 1 root root 4096 May 30 09:33 /sys/devices/pai_ext/type
# grep . /sys/devices/{cpum,pai}*/type
/sys/devices/cpum_cf_diag/type:9
/sys/devices/cpum_cf/type:8
/sys/devices/cpum_sf/type:4
/sys/devices/pai_crypto/type:10
/sys/devices/pai_ext/type:11
# 

Thanks Thomas
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

