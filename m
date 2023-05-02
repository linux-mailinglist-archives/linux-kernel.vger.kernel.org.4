Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146516F406D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjEBJwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjEBJwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:52:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD7F4EEC
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 02:51:57 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3429hxc1032441;
        Tue, 2 May 2023 09:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BI+172CeUrs2eqLfGvS2xkQJe28fVVoyE4cndnDjCUw=;
 b=XIQMeKnM7TLVdJjbB6zA5aRay/YUtAOqDBIja76wdFKUxkr+qQbV/PMLZRhU4QWvk71X
 fQXgIep7poq5ciUBUvGl5kIXHIam7ENs22nGhaMRzr+tS07Lb/0iF68xzar+6OfvayJ3
 jIzVTRJCNhQjLupuC/Lfthflmc5nG64ho6ycV4TAetriVZ2zon0xJYesq4cUQPSJKB87
 o7vgu2q2k0w/d/PZ8Ql8AlzEEZi/WXngBo5+wEqnKRFJTC1jGCIhU2sOWSE5kSEYzr4M
 XggUbZmETnTSzGSqNInB4EXJSVJyl7aYCgJJYKrrmIN56LpAsVBhGwOeRNL/vAau9n/Y xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb052r682-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 09:51:24 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3429jbLa003521;
        Tue, 2 May 2023 09:51:19 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb052r676-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 09:51:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3424EtM9024069;
        Tue, 2 May 2023 09:36:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3q8tgg1gca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 09:36:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3429aZux55640442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 May 2023 09:36:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3451520043;
        Tue,  2 May 2023 09:36:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7747220040;
        Tue,  2 May 2023 09:36:30 +0000 (GMT)
Received: from [9.43.47.187] (unknown [9.43.47.187])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  2 May 2023 09:36:30 +0000 (GMT)
Message-ID: <fff8c92a-7e82-e917-8925-584664543b90@linux.ibm.com>
Date:   Tue, 2 May 2023 15:06:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v21 5/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-6-eric.devolder@oracle.com>
 <da95e01d-24bd-676b-3a48-bafda1b36cda@linux.ibm.com>
 <ZEo3NK/9Nkc7ctrc@bhe.users.ipa.redhat.com>
 <409c8253-49b9-6993-f79e-8e6203ce4b31@linux.ibm.com>
 <ZEuQ/hxmZey+eFZs@MiWiFi-R3L-srv>
 <97d18ae8-468d-cff5-0a32-4f07b050899e@linux.ibm.com>
 <b4c5348d-c8a1-2923-6d91-d10c359adbd1@oracle.com>
