Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5D8679D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjAXPVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjAXPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:21:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253FEC62
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674573636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDb2U5bj4qLnGLbCg1xC9iOAx4lXLgAzJbxtIVGln6c=;
        b=X3qKkMi1B0tcKoGiTElr0QHaGmVR3dLrv9W30S1Tged1oibXn+UJoR+nw1Oe2LBag0XLDl
        9fn65ACdDyEcKe8Vslq2MEjfiAMW2q5ywFBzKTGhTnKHVhqvqiiXJ7vXDtusquhP/7+cOV
        V6lTg67L7SqGH4mjcBpoSQCoxj+Nkyk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-7ueniXzeOwSUOYSulVb5zQ-1; Tue, 24 Jan 2023 10:20:35 -0500
X-MC-Unique: 7ueniXzeOwSUOYSulVb5zQ-1
Received: by mail-wm1-f71.google.com with SMTP id q19-20020a1cf313000000b003d96c95e2f9so4062825wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDb2U5bj4qLnGLbCg1xC9iOAx4lXLgAzJbxtIVGln6c=;
        b=CwAFgBDfbtU/qT8S8D3XxSJiPKKMUN+4bHgIKQr4AiMEH2bNZjsejYJMnTm+Zr7Ehg
         3lQZBOkEaXIzJBSFaVPZYefc47OiLZ5wmNucN17GdUcTO4MWcSvN748YQvSoeaPY9fMJ
         7imtBwS5w+fjVTtjwpGCF+KyD+q+PnEP66i/Rg3/F4b0krylrBxPmLTvYEiYVkyJAHsp
         vv01OVnHA3kOhOE/8KL7bDv6N8idbKD+bzMjOQD8Bn85vfo6KhdRNw44SoJWkXR1IOs1
         HSqb84MvJzsPY9TliTobLY2KIduNJAc6RIYAfSbknNe5RjkpL7gi9ezNBFQ2v7CqsCDY
         3syg==
X-Gm-Message-State: AFqh2koyhGcSR4fzp/DwoxcHr1xNOKc5Z6nwRCoIZb9r188D1d0sVFF9
        9ofa2Wxxid6SgCHFSCEuj3W1nGgZUbjFYODxbAf77u8AZ1lyLgwuWzuDe6e+bCPVDaGQBas11zJ
        JCVAeLjueHV4DTZE8/Anqb2G5
X-Received: by 2002:a05:600c:3412:b0:3d6:e790:c9a0 with SMTP id y18-20020a05600c341200b003d6e790c9a0mr29312389wmp.10.1674573633775;
        Tue, 24 Jan 2023 07:20:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvTaxaYATaMQGSOLQgsxj0xqFj+ZcmGJtf/QfZ434oHCSFRqhTuzzUTnrOVqXVi5jH2mRZ+0Q==
X-Received: by 2002:a05:600c:3412:b0:3d6:e790:c9a0 with SMTP id y18-20020a05600c341200b003d6e790c9a0mr29312359wmp.10.1674573633416;
        Tue, 24 Jan 2023 07:20:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id f31-20020a05600c491f00b003cfa81e2eb4sm2221227wmp.38.2023.01.24.07.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:20:32 -0800 (PST)
Message-ID: <1bf30145-22a5-cc46-e583-25053460b105@redhat.com>
Date:   Tue, 24 Jan 2023 16:20:31 +0100
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
 <de3f1fd1-bcec-c6e5-e57a-b06674144c3b@redhat.com>
 <c38fa123-7750-20de-ed0b-de3346bddc82@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] memory pressure detection in VMs using PSI mechanism for
 dynamically inflating/deflating VM memory
In-Reply-To: <c38fa123-7750-20de-ed0b-de3346bddc82@quicinc.com>
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

On 24.01.23 00:04, Sudarshan Rajagopalan wrote:
[...]
>> One problematic thing is that adding memory to Linux by virtio-mem
>> eventually consumes memory (e.g., the memmap), especially when having
>> to to add a completely new memory block to Linux.
>>
> Yes we have thought about this issue as well where-in when system is
> heavily on memory pressure, it would require some memory for memmap
> metadata, and also few other places in memory hotplug that it would need
> to alloc_pages for hot-plugging in. I think this path in memory_hotplug
> may be fixed where it doesn't rely on allocating some small portion of
> memory for hotplugging. But, the purpose memory_hotplug itself wasn't
> for plugging memory on system being in memory pressure :).

Some small allocations might be classified as "urgent" and go to atomic 
reserves (e.g., resource tree node, memory device node). The big 
allocations (memmap, page-ext if enabled, eventually page tables for 
direct map when not mapping huge pages) are the problematic "memory 
consumers" I think.

> 
> 
>> So if you're already under severe memory pressure, these allocations
>> to bring up new memory can fail. The question is, if PSI can notify
>> "early" enough such that this barely happens in practice.
>>
>> There are some possible ways to mitigate:
>>
>> 1) Always keep spare memory blocks by virtio-mem added to Linux, that
>> B B  don't expose any memory yet. Memory from these block can be handed
>> B B  over to Linux without additional Linux allocations. Of course, they
>> B B  consume metadata, so one might want to limit them.
>>
>> 2) Implement memmap_on_memory support for virtio-mem. This might help in
>> B B  some setups, where the device block size is suitable.
>>
>> Did you run into that scenario already during your experiments, and
>> how did you deal with that?
>>
> We are exactly implementing 2) you had mentioned i.e. enabling
> memmap_on_memory support for virtio-mem. This always guarantees that
> free memory is always present for memmap metadata while hotplugging. But
> this required us to increase memory block size to 256MB (from 128MB) for
> alignment requirement of memory hotplug to enable memory_on_memmap, for
> 4K page size configuration. Option 1) you mentioned also seems

The memmap of 128 MiB is 2 MiB. Assuming the pageblock size is 2 MiB, 
and virtio-mem supports a device block size of 2 MiB, it should "in 
theory" also work with 128 MiB memory blocks.

So I'd be curious why the change to 256 MiB was required. Maybe, that 
kernel config ends up with a pageblock size of 4 MiB (IIRC that can 
happen without CONFIG_HUGETLB -- which we should most probbaly change to 
also be PMD_ORDER due to THP).

> interesting - its good to have some spare memory in hand when system is
> heavily in memory pressure so that this memory can be handed over
> immediately on PSI pressure and doesn't have to wait for memory plug-in
> request roundtrip from Primary VM.

The idea was that you'd still do the roundtrip to request plugging of 
device memory blocks, but that you could immediately expose memory to 
the system (without requiring allocations), to eventually immediately 
prepare the next Linux memory block while "fresh" memory is available.

This way you could handle most allocations that happen when adding a 
Linux memory block.

The main idea was to always have at least one spare one lying around. 
And as soon as you start exposing memory from one of them to the page 
allocator, immediately prepare the next one.

> 
> Do you think having memmap_on_memory support for virtio-mem is useful to
> have? If so, we can send the patch that supports this in virtio-mem?
> 

I think yes. However, last time I though about adding support, I 
realized that there are some ugly corner cases to handle cleanly.

You have to make sure that the device memory blocks to-be-used as memmap 
are "plugged" even before calling add_memory_driver_managed(). And you 
can only "unplug" these device memory blocks after the memory block was 
removed via offline_and_remove_memory().

So the whole order of events and management of plugged device blocks 
changes quite a bit ...

... and what to do if the device block size is, say 4MiB, but the memmap 
is 2 MiB? Of course, one could simply skip the optimization then.

Having that said, if you managed to get it running and it's not too 
ugly, please share.

-- 
Thanks,

David / dhildenb

