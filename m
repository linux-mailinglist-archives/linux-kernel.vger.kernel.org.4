Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BCD68ED33
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBHKpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHKpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:45:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B88F273F;
        Wed,  8 Feb 2023 02:45:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49EC720C1D;
        Wed,  8 Feb 2023 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675853115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nY2NC0vBc03UHVDXrLuj/SNDuqT1hRa8Mkp6xgPWjjg=;
        b=u4/DN30h7ruD/ETiyitg7LV71SFdcliUIk68nMfnl286aSNvXdTCyIRwaCkvQRqDNsTR0a
        WGSs8RtIbPI3Qka3hVosQPl2Hjm1oo3yKXG/pvgK9TveWEVbXNaZUNFMhlAUAPP6kIeuBV
        YU4pLaQ/m0ryBDgT4tbmWr6b+Z7QBpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675853115;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nY2NC0vBc03UHVDXrLuj/SNDuqT1hRa8Mkp6xgPWjjg=;
        b=dzUqDznyX1qG/bX6LKuIgv8D+VVr1rsJBItBZvXbRsI+WCtomCN6Yx82/zJm3h+4EsIUYZ
        M074XVQ2hQhovZCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 315E213425;
        Wed,  8 Feb 2023 10:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DMh7Czt942NJOwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Feb 2023 10:45:15 +0000
Message-ID: <70fc9040-f976-0314-46e8-d9ddad82ccf5@suse.cz>
Date:   Wed, 8 Feb 2023 11:45:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm: reduce lock contention of pcp buffer refill
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Halbuer <halbuer@sra.uni-hannover.de>,
        Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230201162549.68384-1-halbuer@sra.uni-hannover.de>
 <20230202152501.297639031e96baad35cdab17@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230202152501.297639031e96baad35cdab17@linux-foundation.org>
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

On 2/3/23 00:25, Andrew Morton wrote:
> On Wed,  1 Feb 2023 17:25:49 +0100 Alexander Halbuer <halbuer@sra.uni-hannover.de> wrote:
> 
>> The `rmqueue_bulk` function batches the allocation of multiple elements to
>> refill the per-CPU buffers into a single hold of the zone lock. Each
>> element is allocated and checked using the `check_pcp_refill` function.
>> The check touches every related struct page which is especially expensive
>> for higher order allocations (huge pages). This patch reduces the time
>> holding the lock by moving the check out of the critical section similar
>> to the `rmqueue_buddy` function which allocates a single element.
>> Measurements of parallel allocation-heavy workloads show a reduction of
>> the average huge page allocation latency of 50 percent for two cores and
>> nearly 90 percent for 24 cores.
> 
> Sounds nice.
> 
> Were you able to test how much benefit we get by simply removing the
> check_new_pages() call from rmqueue_bulk()?
> 
> Vlastimil, I find this quite confusing:
> 
> #ifdef CONFIG_DEBUG_VM
> /*
>  * With DEBUG_VM enabled, order-0 pages are checked for expected state when
>  * being allocated from pcp lists. With debug_pagealloc also enabled, they are
>  * also checked when pcp lists are refilled from the free lists.
>  */
> static inline bool check_pcp_refill(struct page *page, unsigned int order)
> {
> 	if (debug_pagealloc_enabled_static())
> 		return check_new_pages(page, order);
> 	else
> 		return false;
> }
> 
> static inline bool check_new_pcp(struct page *page, unsigned int order)
> {
> 	return check_new_pages(page, order);
> }
> #else
> /*
>  * With DEBUG_VM disabled, free order-0 pages are checked for expected state
>  * when pcp lists are being refilled from the free lists. With debug_pagealloc
>  * enabled, they are also checked when being allocated from the pcp lists.
>  */
> static inline bool check_pcp_refill(struct page *page, unsigned int order)
> {
> 	return check_new_pages(page, order);
> }
> static inline bool check_new_pcp(struct page *page, unsigned int order)
> {
> 	if (debug_pagealloc_enabled_static())
> 		return check_new_pages(page, order);
> 	else
> 		return false;
> }
> #endif /* CONFIG_DEBUG_VM */
> 
> and the 4462b32c9285b5 changelog is a struggle to follow.
> 
> Why are we performing *any* checks when CONFIG_DEBUG_VM=n and when
> debug_pagealloc_enabled is false?

Well AFAIK the history was like this

- at first we always did the checks when allocating or freeing a page, even
when it was allocated/freed from the pcplist

- then Mel in 479f854a207c and 4db7548ccbd9 changed it so the checks were
done only when moving between pcplist and zone's freelists, so the
pcplist-cached fast paths were now faster. But that means it may not catch
some errors anymore, so with DEBUG_VM checks were still done on every alloc/free

- my 4462b32c9285b5 changed it so that when debug_pagelloc is boot-time
enabled, the checks happen both on pcplist and zone's freelist alloc/free.
This was mainly to allow enabling the checks on production kernels without
recompiling with DEBUG_VM. But it's a mode where catching the culprit is
more desirable than peak performance

> Anyway, these checks sounds quite costly so let's revisit their
> desirability?

So AFAIK never in the past we went with not doing the checks at all. But
given that by default we don't do them on pcplists for years, and the
majority of allocations are using pcplists, maybe indeed we won't lose much
coverage by not doing the checks at all.

But I wonder also what kernel hardening folks think here - are the hardened
kernels usually built with DEBUG_VM or debug_pagealloc enabled, or would you
like to hook some other kernel option for keeping the checks on page/alloc
free active? And should those checks be done on every alloc/free, including
pcplist cached allocations?

