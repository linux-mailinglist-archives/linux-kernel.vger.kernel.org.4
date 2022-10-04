Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1685F3F39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiJDJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJDJLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:11:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1FF2649E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:11:13 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2948GxA3028859;
        Tue, 4 Oct 2022 09:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=t2PKah5/qiEBeInudA3HljdOXh76Px1MxjtLmIXgrgw=;
 b=aQeJBZgG1/ObTV19sgTEzthymFlZ48Vvv+vhg9w5ORlQvNMsitOoGmrx/BG3Czm2bAz3
 MJEOdAacfsmhopOhEDostuROki3Im3kwWQFYc+OOFwvGWMSP11MJU8v7mOA2vm5hGF3z
 dfWc9F2L28OeV0lL+ka+LUvFz18SRKpFL0PIztqn8gcjRtsY4/YCQ0Y9/eH87ROmd1z1
 i8Mek94+xdT3jLEn4O2QaHQu9/k7c16TI0qjAs6dzjPO19QLxp9ovtrwKpIfik/lgAKK
 HG4K+gExgEthJJZbdHS/pD47FZirhw35Izc4veUu7NeL4DvnCXCFV4a0E+Xtps0xlcYF jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fca4pw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 09:10:41 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29496BBo005677;
        Tue, 4 Oct 2022 09:10:40 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fca4pu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 09:10:40 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29495Dc8017198;
        Tue, 4 Oct 2022 09:10:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3jxd68junt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 09:10:38 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2949Aaa560096988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 09:10:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBCA3A405C;
        Tue,  4 Oct 2022 09:10:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F0A0A4054;
        Tue,  4 Oct 2022 09:10:31 +0000 (GMT)
Received: from [9.43.62.42] (unknown [9.43.62.42])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 09:10:31 +0000 (GMT)
Message-ID: <7d0697ee-d6e8-dad1-ca77-f2e8104b0b0f@linux.ibm.com>
Date:   Tue, 4 Oct 2022 14:40:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iedrTH9irDerlit3WIM_TQcK3l_PyykE
X-Proofpoint-ORIG-GUID: Sl7bBEaiFRhswQ05_GNUynjmzrpGbSbt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040058
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/09/22 21:06, Eric DeVolder wrote:
>
>
> On 9/28/22 11:07, Borislav Petkov wrote:
>> On Tue, Sep 13, 2022 at 02:12:31PM -0500, Eric DeVolder wrote:
>>> This topic was discussed previously https://lkml.org/lkml/2022/3/3/372.
>>
>> Please do not use lkml.org to refer to lkml messages. We have a
>> perfectly fine archival system at lore.kernel.org. You simply do
>>
>> https://lore.kernel.org/r/<Message-ID>
>>
>> when you want to point to a previous mail.
>
> ok, thanks for pointing that out to me.
>>
>>> David points out that terminology is tricky here due to differing 
>>> behaviors.
>>> And perhaps that is your point in asking for guidance text. It can be
>>> complicated
>>
>> Which means you need an explanation how to use this even more.
>>
>> And why is CONFIG_CRASH_MAX_MEMORY_RANGES even a Kconfig item and not
>> something you discover from the hardware?
>
> No, is the short answer.
>
>>
>> Your help text talks about System RAM entries in /proc/iomem which means
>> that those entries are present somewhere in the kernel and you can read
>> them out and do the proper calculations dynamically instead of doing the
>> static CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES thing.
>
> The intent is to compute the max size buffer needed to contain a 
> maximum populated elfcorehdr, which is primarily based on the number 
> of CPUs and memory regions. Thus far I (and others involved) have not 
> found a kernel method to determine the maximum number of memory 
> regions possible (if you are aware of one, please let me know!). Thus 
> CONFIG_CRASH_MAX_MEMORY_RANGES was born (rather borrowed from 
> kexec-tools).
>
> So no dynamic computation is possible, yet.
>
>>
>>> , but it all comes down to System RAM entries.
>>>
>>> I could perhaps offer an overly simplified example such that for 
>>> 1GiB block
>>> size, for example, the CRASH_MAX_MEMORY_RANGES of 32768 would allow 
>>> for 32TiB
>>> of memory?
>>
>> Yes, and stick it somewhere in Documentation/admin-guide/kdump/ and
>> refer to it in that help text so that people can find it and read how to
>> use your new option.
>>
> ok
>
>>> The kbuf.bufsz value is obtained via a call to 
>>> prepare_elf_headers(); I can
>>> not initialize it at its declaration.
>>
>> Sorry, I meant this:
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 8fc7d678ac72..ee6fd9f1b2b9 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -395,8 +395,9 @@ int crash_load_segments(struct kimage *image)
>>       if (ret)
>>           return ret;
>>   -    image->elf_headers = kbuf.buffer;
>> -    image->elf_headers_sz = kbuf.bufsz;
>> +    image->elf_headers    = kbuf.buffer;
>> +    image->elf_headers_sz    = kbuf.bufsz;
>> +    kbuf.memsz        = kbuf.bufsz;
>>     #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>       /* Ensure elfcorehdr segment large enough for hotplug changes */
>> @@ -407,9 +408,8 @@ int crash_load_segments(struct kimage *image)
>>       image->elf_headers_sz = kbuf.memsz;
>>       image->elfcorehdr_index = image->nr_segments;
>>       image->elfcorehdr_index_valid = true;
>> -#else
>> -    kbuf.memsz = kbuf.bufsz;
>>   #endif
>> +
>>       kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>       ret = kexec_add_buffer(&kbuf);
>>
> ok
>
>>> I'm at a loss as to what to do differently here. You've raised this 
>>> issue
>>> before and I went back and looked at the suggestions then and I 
>>> don't see
>>> how that applies to this situation. How is this situation different 
>>> than the
>>> #ifdef CONFIG_KEXEC_FILE that immediately preceeds it?
>>
>> See the diff at the end. I'm not saying this is how you should do it
>> but it should give you a better idea. The logic being, the functions
>> in the .c file don't really need ifdeffery around them - you're adding
>> 1-2 functions and crash.c is not that big - so they can be built in
>> unconditionally. You'd need the ifdeffery *in the header only* when
>> crash.c is not being built.
> ok; I've overlooked that scenario.
>>
>> But I've done it with ifdeffery in the .c file now because yes, the
>> kexec code is a minefield of ifdeffery. Hell, there's ifdeffery even in
>> the headers for structs. Ifdeffery you don't really need. Someone should
>> clean that up and simplify this immensely.
>
> ok
>
>>
>>> Currently there is a concurrent effort for PPC support by Sourabh
>>> Jain, and in that effort arch_map_crash_pages() is using __va(paddr).
>>
>> Why?
>>
>>> I do not know the nuances between kmap_local_page() and __va() to
>>> answer the question.
>>
>> kmap_local_page() is a generic interface and it should work on any arch.
>>
>> And it is documented even:
>>
>> $ git grep kmap_local_page Documentation/
>>
>>> If kmap_local_page() works for all archs, then I'm happy to drop these
>>> arch_ variants and use it directly.
>>
>> Yes, pls do.
>
> I'll check with Sourabh to see if PPC can work with kmap_local_page().
I think kmap_local_page do support on  PowerPC. But can you explain why 
we need this
function here, aren't the reserve memory already available to use?

Thanks,
Sourabh Jain
