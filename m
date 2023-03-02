Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638F06A7AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 06:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCBFYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 00:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCBFYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 00:24:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A421041B67
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 21:24:09 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32241b5F012380;
        Thu, 2 Mar 2023 05:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DDss4AABd1yZ0Nt3OBzhl1Efc38Wgk54oWDp7fd84a0=;
 b=abRO++Om6HHjD/Qia/tPg8AqUysZschEMRoJcbB6QT7JOgjG0S1efG7Aog++Pqvz+cC2
 wZfG2VNiyLPPTGvXAjpGK1GuUaZK0EbpM/YKwFiMA3/qKeMi5pQzI4ycM3NC16vVjkoj
 cw3fcisdFOF1Kj/Z68iJ6e/cqfhH137Q87u0HMR3XGeO/gnZquYGI93gE9EKw7qy+0Sc
 zRM6RgOT9zFQ/Syiv1y8AgbmWQ5Yj5ffLBEKTxYzGbCOzaC1gfsQhT5PSlE9AzM00EVd
 1tw/ttNA4bIaLsR4O6NLDnhnZXoc1B5Jip1aRPH5RrzWks/pONu1WbY2zQkMPzu9GDvj BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2mdp1n65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 05:23:39 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3225JZJ8027462;
        Thu, 2 Mar 2023 05:23:38 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2mdp1n5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 05:23:38 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 321KJFXq019799;
        Thu, 2 Mar 2023 05:23:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3nybdfuvrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 05:23:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3225NX3w65339840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Mar 2023 05:23:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7055820043;
        Thu,  2 Mar 2023 05:23:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62C1320040;
        Thu,  2 Mar 2023 05:23:28 +0000 (GMT)
Received: from [9.43.92.152] (unknown [9.43.92.152])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Mar 2023 05:23:28 +0000 (GMT)
Message-ID: <c91066ed-07b9-4e29-6fd0-683c788564be@linux.ibm.com>
Date:   Thu, 2 Mar 2023 10:53:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Baoquan He <bhe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-6-eric.devolder@oracle.com>
 <87sffpzkle.ffs@tglx> <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com>
 <87h6vw2rwf.ffs@tglx> <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
 <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
 <Y/33OOdv22CEaTNA@MiWiFi-R3L-srv>
 <7b0e3676-40e1-3ea1-6d58-6d934970aa27@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <7b0e3676-40e1-3ea1-6d58-6d934970aa27@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4G2WpP5NIdcQQtw_zFuwaa_520pYs7QF
