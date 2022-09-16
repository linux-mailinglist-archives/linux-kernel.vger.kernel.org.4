Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54045BB492
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIPW7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIPW7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:59:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E43B07DF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E263CB8295E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 22:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B19C433C1;
        Fri, 16 Sep 2022 22:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663369140;
        bh=woX7AGmuU2N902gGUPhtT7Z+7N0u/k69ufjvL0LI040=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pOwlYMFMHavTaqxChCVwoTvOkTevrimVfcNCbvsCLX49uXAz34KJuo9VcI+Boz/FC
         PsGOqRyqcDl0KGZVlIuFcMxCr1tff8SZz2Qrsjcv3BPWPIYordclnB9P7Z5mpmvhuc
         P9BCY59k4g0WnUaKhp7DeuTOcfZqGuYbv3t81Us6RJ+KUXdVFnb/dA/baTp3BlvzcE
         FPBJQMquGNMw3LDq0bdZ+9JgQhIhfWlfIdvHCRtmx4DnUm46dPyxRrK+SXAbEROA2D
         /y51ezigXM4GclCdt97w921mM9fxp45jxaX8D8V2wy3kXFnMPRCpDapdMVjoesDGeP
         XU6hunkuGL9sg==
Message-ID: <caa4b270-aefe-f817-4c40-36509b526210@kernel.org>
Date:   Sat, 17 Sep 2022 00:58:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] mm/slub: fix to return errno if kmalloc() fails
Content-Language: en-US
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chao Yu <chao@kernel.org>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Chao Yu <chao.yu@oppo.com>, muchun.song@linux.dev
References: <20220830141009.150075-1-chao@kernel.org>
 <2025305d-16db-abdf-6cd3-1fb93371c2b4@wanadoo.fr>
 <e14a916c-a597-5328-2d79-39274fbdad35@kernel.org>
 <4b87891d-b475-0ad6-db36-a9c1f334c785@wanadoo.fr>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <4b87891d-b475-0ad6-db36-a9c1f334c785@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/22 07:26, Marion & Christophe JAILLET wrote:
> 
> Le 13/09/2022 à 05:42, Chao Yu a écrit :
>> On 2022/9/10 0:47, Christophe JAILLET wrote:
>>> Le 30/08/2022 à 16:10, Chao Yu a écrit :
>>>> From: Chao Yu <chao.yu@oppo.com>
>>>>
>>>> In create_unique_id(), kmalloc(, GFP_KERNEL) can fail due to
>>>> out-of-memory, if it fails, return errno correctly rather than
>>>> triggering panic via BUG_ON();
>>>>
>>>> kernel BUG at mm/slub.c:5893!
>>>> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>>>
>>>> Call trace:
> [...]
>>>>
>>>> Cc: <stable@kernel.org>
>>>> Reported-by: syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
>>>> Signed-off-by: Chao Yu <chao.yu@oppo.com>
>>>> ---
>>>>   mm/slub.c | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index 862dbd9af4f5..e6f3727b9ad2 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -5890,7 +5890,8 @@ static char *create_unique_id(struct kmem_cache *s)
>>>>       char *name = kmalloc(ID_STR_LENGTH, GFP_KERNEL);
>>>
>>> Hi,
>>>
>>> looks that ID_STR_LENGTH could even be reduced to 32 or 16.
>>>
>>> The 2nd BUG_ON at the end of the function could certainly be just removed
>>> as well or remplaced by a:
>>>         if (p > name + ID_STR_LENGTH - 1) {
>>>          kfree(name);
>>>          return -E<something>;
>>>      }
>>
>> Hi Christophe, Vlastimil,
>>
>> Should I include this in v3? or may be in another patch?
> 
> Hi,
> 
> My own preference would be for 3 patches.
> 
> Yours, as-is.
> It fixes a specific issue spotted by syzbot.

Yeah and it's already in git.

> Another one for removing a BUG_ON() (that, IIUC can't happen!)
> Mostly a clean-up or a good practice in order to remove BUG_ON() from the
> kernel we it can be handled another way.
> 
> Eventually a 3rd one for reducing ID_STR_LENGTH.
> I guess that it is safe to reduce it to 32 or 16, but the impact on RL would
> be so small, that I wonder if it worth proposing it.

Agree. Doing 2+3 in the same patch would be OK with me too.

