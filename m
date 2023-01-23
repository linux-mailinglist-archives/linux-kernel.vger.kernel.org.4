Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DAC677817
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjAWKA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjAWKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:00:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3122038
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674467933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqxVJDgcGhaPuWMeQPrfnb0idJyOysfRMbpPEBhyxTU=;
        b=gbFvHiQ06zyjCNWw5hRVTBnQbawrlY375aMPs2VEmoXi8UHDEyr541QOsGs+DZVtqenCrs
        RCqbjpZvaz+hGoSFQFpw7sM9OKALpzY0S5mrBHfHIk27qAABUROecEIznMg4KWxUUa9PV3
        wxVnGezrRvw74SHTrhe/utklur854y8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-620-EVNyw7wlPTqfIK531uqJuQ-1; Mon, 23 Jan 2023 04:58:52 -0500
X-MC-Unique: EVNyw7wlPTqfIK531uqJuQ-1
Received: by mail-wm1-f69.google.com with SMTP id fl5-20020a05600c0b8500b003db12112fdeso7245374wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqxVJDgcGhaPuWMeQPrfnb0idJyOysfRMbpPEBhyxTU=;
        b=kiHyQNa7nlfNWXdp0/eg6HrN8p61M8HcXc50ZvDkmg8GHqniK+q4bhU4IpEPmMsR9d
         uCobJAAE48AY/VkNhCpTZ7DspYHVr4f6MQETFm7uZFiBSJ3DpDeaYB8vFskw+Be5GHCe
         Lh74A9vVPPpRzJ5H/MA9ZHGE7Eo89bFeOO8Tc/jdPylqnoETJa/RlgoNLz2v1+N5C0po
         sh7NvkgUtgveOMNatyzM8Z2wBIDfmv7tZivSW81q6LSR9Wegtom4wx4xvErpdAX1g7Pi
         aiJeE5S7c9bJNYZUR+DcKbRlEwaFNpyTy3k3BUeEn6b6gkOkwrQpkYEdBNS3OOsDSoCa
         pD3w==
X-Gm-Message-State: AFqh2kqKV6+/T8Z1sAmdYBgRIAqeI6zU0r0ZY4mOdatVPZ5b06Sxrt+U
        RelVegnG1unK/hCoQ1rl6/AEoEtQjct4tC4sdIfHnoSKhomkR78+KTQWfxSxs0Ix37aYsBSr+8F
        K8vczf7k65hqN0Zy8Sxq3AX7z
X-Received: by 2002:adf:f6cf:0:b0:2bc:858a:3def with SMTP id y15-20020adff6cf000000b002bc858a3defmr29393210wrp.5.1674467930997;
        Mon, 23 Jan 2023 01:58:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXstu8PcgHyGx2MksVilHw4EWMLVNPr4EaFuPknof9TNabDZ9AHTOwZsX8ISDp5PVXt4YaBMkQ==
X-Received: by 2002:adf:f6cf:0:b0:2bc:858a:3def with SMTP id y15-20020adff6cf000000b002bc858a3defmr29393191wrp.5.1674467930702;
        Mon, 23 Jan 2023 01:58:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id l14-20020a5d526e000000b0028e55b44a99sm24225816wrc.17.2023.01.23.01.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:58:50 -0800 (PST)
Message-ID: <de3f1fd1-bcec-c6e5-e57a-b06674144c3b@redhat.com>
Date:   Mon, 23 Jan 2023 10:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, will@kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Cc:     "Trilok Soni (QUIC)" <quic_tsoni@quicinc.com>,
        "Sukadev Bhattiprolu (QUIC)" <quic_sukadev@quicinc.com>,
        "Srivatsa Vaddagiri (QUIC)" <quic_svaddagi@quicinc.com>,
        "Patrick Daly (QUIC)" <quic_pdaly@quicinc.com>
References: <072de3f4-6bd3-f9ce-024d-e469288fc46a@quicinc.com>
 <acd8d55c-8528-bb21-488e-e5999c3c4e4e@redhat.com>
 <2faf67fe-b1df-d110-6d57-67f284cd5584@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] memory pressure detection in VMs using PSI mechanism for
 dynamically inflating/deflating VM memory
In-Reply-To: <2faf67fe-b1df-d110-6d57-67f284cd5584@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>
>>> 1. This will be a native userspace daemon that will be running only in
>>> the Linux VM which will use virtio-mem driver that uses memory hotplug
>>> to add/remove memory. The VM (aka Secondary VM, SVM) will request for
>>> memory from the host which is Primary VM, PVM via the backend hypervisor
>>> which takes care of cross-VM communication.
>>>
>>> 2. This will be guest driver. This daemon will use PSI mechanism to
>>> monitor memory pressure to keep track of memory demands in the system.
>>> It will register to few memory pressure events and make an educated
>>> guess on when demand for memory in system is increasing.
>>
>> Is that running in the primary or the secondary VM?
> 
> The userspace PSI daemon will be running on secondary VM. It will talk
> to a kernel driver (running on secondary VM itself) via ioctl. This
> kernel driver will talk to slightly modified version of virtio-mem
> driver where it can call the virtio_mem_config_changed(virtiomem_device)
> function for resizing the secondary VM. So its mainly "guest driven" now.

Okay, thanks.

[...]

>>>
>>> This daemon is currently in just Beta stage now and we have basic
>>> functionality running. We are yet to add more flesh to this scheme to
>>
>> Good to hear that the basics are running with virtio-mem (I assume :) ).
>>
>>> make sure any potential risks or security concerns are taken care as
>>> well.
>>
>> It would be great to draw/explain the architecture in more detail.
> 
> We will be looking into solving any potential security concerns where
> hypervisor would restrict few actions of resizing of memory. Right now,
> we are experimenting to see if PSI mechanism itself can be used for ways
> of detecting memory pressure in the system and add memory to secondary
> VM when memory is in need. Taking into account all the latencies
> involved in the PSI scheme (i.e. time when one does malloc call till
> when extra memory gets added to SVM system). And wanted to know
> upstream's opinion on such a scheme using PSI mechanism for detecting
> memory pressure and resizing SVM accordingly.

One problematic thing is that adding memory to Linux by virtio-mem 
eventually consumes memory (e.g., the memmap), especially when having to 
to add a completely new memory block to Linux.

So if you're already under severe memory pressure, these allocations to 
bring up new memory can fail. The question is, if PSI can notify "early" 
enough such that this barely happens in practice.

There are some possible ways to mitigate:

1) Always keep spare memory blocks by virtio-mem added to Linux, that
    don't expose any memory yet. Memory from these block can be handed
    over to Linux without additional Linux allocations. Of course, they
    consume metadata, so one might want to limit them.

2) Implement memmap_on_memory support for virtio-mem. This might help in
    some setups, where the device block size is suitable.

Did you run into that scenario already during your experiments, and how 
did you deal with that?

-- 
Thanks,

David / dhildenb

