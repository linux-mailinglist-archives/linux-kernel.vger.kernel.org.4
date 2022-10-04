Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB85F3D00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJDHEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJDHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:04:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B038464
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:04:17 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2946DE2L007396;
        Tue, 4 Oct 2022 07:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PsbYHhYhSjEUP7TMrDg+LdtNZZu13uv3scw4FNqS2O8=;
 b=Z+2B8CSh1mbL9SwEjthWHxn5laCv3xjGWb+xuUpdM9Ws7i0CxAyYqr8IwX8V7lmZ5wN9
 qwgWCBLXGC3W/gsyftstOYqe4a0wZ3SHeHfKjuv9FWtnZ9zTjHOVb/YsdGPDdd46bYEv
 pFKsEuxxbpzq2Z2P5So9N6WhIUqwdeS+7YcUSdhSMsyC5vqOcWrj/6DjlXId9zHT5Ocn
 yBh3eAd4hzutAq0B6fP2dKBlI2E/dVFptazo1uY8c4xO9jbrnbgG6NW679vBFnFM+EqC
 CnYG5aLcFc1oCY7WXM4bVKiqhi7zVuIhOiFEdHvpXDW1mskkkO51+hbdgPxermWfoqbi nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fc99846-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 07:03:34 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2946h8HA003375;
        Tue, 4 Oct 2022 07:03:34 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fc9983c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 07:03:34 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2946o7AG018527;
        Tue, 4 Oct 2022 07:03:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3jxd693qsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 07:03:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29473xhW47382908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 07:03:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7BF2A4054;
        Tue,  4 Oct 2022 07:03:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 533B9A405C;
        Tue,  4 Oct 2022 07:03:25 +0000 (GMT)
Received: from [9.43.62.42] (unknown [9.43.62.42])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 07:03:25 +0000 (GMT)
Message-ID: <a2e0b554-2ef4-1266-cc3a-fa5a28049131@linux.ibm.com>
Date:   Tue, 4 Oct 2022 12:33:24 +0530
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
X-Proofpoint-GUID: tpPz15D5o-Dkah_HZ6t6UP97IDEGba9b
X-Proofpoint-ORIG-GUID: SHFIntTXAyDTaqkgk6Nr3hhmUpGEj8Bv
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040045
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Hello Eric,

How about allocating buffer space for max program header possible in a 
elfcorehdr?

mage->elf_headers_sz = kbuf.memsz = PN_XNUM * sizeof(Elf64_Phdr);

PN_XNUM is part of linux/elf.h (include/uapi/linux/elf.h).

Refer below link for more details:
https://man7.org/linux/man-pages/man5/elf.5.html

Thanks,
Sourabh Jain

