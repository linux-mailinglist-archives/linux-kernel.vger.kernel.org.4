Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3C6DEFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDLI7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjDLI7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:59:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE219EEB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:58:56 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C8AjLt020009;
        Wed, 12 Apr 2023 08:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kkZrMLK/r0rdbcYrFkrFsudkt/LnSZc4oyMDBQLpPng=;
 b=Gox/YptxQJxgvWO7l41k4K5DOOQPtR2ZMpruyWPhwHA8DfQA1RTDzr+LB78llJk9R+gT
 0vk0YOe+aYJvqOzayGz9vz4bN95jKp5nygyLDQd3BFVgwfRjF1Wclvq5kMbseI7irZOD
 98aPZnfnwEMexVnbtl0o0oHRcKQH3I5QJrD3+PuF9RlCsr9iksxp10RJymqyDAe+oYv6
 aYuLHWcIKq25VhUwq+3XYt8SV1WITQ9xxiSa5+Laar2sbxoRQrh+AWjskhdBgEC6y/ri
 5m0aX+wLC6BFMdtcZAqqxjCizZIKrPjn6mJF80+oOhxMlnIHv8ihFVG6uhfAjv1V/vxb hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwqmbvkw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 08:38:53 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33C8Rf74022033;
        Wed, 12 Apr 2023 08:38:52 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwqmbvkuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 08:38:52 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C40B5l013830;
        Wed, 12 Apr 2023 08:38:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pu0fvsvtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 08:38:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C8cmbS66257268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 08:38:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE2F62004B;
        Wed, 12 Apr 2023 08:38:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC5D720040;
        Wed, 12 Apr 2023 08:38:43 +0000 (GMT)
Received: from [9.43.75.6] (unknown [9.43.75.6])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Apr 2023 08:38:43 +0000 (GMT)
Message-ID: <3e9833e0-4069-5a75-c7e2-94b8f2aacfa8@linux.ibm.com>
Date:   Wed, 12 Apr 2023 14:08:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v21 2/7] crash: add generic infrastructure for crash
 hotplug support
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-3-eric.devolder@oracle.com>
 <ZC6nWzPuIWOxmvv2@MiWiFi-R3L-srv>
 <80767ccc-ffd4-9cb9-44e4-a8d4f0e13853@oracle.com>
Content-Language: en-US
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <80767ccc-ffd4-9cb9-44e4-a8d4f0e13853@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D83uTd-vTQXzizU20BeSmHHJxr49GL3x
X-Proofpoint-GUID: YrG-2yIYPIiDy-ClUiREl0pY4b5Sua7J
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_02,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120078
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/04/23 21:40, Eric DeVolder wrote:
>
>
> On 4/6/23 06:04, Baoquan He wrote:
>> On 04/04/23 at 02:03pm, Eric DeVolder wrote:
>> ......
>>> +static void crash_handle_hotplug_event(unsigned int hp_action, 
>>> unsigned int cpu)
>>> +{
>>> +    struct kimage *image;
>>> +
>>> +    /* Obtain lock while changing crash information */
>>> +    if (!kexec_trylock()) {
>>> +        pr_info("kexec_trylock() failed, elfcorehdr may be 
>>> inaccurate\n");
>>> +        return;
>>> +    }
>>> +
>>> +    /* Check kdump is not loaded */
>>> +    if (!kexec_crash_image)
>>> +        goto out;
>>> +
>>> +    image = kexec_crash_image;
>>> +
>>> +    if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>>> +        hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>>> +        pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
>>> +    else
>>> +        pr_debug("hp_action %u\n", hp_action);
>>
>> Seems we passed in the cpu number just for printing here. Wondering why
>> we don't print out hot added/removed memory ranges. Is the cpu number
>> printing necessary?
>>
> Baoquan,
>
> Ah, actually until recently it was used to track the 'offlinecpu' in 
> this function, but tglx pointed out that was un-necessary. That 
> resulted in dropping the code in this function dealing with 
> offlinecpu, leaving this as its only use in this function.
>
> The printing of cpu number is not necessary, but helpful; I use it for 
> debugging.
>
> The printing of memory range is also not necessary, but in order to do 
> that, should we choose to do so, requires passing in the memory range 
> to this function. This patch series did do this early on, and by v7 I 
> dropped it at your urging 
> (https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/). 
> At the time, I provided it since I considered this generic 
> infrastructure, but I could not defend it since x86 didn't need it. 
> However, PPC now needs this, and is now carrying this as part of PPC 
> support of CRASH_HOTPLUG 
> (https://lore.kernel.org/linuxppc-dev/20230312181154.278900-6-sourabhjain@linux.ibm.com/T/#u).
>
> If you'd rather I pickup the memory range handling again, I can do 
> that. I think I'd likely change this function to be:
>
>   void crash_handle_hotplug_event(unsigned int hp_action, unsigned int 
> cpu,
>      struct memory_notify *mhp);
>
> where on a CPU op the 'cpu' parameter would be valid and 'mhp' NULL, 
> and on a memory op,
> the 'mhp' would be valid and 'cpu' parameter invalid(0).
>
> I'd likely then stuff these two parameters into struct kimage so that 
> it can be utilized by arch-specific handler, if needed.
>
> And of course, would print out the memory range for debug purposes.

I think passing memory_notify as parameter is a better approach compare 
to adding the
same into struct kimage. Because once the crash hotplug event is served 
the memory_notify
object is not useful.

- Sourabh

