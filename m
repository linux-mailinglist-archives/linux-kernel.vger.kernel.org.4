Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01AB670E93
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjARAZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjARAZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:25:26 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8984122A22;
        Tue, 17 Jan 2023 15:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673999103; x=1705535103;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yRAj52TJXXQI7DbN25/qqe3O0In7LmTi9Nz1dx4VU9I=;
  b=K3pK+FeFmgvDA4gv620kVQMcU52oeqOX5koum6IXE66hxYaneda1ED1+
   w45YWBRmpxDk9uKA0EcKjgpzVQ+F5iJwCp8EUT1QvT3wVpG2yXN+mQRgL
   1Di0oxUOXFVgELzjpdlohOj2tG/aZWqAAUxCthQ7/dXfKTEf3UdaaBq9g
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Jan 2023 15:45:03 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 15:45:02 -0800
Received: from [10.110.15.184] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 15:45:02 -0800
Message-ID: <2faf67fe-b1df-d110-6d57-67f284cd5584@quicinc.com>
Date:   Tue, 17 Jan 2023 15:45:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [RFC] memory pressure detection in VMs using PSI mechanism for
 dynamically inflating/deflating VM memory
Content-Language: en-US
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
From:   Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
In-Reply-To: <acd8d55c-8528-bb21-488e-e5999c3c4e4e@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello David, thanks for your comments.


On 1/17/2023 7:33 AM, David Hildenbrand wrote:
> On 15.01.23 04:57, Sudarshan Rajagopalan wrote:
>> Hello all,
>>
>
> Hi,
>
> I'll focus on the virtio-mem side of things :)
>
>> We’re from the Linux memory team here at Qualcomm. We are currently
>> devising a VM memory resizing feature where we dynamically inflate or
>> deflate the Linux VM based on ongoing memory demands in the VM. We
>> wanted to propose few details about this userspace daemon in form of RFC
>> and wanted to know the upstream’s opinion. Here are few details –
>
> I'd avoid using the terminology of inflating/deflating VM memory when 
> talking about virtio-mem. Just call it "dynamically resizing VM 
> memory". virtio-mem is one way of doing it using memory devices.
>
> Inflation/deflation, in contrast, reminds one of a traditional balloon 
> driver, along the lines of virtio-balloon.

Ok sure, duly noted :). "dynamically resizing VM memory" makes more 
sense when using virtio-mem.

>
>>
>> 1. This will be a native userspace daemon that will be running only in
>> the Linux VM which will use virtio-mem driver that uses memory hotplug
>> to add/remove memory. The VM (aka Secondary VM, SVM) will request for
>> memory from the host which is Primary VM, PVM via the backend hypervisor
>> which takes care of cross-VM communication.
>>
>> 2. This will be guest driver. This daemon will use PSI mechanism to
>> monitor memory pressure to keep track of memory demands in the system.
>> It will register to few memory pressure events and make an educated
>> guess on when demand for memory in system is increasing.
>
> Is that running in the primary or the secondary VM?

The userspace PSI daemon will be running on secondary VM. It will talk 
to a kernel driver (running on secondary VM itself) via ioctl. This 
kernel driver will talk to slightly modified version of virtio-mem 
driver where it can call the virtio_mem_config_changed(virtiomem_device) 
function for resizing the secondary VM. So its mainly "guest driven" now.

>
>>
>> 3. Currently, min PSI window size is 500ms, so PSI monitor sampling
>> period will be 50ms. In order to get quick response time from PSI, we’ve
>> reduced the min window size to 50ms so that as small as 5ms increase in
>> memory pressure can be reported to userspace by PSI.
>>
>> /* PSI trigger definitions */
>> -#define WINDOW_MIN_US 500000   /* Min window size is 500ms */
>> +#define WINDOW_MIN_US 50000    /* Min window size is 50ms */
>>
>> 4. Detecting increase in memory demand – when a certain usecase starts
>> in VM that does memory allocations, it will stall causing PSI mechanism
>> to generate a memory pressure event to userspace. To simply put, when
>> pressure increases certain set threshold, it can make educated guess
>> that a memory requiring usecase has ran and VM system needs memory to be
>> added.
>>
>> 5. Detecting decrease in memory pressure – the reverse part where we
>> give back memory to PVM when memory is no longer needed is bit tricky.
>> We look for pressure decay and see if PSI averages (avg10, avg60,
>> avg300) go down, and along with other memory stats (such as free memory
>> etc) we make an educated guess that usecase has ended and memory has
>> been free’ed by the usecase, and this memory can be given back to PVM
>> when its no longer needed.
>>
>> 6. I’m skimming much on the logic and intelligence but the daemon relies
>> on PSI mechanism to know when memory demand is going up and down, and
>> communicates with virtio-mem driver for hot-plugging/unplugging memory.
>
> For now, the hypervisor is in charge of triggering a virtio-mem device 
> resize request. Will the Linux VM expose a virtio-mem device to the 
> SVM and request to resize the SVM memory via that virtio-mem device?

Yes, the Linux VM will expose virtio-mem device where the Linux VM 
itself can ask to resize its VM memory.


>
>> We also factor in the latency involved with roundtrips between SVM<->PVM
>> so we size the memory chuck that needs to be plugged-in accordingly.
>>
>> 7. The whole purpose of daemon using PSI mechanism is to make this si
>> guest driven rather than host driven, which currently is the case mostly
>> with virtio-mem users. The memory pressure and usage monitoring happens
>> inside the SVM and the SVM makes the decisions to request for memory
>> from PVM. This avoids any intervention such as admin in PVM to monitor
>> and control the knobs. We have also set max limit of how much SVMs can
>> grow interms of memory, so that a rouge VM would not abuse this scheme.
>
> Something I envisioned at some point is to
> 1) Have a virtio-mem guest driver to request a size change. The
>    hypervisor will react accordingly by adjusting the requested size.
>
>    Such a driver<->device request could be communicated via any other
>    communication mechanism to the hypervisor, but it already came up a
>    couple of times to do it via the virtio-mem protocol directly.
>
> 2) Configure the hypervisor to have a lower/upper range. Within that
>    range, resize requests by the driver can be granted. The current
>    values of these properties can be exposed via the device to the
>    driver as well.
>
> Is that what you also proposing here? If so, great.

Actually this is exactly what we are doing here. The virtio-mem guest 
driver requests size change and hypervisor reacts to this size change 
and adds/removes the requested size memory into IPA space of VM. The 
virtio-mem guest driver then plugs in/out this memory via memory 
hotplug. I think the driver communicates to hypervisor via virtio 
protocol itself.

Currently we're setting min/max limit within the virtio-mem guest driver 
itself on how much VM memory can be resized to. This limit can ofcourse 
be set in hypervisor for security reasons but we're still in 
experimentation stage now.

>
>>
>> This daemon is currently in just Beta stage now and we have basic
>> functionality running. We are yet to add more flesh to this scheme to
>
> Good to hear that the basics are running with virtio-mem (I assume :) ).
>
>> make sure any potential risks or security concerns are taken care as 
>> well.
>
> It would be great to draw/explain the architecture in more detail.

We will be looking into solving any potential security concerns where 
hypervisor would restrict few actions of resizing of memory. Right now, 
we are experimenting to see if PSI mechanism itself can be used for ways 
of detecting memory pressure in the system and add memory to secondary 
VM when memory is in need. Taking into account all the latencies 
involved in the PSI scheme (i.e. time when one does malloc call till 
when extra memory gets added to SVM system). And wanted to know 
upstream's opinion on such a scheme using PSI mechanism for detecting 
memory pressure and resizing SVM accordingly.


