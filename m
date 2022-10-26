Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBFC60DBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiJZHBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJZHB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:01:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A2232B9C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:01:25 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q69KsS017875;
        Wed, 26 Oct 2022 07:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=i74J7YxKNCGZnJ4ntBW29KJiOsTw3NkvkI4MTBMck88=;
 b=jnLt7cRKjf7YhEcP0y2j1WGV8fjq7obXmW8Kwo/W7irerY3KCiEE780PX0oywARh1spD
 UPv7ZfwL/aWH4KOvKdyOfr0LqZ7Df7HVPc6WKDXEd1h8mSlX1hi4Cfv4TIfi0vppJ9pW
 XwfHiNtp/rcZBvo0ot+WEDCba3pn1cjFcQZuN3sx/jEO2YoJ9Wij04Y5eR/GiAvpawLK
 RacCt1V8CowjyK0BJQHlQSGJasWe6f0q6NVQI9fvMUCloC2CNZHl3JVLuNu++51xfC+j
 XntdczZs2hFniZwWEV5bysrDjpqPWtAxjBuSJOo3/sIyeiAmgwNlcR7ijXQSCDHk1rjY 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kedmq2jbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 07:00:15 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29Q6uuDr018320;
        Wed, 26 Oct 2022 07:00:15 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kedmq2j9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 07:00:15 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29Q6p3CW023281;
        Wed, 26 Oct 2022 07:00:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3kc7sj512w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 07:00:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29Q70iCt51970370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 07:00:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2C834C04E;
        Wed, 26 Oct 2022 07:00:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B654C046;
        Wed, 26 Oct 2022 07:00:03 +0000 (GMT)
Received: from [9.43.71.140] (unknown [9.43.71.140])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Oct 2022 07:00:02 +0000 (GMT)
Message-ID: <04b0ebb7-2131-97f0-a49f-af16c5378831@linux.ibm.com>
Date:   Wed, 26 Oct 2022 12:30:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v12 3/7] crash: add generic infrastructure for crash
 hotplug support
To:     Baoquan He <bhe@redhat.com>,
        Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-4-eric.devolder@oracle.com>
 <8cc31b22-a061-d07c-77dc-c555b8b35af3@linux.ibm.com>
 <97f2daae-f34a-86bb-6d28-8aa8314321bc@oracle.com>
 <Y1ZWaSeGk53QqZHX@MiWiFi-R3L-srv>
Content-Language: en-US
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Y1ZWaSeGk53QqZHX@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y_DdF7yAzuDyQRTIg2efVFrexyXEX96L
X-Proofpoint-ORIG-GUID: ffAIrTWg8AXqgaDGIz-os4EWOLZ0W6s4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_02,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Baoquan,

