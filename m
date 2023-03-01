Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B120E6A679C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 07:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCAGXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 01:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCAGXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 01:23:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA9C1258F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 22:23:45 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3213hguM005643;
        Wed, 1 Mar 2023 06:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Hp6ZoU5w1ZSyH+/PEpslrh7C+rHEhfRfF4vwFAiLRhM=;
 b=G0IN7K6PBRnr5TkcjPGywn7GQWSNeDy1My7lKlRWcNjjvldEeCHuSA14z0ENQaeFzzUa
 lxy3VgOmiEH0QvWRGX/d6gLKcw5Np2fln3SzmKGA3TcwWyT/8PHOcjmGq/iM1tHwc02H
 5hGbXDWX2hlCoLCTIQIg9D/fzVx7UYT5nZc8EMo2Jl9bpKubQmaeYN+XWRtfk05Dmc2q
 Hb63bn255igDyMdD8ZpgxQB03ozubDTO5Vp7NO13mfcPbc0dooqGSOwEj09N/K0+xwxc
 OiXH0qQ2XzNY0AdHVnDNXK1vOOE2NtegOzr3bwibIzxxIv2eiAtAyIqtFmquaWV4mBzC QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1y2734vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 06:23:09 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3216N810011694;
        Wed, 1 Mar 2023 06:23:08 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1y2734v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 06:23:08 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31SBkOtW008599;
        Wed, 1 Mar 2023 06:23:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3nybe2k0b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 06:23:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3216N4sC41419236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Mar 2023 06:23:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51BDD20040;
        Wed,  1 Mar 2023 06:23:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDE8C20063;
        Wed,  1 Mar 2023 06:22:59 +0000 (GMT)
Received: from [9.43.41.8] (unknown [9.43.41.8])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Mar 2023 06:22:59 +0000 (GMT)
Message-ID: <38b4e70b-00b6-8e9c-e98a-77df4454aee7@linux.ibm.com>
Date:   Wed, 1 Mar 2023 11:52:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
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
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <ee58fcfa-1734-2992-d6b7-83f365a9e16a@oracle.com>
 <fc9f8ba4-967a-6e48-df73-67427c145141@linux.ibm.com>
 <4eeda077-c578-791b-8e48-e418744a7615@oracle.com>
 <8aa21721-6951-80d1-ae20-db4198b743ff@linux.ibm.com>
 <4fbdbb3a-dcab-cbf1-0d24-a7be1858b048@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <4fbdbb3a-dcab-cbf1-0d24-a7be1858b048@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ec3wp583yL2nyjsVC7KATPAf51AWonDd
