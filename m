Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5215710D55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbjEYNhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbjEYNht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:37:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE4A189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:37:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F34AA218F9;
        Thu, 25 May 2023 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685021864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/r1TjuHRk87vZnJSLMqQQxYQGCl47OQhhzNLhQKQO0=;
        b=HNNsj33V1+QutPNL1pJrAYIG7mKzwiGy3Pde/xj2/BglCsWn0nSauWpU1fd2KeMcVn6Nzf
        CsUTbyjoGo7RuVvuw5TNLD3/QGbodx3DI0xIvaFjw+BWUJAqFZpIR+fmov7QsUEkf4AIHB
        1wH3ZVG2M7gQ/8UiJzQyCnpIaT68yPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685021864;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/r1TjuHRk87vZnJSLMqQQxYQGCl47OQhhzNLhQKQO0=;
        b=yrzthYOmjmxrwX0gyDNohgkWuM7aNMyf7iVCIGSenviDCHXr5dR+up8vJ6Quur60iQUbk1
        uguvgN+VlJL+7LBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0AE413356;
        Thu, 25 May 2023 13:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id grEvMqdkb2ReVQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 May 2023 13:37:43 +0000
Message-ID: <e87a9797-c8ce-1959-884a-7f791adeaafc@suse.cz>
Date:   Thu, 25 May 2023 15:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] mm: compaction: Update pageblock skip when first
 migration candidate is not at the start
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230515113344.6869-1-mgorman@techsingularity.net>
 <20230515113344.6869-4-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230515113344.6869-4-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 13:33, Mel Gorman wrote:
> isolate_migratepages_block should mark a pageblock as skip if scanning
> started on an aligned pageblock boundary but it only updates the skip
> flag if the first migration candidate is also aligned. Tracing during
> a compaction stress load (mmtests: workload-usemem-stress-numa-compact)
> that many pageblocks are not marked skip causing excessive scanning of
> blocks that had been recently checked. Update pageblock skip based on
> "valid_page" which is set if scanning started on a pageblock boundary.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

I wonder if this has an unintended side-effect that if we resume
isolate_migratepages_block() of a partially compacted pageblock to finish
it, test_and_set_skip() will now tell us to abort, because we already set
the skip bit in the previous call. This would include the
cc->finish_pageblock rescan cases.

So unless I miss something that already prevents that, I agree we should not
tie setting the skip bit to pageblock_aligned(pfn), but maybe if we are not
pageblock aligned, we should ignore the already-set skip bit, as it was most
likely being set by us in the previous iteration and should not prevent us
from finishing the pageblock?

> ---
>  mm/compaction.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index accc6568091a..d7be990b1d60 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -392,18 +392,14 @@ void reset_isolation_suitable(pg_data_t *pgdat)
>   * Sets the pageblock skip bit if it was clear. Note that this is a hint as
>   * locks are not required for read/writers. Returns true if it was already set.
>   */
> -static bool test_and_set_skip(struct compact_control *cc, struct page *page,
> -							unsigned long pfn)
> +static bool test_and_set_skip(struct compact_control *cc, struct page *page)
>  {
>  	bool skip;
>  
> -	/* Do no update if skip hint is being ignored */
> +	/* Do not update if skip hint is being ignored */
>  	if (cc->ignore_skip_hint)
>  		return false;
>  
> -	if (!pageblock_aligned(pfn))
> -		return false;
> -
>  	skip = get_pageblock_skip(page);
>  	if (!skip && !cc->no_set_skip_hint)
>  		set_pageblock_skip(page);
> @@ -470,8 +466,7 @@ static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
>  {
>  }
>  
> -static bool test_and_set_skip(struct compact_control *cc, struct page *page,
> -							unsigned long pfn)
> +static bool test_and_set_skip(struct compact_control *cc, struct page *page)
>  {
>  	return false;
>  }
> @@ -1075,9 +1070,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			lruvec_memcg_debug(lruvec, page_folio(page));
>  
>  			/* Try get exclusive access under lock */
> -			if (!skip_updated) {
> +			if (!skip_updated && valid_page) {
>  				skip_updated = true;
> -				if (test_and_set_skip(cc, page, low_pfn))
> +				if (test_and_set_skip(cc, valid_page))
>  					goto isolate_abort;
>  			}
>  