On 24/10/22 14:40, Baoquan He wrote:
> Hi Eric, Sourabh,
>
> On 10/07/22 at 02:14pm, Eric DeVolder wrote:
>>
>> On 10/3/22 12:51, Sourabh Jain wrote:
>>> Hello Eric,
>>>
>>> On 10/09/22 02:35, Eric DeVolder wrote:
> ......
>>>> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>>>> +{
>>>> +    /* Obtain lock while changing crash information */
>>>> +    mutex_lock(&kexec_mutex);
>>>> +
>>>> +    /* Check kdump is loaded */
>>>> +    if (kexec_crash_image) {
>>>> +        struct kimage *image = kexec_crash_image;
>>>> +
>>>> +        if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>>>> +            hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>>>> +            pr_debug("crash hp: hp_action %u, cpu %u\n", hp_action, cpu);
>>>> +        else
>>>> +            pr_debug("crash hp: hp_action %u\n", hp_action);
>>>> +
>>>> +        /*
>>>> +         * When the struct kimage is allocated, it is wiped to zero, so
>>>> +         * the elfcorehdr_index_valid defaults to false. Find the
>>>> +         * segment containing the elfcorehdr, if not already found.
>>>> +         * This works for both the kexec_load and kexec_file_load paths.
>>>> +         */
>>>> +        if (!image->elfcorehdr_index_valid) {
>>>> +            unsigned char *ptr;
>>>> +            unsigned long mem, memsz;
>>>> +            unsigned int n;
>>>> +
>>>> +            for (n = 0; n < image->nr_segments; n++) {
>>>> +                mem = image->segment[n].mem;
>>>> +                memsz = image->segment[n].memsz;
>>>> +                ptr = arch_map_crash_pages(mem, memsz);
>>>> +                if (ptr) {
>>>> +                    /* The segment containing elfcorehdr */
>>>> +                    if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>>>> +                        image->elfcorehdr_index = (int)n;
>>>> +                        image->elfcorehdr_index_valid = true;
>>>> +                    }
>>>> +                }
>>>> +                arch_unmap_crash_pages((void **)&ptr);
>>>> +            }
>>>> +        }
>>>> +
>>>> +        if (!image->elfcorehdr_index_valid) {
>>>> +            pr_err("crash hp: unable to locate elfcorehdr segment");
>>>> +            goto out;
>>>> +        }
>>>> +
>>>> +        /* Needed in order for the segments to be updated */
>>>> +        arch_kexec_unprotect_crashkres();
>>>> +
>>>> +        /* Flag to differentiate between normal load and hotplug */
>>>> +        image->hotplug_event = true;
>>>> +
>>>> +        /* Now invoke arch-specific update handler */
>>>> +        arch_crash_handle_hotplug_event(image, hp_action);
>>>> +
>>>> +        /* No longer handling a hotplug event */
>>>> +        image->hotplug_event = false;
>>>> +
>>>> +        /* Change back to read-only */
>>>> +        arch_kexec_protect_crashkres();
>>>> +    }
>>>> +
>>>> +out:
>>>> +    /* Release lock now that update complete */
>>>> +    mutex_unlock(&kexec_mutex);
>>>> +}
>>>> +
>>>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>>>> +{
>>>> +    switch (val) {
>>>> +    case MEM_ONLINE:
>>>> +        handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
>>>> +        break;
>>>> +
>>>> +    case MEM_OFFLINE:
>>>> +        handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
>>>> +        break;
>>>> +    }
>>>> +    return NOTIFY_OK;
>>> Can we pass v (memory_notify) argument to arch_crash_handle_hotplug_event function
>>> via handle_hotplug_event?
>>>
>>> Because the way memory hotplug is handled on PowerPC, it is hard to update the elfcorehdr
>>> without memory_notify args.
>>>
>>> On PowePC memblock data structure is used to prepare elfcorehdr for kdump. Since the notifier
>>> used for memory hotplug crash handler get initiated before the memblock data structure update
>>> happens (as depicted below), the newly prepared elfcorehdr still holds the old memory regions.
>>> So if the system crash with obsolete elfcorehdr, makedumpfile failed to collect vmcore.
>>>
>>> Sequence of actions done on PowerPC to server the memory hotplug:
>>>
>>>    Initiate memory hot remove
>>>             |
>>>             v
>>>    offline pages
>>>             |
>>>             v
>>>    initiate memory notify call chain
>>>    for MEM_OFFLINE event.
>>>    (same is used for crash update)
>>>             |
>>>             v
>>>    prepare new elfcorehdr for kdump using
>>>    memblock data structure
>>>             |
>>>             v
>>>    update memblock data structure
>>>
>>> How passing memory_notify to arch crash hotplug handler will help?
>>>
>>> memory_notify holds the start PFN and page count, with that we can get
>>> the base address and size of hot unplugged memory and can use the same
>>> to avoid hot unplugged memeory region to get added in the elfcorehdr..
>>>
>>> Thanks,
>>> Sourabh Jain
>>>
>> Sourabh, let's see what Baoquan thinks.
>>
>> Baoquan, are you OK with this request? I once had these parameters to the
>> crash hotplug handler and since they were unused at the time, you asked
>> that I remove them, which I did.
> Sorry to miss this mail. I thought both of you were talking about
> somthing, and didn't notice this question to me.
>
> I think there are two ways to solve the issue Sourabh raised:
> 1) make handle_hotplug_event() get and pass down the memory_notify as
> Sourabh said, or the hp_action, mem_start|size as Eric suggested. I
> have to admit I haven't carefully checked which one is better.
>
> 2) let the current code as is since it's aiming at x86 only. Later
> Sourabh can modify code according to his need on ppc. This can give
> satisfying why on code change each time.
>
> I personally like the 2nd way, while also like seeing 1st one if the
> code change and log is convincing to any reviewer.

Ok let's go with second approach. I will introduce a patch in PowerPC 
series to update the
handle_hotplug_event function signature and justify the change.

Thanks,
Sourabh Jain

