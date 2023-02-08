Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080A868F2D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjBHQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjBHQHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:07:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2204B47ED8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:07:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C74181F8B4;
        Wed,  8 Feb 2023 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675872431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nHphhFdiAEYAVwsvl8jLLgqi2hdj2F6tFyWe+9CmgU=;
        b=2xDsVBpLDExOGYrQZdLlxIxP0+Tcr8uReuPjEfpdDQPqXtKbhgatsIDnqZ9dwQBzLHfSH4
        SaYeZ6trUO4uCwHXlbmoSYiLPGSzZAWLvtjzPbMj5OrdmTDAm0zENOih7PIfIBsWWhSVod
        BkBLweFA4ysGnd1vLs+1D6xmcQg4v+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675872431;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nHphhFdiAEYAVwsvl8jLLgqi2hdj2F6tFyWe+9CmgU=;
        b=sMxJUWpXW7eR5tYrqEHXOt20Ututw1n62Ydsoj03RNbE9JEnO33wS1Au296APxVtkd82LF
        0RRIQGR9S10K61DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2BC41358A;
        Wed,  8 Feb 2023 16:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1jkgJ6/I42MhUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Feb 2023 16:07:11 +0000
Message-ID: <b95505ab-8206-2a00-e199-e3defecd9d72@suse.cz>
Date:   Wed, 8 Feb 2023 17:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm/page_alloc: reduce fallbacks to (MIGRATE_PCPTYPES - 1)
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yajun Deng <yajun.deng@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>
References: <20230203100132.1627787-1-yajun.deng@linux.dev>
 <20230203142324.e5c0652990676ac69a4e5eb1@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230203142324.e5c0652990676ac69a4e5eb1@linux-foundation.org>
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

On 2/3/23 23:23, Andrew Morton wrote:
> On Fri,  3 Feb 2023 18:01:32 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:
> 
>> The commit 1dd214b8f21c ("mm: page_alloc: avoid merging non-fallbackable
>> pageblocks with others") has removed MIGRATE_CMA and MIGRATE_ISOLATE from
>> fallbacks list. so there is no need to add an element at the end of every
>> type.
>> 
>> Reduce fallbacks to (MIGRATE_PCPTYPES - 1).


Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Thanks.  `git log' suggests who should be cc'ed when fixing things...
> 
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2603,10 +2603,10 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
>>   *
>>   * The other migratetypes do not have fallbacks.
>>   */
>> -static int fallbacks[MIGRATE_TYPES][3] = {
>> -	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
>> -	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
>> -	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
>> +static int fallbacks[MIGRATE_TYPES][MIGRATE_PCPTYPES - 1] = {

Why not also reduce the first index size from [MIGRATE_TYPES] to
[MIGRATE_PCPTYPES] ?

>> +	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE   },
>> +	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE },
>> +	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE   },
>>  };
>>  
>>  #ifdef CONFIG_CMA
>> @@ -2865,11 +2865,8 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
>>  		return -1;
>>  
>>  	*can_steal = false;
>> -	for (i = 0;; i++) {
>> +	for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
>>  		fallback_mt = fallbacks[migratetype][i];
>> -		if (fallback_mt == MIGRATE_TYPES)
>> -			break;
>> -
>>  		if (free_area_empty(area, fallback_mt))
>>  			continue;
>>  
>> -- 
>> 2.25.1

