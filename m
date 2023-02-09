Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F54691081
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBISny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBISnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:43:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4A84902D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:43:51 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319IFItu027092;
        Thu, 9 Feb 2023 18:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CbeDSGRGITgYPWKV/a/L7ZMG0+7RL3Ck2IccPPZsZB4=;
 b=bl5FUS17HBdsEsdeZDfCVoBMpOGH9rqS3EtjN0bEmFVHqPsqXhh8iZ0uLIzZNACCmqve
 czuXlKLp987Um0DR4CeKvJKPW8eS9zKhEDjo0qF451ccV317VLzg3kh/Or37hvtzDu90
 zaFGb8RFzSDgul+SA4LGoRycEplJNMuwHDsYADGzPJ4rnyCDBUfnbVYryVu+Yb+2OBGk
 IbfwY9GylJockHQctgIObPn/LTQw4VCj8qjeN/v7sDmQd6hYXaytEmB42OEG5BClMRLo
 uGv3p0ECEyKJSMhPhtg6x60ut9IZsZO4suPobqcjNmwKyqU2FJcfvLm8rLwuMxZkBzFq sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn5xtruxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 18:43:13 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 319INVHl027357;
        Thu, 9 Feb 2023 18:43:12 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn5xtrux4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 18:43:12 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319Hoe8U011173;
        Thu, 9 Feb 2023 18:43:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3nhf06vns1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 18:43:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 319Ih7NW49938688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 18:43:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6259D20040;
        Thu,  9 Feb 2023 18:43:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F16620043;
        Thu,  9 Feb 2023 18:43:02 +0000 (GMT)
Received: from [9.43.118.216] (unknown [9.43.118.216])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Feb 2023 18:43:01 +0000 (GMT)
Message-ID: <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
Date:   Fri, 10 Feb 2023 00:13:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
Content-Language: en-US
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qdDpszezIS5EbmhA72goeZYtIaqtY0Q0
X-Proofpoint-ORIG-GUID: IDLYTDlY6iOI64r9nJQL2lJoyqID8yCE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090174
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On 09/02/23 23:01, Eric DeVolder wrote:
>
>
> On 2/8/23 07:44, Thomas Gleixner wrote:
>> Eric!
>>
>> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>>
>>> So my latest solution is introduce two new CPUHP states, 
>>> CPUHP_AP_ELFCOREHDR_ONLINE
>>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. I'm open 
>>> to better names.
>>>
>>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after 
>>> CPUHP_BRINGUP_CPU. My
>>> attempts at locating this state failed when inside the STARTING 
>>> section, so I located
>>> this just inside the ONLINE sectoin. The crash hotplug handler is 
>>> registered on
>>> this state as the callback for the .startup method.
>>>
>>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before 
>>> CPUHP_TEARDOWN_CPU, and I
>>> placed it at the end of the PREPARE section. This crash hotplug 
>>> handler is also
>>> registered on this state as the callback for the .teardown method.
>>
>> TBH, that's still overengineered. Something like this:
>>
>> bool cpu_is_alive(unsigned int cpu)
>> {
>>     struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>
>>     return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
>> }
>>
>> and use this to query the actual state at crash time. That spares all
>> those callback heuristics.
>>
>>> I'm making my way though percpu crash_notes, elfcorehdr, vmcoreinfo,
>>> makedumpfile and (the consumer of it all) the userspace crash utility,
>>> in order to understand the impact of moving from for_each_present_cpu()
>>> to for_each_online_cpu().
>>
>> Is the packing actually worth the trouble? What's the actual win?
>>
>> Thanks,
>>
>>          tglx
>>
>>
>
> Thomas,
> I've investigated the passing of crash notes through the vmcore. What 
> I've learned is that:
>
> - linux/fs/proc/vmcore.c (which makedumpfile references to do its job) 
> does
>   not care what the contents of cpu PT_NOTES are, but it does coalesce 
> them together.
>
> - makedumpfile will count the number of cpu PT_NOTES in order to 
> determine its
>   nr_cpus variable, which is reported in a header, but otherwise 
> unused (except
>   for sadump method).
>
> - the crash utility, for the purposes of determining the cpus, does 
> not appear to
>   reference the elfcorehdr PT_NOTEs. Instead it locates the various
>   cpu_[possible|present|online]_mask and computes nr_cpus from that, 
> and also of
>   course which are online. In addition, when crash does reference the 
> cpu PT_NOTE,
>   to get its prstatus, it does so by using a percpu technique directly 
> in the vmcore
>   image memory, not via the ELF structure. Said differently, it 
> appears to me that
>   crash utility doesn't rely on the ELF PT_NOTEs for cpus; rather it 
> obtains them
>   via kernel cpumasks and the memory within the vmcore.
>
> With this understanding, I did some testing. Perhaps the most telling 
> test was that I
> changed the number of cpu PT_NOTEs emitted in the 
> crash_prepare_elf64_headers() to just 1,
> hot plugged some cpus, then also took a few offline sparsely via 
> chcpu, then generated a
> vmcore. The crash utility had no problem loading the vmcore, it 
> reported the proper number
> of cpus and the number offline (despite only one cpu PT_NOTE), and 
> changing to a different
> cpu via 'set -c 30' and the backtrace was completely valid.
>
> My take away is that crash utility does not rely upon ELF cpu 
> PT_NOTEs, it obtains the
> cpu information directly from kernel data structures. Perhaps at one 
> time crash relied
> upon the ELF information, but no more. (Perhaps there are other crash 
> dump analyzers
> that might rely on the ELF info?)
>
> So, all this to say that I see no need to change 
> crash_prepare_elf64_headers(). There
> is no compelling reason to move away from for_each_present_cpu(), or 
> modify the list for
> online/offline.
>
> Which then leaves the topic of the cpuhp state on which to register. 
> Perhaps reverting
> back to the use of CPUHP_BP_PREPARE_DYN is the right answer. There 
> does not appear to
> be a compelling need to accurately track whether the cpu went 
> online/offline for the
> purposes of creating the elfcorehdr, as ultimately the crash utility 
> pulls that from
> kernel data structures, not the elfcorehdr.
>
> I think this is what Sourabh has known and has been advocating for an 
> optimization
> path that allows not regenerating the elfcorehdr on cpu changes 
> (because all the percpu
> structs are all laid out). I do think it best to leave that as an arch 
> choice.

Since things are clear on how the PT_NOTES are consumed in kdump kernel 
[fs/proc/vmcore.c],
makedumpfile, and crash tool I need your opinion on this:

Do we really need to regenerate elfcorehdr for CPU hotplug events?
If yes, can you please list the elfcorehdr components that changes due 
to CPU hotplug.

 From what I understood, crash notes are prepared for possible CPUs as 
system boots and
could be used to create a PT_NOTE section for each possible CPU while 
generating the elfcorehdr
during the kdump kernel load.

Now once the elfcorehdr is loaded with PT_NOTEs for every possible CPU 
there is no need to
regenerate it for CPU hotplug events. Or do we?

Thanks,
Sourabh Jain
