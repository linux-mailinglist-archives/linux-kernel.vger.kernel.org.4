Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDDC70D793
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjEWIew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjEWIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F20035A3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684830519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8I6tDWM1Iv9Bqf5hKdBFNuA+Ju2w9woV57Zdht2pj0=;
        b=Yml3HNkle+TlsppLeozmDmHnM2JNhUS6VCMR58gFJPTrjE6GgDHmNdSNlw7r5n4enKjQiQ
        MJPjWKzOuu9u2OGyxXCNcr2D0v2iyGrRIX9Yuf+F0dvuZzeuKroDkhSlTd3QNcx7K+ETBf
        5fwI7+Y3qG+t1/MqjforaWLN6DbVpzc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620--TP1b5UCPNmPg0fURDdnQw-1; Tue, 23 May 2023 04:28:35 -0400
X-MC-Unique: -TP1b5UCPNmPg0fURDdnQw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f423d47945so24119105e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684830514; x=1687422514;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8I6tDWM1Iv9Bqf5hKdBFNuA+Ju2w9woV57Zdht2pj0=;
        b=ZZcLZNemBjOPKm/Ipn6okm+Hn6/E7Kd6zn6Pjm8BeakAH0fdAd94N0HYLCWdmmgwSy
         I94lbLQMXCyLdZHG+pDNh2ZO4ruf4I9dDlXJdXBizhe+QK8nAkZVNd4I14pagUx3gTEm
         oTJXNRdfj6mzgXMx8ZigsbLIWryGONENm0Zi0hj6+lJgyvIOYza2KwTP6/5JksbGWID0
         wXpkHsux6b40EBb0jvICYiwwdLi2Rm1gNkyJlFlnQR7CmYbEJrxGHvKiiipiBdqzy+uu
         695x/d4QcUWED9Vnb3LJxDCLPyhtrqZiF4TNIIm+B9/05lh0O8JrNN4+DAINd2JULJqc
         D3iA==
X-Gm-Message-State: AC+VfDy9mKylOsRnhKF3dN8NzhPCGnjq2PWv4c8PXXl7RHlAO0wLu0Ld
        kIgeqfkhT8LXVX3ZuCrwzTVXJTue3PrP54i122Vvw/F+2I2IBGskXiJGUaru9ov8gf84EXWxAxn
        GJINbXpq0e/NLm0Lm75eXQ1pp
X-Received: by 2002:a7b:c3cb:0:b0:3f6:2ee:6993 with SMTP id t11-20020a7bc3cb000000b003f602ee6993mr4905203wmj.4.1684830514704;
        Tue, 23 May 2023 01:28:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gOQNX87suO0H8fn7p147MaVPUDFgkJ06tS0QzWI02kVwiGz/m2oMwNGzKIx1rTmFdrNHiOg==
X-Received: by 2002:a7b:c3cb:0:b0:3f6:2ee:6993 with SMTP id t11-20020a7bc3cb000000b003f602ee6993mr4905180wmj.4.1684830514331;
        Tue, 23 May 2023 01:28:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id c4-20020a7bc004000000b003f42461ac75sm14155534wmb.12.2023.05.23.01.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 01:28:33 -0700 (PDT)
Message-ID: <9191d9b0-3318-4e70-a81b-69acff184fc6@redhat.com>
Date:   Tue, 23 May 2023 10:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/slab: remove HAVE_HARDENED_USERCOPY_ALLOCATOR
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230523073136.4900-1-vbabka@suse.cz>
 <310077ed-6f3f-41fe-afcf-36500a9408ec@lucifer.local>
 <623a87c6-c0d2-799a-c39e-0d14dcdfa6df@suse.cz>
 <ae3ff438-5e5a-4a75-b4e9-575324a584f7@lucifer.local>
 <ca7860db-220f-ae77-93e6-2a38f6c1130a@redhat.com>
 <4674f97f-5f97-45b7-a4b9-a19ca46b7ce1@lucifer.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4674f97f-5f97-45b7-a4b9-a19ca46b7ce1@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.23 10:19, Lorenzo Stoakes wrote:
