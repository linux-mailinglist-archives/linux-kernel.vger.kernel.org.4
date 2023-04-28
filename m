Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E296D6F1E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346487AbjD1Swf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjD1Swd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:52:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AB030D6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:52:31 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SIffHl002605;
        Fri, 28 Apr 2023 18:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=h5MMbqwNWM1UuGgEnhB+WpFKFfKQZSmOMuSC+Pj4ZQQ=;
 b=GLruJiDXuKOPHKAr4rgfpL7tZeUo10yw5VWUeuFgjyj3IiFCLl4k8mbSFpBkFU4s2FyD
 5hk3JCOZUXs3TfKnyQbRrvtDhpOoAs8N9G+Y3s20mcmsIpEhSKhdD0yIUizyyR8MNhHp
 CHgcbnNmmr0pnRV4+tRDFkkD5P/HuVqiZfr6hsONARVZNBcF0OWFklrJck0k2AgAF/zN
 OvaYbg9oSgZnlIxzP+wwIxjOnNUyBpH2FzF1PDbjC8KWxVnclxewvdYSytS0TeiooKvm
 RRmnrFDJlmzG79xmdtM8z+HiejQ2e/5sDBZqwgEbEhyFT165mgl3Ji6DKVpsdL0WDAfa GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8k8v9068-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 18:51:26 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SIpJTk017148;
        Fri, 28 Apr 2023 18:51:25 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8k8v902x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 18:51:25 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33SHcZqL024049;
        Fri, 28 Apr 2023 18:31:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3q47773qt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 18:31:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33SIVAE544368248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 18:31:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C650720040;
        Fri, 28 Apr 2023 18:31:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B451720043;
        Fri, 28 Apr 2023 18:31:04 +0000 (GMT)
Received: from [9.43.39.167] (unknown [9.43.39.167])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Apr 2023 18:31:04 +0000 (GMT)
Message-ID: <97d18ae8-468d-cff5-0a32-4f07b050899e@linux.ibm.com>
Date:   Sat, 29 Apr 2023 00:01:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v21 5/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
From:   Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <ZEuQ/hxmZey+eFZs@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NRmGodiaPurq9qe1241VYotLXV9DhjR3
X-Proofpoint-ORIG-GUID: _ddVJxwuS15o0lOIO2w8Gqf19LfZvSmA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_05,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280150
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/04/23 2:55 pm, Baoquan He wrote:
> On 04/27/23 at 10:26pm, Hari Bathini wrote:
>> On 27/04/23 2:19 pm, Baoquan He wrote:
>>> On 04/27/23 at 12:39pm, Hari Bathini wrote:
>>>> Hi Eric,
>>>>
>>>> On 04/04/23 11:33 pm, Eric DeVolder wrote:
>>>>> When CPU or memory is hot un/plugged, or off/onlined, the crash
>>>>> elfcorehdr, which describes the CPUs and memory in the system,
>>>>> must also be updated.
>>>>>
>>>>> The segment containing the elfcorehdr is identified at run-time
>>>>> in crash_core:crash_handle_hotplug_event(), which works for both
>>>>> the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
>>>>> is generated from the available CPUs and memory into a buffer,
>>>>> and then installed over the top of the existing elfcorehdr.
>>>>>
>>>>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>>>>> the need to update purgatory due to the change in elfcorehdr was
>>>>> eliminated.  As a result, no changes to purgatory or boot_params
>>>>> (as the elfcorehdr= kernel command line parameter pointer
>>>>> remains unchanged and correct) are needed, just elfcorehdr.
>>>>>
>>>>> To accommodate a growing number of resources via hotplug, the
>>>>> elfcorehdr segment must be sufficiently large enough to accommodate
>>>>> changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
>>>>> only on the kexec_file_load() syscall; for kexec_load() userspace
>>>>> will need to size the segment similarly.
>>>>>
>>>>> To accommodate kexec_load() syscall in the absence of
>>>>
>>>> Firstly, thanks! This series is a nice improvement to kdump support
>>>> in hotplug environment.
>>>>
>>>> One concern though is that this change assumes corresponding support
>>>> in kexec-tools. Without that support kexec_load would fail to boot
>>>> with digest verification failure, iiuc.
>>>
>>> Eric has posted patchset to modify kexec_tools to support that, please
>>> see the link Eric pasted in the cover letter.
>>>
>>> http://lists.infradead.org/pipermail/kexec/2022-October/026032.html
>>
>> Right, Baoquan.
>>
>> I did see that and if I read the code correctly, without that patchset
>> kexec_load would fail. Not with an explicit error that hotplug support
>> is missing or such but it would simply fail to boot into capture kernel
>> with digest verification failure.
>>
>> My suggestion was to avoid that userspace tool breakage for older
>> kexec-tools version by introducing a new kexec flag that can tell
>> kernel that kexec-tools is ready to use this in-kernel update support.
>> So, if kexec_load happens without the flag, avoid doing an in-kernel
>> update on hotplug. I hope that clears the confusion.
> 
> Yeah, sounds like a good idea. It may be extended in later patch.

Fixing it in this series itself would be a cleaner way, I guess.

Thanks
Hari
