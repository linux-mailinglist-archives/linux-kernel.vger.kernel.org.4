Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C20691970
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjBJH6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjBJH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:58:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E899367E4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 23:58:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 374CF3F6ED;
        Fri, 10 Feb 2023 07:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676015909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMV2zrt0789D/DWlN3CCCtKbsypSsElbAe4u2O/7aOU=;
        b=vzxgu8k/8Yd94r+VhTLTxNcjRHn9yLrEgT7iChH7iKiOzy1N+ePLPyFkOYp043/CG4BwL6
        T3fhDY8jbjfvgcFISclbl5Q0G6qpmEJJUcdicqz9D4TmnrXWiza7qxQMp3RpX+dEeE8KD9
        FoT8rsMPrXhNoq82Ee4mi3PxI2YECZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676015909;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMV2zrt0789D/DWlN3CCCtKbsypSsElbAe4u2O/7aOU=;
        b=EthDL2Lhl3GhyDbanZ8r9P/x+eY1AJscgfdzkGiwl7C5wXMgTaUa5Hqle+SjTf9QttO8FH
        Ve00X5nGPlgJbaAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C0B013206;
        Fri, 10 Feb 2023 07:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3JDvASX55WN5eQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 10 Feb 2023 07:58:29 +0000
Message-ID: <c68af237-11b1-aafa-3a0b-132690f825d6@suse.cz>
Date:   Fri, 10 Feb 2023 08:58:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] mm/page_alloc: optimize find_suitable_fallback() and
 fallbacks array
To:     Yajun Deng <yajun.deng@linux.dev>, Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, rppt@linux.ibm.com, osalvador@suse.de,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <626a5f4c4996f57631a8e1877c7646e5@linux.dev>
 <494D9F5D-33A4-48B4-911B-9A75CFC9BC67@nvidia.com>
 <4C196D76-49A9-4B06-A51F-D8A13109DF3B@nvidia.com>
 <20230209101144.496144-1-yajun.deng@linux.dev>
 <ddc2d9001ef9d44651b62869ff9575b6@linux.dev>
 <fa878915627b52d2e6fdf838b96a2f2f@linux.dev>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <fa878915627b52d2e6fdf838b96a2f2f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/23 03:51, Yajun Deng wrote:
> February 10, 2023 10:33 AM, "Yajun Deng" <yajun.deng@linux.dev> wrote:
> 
>> February 10, 2023 10:14 AM, "Zi Yan" <ziy@nvidia.com> wrote:
>> 
>>> On 9 Feb 2023, at 20:57, Yajun Deng wrote:
>>> 
>>>> February 9, 2023 11:50 PM, "Zi Yan" <ziy@nvidia.com> wrote:
>>> 
>>> On 9 Feb 2023, at 5:11, Yajun Deng wrote:
>>>> There is no need to execute the next loop if it not return in the first
>>>> loop. So add a break at the end of the loop.
>>> 
>>> Can you explain why? If it is the case, MIGRATE_UNMOVABLE cannot fall back
>>> to MIGRATE_MOVABLE? And MIGRATE_MOVABLE cannot fall back to MIGRATE_UNMOVABLE?
>>> And MIGRATE_RECLAIMABLE cannot fall back to MIGRATE_MOVABLE?
>>>> The return in the loop is only related to 'order', 'migratetype' and 'only_stealable'
>>>> variables. Even if it execute the next loop, it can't change the result. So the loop
>>>> can be broken if the first loop can't return.
>>> 
>>> OK. Got it. Would the code below look better?
>>> 
>>> for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
>>> fallback_mt = fallbacks[migratetype][i];
>>> if (free_area_empty(area, fallback_mt))
>>> continue;
>>> }
>>> 
>>> if (can_steal_fallback(order, migratetype))
>>> *can_steal = true;
>>> 
>>> if (!only_stealable || *can_steal)
>>> return fallback_mt;
>>> 
>>> return -1;
>> 
>> Yes, I'll submit a v3 patch.
>> Thanks.
>> 
> 
> I found a logical error in your code. It should be like this:
> 
>         for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
>                 fallback_mt = fallbacks[migratetype][i];
>                 if (!free_area_empty(area, fallback_mt))
>                         break;
>         }
> 
>         if (can_steal_fallback(order, migratetype))
>                 *can_steal = true;
> 
>         if (!only_stealable || *can_steal)
>                 return fallback_mt;
> 
>         return -1;
> 
> This code will modify the logic to the opposite.

It's still wrong, IMHO. If all fallbacks have free_area_empty(), it will
return the last one and not -1. Also will set *can_steal in such case.

> So can anyone tell me if I should use this code or the v2 patch?

Once that bugs are fixed, the result will probably not look much better than
v2, so I don't mind keeping v2.

