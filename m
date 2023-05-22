Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863E270B83F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjEVJAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjEVI7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:59:24 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7F5AF;
        Mon, 22 May 2023 01:58:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QPrw94DMLz4f463D;
        Mon, 22 May 2023 16:58:49 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
        by APP1 (Coremail) with SMTP id cCh0CgCH6yWxLmtk91CHJQ--.43916S2;
        Mon, 22 May 2023 16:58:50 +0800 (CST)
Message-ID: <1cec95d5-5cd4-fbf9-754b-e6a1229d45c3@huaweicloud.com>
Date:   Mon, 22 May 2023 16:58:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        kasan-dev@googlegroups.com, Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Gong Ruiqi <gongruiqi1@huawei.com>
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
 <CAB=+i9QxWL6ENDz_r1jPbiZsTUj1EE3u-j0uP6y_MxFSM9RerQ@mail.gmail.com>
 <5f5a858a-7017-5424-0fa0-db3b79e5d95e@huawei.com>
 <CAB=+i9R0GZiau7PKDSGdCOijPH1TVqA3rJ5tQLejJpoR55h6dg@mail.gmail.com>
 <19707cc6-fa5e-9835-f709-bc8568e4c9cd@huawei.com>
 <CAB=+i9T-iqtMZw8y7SxkaFBtiXA93YwFFEtQyGynBsorud1+_Q@mail.gmail.com>
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <CAB=+i9T-iqtMZw8y7SxkaFBtiXA93YwFFEtQyGynBsorud1+_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCH6yWxLmtk91CHJQ--.43916S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWUXF1fAF47Xry3Wr47XFb_yoW8tFyUpF
        WIyF1UCr4xCr17Cry0ya10va92v3y7tF1Uu3s0gryUZr1kJw18XFsakr109r93ZF45GFy3
        XFsYkF13WF9xt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/05/22 16:03, Hyeonggon Yoo wrote:
> On Mon, May 22, 2023 at 4:35 PM Gong Ruiqi <gongruiqi1@huawei.com> wrote:
>> On 2023/05/17 6:35, Hyeonggon Yoo wrote:
> [...]
>>>>>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
>>>>>> +# define SLAB_RANDOMSLAB       ((slab_flags_t __force)0x01000000U)
>>>>>> +#else
>>>>>> +# define SLAB_RANDOMSLAB       0
>>>>>> +#endif
>>>
>>> There is already the SLAB_KMALLOC flag that indicates if a cache is a
>>> kmalloc cache. I think that would be enough for preventing merging
>>> kmalloc caches?
>>
>> After digging into the code of slab merging (e.g. slab_unmergeable(),
>> find_mergeable(), SLAB_NEVER_MERGE, SLAB_MERGE_SAME etc), I haven't
>> found an existing mechanism that prevents normal kmalloc caches with
>> SLAB_KMALLOC from being merged with other slab caches. Maybe I missed
>> something?
>>
>> While SLAB_RANDOMSLAB, unlike SLAB_KMALLOC, is added into
>> SLAB_NEVER_MERGE, which explicitly indicates the no-merge policy.
> 
> I mean, why not make slab_unmergable()/find_mergeable() not to merge kmalloc
> caches when CONFIG_RANDOM_KMALLOC_CACHES is enabled, instead of a new flag?
> 
> Something like this:
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 607249785c07..13ac08e3e6a0 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -140,6 +140,9 @@ int slab_unmergeable(struct kmem_cache *s)
>   if (slab_nomerge || (s->flags & SLAB_NEVER_MERGE))
>   return 1;
> 
> + if (IS_ENALBED(CONFIG_RANDOM_KMALLOC_CACHES) && (flags & SLAB_KMALLOC))
> + return 1;
> +
>   if (s->ctor)
>   return 1;
> 
> @@ -176,6 +179,9 @@ struct kmem_cache *find_mergeable(unsigned int
> size, unsigned int align,
>   if (flags & SLAB_NEVER_MERGE)
>   return NULL;
> 
> + if (IS_ENALBED(CONFIG_RANDOM_KMALLOC_CACHES) && (flags & SLAB_KMALLOC))
> + return NULL;
> +
>   list_for_each_entry_reverse(s, &slab_caches, list) {
>   if (slab_unmergeable(s))
>   continue;

Ah I see. My concern is that it would affect not only normal kmalloc
caches, but kmalloc_{dma,cgroup,rcl} as well: since they were all marked
with SLAB_KMALLOC when being created, this code could potentially change
their mergeablity. I think it's better not to influence those irrelevant
caches.

