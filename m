Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E162F5E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbiKRNYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiKRNYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:24:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD6B84319
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:24:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 185471FA51;
        Fri, 18 Nov 2022 13:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668777885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjSzJOUlS6BPTCP6rxsM/mMEKiqvCtEfd6HOKLUviYI=;
        b=C9muodQBTkufJz+UqsoeXUlSNBMEGazEu5rJTHV/2KYuXxZeBsQleafQKcx0/q7Hj0RQ7l
        xQnhiBqYUXEuRLukzAUvc3NOWu8/FLqr5vzpuyLecXFpD/LQ+jrzxcbgbG9rG6Aesp8qU9
        g42T6ppUyUUNr9ySoe0NpNTzdpe5wHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668777885;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjSzJOUlS6BPTCP6rxsM/mMEKiqvCtEfd6HOKLUviYI=;
        b=v4bNxqLzI2sj+ptZdrXbng62t8NVbedr7UQjHOV9KojsLHMvRWV2tF3hsMEXMLzkTV0mOv
        w1msrSNvQgk/JnAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5CF413A66;
        Fri, 18 Nov 2022 13:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iSdfN5yHd2O6JgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 18 Nov 2022 13:24:44 +0000
Message-ID: <acb96bfc-efe7-c42a-2e0c-e97055dbfc36@suse.cz>
Date:   Fri, 18 Nov 2022 14:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] mm/page_alloc: Always remove pages from temporary
 list
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20221118101714.19590-1-mgorman@techsingularity.net>
 <20221118101714.19590-2-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221118101714.19590-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 11:17, Mel Gorman wrote:
> free_unref_page_list() has neglected to remove pages properly from the list
> of pages to free since forever. It works by coincidence because list_add
> happened to do the right thing adding the pages to just the PCP lists.
> However, a later patch added pages to either the PCP list or the zone list
> but only properly deleted the page from the list in one path leading to
> list corruption and a subsequent failure. As a preparation patch, always
> delete the pages from one list properly before adding to another.  On its
> own, this fixes nothing although it adds a fractional amount of overhead
> but is critical to the next patch.
> 
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 218b28ee49ed..1ec54173b8d4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3546,6 +3546,8 @@ void free_unref_page_list(struct list_head *list)
>  	list_for_each_entry_safe(page, next, list, lru) {
>  		struct zone *zone = page_zone(page);
>  
> +		list_del(&page->lru);
> +
>  		/* Different zone, different pcp lock. */
>  		if (zone != locked_zone) {
>  			if (pcp)

