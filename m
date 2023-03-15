Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867306BB8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCOP4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjCOPzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:55:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0B35A6D2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:54:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 538C81FD83;
        Wed, 15 Mar 2023 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678895672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0aCWIYa326RLpPY8ttk7CVUTnd7Pxqk529d3RaeNXEE=;
        b=LNprHW6je3Q1tHksvit1HEMnsj2ETDtXJwenQb8e4i5HOGhIKicTwAI9WzeRa2pr8gvoC6
        uldV5obRZgq0u9QuavELGSxizYkwh3TEhgCB3MfOFOevzKWF/eDx0kmQlE8VL3zlSCFzJT
        pYLyRC9EIPRqgNYIsvEr58CO1YY/Acw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678895672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0aCWIYa326RLpPY8ttk7CVUTnd7Pxqk529d3RaeNXEE=;
        b=2rviSpn+CAaLS96h24uEf8u23NeHFc6ga7pBYDAHxab2Lc0STY63KIoGO4hiHFR8KudjCR
        5f7dHuaKdjL5qmDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36ACB13A2F;
        Wed, 15 Mar 2023 15:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0B2kDDjqEWQCeAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Mar 2023 15:54:32 +0000
Message-ID: <258932e0-a2a6-7f17-014c-05676bfad456@suse.cz>
Date:   Wed, 15 Mar 2023 16:54:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] mm: compaction: consider the number of scanning
 compound pages in isolate fail path
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, osalvador@suse.de,
        william.lam@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 11:37, Baolin Wang wrote:
> The commit b717d6b93b54 ("mm: compaction: include compound page count
> for scanning in pageblock isolation") had added compound page statistics
> for scanning in pageblock isolation, to make sure the number of scanned
> pages are always larger than the number of isolated pages when isolating
> mirgratable or free pageblock.
> 
> However, when failed to isolate the pages when scanning the mirgratable or
> free pageblock, the isolation failure path did not consider the scanning
> statistics of the compound pages, which can show the incorrect number of
> scanned pages in tracepoints or the vmstats to make people confusing about
> the page scanning pressure in memory compaction.
> 
> Thus we should take into account the number of scanning pages when failed
> to isolate the compound pages to make the statistics accurate.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/compaction.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 5a9501e0ae01..c9d9ad958e2a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -587,6 +587,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>  				blockpfn += (1UL << order) - 1;
>  				cursor += (1UL << order) - 1;
>  			}
> +			nr_scanned += (1UL << order) - 1;

I'd rather put it in the block above that tests order < MAX_ORDER. Otherwise
as the comments say, the value can be bogus as it's racy.

>  			goto isolate_fail;
>  		}
>  
> @@ -873,9 +874,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			cond_resched();
>  		}
>  
> -		nr_scanned++;
> -
>  		page = pfn_to_page(low_pfn);
> +		nr_scanned += compound_nr(page);

For the same reason, I'd rather leave the nr_scanned adjustment by order in
the specific code blocks where we know/think we have a compound or huge page
and have sanity checked the order/nr_pages, and not add an unchecked
compound_nr() here.

Thanks.

>  
>  		/*
>  		 * Check if the pageblock has already been marked skipped.
> @@ -1077,6 +1077,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			 */
>  			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
>  				low_pfn += compound_nr(page) - 1;
> +				nr_scanned += compound_nr(page) - 1;
>  				SetPageLRU(page);
>  				goto isolate_fail_put;
>  			}
> @@ -1097,7 +1098,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  isolate_success_no_list:
>  		cc->nr_migratepages += compound_nr(page);
>  		nr_isolated += compound_nr(page);
> -		nr_scanned += compound_nr(page) - 1;
>  
>  		/*
>  		 * Avoid isolating too much unless this block is being

