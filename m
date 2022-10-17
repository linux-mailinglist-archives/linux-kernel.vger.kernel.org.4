Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EAA6006CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJQGq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJQGq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:46:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83EA543D8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 23:46:54 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29H5vtvf030516;
        Mon, 17 Oct 2022 06:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ueyo4i0t7NB7EKyXOPdWLOfDpPTnIZoO0Pi9reWnp9E=;
 b=X+MZF0z5ZbrPjQNxitJjQOK+ImZrgMmx/jyLYHLjhLNRW65ocmekvt4SBxD64J1Gm1i3
 UAO9K44Cpt+p5fJ96jTqEZiWdXUYOiDjAHgdgqeWWX606cz+eriYCZqAy/orqVoRYObm
 s9/FK4ZAuJd0YqBcgPD/Vu+QIw3KNmD1vyGr3ezf4o4zqqkgOdxSUbj4MxhkkNKZNkHT
 V6GJ2dIB8Gr/9SXoiOjH3qriyYQuq0kdOf4kKhoBPgMFuU6cwvdQOtAimzS6JScez6eM
 Db14AzYTqxwXAqwT9LqvX8hjrzCzpR8WFvJMGlXaVmepZRtX5/JEnkKkqEYjKNp4bySu Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86nte2cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 06:46:18 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29H653t6018998;
        Mon, 17 Oct 2022 06:46:17 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86nte2b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 06:46:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29H6bsGr028652;
        Mon, 17 Oct 2022 06:46:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3k7mg92ewu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 06:46:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29H6fHY350725352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 06:41:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95B49A4051;
        Mon, 17 Oct 2022 06:46:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93A1AA4040;
        Mon, 17 Oct 2022 06:46:07 +0000 (GMT)
Received: from [9.43.94.119] (unknown [9.43.94.119])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Oct 2022 06:46:07 +0000 (GMT)
Message-ID: <13709fd8-400e-da70-42b5-21cd3b850fbc@linux.ibm.com>
Date:   Mon, 17 Oct 2022 12:15:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v12 3/7] crash: add generic infrastructure for crash
 hotplug support
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
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-4-eric.devolder@oracle.com>
 <8cc31b22-a061-d07c-77dc-c555b8b35af3@linux.ibm.com>
 <97f2daae-f34a-86bb-6d28-8aa8314321bc@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <97f2daae-f34a-86bb-6d28-8aa8314321bc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: atVTK50R26ECHjUSWqOA7fToCubFAQTv