> On Tue, May 23, 2023 at 10:14:24AM +0200, David Hildenbrand wrote:
>> On 23.05.23 09:56, Lorenzo Stoakes wrote:
>>> On Tue, May 23, 2023 at 09:46:46AM +0200, Vlastimil Babka wrote:
>>>> On 5/23/23 09:42, Lorenzo Stoakes wrote:
>>>>> On Tue, May 23, 2023 at 09:31:36AM +0200, Vlastimil Babka wrote:
>>>>>> With SLOB removed, both remaining allocators support hardened usercopy,
>>>>>> so remove the config and associated #ifdef.
>>>>>>
>>>>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>>>>> ---
>>>>>>    mm/Kconfig       | 2 --
>>>>>>    mm/slab.h        | 9 ---------
>>>>>>    security/Kconfig | 8 --------
>>>>>>    3 files changed, 19 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>>>> index 7672a22647b4..041f0da42f2b 100644
>>>>>> --- a/mm/Kconfig
>>>>>> +++ b/mm/Kconfig
>>>>>> @@ -221,7 +221,6 @@ choice
>>>>>>    config SLAB
>>>>>>    	bool "SLAB"
>>>>>>    	depends on !PREEMPT_RT
>>>>>> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
>>>>>>    	help
>>>>>>    	  The regular slab allocator that is established and known to work
>>>>>>    	  well in all environments. It organizes cache hot objects in
>>>>>> @@ -229,7 +228,6 @@ config SLAB
>>>>>>
>>>>>>    config SLUB
>>>>>>    	bool "SLUB (Unqueued Allocator)"
>>>>>> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
>>>>>>    	help
>>>>>>    	   SLUB is a slab allocator that minimizes cache line usage
>>>>>>    	   instead of managing queues of cached objects (SLAB approach).
>>>>>> diff --git a/mm/slab.h b/mm/slab.h
>>>>>> index f01ac256a8f5..695ef96b4b5b 100644
>>>>>> --- a/mm/slab.h
>>>>>> +++ b/mm/slab.h
>>>>>> @@ -832,17 +832,8 @@ struct kmem_obj_info {
>>>>>>    void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
>>>>>>    #endif
>>>>>>
>>>>>> -#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
>>>>>>    void __check_heap_object(const void *ptr, unsigned long n,
>>>>>>    			 const struct slab *slab, bool to_user);
>>>>>> -#else
>>>>>> -static inline
>>>>>> -void __check_heap_object(const void *ptr, unsigned long n,
>>>>>> -			 const struct slab *slab, bool to_user)
>>>>>> -{
>>>>>> -}
>>>>>> -#endif
>>>>>
>>>>> Hm, this is still defined in slab.c/slub.c and invoked in usercopy.c, do we
>>>>> not want the prototype?
>>>>
>>>> Well I didn't delete the prototype, just the ifdef/else around, so now it's
>>>> there unconditionally.
>>>>
>>>>> Perhaps replacing with #ifdef
>>>>> CONFIG_HARDENED_USERCOPY instead? I may be missing something here :)
>>>>
>>>> Putting it under that #ifdef would work and match that the implementations
>>>> of that function are under that same ifdef, but maybe it's unnecessary noise
>>>> in the header?
>>>>
>>>
>>> Yeah my brain inserted extra '-'s there, sorry!
>>>
>>> Given we only define __check_heap_object() in sl[au]b.c if
>>> CONFIG_HARDENED_USERCOPY wouldn't we need to keep the empty version around
>>> if !CONFIG_HARDENED_USERCOPY since check_heap_object() appears to be called
>>> unconditionally?
>>>
>>
>> The file is only compiled with CONFIG_HARDENED_USERCOPY:
>>
>> mm/Makefile:obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
>>
> 
> Yeah ugh at this sort of implicit thing. Anyway it'd be preferable to stick
> #ifdef CONFIG_HARDENED_USERCOPY around the prototype just so it's
> abundantly clear this function doesn't exist unless that is set.

I recall that it is very common to not use ifdefs unless really 
required. Because less ifefs are obviously preferable ;)

Compilation+linking will fail in any case.

-- 
Thanks,

David / dhildenb

