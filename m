Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C751678BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjAWXFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjAWXFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:05:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E049D9EEA;
        Mon, 23 Jan 2023 15:04:44 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NMp1cH005194;
        Mon, 23 Jan 2023 23:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z9PLXLxtVdC8+a1V5AHZcCYIitXdwSMYg/xFBnTL4RM=;
 b=VJWPQw3ssLNvtT43nscEIwDa3EpaYq4kaYWMsJVM1bV7SyBai0S9eyuxKwxdwvTesZUq
 ZGfe98dM6u3QWciqrKfOdg74Fqyh9jIXBc3TSOZukFYeyDY186etQ89sb8y9UOtqMsaV
 Eg86gNviSV0TscCDrXx2Ybox06v7diUv8e9Rf3Qt23/QHkWpH63kCCNM+uowVvjQYSio
 hGVBdB06A7+Z80K7FTLvmePETV5DvnG/JJeL/yf6R0aLo3TTT0a/FVYijeZUmODucOIw
 /XJhYbYsMkV+6z2a/7GfJkyQpOAx9HglajY3Vj5DVyM80rHX3qPZywE9Pp5GEOQGp2lD Qg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89hk3xqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 23:04:23 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30NN4MR6019112
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 23:04:22 GMT
Received: from [10.110.42.249] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 15:04:21 -0800
Message-ID: <c38fa123-7750-20de-ed0b-de3346bddc82@quicinc.com>
Date:   Mon, 23 Jan 2023 15:04:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
From:   Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Subject: Re: [RFC] memory pressure detection in VMs using PSI mechanism for
 dynamically inflating/deflating VM memory
To:     David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <virtualization@lists.linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     "Trilok Soni (QUIC)" <quic_tsoni@quicinc.com>,
        "Sukadev Bhattiprolu (QUIC)" <quic_sukadev@quicinc.com>,
        "Srivatsa Vaddagiri (QUIC)" <quic_svaddagi@quicinc.com>,
        "Patrick Daly (QUIC)" <quic_pdaly@quicinc.com>
References: <072de3f4-6bd3-f9ce-024d-e469288fc46a@quicinc.com>
 <acd8d55c-8528-bb21-488e-e5999c3c4e4e@redhat.com>
 <2faf67fe-b1df-d110-6d57-67f284cd5584@quicinc.com>
 <de3f1fd1-bcec-c6e5-e57a-b06674144c3b@redhat.com>
Content-Language: en-US
In-Reply-To: <de3f1fd1-bcec-c6e5-e57a-b06674144c3b@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QYpq1npaZ40qG0wsl7QfIOuQIPlVMBio
X-Proofpoint-ORIG-GUID: QYpq1npaZ40qG0wsl7QfIOuQIPlVMBio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230219
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/23/2023 1:58 AM, David Hildenbrand wrote:
>>>>
>>>> 1. This will be a native userspace daemon that will be running only in
>>>> the Linux VM which will use virtio-mem driver that uses memory hotplug
>>>> to add/remove memory. The VM (aka Secondary VM, SVM) will request for
>>>> memory from the host which is Primary VM, PVM via the backend 
>>>> hypervisor
>>>> which takes care of cross-VM communication.
>>>>
>>>> 2. This will be guest driver. This daemon will use PSI mechanism to
>>>> monitor memory pressure to keep track of memory demands in the system.
>>>> It will register to few memory pressure events and make an educated
>>>> guess on when demand for memory in system is increasing.
>>>
>>> Is that running in the primary or the secondary VM?
>>
>> The userspace PSI daemon will be running on secondary VM. It will talk
>> to a kernel driver (running on secondary VM itself) via ioctl. This
>> kernel driver will talk to slightly modified version of virtio-mem
>> driver where it can call the virtio_mem_config_changed(virtiomem_device)
>> function for resizing the secondary VM. So its mainly "guest driven" 
>> now.
>
> Okay, thanks.
>
> [...]
>
>>>>
>>>> This daemon is currently in just Beta stage now and we have basic
>>>> functionality running. We are yet to add more flesh to this scheme to
>>>
>>> Good to hear that the basics are running with virtio-mem (I assume 
>>> :) ).
>>>
>>>> make sure any potential risks or security concerns are taken care as
>>>> well.
>>>
>>> It would be great to draw/explain the architecture in more detail.
>>
>> We will be looking into solving any potential security concerns where
>> hypervisor would restrict few actions of resizing of memory. Right now,
>> we are experimenting to see if PSI mechanism itself can be used for ways
>> of detecting memory pressure in the system and add memory to secondary
>> VM when memory is in need. Taking into account all the latencies
>> involved in the PSI scheme (i.e. time when one does malloc call till
>> when extra memory gets added to SVM system). And wanted to know
>> upstream's opinion on such a scheme using PSI mechanism for detecting
>> memory pressure and resizing SVM accordingly.
>
> One problematic thing is that adding memory to Linux by virtio-mem 
> eventually consumes memory (e.g., the memmap), especially when having 
> to to add a completely new memory block to Linux.
>
Yes we have thought about this issue as well where-in when system is 
heavily on memory pressure, it would require some memory for memmap 
metadata, and also few other places in memory hotplug that it would need 
to alloc_pages for hot-plugging in. I think this path in memory_hotplug 
may be fixed where it doesn't rely on allocating some small portion of 
memory for hotplugging. But, the purpose memory_hotplug itself wasn't 
for plugging memory on system being in memory pressure :).


> So if you're already under severe memory pressure, these allocations 
> to bring up new memory can fail. The question is, if PSI can notify 
> "early" enough such that this barely happens in practice.
>
> There are some possible ways to mitigate:
>
> 1) Always keep spare memory blocks by virtio-mem added to Linux, that
> B B  don't expose any memory yet. Memory from these block can be handed
> B B  over to Linux without additional Linux allocations. Of course, they
> B B  consume metadata, so one might want to limit them.
>
> 2) Implement memmap_on_memory support for virtio-mem. This might help in
> B B  some setups, where the device block size is suitable.
>
> Did you run into that scenario already during your experiments, and 
> how did you deal with that?
>
We are exactly implementing 2) you had mentioned i.e. enabling 
memmap_on_memory support for virtio-mem. This always guarantees that 
free memory is always present for memmap metadata while hotplugging. But 
this required us to increase memory block size to 256MB (from 128MB) for 
alignment requirement of memory hotplug to enable memory_on_memmap, for 
4K page size configuration. Option 1) you mentioned also seems 
interesting - its good to have some spare memory in hand when system is 
heavily in memory pressure so that this memory can be handed over 
immediately on PSI pressure and doesn't have to wait for memory plug-in 
request roundtrip from Primary VM.

Do you think having memmap_on_memory support for virtio-mem is useful to 
have? If so, we can send the patch that supports this in virtio-mem?

Also, we are looking into ways of having memmap_on_memory enabled 
without requiring to increase memory block size. This might require some 
core changes in memory_hotplug but we haven't explored it much.

