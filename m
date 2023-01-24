Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3010B67991F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjAXNT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjAXNTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:19:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9074489
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674566284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8FL2hCl9BWMQrve4jEgUposmmxHpM9LrhFavxYOcgQ=;
        b=akm3EDRpnIHov9f1e2HfePF2oh2WcbfHEq0HL8ik16RggXywix3lhLoxPAkPwzm4xNhvGw
        vL5qpnNS6ax6+r8DoUTiNIK2xVOiyqhL558J0HY9PpLdkvq++vYCk6Bo1vl7iClvh2kKhn
        zLKXj65JLPyOZk45p5UsgnjJcPkzax4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-IBZZ78gHN8SlHKIjC2MZ-A-1; Tue, 24 Jan 2023 08:18:01 -0500
X-MC-Unique: IBZZ78gHN8SlHKIjC2MZ-A-1
Received: by mail-wm1-f71.google.com with SMTP id fl5-20020a05600c0b8500b003db12112fdeso9192084wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8FL2hCl9BWMQrve4jEgUposmmxHpM9LrhFavxYOcgQ=;
        b=W6YlSYRK8hFvmWgusKByOXG8DEXzoJInKXLiTi0vptQETTnhikI1pRARkp6mJapwo9
         74NIMHsd5mvU2X7BLfvF2v/aAdpppuPJ09+/WlEAkF65J+vAJ7maBLMGM+IC/XttZeeQ
         VfAOqpiaZr0kSu8IkxL0axvmlylpcUC6oWMaPAVQo04TvNTYjDl+nKE8GUR2N97x04Yk
         pIPuW+THqNZIhXGUbHkR3wXceE3kvBWjOGBH+aT4QVhzVymqoSHxkf938X8mCmQPrWts
         oFWyvN1aQCUuDe+img4//hkQLjHWSSVJnAZAHhiHHlGErvRV8Hj5E0qQHMTw8Q2WyV5x
         Dmgw==
X-Gm-Message-State: AFqh2koU0ly0ienfLdglZO0A5nXzMBpvdAFglCUTTot5BUm2E8Fxvj7c
        4OGYHzMGgEo2zMt8K6roklfeutyXpYqJw15gM1xCW6cY+SS0qTJuntlwJfi+ROtY/lzQ3VYkvqT
        jdoeV6pm6R5qx0VQiO51Hcc69
X-Received: by 2002:a05:600c:35d5:b0:3db:fc4:d018 with SMTP id r21-20020a05600c35d500b003db0fc4d018mr25273872wmq.40.1674566280753;
        Tue, 24 Jan 2023 05:18:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsXTM8iTQEaYS8uGn/qwNJ8FB0rJLsepjJozYAsBeZMjmKElS3iKMDkFvVcz+xTltH0ta5v8w==
X-Received: by 2002:a05:600c:35d5:b0:3db:fc4:d018 with SMTP id r21-20020a05600c35d500b003db0fc4d018mr25273849wmq.40.1674566280391;
        Tue, 24 Jan 2023 05:18:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c2b4600b003da2932bde0sm2393864wmf.23.2023.01.24.05.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 05:17:59 -0800 (PST)
Message-ID: <de1ed6a6-6f74-2664-dad4-3467efd83483@redhat.com>
Date:   Tue, 24 Jan 2023 14:17:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] maple_tree: Remove GFP_ZERO from kmem_cache_alloc() and
 kmem_cache_alloc_bulk()
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230105160427.2988454-1-Liam.Howlett@oracle.com>
 <Y7fNo4IElYXCyPmd@kernel.org> <20230106183559.mpdywid4szzpghlk@revolver>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230106183559.mpdywid4szzpghlk@revolver>
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

On 06.01.23 19:36, Liam Howlett wrote:
> * Mike Rapoport <rppt@kernel.org> [230106 02:28]:
>> On Thu, Jan 05, 2023 at 04:05:34PM +0000, Liam Howlett wrote:
>>> Preallocations are common in the VMA code to avoid allocating under
>>> certain locking conditions.  The preallocations must also cover the
>>> worst-case scenario.  Removing the GFP_ZERO flag from the
>>> kmem_cache_alloc() (and bulk variant) calls will reduce the amount of
>>> time spent zeroing memory that may not be used.  Only zero out the
>>> necessary area to keep track of the allocations in the maple state.
>>> Zero the entire node prior to using it in the tree.
>>>
>>> This required internal changes to node counting on allocation, so the
>>> test code is also updated.
>>>
>>> This restores some micro-benchmark performance:
>>> up to +9% in mmtests mmap1 by my testing
>>> +10% to +20% in mmap, mmapaddr, mmapmany tests reported by Red Hat
>>>
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2149636
>>> Reported-by: Jirka Hladky <jhladky@redhat.com>
>>> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
>>> ---
>>>   lib/maple_tree.c                 | 80 +++++++++++++++++---------------
>>>   tools/testing/radix-tree/maple.c | 18 +++----
>>>   2 files changed, 52 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>> index 26e2045d3cda..82a8121fe49b 100644
>>> --- a/lib/maple_tree.c
>>> +++ b/lib/maple_tree.c
>>> @@ -149,13 +149,12 @@ struct maple_subtree_state {
>>>   /* Functions */
>>>   static inline struct maple_node *mt_alloc_one(gfp_t gfp)
>>>   {
>>> -	return kmem_cache_alloc(maple_node_cache, gfp | __GFP_ZERO);
>>> +	return kmem_cache_alloc(maple_node_cache, gfp);
>>>   }
>>>   
>>>   static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
>>>   {
>>> -	return kmem_cache_alloc_bulk(maple_node_cache, gfp | __GFP_ZERO, size,
>>> -				     nodes);
>>> +	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
>>>   }
>>>   
>>>   static inline void mt_free_bulk(size_t size, void __rcu **nodes)
>>> @@ -1127,9 +1126,10 @@ static inline struct maple_node *mas_pop_node(struct ma_state *mas)
>>>   {
>>>   	struct maple_alloc *ret, *node = mas->alloc;
>>>   	unsigned long total = mas_allocated(mas);
>>> +	unsigned int req = mas_alloc_req(mas);
>>>   
>>>   	/* nothing or a request pending. */
>>> -	if (unlikely(!total))
>>> +	if (WARN_ON(!total))
>>
>> Hmm, isn't WARN_ON() here too much?
> 
> I don't think so.  If we get to the point of asking for a node while we
> don't have any to give, then it's too late.  It means we (I) have
> calculated the necessary nodes incorrectly and we won't have enough
> memory to fit things into the tree.  It should never happen.

Either way, the suggestion is to use WARN_ON_ONCE() instead of WARN_ON().

... now documented in Documentation/process/coding-style.rst

-- 
Thanks,

David / dhildenb

