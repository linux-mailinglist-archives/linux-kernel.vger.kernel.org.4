Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA585F07C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiI3Jkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiI3Jk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF22B95AD6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664530822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOAQx+cKWm3EbsMD3IkvLXTlFRxCvE0EcUoclGvdQRk=;
        b=SlfZVBM373e4mmboqA9FDQebNr6R6ftmIqhCEtwvwvppBMUhkXbp60USHjSpueMvMD+7E3
        cTAR/WjvBUBQxs3nepw3mifwvnAi4PD6FyzVPLUb2geh717au9Mrfv/vV/eK/flEZEaZvK
        iFrtxAmLdMDIYhSVPw6YxpxpLmU+inI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-rAUavzgcM2iwjkmjeyfLrA-1; Fri, 30 Sep 2022 05:40:21 -0400
X-MC-Unique: rAUavzgcM2iwjkmjeyfLrA-1
Received: by mail-wr1-f71.google.com with SMTP id d18-20020adfa352000000b0022cbe33d2a5so1385165wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=bOAQx+cKWm3EbsMD3IkvLXTlFRxCvE0EcUoclGvdQRk=;
        b=2MjHQI/BDu97EoTAFom1EtXdMmiEmKyg02MazfUSLF6urproWsE+xZSlsjj+zG4msx
         Cq8N3QgtouZ1IAXn6ITfsDiiU2vAv5SeShQ0VUYHx+IbdQb0mMXqOdQw6d3Sm1cN5XJP
         vLRNAwHlVkriG+lWkSMH+cFJvgAbGW8NXIZuCoH2QNT7iWNtTJ5Kuz5MiA3Z3/BrUbR+
         bFmaNLZdgvyBSA5GvvnWcs3WZvbkAcGuDXQM3ZFrlti9zRmTRlBZ0rZsTDd3FFvQAAhY
         SyBEnz1wQklp2M5YixXnarvLiI3XNPtymxtmzYIgiVZ0457bXkpVz0xKjYeUemPTtY9W
         ohuQ==
X-Gm-Message-State: ACrzQf1rfJV+/iEBQZN82DP+pe8EfbBwuQcaM4DBxNFGEm+wSMTJ1sUw
        EYpptETVKVY/1oJfmPCl9O++Vocj9ZFecznO8P552L/KdrZEaSCLaWsXrzLlwOwYkpc/taTo8f+
        47pOq06pz4qsD1lGqZ0du+g5M
X-Received: by 2002:a05:6000:1f0c:b0:22c:c601:a824 with SMTP id bv12-20020a0560001f0c00b0022cc601a824mr5038490wrb.215.1664530819904;
        Fri, 30 Sep 2022 02:40:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4wSi36ADBqOfJFTbQ3pc2S/28fuP8wBvQBDe+GN6q1SBsyZPPoGxYPsjyMvmMHN12NSYfsHg==
X-Received: by 2002:a05:6000:1f0c:b0:22c:c601:a824 with SMTP id bv12-20020a0560001f0c00b0022cc601a824mr5038469wrb.215.1664530819599;
        Fri, 30 Sep 2022 02:40:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:c00:48b:b68a:f9e0:ebce? (p200300cbc70c0c00048bb68af9e0ebce.dip0.t-ipconnect.de. [2003:cb:c70c:c00:48b:b68a:f9e0:ebce])
        by smtp.gmail.com with ESMTPSA id m64-20020a1ca343000000b003a6125562e1sm1478481wme.46.2022.09.30.02.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:40:19 -0700 (PDT)
Message-ID: <917e6889-2478-1992-6ef9-1b2ad450b02f@redhat.com>
Date:   Fri, 30 Sep 2022 11:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/3] ksm: fix incorrect count of merged pages when
 enabling use_zero_pages
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     xu.xin.sc@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
 <4a3daba6-18f9-d252-697c-197f65578c44@redhat.com>
 <20220929123630.0951b199@p-imbrenda>
 <745f75a4-6a2a-630f-8228-0c5e081588e7@redhat.com>
 <20220929140548.1945dccf@p-imbrenda>
 <1fc6984b-bcc7-123d-1ea3-9e04d5b26529@redhat.com>
 <20220930113047.60800177@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220930113047.60800177@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>    
>>>>   
>>>>>
>>>>> second, once a page is merged with a zero page, it's not really handled
>>>>> by KSM anymore. if you have a big allocation, of which you only touch a
>>>>> few pages, would the rest be considered "merged"? no, it's just zero
>>>>> pages, right?
>>>>
>>>> If you haven't touched memory, there is nothing populated -- no shared
>>>> zeropage.
>>>>
>>>> We only populate shared zeropages in private anonymous mappings on read
>>>> access without prior write.
>>>
>>> that's what I meant. if you read without writing, you get zero pages.
>>> you don't consider those to be "shared" from a KSM point of view
>>>
>>> does it make a difference if some pages that have been written to but
>>> now only contain zeroes are discarded and mapped back to the zero pages?
>>
>> That's a good question. When it comes to unmerging, you'd might expect
>> that whatever was deduplicated will get duplicated again -- and your
>> memory consumption will adjust accordingly. The stats might give an
>> admin an idea regarding how much memory is actually overcommited. See
>> below on the important case where we essentially never see the shared
>> zeropage.
>>
>> The motivation behind these patches would be great -- what is the KSM
>> user and what does it want to achieve with these numbers?
> 
> anyone who works on big amounts of very sparse data, especially in a VM
> (as I explained above, with KSM without use_zero_pages KVM guests lose
> the zero page colouring)

I meant the patches in question here :)

> 
>>
>>>    
>>>>   
>>>>> this is the same, except that we take present pages with zeroes in it
>>>>> and we discard them and map them to zero pages. it's kinda like if we
>>>>> had never touched them.
>>>>
>>>> MADV_UNMERGEABLE
>>>>
>>>> "Undo  the effect of an earlier MADV_MERGEABLE operation on the
>>>> specified address range; KSM unmerges whatever pages it had merged in
>>>> the address range specified  by  addr  and length."
>>>>
>>>> Now please explain to me how not undoing a zeropage merging is correct
>>>> according to this documentation.
>>>>   
>>>
>>> because once it's discarded and replaced with a zero page, the page is
>>> not handled by KSM anymore.
>>>
>>> I understand what you mean, that KSM did an action that now cannot be
>>> undone, but how would you differentiate between zero pages that were
>>> never written to and pages that had been written to and then discarded
>>> and mapped back to a zero page because they only contained zeroes?
>>
>> An application that always properly initializes (write at least some
>> part once) all its memory will never have the shared zeropage mapped. VM
>> guest memory comes to mind, probably still the most important KSM use case.
>>
>> There are currently some remaining issues when taking a GUP R/O longterm
>> pin on such a page (e.g., vfio). In contrast to KSM pages, such pins are
>> not reliable for the shared zeropage, but I have fixes for them pending.
>> However, that is rather a corner case (it didn't work at all correctly a
>> while ago) and will be sorted out soon.
>>
>> So the question is if MADV_UNMERGEABLE etc. (stats) should be adjusted
>> to document the behavior with use_zero_pages accordingly.
> 
> we can count how many times a page full of zeroes was merged with a
> zero-page, but we can't count how many time one of those pages was then
> unmerged. once it's merged it becomes a zero-page, like the others.

Right. We could special case on MADV_MERGEABLE ("how many zero pages do 
we have mapped into MADV_MERGEABLE VMAs"), but it gets tricky once we 
enable MADV_MERGEABLE on a region where the shared zeropage was already 
populated. Probably not worth the effort.


-- 
Thanks,

David / dhildenb