X-Proofpoint-ORIG-GUID: 3bpKXH2b05hUL5M8l4_Wv_5RuDVj3JSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_17,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303020040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/03/23 00:22, Eric DeVolder wrote:
>
>
> On 2/28/23 06:44, Baoquan He wrote:
>> On 02/13/23 at 10:10am, Sourabh Jain wrote:
>>>
>>> On 11/02/23 06:05, Eric DeVolder wrote:
>>>>
>>>>
>>>> On 2/10/23 00:29, Sourabh Jain wrote:
>>>>>
>>>>> On 10/02/23 01:09, Eric DeVolder wrote:
>>>>>>
>>>>>>
>>>>>> On 2/9/23 12:43, Sourabh Jain wrote:
>>>>>>> Hello Eric,
>>>>>>>
>>>>>>> On 09/02/23 23:01, Eric DeVolder wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/8/23 07:44, Thomas Gleixner wrote:
>>>>>>>>> Eric!
>>>>>>>>>
>>>>>>>>> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>>>>>>>>>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>>>>>>>>>
>>>>>>>>>> So my latest solution is introduce two new CPUHP
>>>>>>>>>> states, CPUHP_AP_ELFCOREHDR_ONLINE
>>>>>>>>>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for
>>>>>>>>>> offlining. I'm open to better names.
>>>>>>>>>>
>>>>>>>>>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be
>>>>>>>>>> placed after CPUHP_BRINGUP_CPU. My
>>>>>>>>>> attempts at locating this state failed when
>>>>>>>>>> inside the STARTING section, so I located
>>>>>>>>>> this just inside the ONLINE sectoin. The crash
>>>>>>>>>> hotplug handler is registered on
>>>>>>>>>> this state as the callback for the .startup method.
>>>>>>>>>>
>>>>>>>>>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be
>>>>>>>>>> placed before CPUHP_TEARDOWN_CPU, and I
>>>>>>>>>> placed it at the end of the PREPARE section.
>>>>>>>>>> This crash hotplug handler is also
>>>>>>>>>> registered on this state as the callback for the .teardown 
>>>>>>>>>> method.
>>>>>>>>>
>>>>>>>>> TBH, that's still overengineered. Something like this:
>>>>>>>>>
>>>>>>>>> bool cpu_is_alive(unsigned int cpu)
>>>>>>>>> {
>>>>>>>>>      struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>>>>>>>>
>>>>>>>>>      return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> and use this to query the actual state at crash
>>>>>>>>> time. That spares all
>>>>>>>>> those callback heuristics.
>>>>>>>>>
>>>>>>>>>> I'm making my way though percpu crash_notes,
>>>>>>>>>> elfcorehdr, vmcoreinfo,
>>>>>>>>>> makedumpfile and (the consumer of it all) the
>>>>>>>>>> userspace crash utility,
>>>>>>>>>> in order to understand the impact of moving from
>>>>>>>>>> for_each_present_cpu()
>>>>>>>>>> to for_each_online_cpu().
>>>>>>>>>
>>>>>>>>> Is the packing actually worth the trouble? What's the actual win?
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>>           tglx
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thomas,
>>>>>>>> I've investigated the passing of crash notes through the
>>>>>>>> vmcore. What I've learned is that:
>>>>>>>>
>>>>>>>> - linux/fs/proc/vmcore.c (which makedumpfile references
>>>>>>>> to do its job) does
>>>>>>>>    not care what the contents of cpu PT_NOTES are, but it
>>>>>>>> does coalesce them together.
>>>>>>>>
>>>>>>>> - makedumpfile will count the number of cpu PT_NOTES in
>>>>>>>> order to determine its
>>>>>>>>    nr_cpus variable, which is reported in a header, but
>>>>>>>> otherwise unused (except
>>>>>>>>    for sadump method).
>>>>>>>>
>>>>>>>> - the crash utility, for the purposes of determining the
>>>>>>>> cpus, does not appear to
>>>>>>>>    reference the elfcorehdr PT_NOTEs. Instead it locates the 
>>>>>>>> various
>>>>>>>>    cpu_[possible|present|online]_mask and computes
>>>>>>>> nr_cpus from that, and also of
>>>>>>>>    course which are online. In addition, when crash does
>>>>>>>> reference the cpu PT_NOTE,
>>>>>>>>    to get its prstatus, it does so by using a percpu
>>>>>>>> technique directly in the vmcore
>>>>>>>>    image memory, not via the ELF structure. Said
>>>>>>>> differently, it appears to me that
>>>>>>>>    crash utility doesn't rely on the ELF PT_NOTEs for
>>>>>>>> cpus; rather it obtains them
>>>>>>>>    via kernel cpumasks and the memory within the vmcore.
>>>>>>>>
>>>>>>>> With this understanding, I did some testing. Perhaps the
>>>>>>>> most telling test was that I
>>>>>>>> changed the number of cpu PT_NOTEs emitted in the
>>>>>>>> crash_prepare_elf64_headers() to just 1,
>>>>>>>> hot plugged some cpus, then also took a few offline
>>>>>>>> sparsely via chcpu, then generated a
>>>>>>>> vmcore. The crash utility had no problem loading the
>>>>>>>> vmcore, it reported the proper number
>>>>>>>> of cpus and the number offline (despite only one cpu
>>>>>>>> PT_NOTE), and changing to a different
>>>>>>>> cpu via 'set -c 30' and the backtrace was completely valid.
>>>>>>>>
>>>>>>>> My take away is that crash utility does not rely upon
>>>>>>>> ELF cpu PT_NOTEs, it obtains the
>>>>>>>> cpu information directly from kernel data structures.
>>>>>>>> Perhaps at one time crash relied
>>>>>>>> upon the ELF information, but no more. (Perhaps there
>>>>>>>> are other crash dump analyzers
>>>>>>>> that might rely on the ELF info?)
>>>>>>>>
>>>>>>>> So, all this to say that I see no need to change
>>>>>>>> crash_prepare_elf64_headers(). There
>>>>>>>> is no compelling reason to move away from
>>>>>>>> for_each_present_cpu(), or modify the list for
>>>>>>>> online/offline.
>>>>>>>>
>>>>>>>> Which then leaves the topic of the cpuhp state on which
>>>>>>>> to register. Perhaps reverting
>>>>>>>> back to the use of CPUHP_BP_PREPARE_DYN is the right
>>>>>>>> answer. There does not appear to
>>>>>>>> be a compelling need to accurately track whether the cpu
>>>>>>>> went online/offline for the
>>>>>>>> purposes of creating the elfcorehdr, as ultimately the
>>>>>>>> crash utility pulls that from
>>>>>>>> kernel data structures, not the elfcorehdr.
>>>>>>>>
>>>>>>>> I think this is what Sourabh has known and has been
>>>>>>>> advocating for an optimization
>>>>>>>> path that allows not regenerating the elfcorehdr on cpu
>>>>>>>> changes (because all the percpu
>>>>>>>> structs are all laid out). I do think it best to leave
>>>>>>>> that as an arch choice.
>>>>>>>
>>>>>>> Since things are clear on how the PT_NOTES are consumed in
>>>>>>> kdump kernel [fs/proc/vmcore.c],
>>>>>>> makedumpfile, and crash tool I need your opinion on this:
>>>>>>>
>>>>>>> Do we really need to regenerate elfcorehdr for CPU hotplug events?
>>>>>>> If yes, can you please list the elfcorehdr components that
>>>>>>> changes due to CPU hotplug.
>>>>>> Due to the use of for_each_present_cpu(), it is possible for the
>>>>>> number of cpu PT_NOTEs
>>>>>> to fluctuate as cpus are un/plugged. Onlining/offlining of cpus
>>>>>> does not impact the
>>>>>> number of cpu PT_NOTEs (as the cpus are still present).
>>>>>>
>>>>>>>
>>>>>>>   From what I understood, crash notes are prepared for
>>>>>>> possible CPUs as system boots and
>>>>>>> could be used to create a PT_NOTE section for each possible
>>>>>>> CPU while generating the elfcorehdr
>>>>>>> during the kdump kernel load.
>>>>>>>
>>>>>>> Now once the elfcorehdr is loaded with PT_NOTEs for every
>>>>>>> possible CPU there is no need to
>>>>>>> regenerate it for CPU hotplug events. Or do we?
>>>>>>
>>>>>> For onlining/offlining of cpus, there is no need to regenerate
>>>>>> the elfcorehdr. However,
>>>>>> for actual hot un/plug of cpus, the answer is yes due to
>>>>>> for_each_present_cpu(). The
>>>>>> caveat here of course is that if crash utility is the only
>>>>>> coredump analyzer of concern,
>>>>>> then it doesn't care about these cpu PT_NOTEs and there would be
>>>>>> no need to re-generate them.
>>>>>>
>>>>>> Also, I'm not sure if ARM cpu hotplug, which is just now coming
>>>>>> into mainstream, impacts
>>>>>> any of this.
>>>>>>
>>>>>> Perhaps the one item that might help here is to distinguish
>>>>>> between actual hot un/plug of
>>>>>> cpus, versus onlining/offlining. At the moment, I can not
>>>>>> distinguish between a hot plug
>>>>>> event and an online event (and unplug/offline). If those were
>>>>>> distinguishable, then we
>>>>>> could only regenerate on un/plug events.
>>>>>>
>>>>>> Or perhaps moving to for_each_possible_cpu() is the better choice?
>>>>>
>>>>> Yes, because once elfcorehdr is built with possible CPUs we don't
>>>>> have to worry about
>>>>> hot[un]plug case.
>>>>>
>>>>> Here is my view on how things should be handled if a core-dump
>>>>> analyzer is dependent on
>>>>> elfcorehdr PT_NOTEs to find online/offline CPUs.
>>>>>
>>>>> A PT_NOTE in elfcorehdr holds the address of the corresponding crash
>>>>> notes (kernel has
>>>>> one crash note per CPU for every possible CPU). Though the crash
>>>>> notes are allocated
>>>>> during the boot time they are populated when the system is on the
>>>>> crash path.
>>>>>
>>>>> This is how crash notes are populated on PowerPC and I am expecting
>>>>> it would be something
>>>>> similar on other architectures too.
>>>>>
>>>>> The crashing CPU sends IPI to every other online CPU with a callback
>>>>> function that updates the
>>>>> crash notes of that specific CPU. Once the IPI completes the
>>>>> crashing CPU updates its own crash
>>>>> note and proceeds further.
>>>>>
>>>>> The crash notes of CPUs remain uninitialized if the CPUs were
>>>>> offline or hot unplugged at the time
>>>>> system crash. The core-dump analyzer should be able to identify
>>>>> [un]/initialized crash notes
>>>>> and display the information accordingly.
>>>>>
>>>>> Thoughts?
>>>>>
>>>>> - Sourabh
>>>>
>>>> In general, I agree with your points. You've presented a strong 
>>>> case to
>>>> go with for_each_possible_cpu() in crash_prepare_elf64_headers() and
>>>> those crash notes would always be present, and we can ignore 
>>>> changes to
>>>> cpus wrt/ elfcorehdr updates.
>>>>
>>>> But what do we do about kexec_load() syscall? The way the userspace
>>>> utility works is it determines cpus by:
>>>>   nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>>>> which is not the equivalent of possible_cpus. So the complete list of
>>>> cpu PT_NOTEs is not generated up front. We would need a solution for
>>>> that?
>>> Hello Eric,
>>>
>>> The sysconf document says _SC_NPROCESSORS_CONF is processors 
>>> configured,
>>> isn't that equivalent to possible CPUs?
>>>
>>> What exactly sysconf(_SC_NPROCESSORS_CONF) returns on x86? IIUC, on 
>>> powerPC
>>> it is possible CPUs.
>>
> Baoquan,
>
>>  From sysconf man page, with my understanding, _SC_NPROCESSORS_CONF is
>> returning the possible cpus, while _SC_NPROCESSORS_ONLN returns present
>> cpus. If these are true, we can use them.
>
> Thomas Gleixner has pointed out that:
>
>  glibc tries to evaluate that in the following order:
>   1) /sys/devices/system/cpu/cpu*
>      That's present CPUs not possible CPUs
>   2) /proc/stat
>      That's online CPUs
>   3) sched_getaffinity()
>      That's online CPUs at best. In the worst case it's an affinity mask
>      which is set on a process group
>
> meaning that _SC_NPROCESSORS_CONF is not equivalent to 
> possible_cpus(). Furthermore, the /sys/system/devices/cpus/cpuXX 
> entries are not available for not-present-but-possible cpus; thus 
> userspace kexec utility can not write out the elfcorehdr with all 
> possible cpus listed.
>
>>
>> But I am wondering why the existing present cpu way is going to be
>> discarded. Sorry, I tried to go through this thread, it's too long, can
>> anyone summarize the reason with shorter and clear sentences. Sorry
>> again for that.
>
Hello Eric,

> By utilizing for_each_possible_cpu() in crash_prepare_elf64_headers(), 
> in the case of the kexec_file_load(), this change would simplify some 
> issues Sourabh has encountered for PPC support.

Things are fine even with for_each_present_cpu on PPC. It is just that I 
want to avoid
the regeneration of elfcorehdr for every CPU change by packing possible 
CPUs at once.


Thanks,
Sourabh Jain

