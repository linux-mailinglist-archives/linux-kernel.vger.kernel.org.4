Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE796B2DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCITfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCITfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:35:22 -0500
X-Greylist: delayed 76833 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Mar 2023 11:34:25 PST
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D674120D19
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:34:25 -0800 (PST)
Received: from iva6-eccc17c3aa65.qloud-c.yandex.net (iva6-eccc17c3aa65.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7598:0:640:eccc:17c3])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 3B0EE5F10E;
        Thu,  9 Mar 2023 22:34:22 +0300 (MSK)
Received: by iva6-eccc17c3aa65.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id JYjOWj5btOs1-U1Zmn3cx;
        Thu, 09 Mar 2023 22:34:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1678390461;
        bh=QnAXpX051nzPo+8CEjdAzCSqmApdQEykiwFVcf/r99c=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=V35pElRHX3fwN2fxLVizqwLZ0py0quD4YexSY7g6jYgHfDft5I9mvjukJ/1rU99VW
         YwsmHRkc6I5vWEn1set1htf0y2KctN0CdnAcr0PFDdGT/6040qY/reyWrktJGNsYXU
         kKxR2y36EQ47dY9zCpOUU7wB7dqJa4uDLbS1Qm7k=
Authentication-Results: iva6-eccc17c3aa65.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <c90b250e-822f-9f3b-8327-a0296e38cd1b@ya.ru>
Date:   Thu, 9 Mar 2023 22:34:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 7/8] mm: vmscan: remove shrinker_rwsem from
 synchronize_shrinkers()
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-8-zhengqi.arch@bytedance.com>
 <bc829246-4606-cc8d-4a4f-da285255f5a3@ya.ru>
 <07078623-b7ef-ceb4-eccc-8872a4067273@bytedance.com>
 <d527005e-5f55-a6f7-21ce-817076860e99@amd.com>
 <85f9e200-dabe-7340-b76d-6525988054aa@bytedance.com>
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <85f9e200-dabe-7340-b76d-6525988054aa@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.2023 11:32, Qi Zheng wrote:
> Hi Christian,
> 
> On 2023/3/9 16:11, Christian König wrote:
>> Am 09.03.23 um 08:06 schrieb Qi Zheng:
>>> Hi Kirill,
>>>
>>> On 2023/3/9 06:39, Kirill Tkhai wrote:
>>>> On 07.03.2023 09:56, Qi Zheng wrote:
>>>>> Now there are no readers of shrinker_rwsem, so
>>>>> synchronize_shrinkers() does not need to hold the
>>>>> writer of shrinker_rwsem to wait for all running
>>>>> shinkers to complete, synchronize_srcu() is enough.
>>>>>
>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>> ---
>>>>>   mm/vmscan.c | 8 ++------
>>>>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>> index 7aaf6f94ac1b..ac7ab4aa344f 100644
>>>>> --- a/mm/vmscan.c
>>>>> +++ b/mm/vmscan.c
>>>>> @@ -796,15 +796,11 @@ EXPORT_SYMBOL(unregister_shrinker);
>>>>>   /**
>>>>>    * synchronize_shrinkers - Wait for all running shrinkers to complete.
>>>>>    *
>>>>> - * This is equivalent to calling unregister_shrink() and register_shrinker(),
>>>>> - * but atomically and with less overhead. This is useful to guarantee that all
>>>>> - * shrinker invocations have seen an update, before freeing memory, similar to
>>>>> - * rcu.
>>>>> + * This is useful to guarantee that all shrinker invocations have seen an
>>>>> + * update, before freeing memory.
>>>>>    */
>>>>>   void synchronize_shrinkers(void)
>>>>>   {
>>>>> -    down_write(&shrinker_rwsem);
>>>>> -    up_write(&shrinker_rwsem);
>>>>>       atomic_inc(&shrinker_srcu_generation);
>>>>>       synchronize_srcu(&shrinker_srcu);
>>>>>   }
>>>>
>>>> Just curious, callers of synchronize_shrinkers() don't want to have parallel register_shrinker() and unregister_shrink() are completed?
>>>> Here we only should wait for parallel shrink_slab(), correct?
>>>
>>> I think yes.
>>>
>>> The synchronize_shrinkers() is currently only used by TTM pool.
>>>
>>> In TTM pool, a shrinker named "drm-ttm_pool" is registered, and
>>> the scan_objects callback will pick an entry from its own shrinker_list:
>>>
>>> ttm_pool_shrink
>>> --> spin_lock(&shrinker_lock);
>>>     pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
>>>     list_move_tail(&pt->shrinker_list, &shrinker_list);
>>>     spin_unlock(&shrinker_lock);
>>>
>>> These entries have been removed from shrinker_list before calling
>>> synchronize_shrinkers():
>>>
>>> ttm_pool_fini
>>> --> ttm_pool_type_fini
>>>     --> spin_lock(&shrinker_lock);
>>>     list_del(&pt->shrinker_list);
>>>     spin_unlock(&shrinker_lock);
>>>     synchronize_shrinkers
>>>
>>> So IIUC, we only need to wait for the parallel shrink_slab() here. Like
>>> its comment says:
>>>
>>> /* We removed the pool types from the LRU, but we need to also make sure
>>>  * that no shrinker is concurrently freeing pages from the pool.
>>>  */
>>
>> Yes your analyses is completely correct.
>>
>> I just didn't wanted to add another SRCU into the critical code paths of the TTM pool just for device hot plug when I have that functionality already.
>>
>> We just make sure that no shrinker is running in parallel with destruction of the pool. Registering and unregistering is harmless.
> 
> That's great, thanks for confirming.
> 
> Thanks,
> Qi

Christian and Qi, thanks for the explanation.

>>
>> Regards,
>> Christian.
>>
>>>
>>> + CC: Christian König :)
>>>
>>> Thanks,
>>> Qi
>>
>>

