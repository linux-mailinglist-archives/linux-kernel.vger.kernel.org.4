Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1257633810
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiKVJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiKVJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:11:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA445A1D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:11:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8151D21C53;
        Tue, 22 Nov 2022 09:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669108311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eQy8/FzmfAJmY6PaadkWLeuCTeBU4iD5a7n2mEcspo=;
        b=13VX7qi1e2z/i1+Da0UlPonXzuzd29Mv1N/s3ixxOmenm9wvIgrC7eAuTUgUp7qIW7pupU
        I2vEooyh734wRfPDYZU6hY2Xu9lOgjlB9Q59S3ZupVOzc/5LxGq6xIgTDmnqbVcvyr9WIl
        9sspETKbh8zYkaJhNoDYleXHGuAr7Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669108311;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eQy8/FzmfAJmY6PaadkWLeuCTeBU4iD5a7n2mEcspo=;
        b=/m/OvbrBSI98HGwjHOaKIKiU0P+NhKBH15F7l01x4TCSgZMoh1ar2nbEGEjn9xJsOUSyQJ
        4211cje37/q5j/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59BA813AA1;
        Tue, 22 Nov 2022 09:11:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NQEzFVeSfGMpMgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 22 Nov 2022 09:11:51 +0000
Message-ID: <79a168e3-41a0-ce4c-6f9c-777974f042aa@suse.cz>
Date:   Tue, 22 Nov 2022 10:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20221118101714.19590-1-mgorman@techsingularity.net>
 <20221118101714.19590-3-mgorman@techsingularity.net>
 <f9acd363-bf53-c582-78ec-347fd7ec5c37@suse.cz>
 <20221121120121.djgvgm5bsklgfx7c@techsingularity.net>
 <20221121160324.4q7clvqdqohgycqh@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221121160324.4q7clvqdqohgycqh@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 17:03, Mel Gorman wrote:
> On Mon, Nov 21, 2022 at 12:01:23PM +0000, Mel Gorman wrote:
>> On Fri, Nov 18, 2022 at 03:30:57PM +0100, Vlastimil Babka wrote:
>> > On 11/18/22 11:17, Mel Gorman wrote:
>> > AFAICS if this block was just "locked_zone = NULL;" then the existing code
>> > would do the right thing.
>> > Or maybe to have simpler code, just do batch_count++ here and
>> > make the relocking check do
>> > if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX)
>> > 
>> 
>> While I think you're right, I think it's a bit subtle, the batch reset would
>> need to move, rechecked within the "Different zone, different pcp lock."
>> block and it would be easy to forget exactly why it's structured like
>> that in the future.  Rather than being a fix, it could be a standalone
>> patch so it would be obvious in git blame but I don't feel particularly
>> strongly about it.
>> 
> 
> Ok, less subtle than I initially thought but still deserving of a separate
> patch instead of being a fix. This?

Yeah, thanks!

> --8<--
> mm/page_alloc: Simplify locking during free_unref_page_list
> 
> While freeing a large list, the zone lock will be released and reacquired
> to avoid long hold times since commit c24ad77d962c ("mm/page_alloc.c: avoid
> excessive IRQ disabled times in free_unref_page_list()"). As suggested
> by Vlastimil Babka, the lockrelease/reacquire logic can be simplified by
> reusing the logic that acquires a different lock when changing zones.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 445066617204..08e32daf0918 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3518,13 +3518,19 @@ void free_unref_page_list(struct list_head *list)
>  		list_del(&page->lru);
>  		migratetype = get_pcppage_migratetype(page);
>  
> -		/* Different zone, different pcp lock. */
> -		if (zone != locked_zone) {
> +		/*
> +		 * Either different zone requiring a different pcp lock or
> +		 * excessive lock hold times when freeing a large list of
> +		 * pages.
> +		 */
> +		if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX) {
>  			if (pcp) {
>  				pcp_spin_unlock(pcp);
>  				pcp_trylock_finish(UP_flags);
>  			}
>  
> +			batch_count = 0;
> +
>  			/*
>  			 * trylock is necessary as pages may be getting freed
>  			 * from IRQ or SoftIRQ context after an IO completion.
> @@ -3539,7 +3545,6 @@ void free_unref_page_list(struct list_head *list)
>  				continue;
>  			}
>  			locked_zone = zone;
> -			batch_count = 0;
>  		}
>  
>  		/*
> @@ -3551,19 +3556,7 @@ void free_unref_page_list(struct list_head *list)
>  
>  		trace_mm_page_free_batched(page);
>  		free_unref_page_commit(zone, pcp, page, migratetype, 0);
> -
> -		/*
> -		 * Guard against excessive lock hold times when freeing
> -		 * a large list of pages. Lock will be reacquired if
> -		 * necessary on the next iteration.
> -		 */
> -		if (++batch_count == SWAP_CLUSTER_MAX) {
> -			pcp_spin_unlock(pcp);
> -			pcp_trylock_finish(UP_flags);
> -			batch_count = 0;
> -			pcp = NULL;
> -			locked_zone = NULL;
> -		}
> +		batch_count++;
>  	}
>  
>  	if (pcp) {

