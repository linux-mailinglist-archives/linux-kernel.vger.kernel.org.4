Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B51069037B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjBIJXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjBIJXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:23:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD83C5EFAC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:22:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64EF35C5D9;
        Thu,  9 Feb 2023 09:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675934565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9kXmUSbj0Uh0U4j6gi3rfA23pb+D6yeELZIIM2RPGM=;
        b=BBjL+Xt7Iy3JA4/7Yty8xBor+MxW59jhPIVyClb7nOhO2gR/E9ACwWLgNWxJtBZXAmz3I7
        H9C694sYnrxW9v4fOBWaEHfNTVx1dVjVENS1yKJx9h82Yi5x5oRZlpdPF45/o6MT0UsXjf
        YJDr/M/HFs8+JTuFS4hTy+BohjWn2ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675934565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9kXmUSbj0Uh0U4j6gi3rfA23pb+D6yeELZIIM2RPGM=;
        b=AwUzHqGQ+lSArs5UYTFwTZISNveZ5mlBjV3T2hQYeyKQpqKBnn2yVCkgmLxm9LatYKDpQ2
        XKuvJAwLrck8BfBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A0C91339E;
        Thu,  9 Feb 2023 09:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m0V9DWW75GPNKwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Feb 2023 09:22:45 +0000
Message-ID: <575de0c1-18fc-8568-eae9-2bc0b247622e@suse.cz>
Date:   Thu, 9 Feb 2023 10:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm/page_alloc: optimize the loop in
 find_suitable_fallback()
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, mgorman@techsingularity.net, david@redhat.com,
        rppt@linux.ibm.com, osalvador@suse.de, rppt@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <362e1270-8a54-36f5-f7c0-d922b3d12860@suse.cz>
 <20230209024435.3392916-1-yajun.deng@linux.dev>
 <7cc548bc6be5f84e1fb9c6cac07b7451@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <7cc548bc6be5f84e1fb9c6cac07b7451@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 09:44, Yajun Deng wrote:
> February 9, 2023 4:12 PM, "Vlastimil Babka" <vbabka@suse.cz> wrote:
> 
>> On 2/9/23 03:44, Yajun Deng wrote:
>> 
>>> There is no need to execute the next loop if it not return in the first
>>> loop. So add a break at the end of the loop.
>>> 
>>> There are only three rows in fallbacks, so reduce the first index size
>>> from MIGRATE_TYPES to MIGRATE_PCPTYPES.
>>> 
>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> 
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>>> ---
>>> mm/page_alloc.c | 11 +++++------
>>> 1 file changed, 5 insertions(+), 6 deletions(-)
>>> 
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 1113483fa6c5..536e8d838fb5 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -2603,7 +2603,7 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
>>> *
>>> * The other migratetypes do not have fallbacks.
>>> */
>>> -static int fallbacks[MIGRATE_TYPES][MIGRATE_PCPTYPES - 1] = {
>>> +static int fallbacks[MIGRATE_PCPTYPES][MIGRATE_PCPTYPES - 1] = {
>>> [MIGRATE_UNMOVABLE] = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE },
>>> [MIGRATE_MOVABLE] = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE },
>>> [MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE, MIGRATE_MOVABLE },
>>> @@ -2861,7 +2861,7 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
>>> int i;
>>> int fallback_mt;
>>> 
>>> - if (area->nr_free == 0)
>>> + if (area->nr_free == 0 || !migratetype_is_mergeable(migratetype))
>> 
>> Just curious, did you the check for extra safety or did you find (by running
>> or code inspection) that this can be indeed called with a non-mergeable
>> migratetype, and cause out of bounds access of the shrinked fallbacks array?
>> 
> 
> No, I'm not sure if it is called with a non-mergeable migratetype.
> It is just for extra safety.

OK, I agree with that.

>> BTW, I noticed the commment on migratetype_is_mergeable() contains:
>> 
>> "See fallbacks[MIGRATE_TYPES][3] in page_alloc.c. "
>> 
>> Should probably change it to e.g. "See fallbacks[][] array ..." so we don't
>> have to keep it in exact sync...
>> 
> 
> Yes, this comment should be changed.
> So do I need to submit a v2 patch?

Please do, with my acked-by.

>>> return -1;
>>> 
>>> *can_steal = false;
>>> @@ -2873,11 +2873,10 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
>>> if (can_steal_fallback(order, migratetype))
>>> *can_steal = true;
>>> 
>>> - if (!only_stealable)
>>> - return fallback_mt;
>>> -
>>> - if (*can_steal)
>>> + if (!only_stealable || *can_steal)
>>> return fallback_mt;
>>> + else
>>> + break;
>>> }
>>> 
>>> return -1;

