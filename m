Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B561F5E93F1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 17:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiIYPZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiIYPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 11:25:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0566113FA4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 08:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 326C061488
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 15:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2095C433D6;
        Sun, 25 Sep 2022 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664119500;
        bh=Fpv353I50hrgwd5/Rj0tOo2NjUe8ua59ZT8TMzWWfxs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U4HF8I6EvFuaKav5dBdbiPZx+L02Mon+78/CgcGbOW0upqxHMZNoLgshJetp2weMV
         DWQ8eYgvp679kV6qoD/ryKd/86IvDrhJ5fEnLcUtXhOaDx9PqrF/9CFbVAx2+wnSn8
         I72hd8hd/m3U/vO9/jS+260HDc4PaTKKQyrsZsJq2EXMQpK1tuMUtjDAvWM5LbA3UL
         xLi9ioNc/K2AfmVbVCRM0RXpfDLJnevptsOEvOG7bgDbwLlRohzIPzINfxE9VFZjys
         D0jgw4eWq3uL4ArbeQk1kMTAUHKIvMUXLGGKeZb0wWuWk3yQp1IZQXCMra0snlxGR0
         P7An+f/GY/XfQ==
Message-ID: <449ccb5d-d2e5-950d-3458-5d0e56e83bf9@kernel.org>
Date:   Sun, 25 Sep 2022 23:24:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] mm/slub: clean up create_unique_id()
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Hugh Dickins <hugh@veritas.com>
Cc:     Chao Yu <chao.yu@oppo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220918092146.4060783-1-chao@kernel.org>
 <719a7ea0-c152-af03-8f6c-7dda702d1863@suse.cz>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <719a7ea0-c152-af03-8f6c-7dda702d1863@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/23 4:47, Vlastimil Babka wrote:
> On 9/18/22 11:21, Chao Yu wrote:
>> From: Chao Yu <chao.yu@oppo.com>
>>
>> As Christophe JAILLET suggested:
>>
>> In create_unique_id(),
>>
>> "looks that ID_STR_LENGTH could even be reduced to 32 or 16.
>>
>> The 2nd BUG_ON at the end of the function could certainly be just
>> removed as well or remplaced by a:
>>          if (p > name + ID_STR_LENGTH - 1) {
>>                  kfree(name);
>>                  return -E<something>;
>>          }
>> "
>>
>> According to above suggestion, let's do below cleanups:
>> 1. reduce ID_STR_LENGTH to 32, as the buffer size should be enough;
>> 2. remove BUG_ON() and return error if check condition is true.
> 
> I'd leave a WARN_ON there as we really don't expect this to happen, so if it
> does, we should be loud about it and not silently fail.

Agreed.

> 
>> Link: https://lore.kernel.org/linux-mm/2025305d-16db-abdf-6cd3-1fb93371c2b4@wanadoo.fr/
>> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Fixes: 81819f0fc828 ("SLUB core")
>> Signed-off-by: Chao Yu <chao.yu@oppo.com>
>> ---
>>   mm/slub.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 5ba6db62a5ab..a045c1ca8772 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5883,7 +5883,7 @@ static inline struct kset *cache_kset(struct kmem_cache *s)
>>   	return slab_kset;
>>   }
>>   
>> -#define ID_STR_LENGTH 64
>> +#define ID_STR_LENGTH 32
>>   
>>   /* Create a unique string id for a slab cache:
>>    *
>> @@ -5919,7 +5919,10 @@ static char *create_unique_id(struct kmem_cache *s)
>>   		*p++ = '-';
>>   	p += sprintf(p, "%07u", s->size);
> 
> Hm but sprintf() will happily overflow, so if we only detect that
> afterwards, it's kinda too late to gracefully fail.
> Should use snprintf() then?

Correct.

Updated in v2.

Thanks,

> 
>> -	BUG_ON(p > name + ID_STR_LENGTH - 1);
>> +	if (p > name + ID_STR_LENGTH - 1) {
>> +		kfree(name);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>>   	return name;
>>   }
>>   
> 