X-Proofpoint-GUID: gzOoVJ3sZ_FngjGtqyeRG9BBLeyFSzLN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_06,2022-10-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/10/22 00:44, Eric DeVolder wrote:
>
>
> On 10/3/22 12:51, Sourabh Jain wrote:
>> Hello Eric,
>>
>> On 10/09/22 02:35, Eric DeVolder wrote:
>>> CPU and memory change notifications are received in order to
>>> regenerate the elfcorehdr.
>>>
>>> To support cpu hotplug, a callback is registered to capture the
>>> CPUHP_AP_ONLINE_DYN online and offline events via
>>> cpuhp_setup_state_nocalls().
>>>
>>> To support memory hotplug, a notifier is registered to capture the
>>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>>
>>> The cpu callback and memory notifiers call handle_hotplug_event()
>>> which performs needed tasks and then dispatches the event to the
>>> architecture specific arch_crash_handle_hotplug_event(). During the
>>> process, the kexec_mutex is held.
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> Acked-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>   include/linux/crash_core.h |   8 +++
>>>   include/linux/kexec.h      |  26 +++++++
>>>   kernel/crash_core.c        | 134 
>>> +++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 168 insertions(+)
>>>
>>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>>> index de62a722431e..a270f8660538 100644
>>> --- a/include/linux/crash_core.h
>>> +++ b/include/linux/crash_core.h
>>> @@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, 
>>> unsigned long long system_ram,
>>>   int parse_crashkernel_low(char *cmdline, unsigned long long 
>>> system_ram,
>>>           unsigned long long *crash_size, unsigned long long 
>>> *crash_base);
>>> +#define KEXEC_CRASH_HP_REMOVE_CPU        0
>>> +#define KEXEC_CRASH_HP_ADD_CPU            1
>>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY        2
>>> +#define KEXEC_CRASH_HP_ADD_MEMORY        3
>>> +#define KEXEC_CRASH_HP_INVALID_CPU        -1U
>>> +
>>> +struct kimage;
>>> +
>>>   #endif /* LINUX_CRASH_CORE_H */
>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>> index 4eefa631e0ae..9597b41136ec 100644
>>> --- a/include/linux/kexec.h
>>> +++ b/include/linux/kexec.h
>>> @@ -374,6 +374,13 @@ struct kimage {
>>>       struct purgatory_info purgatory_info;
>>>   #endif
>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>> +    bool hotplug_event;
>>> +    unsigned int offlinecpu;
>>> +    bool elfcorehdr_index_valid;
>>> +    int elfcorehdr_index;
>>> +#endif
>>> +
>>>   #ifdef CONFIG_IMA_KEXEC
>>>       /* Virtual address of IMA measurement buffer for kexec syscall */
>>>       void *ima_buffer;
>>> @@ -503,6 +510,25 @@ static inline int 
>>> arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>>>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned 
>>> int pages) { }
>>>   #endif
>>> +#ifndef arch_map_crash_pages
>>> +static inline void *arch_map_crash_pages(unsigned long paddr,
>>> +        unsigned long size)
>>> +{
>>> +    return NULL;
>>> +}
>>> +#endif
>>> +
>>> +#ifndef arch_unmap_crash_pages
>>> +static inline void arch_unmap_crash_pages(void **ptr) { }
>>> +#endif
>>> +
>>> +#ifndef arch_crash_handle_hotplug_event
>>> +static inline void arch_crash_handle_hotplug_event(struct kimage 
>>> *image,
>>> +        unsigned int hp_action)
>>> +{
>>> +}
>>> +#endif
>>> +
>>>   #else /* !CONFIG_KEXEC_CORE */
>>>   struct pt_regs;
>>>   struct task_struct;
>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>> index 8c648fd5897a..4b15d91f0b21 100644
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -11,6 +11,8 @@
>>>   #include <linux/vmalloc.h>
>>>   #include <linux/sizes.h>
>>>   #include <linux/kexec.h>
>>> +#include <linux/memory.h>
>>> +#include <linux/cpuhotplug.h>
>>>   #include <asm/page.h>
>>>   #include <asm/sections.h>
>>> @@ -18,6 +20,7 @@
>>>   #include <crypto/sha1.h>
>>>   #include "kallsyms_internal.h"
>>> +#include "kexec_internal.h"
>>>   /* vmcoreinfo stuff */
>>>   unsigned char *vmcoreinfo_data;
>>> @@ -612,3 +615,134 @@ static int __init 
>>> crash_save_vmcoreinfo_init(void)
>>>   }
>>>   subsys_initcall(crash_save_vmcoreinfo_init);
>>> +
>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>> +/*
>>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>>> + * must be updated with the new list of CPUs and memories.
>>> + *
>>> + * In order to make changes to elfcorehdr, two conditions are needed:
>>> + * First, the segment containing the elfcorehdr must be large enough
>>> + * to permit a growing number of resources. The elfcorehdr memory is
>>> + * typically based on CONFIG_NR_CPUS and 
>>> CONFIG_CRASH_MAX_MEMORY_RANGES.
>>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>>> + * list of segments it checks (since the elfcorehdr changes and thus
>>> + * would require an update to purgatory itself to update the digest).
>>> + */
>>> +static void handle_hotplug_event(unsigned int hp_action, unsigned 
>>> int cpu)
>>> +{
>>> +    /* Obtain lock while changing crash information */
>>> +    mutex_lock(&kexec_mutex);
>>> +
>>> +    /* Check kdump is loaded */
>>> +    if (kexec_crash_image) {
>>> +        struct kimage *image = kexec_crash_image;
>>> +
>>> +        if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>>> +            hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>>> +            pr_debug("crash hp: hp_action %u, cpu %u\n", hp_action, 
>>> cpu);
>>> +        else
>>> +            pr_debug("crash hp: hp_action %u\n", hp_action);
>>> +
>>> +        /*
>>> +         * When the struct kimage is allocated, it is wiped to 
>>> zero, so
>>> +         * the elfcorehdr_index_valid defaults to false. Find the
>>> +         * segment containing the elfcorehdr, if not already found.
>>> +         * This works for both the kexec_load and kexec_file_load 
>>> paths.
>>> +         */
>>> +        if (!image->elfcorehdr_index_valid) {
>>> +            unsigned char *ptr;
>>> +            unsigned long mem, memsz;
>>> +            unsigned int n;
>>> +
>>> +            for (n = 0; n < image->nr_segments; n++) {
>>> +                mem = image->segment[n].mem;
>>> +                memsz = image->segment[n].memsz;
>>> +                ptr = arch_map_crash_pages(mem, memsz);
>>> +                if (ptr) {
>>> +                    /* The segment containing elfcorehdr */
>>> +                    if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>>> +                        image->elfcorehdr_index = (int)n;
>>> +                        image->elfcorehdr_index_valid = true;
>>> +                    }
>>> +                }
>>> +                arch_unmap_crash_pages((void **)&ptr);
>>> +            }
>>> +        }
>>> +
>>> +        if (!image->elfcorehdr_index_valid) {
>>> +            pr_err("crash hp: unable to locate elfcorehdr segment");
>>> +            goto out;
>>> +        }
>>> +
>>> +        /* Needed in order for the segments to be updated */
>>> +        arch_kexec_unprotect_crashkres();
>>> +
>>> +        /* Flag to differentiate between normal load and hotplug */
>>> +        image->hotplug_event = true;
>>> +
>>> +        /* Now invoke arch-specific update handler */
>>> +        arch_crash_handle_hotplug_event(image, hp_action);
>>> +
>>> +        /* No longer handling a hotplug event */
>>> +        image->hotplug_event = false;
>>> +
>>> +        /* Change back to read-only */
>>> +        arch_kexec_protect_crashkres();
>>> +    }
>>> +
>>> +out:
>>> +    /* Release lock now that update complete */
>>> +    mutex_unlock(&kexec_mutex);
>>> +}
>>> +
>>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned 
>>> long val, void *v)
>>> +{
>>> +    switch (val) {
>>> +    case MEM_ONLINE:
>>> +        handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
>>> +        break;
>>> +
>>> +    case MEM_OFFLINE:
>>> +        handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
>>> +        break;
>>> +    }
>>> +    return NOTIFY_OK;
>>
>> Can we pass v (memory_notify) argument to 
>> arch_crash_handle_hotplug_event function
>> via handle_hotplug_event?
>>
>> Because the way memory hotplug is handled on PowerPC, it is hard to 
>> update the elfcorehdr
>> without memory_notify args.
>>
>> On PowePC memblock data structure is used to prepare elfcorehdr for 
>> kdump. Since the notifier
>> used for memory hotplug crash handler get initiated before the 
>> memblock data structure update
>> happens (as depicted below), the newly prepared elfcorehdr still 
>> holds the old memory regions.
>> So if the system crash with obsolete elfcorehdr, makedumpfile failed 
>> to collect vmcore.
>>
>> Sequence of actions done on PowerPC to server the memory hotplug:
>>
>>   Initiate memory hot remove
>>            |
>>            v
>>   offline pages
>>            |
>>            v
>>   initiate memory notify call chain
>>   for MEM_OFFLINE event.
>>   (same is used for crash update)
>>            |
>>            v
>>   prepare new elfcorehdr for kdump using
>>   memblock data structure
>>            |
>>            v
>>   update memblock data structure
>>
>> How passing memory_notify to arch crash hotplug handler will help?
>>
>> memory_notify holds the start PFN and page count, with that we can get
>> the base address and size of hot unplugged memory and can use the same
>> to avoid hot unplugged memeory region to get added in the elfcorehdr..
>>
>> Thanks,
>> Sourabh Jain
>>
>
> Sourabh, let's see what Baoquan thinks.
>
> Baoquan, are you OK with this request? I once had these parameters to the
> crash hotplug handler and since they were unused at the time, you asked
> that I remove them, which I did.
>
> To accommodate this, how about this:
>
> static void handle_hotplug_event(unsigned int hp_action, unsigned int 
> cpu,
>      unsigned long mem_start, unsigned long mem_size)
>
> For CPU events, I would just pass zeros for mem_start/size. For memory 
> events,
> I would pass KEXEC_CRASH_HP_INVALID_CPU.

How about passing memory_notify struct as is and let architecture handle 
the rest?

Thanks,
Sourabh Jain