X-Proofpoint-ORIG-GUID: ffQcOzxKoGc0USdAcMhepDk3OlRiFddn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_02,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/03/23 03:20, Eric DeVolder wrote:
>
>
> On 2/27/23 00:11, Sourabh Jain wrote:
>>
>> On 25/02/23 01:46, Eric DeVolder wrote:
>>>
>>>
>>> On 2/24/23 02:34, Sourabh Jain wrote:
>>>>
>>>> On 24/02/23 02:04, Eric DeVolder wrote:
>>>>>
>>>>>
>>>>> On 2/10/23 00:29, Sourabh Jain wrote:
>>>>>>
>>>>>> On 10/02/23 01:09, Eric DeVolder wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/9/23 12:43, Sourabh Jain wrote:
>>>>>>>> Hello Eric,
>>>>>>>>
>>>>>>>> On 09/02/23 23:01, Eric DeVolder wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2/8/23 07:44, Thomas Gleixner wrote:
>>>>>>>>>> Eric!
>>>>>>>>>>
>>>>>>>>>> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>>>>>>>>>>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>>>>>>>>>>
>>>>>>>>>>> So my latest solution is introduce two new CPUHP states, 
>>>>>>>>>>> CPUHP_AP_ELFCOREHDR_ONLINE
>>>>>>>>>>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. 
>>>>>>>>>>> I'm open to better names.
>>>>>>>>>>>
>>>>>>>>>>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after 
>>>>>>>>>>> CPUHP_BRINGUP_CPU. My
>>>>>>>>>>> attempts at locating this state failed when inside the 
>>>>>>>>>>> STARTING section, so I located
>>>>>>>>>>> this just inside the ONLINE sectoin. The crash hotplug 
>>>>>>>>>>> handler is registered on
>>>>>>>>>>> this state as the callback for the .startup method.
>>>>>>>>>>>
>>>>>>>>>>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before 
>>>>>>>>>>> CPUHP_TEARDOWN_CPU, and I
>>>>>>>>>>> placed it at the end of the PREPARE section. This crash 
>>>>>>>>>>> hotplug handler is also
>>>>>>>>>>> registered on this state as the callback for the .teardown 
>>>>>>>>>>> method.
>>>>>>>>>>
>>>>>>>>>> TBH, that's still overengineered. Something like this:
>>>>>>>>>>
>>>>>>>>>> bool cpu_is_alive(unsigned int cpu)
>>>>>>>>>> {
>>>>>>>>>>     struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>>>>>>>>>
>>>>>>>>>>     return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> and use this to query the actual state at crash time. That 
>>>>>>>>>> spares all
>>>>>>>>>> those callback heuristics.
>>>>>>>>>>
>>>>>>>>>>> I'm making my way though percpu crash_notes, elfcorehdr, 
>>>>>>>>>>> vmcoreinfo,
>>>>>>>>>>> makedumpfile and (the consumer of it all) the userspace 
>>>>>>>>>>> crash utility,
>>>>>>>>>>> in order to understand the impact of moving from 
>>>>>>>>>>> for_each_present_cpu()
>>>>>>>>>>> to for_each_online_cpu().
>>>>>>>>>>
>>>>>>>>>> Is the packing actually worth the trouble? What's the actual 
>>>>>>>>>> win?
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>>
>>>>>>>>>>          tglx
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thomas,
>>>>>>>>> I've investigated the passing of crash notes through the 
>>>>>>>>> vmcore. What I've learned is that:
>>>>>>>>>
>>>>>>>>> - linux/fs/proc/vmcore.c (which makedumpfile references to do 
>>>>>>>>> its job) does
>>>>>>>>>   not care what the contents of cpu PT_NOTES are, but it does 
>>>>>>>>> coalesce them together.
>>>>>>>>>
>>>>>>>>> - makedumpfile will count the number of cpu PT_NOTES in order 
>>>>>>>>> to determine its
>>>>>>>>>   nr_cpus variable, which is reported in a header, but 
>>>>>>>>> otherwise unused (except
>>>>>>>>>   for sadump method).
>>>>>>>>>
>>>>>>>>> - the crash utility, for the purposes of determining the cpus, 
>>>>>>>>> does not appear to
>>>>>>>>>   reference the elfcorehdr PT_NOTEs. Instead it locates the 
>>>>>>>>> various
>>>>>>>>>   cpu_[possible|present|online]_mask and computes nr_cpus from 
>>>>>>>>> that, and also of
>>>>>>>>>   course which are online. In addition, when crash does 
>>>>>>>>> reference the cpu PT_NOTE,
>>>>>>>>>   to get its prstatus, it does so by using a percpu technique 
>>>>>>>>> directly in the vmcore
>>>>>>>>>   image memory, not via the ELF structure. Said differently, 
>>>>>>>>> it appears to me that
>>>>>>>>>   crash utility doesn't rely on the ELF PT_NOTEs for cpus; 
>>>>>>>>> rather it obtains them
>>>>>>>>>   via kernel cpumasks and the memory within the vmcore.
>>>>>>>>>
>>>>>>>>> With this understanding, I did some testing. Perhaps the most 
>>>>>>>>> telling test was that I
>>>>>>>>> changed the number of cpu PT_NOTEs emitted in the 
>>>>>>>>> crash_prepare_elf64_headers() to just 1,
>>>>>>>>> hot plugged some cpus, then also took a few offline sparsely 
>>>>>>>>> via chcpu, then generated a
>>>>>>>>> vmcore. The crash utility had no problem loading the vmcore, 
>>>>>>>>> it reported the proper number
>>>>>>>>> of cpus and the number offline (despite only one cpu PT_NOTE), 
>>>>>>>>> and changing to a different
>>>>>>>>> cpu via 'set -c 30' and the backtrace was completely valid.
>>>>>>>>>
>>>>>>>>> My take away is that crash utility does not rely upon ELF cpu 
>>>>>>>>> PT_NOTEs, it obtains the
>>>>>>>>> cpu information directly from kernel data structures. Perhaps 
>>>>>>>>> at one time crash relied
>>>>>>>>> upon the ELF information, but no more. (Perhaps there are 
>>>>>>>>> other crash dump analyzers
>>>>>>>>> that might rely on the ELF info?)
>>>>>>>>>
>>>>>>>>> So, all this to say that I see no need to change 
>>>>>>>>> crash_prepare_elf64_headers(). There
>>>>>>>>> is no compelling reason to move away from 
>>>>>>>>> for_each_present_cpu(), or modify the list for
>>>>>>>>> online/offline.
>>>>>>>>>
>>>>>>>>> Which then leaves the topic of the cpuhp state on which to 
>>>>>>>>> register. Perhaps reverting
>>>>>>>>> back to the use of CPUHP_BP_PREPARE_DYN is the right answer. 
>>>>>>>>> There does not appear to
>>>>>>>>> be a compelling need to accurately track whether the cpu went 
>>>>>>>>> online/offline for the
>>>>>>>>> purposes of creating the elfcorehdr, as ultimately the crash 
>>>>>>>>> utility pulls that from
>>>>>>>>> kernel data structures, not the elfcorehdr.
>>>>>>>>>
>>>>>>>>> I think this is what Sourabh has known and has been advocating 
>>>>>>>>> for an optimization
>>>>>>>>> path that allows not regenerating the elfcorehdr on cpu 
>>>>>>>>> changes (because all the percpu
>>>>>>>>> structs are all laid out). I do think it best to leave that as 
>>>>>>>>> an arch choice.
>>>>>>>>
>>>>>>>> Since things are clear on how the PT_NOTES are consumed in 
>>>>>>>> kdump kernel [fs/proc/vmcore.c],
>>>>>>>> makedumpfile, and crash tool I need your opinion on this:
>>>>>>>>
>>>>>>>> Do we really need to regenerate elfcorehdr for CPU hotplug events?
>>>>>>>> If yes, can you please list the elfcorehdr components that 
>>>>>>>> changes due to CPU hotplug.
>>>>>>> Due to the use of for_each_present_cpu(), it is possible for the 
>>>>>>> number of cpu PT_NOTEs
>>>>>>> to fluctuate as cpus are un/plugged. Onlining/offlining of cpus 
>>>>>>> does not impact the
>>>>>>> number of cpu PT_NOTEs (as the cpus are still present).
>>>>>>>
>>>>>>>>
>>>>>>>>  From what I understood, crash notes are prepared for possible 
>>>>>>>> CPUs as system boots and
>>>>>>>> could be used to create a PT_NOTE section for each possible CPU 
>>>>>>>> while generating the elfcorehdr
>>>>>>>> during the kdump kernel load.
>>>>>>>>
>>>>>>>> Now once the elfcorehdr is loaded with PT_NOTEs for every 
>>>>>>>> possible CPU there is no need to
>>>>>>>> regenerate it for CPU hotplug events. Or do we?
>>>>>>>
>>>>>>> For onlining/offlining of cpus, there is no need to regenerate 
>>>>>>> the elfcorehdr. However,
>>>>>>> for actual hot un/plug of cpus, the answer is yes due to 
>>>>>>> for_each_present_cpu(). The
>>>>>>> caveat here of course is that if crash utility is the only 
>>>>>>> coredump analyzer of concern,
>>>>>>> then it doesn't care about these cpu PT_NOTEs and there would be 
>>>>>>> no need to re-generate them.
>>>>>>>
>>>>>>> Also, I'm not sure if ARM cpu hotplug, which is just now coming 
>>>>>>> into mainstream, impacts
>>>>>>> any of this.
>>>>>>>
>>>>>>> Perhaps the one item that might help here is to distinguish 
>>>>>>> between actual hot un/plug of
>>>>>>> cpus, versus onlining/offlining. At the moment, I can not 
>>>>>>> distinguish between a hot plug
>>>>>>> event and an online event (and unplug/offline). If those were 
>>>>>>> distinguishable, then we
>>>>>>> could only regenerate on un/plug events.
>>>>>>>
>>>>>>> Or perhaps moving to for_each_possible_cpu() is the better choice?
>>>>>>
>>>>>> Yes, because once elfcorehdr is built with possible CPUs we don't 
>>>>>> have to worry about
>>>>>> hot[un]plug case.
>>>>>>
>>>>>> Here is my view on how things should be handled if a core-dump 
>>>>>> analyzer is dependent on
>>>>>> elfcorehdr PT_NOTEs to find online/offline CPUs.
>>>>>>
>>>>>> A PT_NOTE in elfcorehdr holds the address of the corresponding 
>>>>>> crash notes (kernel has
>>>>>> one crash note per CPU for every possible CPU). Though the crash 
>>>>>> notes are allocated
>>>>>> during the boot time they are populated when the system is on the 
>>>>>> crash path.
>>>>>>
>>>>>> This is how crash notes are populated on PowerPC and I am 
>>>>>> expecting it would be something
>>>>>> similar on other architectures too.
>>>>>>
>>>>>> The crashing CPU sends IPI to every other online CPU with a 
>>>>>> callback function that updates the
>>>>>> crash notes of that specific CPU. Once the IPI completes the 
>>>>>> crashing CPU updates its own crash
>>>>>> note and proceeds further.
>>>>>>
>>>>>> The crash notes of CPUs remain uninitialized if the CPUs were 
>>>>>> offline or hot unplugged at the time
>>>>>> system crash. The core-dump analyzer should be able to identify 
>>>>>> [un]/initialized crash notes
>>>>>> and display the information accordingly.
>>>>>>
>>>>>> Thoughts?
>>>>>>
>>>>>> - Sourabh
>>>>>
>>>>> I've been examining what it would mean to move to 
>>>>> for_each_possible_cpu() in crash_prepare_elf64_headers(). I think 
>>>>> it means:
>>>>>
>>>>> - Changing for_each_present_cpu() to for_each_possible_cpu() in 
>>>>> crash_prepare_elf64_headers().
>>>>> - For kexec_load() syscall path, rewrite the incoming/supplied 
>>>>> elfcorehdr immediately on the load with the elfcorehdr generated 
>>>>> by crash_prepare_elf64_headers().
>>>>> - Eliminate/remove the cpuhp machinery for handling crash hotplug 
>>>>> events.
>>>>
>>>> If for_each_present_cpu is replaced with for_each_possible_cpu I 
>>>> still need cpuhp machinery
>>>> to update FDT kexec segment for CPU hot add case.
>>>
>>> Ah, ok, that's important! So the cpuhp callbacks are still needed.
>>>>
>>>>
>>>>>
>>>>> This would then setup PT_NOTEs for all possible cpus, which should 
>>>>> in theory accommodate crash analyzers that rely on ELF PT_NOTEs 
>>>>> for crash_notes.
>>>>>
>>>>> If staying with for_each_present_cpu() is ultimately decided, then 
>>>>> I think leaving the cpuhp machinery in place and each arch could 
>>>>> decide how to handle crash cpu hotplug events. The overhead for 
>>>>> doing this is very minimal, and the events are likely very 
>>>>> infrequent.
>>>>
>>>> I agree. Some architectures may need cpuhp machinery to update 
>>>> kexec segment[s] other then elfcorehdr. For example FDT on PowerPC.
>>>>
>>>> - Sourabh Jain
>>>
>>> OK, I was thinking that the desire was to eliminate the cpuhp 
>>> callbacks. In reality, the desire is to change to 
>>> for_each_possible_cpu(). Given that the kernel creates crash_notes 
>>> for all possible cpus upon kernel boot, there seems to be no reason 
>>> to not do this?
>>>
>>> HOWEVER...
>>>
>>> It's not clear to me that this particular change needs to be part of 
>>> this series. It's inclusion would facilitate PPC support, but 
>>> doesn't "solve" anything in general. In fact it causes kexec_load 
>>> and kexec_file_load to deviate (kexec_load via userspace kexec does 
>>> the equivalent of for_each_present_cpu() where as with this change 
>>> kexec_file_load would do for_each_possible_cpu(); until a hot plug 
>>> event then both would do for_each_possible_cpu()). And if this 
>>> change were to arrive as part of Sourabh's PPC support, then it does 
>>> not appear to impact x86 (not sure about other arches). And the 
>>> 'crash' dump analyzer doesn't care either way.
>>>
>>> Including this change would enable an optimization path (for x86 at 
>>> least) that short-circuits cpu hotplug changes in the arch crash 
>>> handler, for example:
>>>
>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>> index aca3f1817674..0883f6b11de4 100644
>>> --- a/arch/x86/kernel/crash.c
>>> +++ b/arch/x86/kernel/crash.c
>>> @@ -473,6 +473,11 @@ void arch_crash_handle_hotplug_event(struct 
>>> kimage *image)
>>>     unsigned long mem, memsz;
>>>     unsigned long elfsz = 0;
>>>
>>> +   if (image->file_mode && (
>>> +       image->hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>>> +       image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU))
>>> +       return;
>>> +
>>>     /*
>>>      * Create the new elfcorehdr reflecting the changes to CPU and/or
>>>      * memory resources.
>>>
>>> I'm not sure that is compelling given the infrequent nature of cpu 
>>> hotplug events.
>> It certainly closes/reduces the window where kdump is not active due 
>> kexec segment update.|
>
> Fair enough. I plan to include this change in v19.
>
>>
>>>
>>> In my mind I still have a question about kexec_load() path. The 
>>> userspace kexec can not do the equivalent of 
>>> for_each_possible_cpu(). It can obtain max possible cpus from 
>>> /sys/devices/system/cpu/possible, but for those cpus not present the 
>>> /sys/devices/system/cpu/cpuXX is not available and so the 
>>> crash_notes entries is not available. My attempts to expose all 
>>> cpuXX lead to odd behavior that was requiring changes in ACPI and 
>>> arch code that looked untenable.
>>>
>>> There seem to be these options available for kexec_load() path:
>>> - immediately rewrite the elfcorehdr upon load via a call to 
>>> crash_prepare_elf64_headers(). I've made this work with the 
>>> following, as proof of concept:
>> Yes regenerating/patching the elfcorehdr could be an option for 
>> kexec_load syscall.
> So this is not needed by x86, but more so by ppc. Should this change 
> be in the ppc set or this set?
Since /sys/devices/system/cpu/cpuXX represents possible CPUs on PowerPC, 
there is no need for elfcorehdr regeneration on PowerPC for kexec_load case
for CPU hotplug events.

My ask is, keep the cpuhp machinery so that architectures can update 
other kexec segments if needed of CPU add/remove case.

In case x86 has nothing to update on CPU hotplug events and you want 
remove the CPU hp machinery I can add the same
in ppc patch series.

Thanks,
Sourabh Jain