From:   Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <b4c5348d-c8a1-2923-6d91-d10c359adbd1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kPDLXnqmD2UO0FJgR05o--E_CSRxVVvw
X-Proofpoint-GUID: mhs86GNDxrAFNXBo3M8rg62DRir1WZeC
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_05,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305020082
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/23 12:03 am, Eric DeVolder wrote:
> 
> 
> On 4/28/23 13:31, Hari Bathini wrote:
>>
>> On 28/04/23 2:55 pm, Baoquan He wrote:
>>> On 04/27/23 at 10:26pm, Hari Bathini wrote:
>>>> On 27/04/23 2:19 pm, Baoquan He wrote:
>>>>> On 04/27/23 at 12:39pm, Hari Bathini wrote:
>>>>>> Hi Eric,
>>>>>>
>>>>>> On 04/04/23 11:33 pm, Eric DeVolder wrote:
>>>>>>> When CPU or memory is hot un/plugged, or off/onlined, the crash
>>>>>>> elfcorehdr, which describes the CPUs and memory in the system,
>>>>>>> must also be updated.
>>>>>>>
>>>>>>> The segment containing the elfcorehdr is identified at run-time
>>>>>>> in crash_core:crash_handle_hotplug_event(), which works for both
>>>>>>> the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
>>>>>>> is generated from the available CPUs and memory into a buffer,
>>>>>>> and then installed over the top of the existing elfcorehdr.
>>>>>>>
>>>>>>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>>>>>>> the need to update purgatory due to the change in elfcorehdr was
>>>>>>> eliminated.  As a result, no changes to purgatory or boot_params
>>>>>>> (as the elfcorehdr= kernel command line parameter pointer
>>>>>>> remains unchanged and correct) are needed, just elfcorehdr.
>>>>>>>
>>>>>>> To accommodate a growing number of resources via hotplug, the
>>>>>>> elfcorehdr segment must be sufficiently large enough to accommodate
>>>>>>> changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
>>>>>>> only on the kexec_file_load() syscall; for kexec_load() userspace
>>>>>>> will need to size the segment similarly.
>>>>>>>
>>>>>>> To accommodate kexec_load() syscall in the absence of
>>>>>>
>>>>>> Firstly, thanks! This series is a nice improvement to kdump support
>>>>>> in hotplug environment.
> Thank you!
> 
>>>>>>
>>>>>> One concern though is that this change assumes corresponding support
>>>>>> in kexec-tools. Without that support kexec_load would fail to boot
>>>>>> with digest verification failure, iiuc.
> 
> Yes, you've correctly identified that if a hotplug change occurs 
> following kexec_load
> (made with kexec-tools unaltered for hotplug), then a subsequent panic 
> would in fact
> fail the purgatory digest verification, and  kdump would not happen.
> 
>>>>>
>>>>> Eric has posted patchset to modify kexec_tools to support that, please
>>>>> see the link Eric pasted in the cover letter.
>>>>>
>>>>> http://lists.infradead.org/pipermail/kexec/2022-October/026032.html
>>>>
>>>> Right, Baoquan.
>>>>
>>>> I did see that and if I read the code correctly, without that patchset
>>>> kexec_load would fail. Not with an explicit error that hotplug support
>>>> is missing or such but it would simply fail to boot into capture kernel
>>>> with digest verification failure.
> This is correct.
> 
>>>>
>>>> My suggestion was to avoid that userspace tool breakage for older
>>>> kexec-tools version by introducing a new kexec flag that can tell
>>>> kernel that kexec-tools is ready to use this in-kernel update support.
>>>> So, if kexec_load happens without the flag, avoid doing an in-kernel
>>>> update on hotplug. I hope that clears the confusion.
>>>
>>> Yeah, sounds like a good idea. It may be extended in later patch.
>>
>> Fixing it in this series itself would be a cleaner way, I guess.
> 
> You're suggestion of using a flag makes alot of sense; it is an indication
> to the kernel that it is valid/okay to modify the kexec_load elfcorehdr.
> Only kexec-tools that understands this (meaning the elfcorehdr buffer is
> appropriately sized *and* excludes the elfcorehdr from the purgatory check)
> would set that flag.
> 
> The roll-out of this feature needs to be coordinated, no doubt. There 
> are three
> pieces to this puzzle: this kernel series, the udev rule changes, and 
> the changes
> to kexec-tools for kexec_load.
> 
> I consider the udev rule changes critical to making this feature work 
> efficiently.
> I also think that deploying the udev rules immediately is doable since 
> nothing
> references them, yet; they would be NOPs. And they would be in place 
> when the
> kernel and/or kexec-tool changes deploy.
> 
> However, your point about supporting kexec_load with and without this 
> new flag
> means the sysfs nodes upon which the udev rule change rely need to be a bit
> smarter now. (I'm assuming these udev rules will be generally accepted 
> as-is,
> as they are simple and efficient.)
> 

> The sysfs crash_hotplug nodes need to take into account kexec_file_load vs
> (kexec_load && new_flag). Generally speaking these crash_hotplug sysfs 
> nodes we
> want to be 1 going forward, but where kexec_load/kexec-tools is older 
> and/or no new_flag,
> it needs to be 0. In this way the udev rules can remain as proposed and 
> work properly
> for kexec_file_load and both flavors of kexec_load.

Right. That is the tricky part. kdump scripts and kexec-tools have to
be in sync if udev rules have to just rely on crash_hotplug.

Thanks
Hari

