Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED5970D70F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjEWIR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjEWIRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441D10FF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684829668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pK75x5ErRQbR7sZTyIQvs8c6Qw3cdzJ6+CtVUWa6Arg=;
        b=AQjk4+6vhrQGvGYf8L6tDhOWFfEqacUgqNgg8X7UYWepwuVIL2PKJ47js16/NaAgCMJCw/
        KmkV2oAvJ3ljevYSr2Reh5Miv47cDyFp4gGn9A9zJdM4fnPZ9f9RWvg2uDSJaKP1OdyMkw
        4pMhEHo0wGy8JJqQoXPLDlbx6+qfMB4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-I_OqLPx7OZ6ia9EQYj6UYQ-1; Tue, 23 May 2023 04:14:27 -0400
X-MC-Unique: I_OqLPx7OZ6ia9EQYj6UYQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-309571456a1so2045191f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684829666; x=1687421666;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pK75x5ErRQbR7sZTyIQvs8c6Qw3cdzJ6+CtVUWa6Arg=;
        b=ONOHruOBC25ENqNQt/0T5Lkbyxx2CxD4OyX4OjMhKPdti3JZZehhUXvODLwCYY9wd0
         7gMo0RpUz5pxMLiPtcLXPSSlVyrATx4unYrVa/WgeAPfS/gMXcE9vgm5B14Mzze6QXhG
         rex024x++mgvES9z4NlpSgUShiHCkTCrUmv2vVC8MkmubKf/mUaiJbypmx+Ujxffv8dH
         yNO9IdafINM3Wgn0HtoCCi42E4srqCz9KOAP3hEvtfj6qZmRtFQc+yu3LkIFqU2nwz9s
         VCgTzG46HbZjRPL8yL8hg74M39FkPs47D+vKpPclHrdTSb6je99Zlxwbe0Sgx4Un/DOF
         0n1g==
X-Gm-Message-State: AC+VfDzU0ObUXxUj9HEvm4RkBXoOCvzVmlNg2BQXS2VwNi/JIcY2Kee0
        +FgO4YTuedse/WuYs19Ey7HX+wzSiEUI862T8Fr833MS3pfZ3mUfpe7vJnrJ41Jqh0EbdI89U+G
        NAc+a0j+xI0ejnytS4xjI2GJL
X-Received: by 2002:adf:ea82:0:b0:30a:8f9e:8ee6 with SMTP id s2-20020adfea82000000b0030a8f9e8ee6mr4507348wrm.22.1684829666191;
        Tue, 23 May 2023 01:14:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6H1MPKDPiSbV8c1ccyUYy2bHzIhCHQ2vPFAk/Ser7s8xXZJeKgLdg+5PD28Od7MlUSBAjG7A==
X-Received: by 2002:adf:ea82:0:b0:30a:8f9e:8ee6 with SMTP id s2-20020adfea82000000b0030a8f9e8ee6mr4507320wrm.22.1684829665772;
        Tue, 23 May 2023 01:14:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b00306281cfa59sm10367794wrn.47.2023.05.23.01.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 01:14:25 -0700 (PDT)
Message-ID: <ca7860db-220f-ae77-93e6-2a38f6c1130a@redhat.com>
Date:   Tue, 23 May 2023 10:14:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/slab: remove HAVE_HARDENED_USERCOPY_ALLOCATOR
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ae3ff438-5e5a-4a75-b4e9-575324a584f7@lucifer.local>
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

On 23.05.23 09:56, Lorenzo Stoakes wrote:
> On Tue, May 23, 2023 at 09:46:46AM +0200, Vlastimil Babka wrote:
>> On 5/23/23 09:42, Lorenzo Stoakes wrote:
>>> On Tue, May 23, 2023 at 09:31:36AM +0200, Vlastimil Babka wrote:
>>>> With SLOB removed, both remaining allocators support hardened usercopy,
>>>> so remove the config and associated #ifdef.
>>>>
>>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>>> ---
>>>>   mm/Kconfig       | 2 --
>>>>   mm/slab.h        | 9 ---------
>>>>   security/Kconfig | 8 --------
>>>>   3 files changed, 19 deletions(-)
>>>>
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 7672a22647b4..041f0da42f2b 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -221,7 +221,6 @@ choice
>>>>   config SLAB
>>>>   	bool "SLAB"
>>>>   	depends on !PREEMPT_RT
>>>> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
>>>>   	help
>>>>   	  The regular slab allocator that is established and known to work
>>>>   	  well in all environments. It organizes cache hot objects in
>>>> @@ -229,7 +228,6 @@ config SLAB
>>>>
>>>>   config SLUB
>>>>   	bool "SLUB (Unqueued Allocator)"
>>>> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
>>>>   	help
>>>>   	   SLUB is a slab allocator that minimizes cache line usage
>>>>   	   instead of managing queues of cached objects (SLAB approach).
>>>> diff --git a/mm/slab.h b/mm/slab.h
>>>> index f01ac256a8f5..695ef96b4b5b 100644
>>>> --- a/mm/slab.h
>>>> +++ b/mm/slab.h
>>>> @@ -832,17 +832,8 @@ struct kmem_obj_info {
>>>>   void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
>>>>   #endif
>>>>
>>>> -#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
>>>>   void __check_heap_object(const void *ptr, unsigned long n,
>>>>   			 const struct slab *slab, bool to_user);
>>>> -#else
>>>> -static inline
>>>> -void __check_heap_object(const void *ptr, unsigned long n,
>>>> -			 const struct slab *slab, bool to_user)
>>>> -{
>>>> -}
>>>> -#endif
>>>
>>> Hm, this is still defined in slab.c/slub.c and invoked in usercopy.c, do we
>>> not want the prototype?
>>
>> Well I didn't delete the prototype, just the ifdef/else around, so now it's
>> there unconditionally.
>>
>>> Perhaps replacing with #ifdef
>>> CONFIG_HARDENED_USERCOPY instead? I may be missing something here :)
>>
>> Putting it under that #ifdef would work and match that the implementations
>> of that function are under that same ifdef, but maybe it's unnecessary noise
>> in the header?
>>
> 
> Yeah my brain inserted extra '-'s there, sorry!
> 
> Given we only define __check_heap_object() in sl[au]b.c if
> CONFIG_HARDENED_USERCOPY wouldn't we need to keep the empty version around
> if !CONFIG_HARDENED_USERCOPY since check_heap_object() appears to be called
> unconditionally?
> 

The file is only compiled with CONFIG_HARDENED_USERCOPY:

mm/Makefile:obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o



Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

