Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A718D6F90D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjEFJRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEFJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 05:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099A12100
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683364574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsDzLFnpYpZQjeRWWOmndbUxeGH12g+kaA80++/jh18=;
        b=KyVQlZmO02hbcK/e3yTTvGM6uds4byaXhCU12J5DTYpwalL42RQHqoBF3bPnkb0vFKMfQ8
        oZ4OC/QgKbUyhyjFIY+C8VuOa2JqgkrZGBxRL26HPWa4tWFJCLIkcS1q5cyOxjj5N+lY+s
        HHPmKB8v3JSj1+LyVJLGQZQSi+EbWlw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-BB4PLrtrM96FfVP0ZizXpA-1; Sat, 06 May 2023 05:16:08 -0400
X-MC-Unique: BB4PLrtrM96FfVP0ZizXpA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f33f8ffa95so11109205e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 02:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683364567; x=1685956567;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsDzLFnpYpZQjeRWWOmndbUxeGH12g+kaA80++/jh18=;
        b=l6MibSeRV8Elfbe7bA4WiSOVs3QCRWHw2XaI7E9O2eJVR/+7LWl+E3hQYscIB/AxE9
         gcDOWfj2FWtixsb7TOXywuU4GVIZvJ4wjmGTdV+vEhom92OeU6Yvvu8aajbScfUsDSet
         5Ge4AyydJeffiEswDbYGHFG8qxuHybjtjq7oxgbjWL5ohCav8jaL72L68/7jCTh552KA
         rWVlpAn7E29XOwzPjrUv2bKNGo/JTXF9VFHhzQXmXqm7bigjcM8E2K1azKufcylc9BD8
         kTgW4ji3EorKEtzg6mFLlQ5jyKyl6sR61x2ifSmLc4szk9hYNmLBxJcuWt0eoXMxLqoS
         uf0w==
X-Gm-Message-State: AC+VfDxI3GHuYVKkyJHrMe212QPBI4mBLNxtNelzf7JpKGsSQoAAsU5B
        oUXWYQ/+piSMyN+i1dpbzmPjmnkXoYyG0veE8IlmSaJI8cSCcORckU1Z+ugBgCFYdbfs8Y5cMGs
        pbpIK0nRpM32DcXe9FlM5tJbe
X-Received: by 2002:a7b:cc15:0:b0:3f4:16bc:bd1b with SMTP id f21-20020a7bcc15000000b003f416bcbd1bmr1058185wmh.39.1683364566886;
        Sat, 06 May 2023 02:16:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yT30KCl8xFUHNvRL0GXZ37yB4LlxoA/VrJPeYY0UrtOFZLwzVNDEqFTNy9mik0LH+szXbfw==
X-Received: by 2002:a7b:cc15:0:b0:3f4:16bc:bd1b with SMTP id f21-20020a7bcc15000000b003f416bcbd1bmr1058146wmh.39.1683364566395;
        Sat, 06 May 2023 02:16:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72b:8c00:d06f:a47f:7155:9f1c? (p200300cbc72b8c00d06fa47f71559f1c.dip0.t-ipconnect.de. [2003:cb:c72b:8c00:d06f:a47f:7155:9f1c])
        by smtp.gmail.com with ESMTPSA id x9-20020adfec09000000b002faaa9a1721sm4783661wrn.58.2023.05.06.02.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 02:16:05 -0700 (PDT)
Message-ID: <b69958b4-da03-ea96-1f21-44a5c2b8a03e@redhat.com>
Date:   Sat, 6 May 2023 11:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9]
 KVM: mm: fd-based approach for supporting KVM)
To:     Vlastimil Babka <vbabka@suse.cz>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        tabba@google.com, Michael Roth <michael.roth@amd.com>,
        wei.w.wang@intel.com, Mike Rapoport <rppt@kernel.org>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <ZD1oevE8iHsi66T2@google.com>
 <658018f9-581c-7786-795a-85227c712be0@redhat.com>
 <CS465PQZS77J.J1RP6AJX1CWZ@suppilovahvero>
 <6db68140-0612-a7a3-2cec-c583b2ed3a61@redhat.com>
 <3b0ec3da-ba18-7b9f-4e84-1cc30e78aed7@suse.cz>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3b0ec3da-ba18-7b9f-4e84-1cc30e78aed7@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.23 09:44, Vlastimil Babka wrote:
> On 5/5/23 22:00, David Hildenbrand wrote:
>> On 23.04.23 15:28, Jarkko Sakkinen wrote:
>>> On Mon Apr 17, 2023 at 6:48 PM EEST, David Hildenbrand wrote:
>>>> On 17.04.23 17:40, Sean Christopherson wrote:
>>>>> What do y'all think about renaming "restrictedmem" to "guardedmem"?
>>>>
>>>> Yeay, let's add more confusion :D
>>>>
>>>> If we're at renaming, I'd appreciate if we could find a terminology that
>>>> does look/sound less horrible.
>>>>
>>>>>
>>>>> I want to start referring to the code/patches by its syscall/implementation name
>>>>> instead of "UPM", as "UPM" is (a) very KVM centric, (b) refers to the broader effort
>>>>> and not just the non-KVM code, and (c) will likely be confusing for future reviewers
>>>>> since there's nothing in the code that mentions "UPM" in any way.
>>>>>
>>>>> But typing out restrictedmem is quite tedious, and git grep shows that "rmem" is
>>>>> already used to refer to "reserved memory".
>>>>>
>>>>> Renaming the syscall to "guardedmem"...
>>>>
>>>> restrictedmem, guardedmem, ... all fairly "suboptimal" if you'd ask me ...
>>>
>>> In the world of TEE's and confidential computing it is fairly common to
>>> call memory areas enclaves, even outside SGX context. So in that sense
>>> enclave memory would be the most correct terminology.
>>
>> I was also thinking along the lines of isolated_mem or imem ...
>> essentially, isolated from (unprivileged) user space.
>>
>> ... if we still want to have a common syscall for it.
> 
> I'm fan of the ioctl, if it has a chance of working out.
Yes, me too.

-- 
Thanks,

David / dhildenb

