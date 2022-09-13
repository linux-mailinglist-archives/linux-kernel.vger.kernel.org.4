Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7708A5B674E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIMF1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIMF1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:27:01 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F36B205DE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:27:00 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id XyRkouUZN3VQxXyRko1dbL; Tue, 13 Sep 2022 07:26:58 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 13 Sep 2022 07:26:58 +0200
X-ME-IP: 90.11.190.129
Message-ID: <4b87891d-b475-0ad6-db36-a9c1f334c785@wanadoo.fr>
Date:   Tue, 13 Sep 2022 07:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/slub: fix to return errno if kmalloc() fails
Content-Language: en-US
To:     Chao Yu <chao@kernel.org>,
        "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Chao Yu <chao.yu@oppo.com>, muchun.song@linux.dev
References: <20220830141009.150075-1-chao@kernel.org>
 <2025305d-16db-abdf-6cd3-1fb93371c2b4@wanadoo.fr>
 <e14a916c-a597-5328-2d79-39274fbdad35@kernel.org>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <e14a916c-a597-5328-2d79-39274fbdad35@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 13/09/2022 à 05:42, Chao Yu a écrit :
> On 2022/9/10 0:47, Christophe JAILLET wrote:
>> Le 30/08/2022 à 16:10, Chao Yu a écrit :
>>> From: Chao Yu <chao.yu@oppo.com>
>>>
>>> In create_unique_id(), kmalloc(, GFP_KERNEL) can fail due to
>>> out-of-memory, if it fails, return errno correctly rather than
>>> triggering panic via BUG_ON();
>>>
>>> kernel BUG at mm/slub.c:5893!
>>> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>>
>>> Call trace:
[...]
>>>
>>> Cc: <stable@kernel.org>
>>> Reported-by: syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
>>> Signed-off-by: Chao Yu <chao.yu@oppo.com>
>>> ---
>>>   mm/slub.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index 862dbd9af4f5..e6f3727b9ad2 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -5890,7 +5890,8 @@ static char *create_unique_id(struct 
>>> kmem_cache *s)
>>>       char *name = kmalloc(ID_STR_LENGTH, GFP_KERNEL);
>>
>> Hi,
>>
>> looks that ID_STR_LENGTH could even be reduced to 32 or 16.
>>
>> The 2nd BUG_ON at the end of the function could certainly be just 
>> removed as well or remplaced by a:
>>         if (p > name + ID_STR_LENGTH - 1) {
>>          kfree(name);
>>          return -E<something>;
>>      }
>
> Hi Christophe, Vlastimil,
>
> Should I include this in v3? or may be in another patch?

Hi,

My own preference would be for 3 patches.

Yours, as-is.
It fixes a specific issue spotted by syzbot.

Another one for removing a BUG_ON() (that, IIUC can't happen!)
Mostly a clean-up or a good practice in order to remove BUG_ON() from 
the kernel we it can be handled another way.

Eventually a 3rd one for reducing ID_STR_LENGTH.
I guess that it is safe to reduce it to 32 or 16, but the impact on RL 
would be so small, that I wonder if it worth proposing it.

Just my 2c,

CJ



>
> Thanks,
>
>>
>> Just my 2c,
>>
>> CJ
>>
>>>       char *p = name;
>>> -    BUG_ON(!name);
>>> +    if (!name)
>>> +        return ERR_PTR(-ENOMEM);
>>>       *p++ = ':';
>>>       /*
>>> @@ -5948,6 +5949,8 @@ static int sysfs_slab_add(struct kmem_cache *s)
>>>            * for the symlinks.
>>>            */
>>>           name = create_unique_id(s);
>>> +        if (IS_ERR(name))
>>> +            return PTR_ERR(name);
>>>       }
>>>       s->kobj.kset = kset;
>>
