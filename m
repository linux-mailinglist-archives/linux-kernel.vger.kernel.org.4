Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD5714995
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjE2Mny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjE2Mnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:43:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3DCB1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:43:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 551431F88E;
        Mon, 29 May 2023 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685364229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GzCtx5Td+eoDNVY0dXN9m8+YNDjh3ADQgtk2GxyYC5g=;
        b=euZA2uppJ9p3Gv6P0DaFZ2l2OvM3BhioXsCROMC8vzMsI1ZRqHoGajYwlkedZb4z3sx6mi
        N7ntNcJtyVU3e/sPg2SUYxMLiks3ByU2pYd4BihU0sVCPcTbImgFeqSbzDALeMrkV+lo/D
        9K/5p2rM83QT05xTNVOVSCi+L+TOhv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685364229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GzCtx5Td+eoDNVY0dXN9m8+YNDjh3ADQgtk2GxyYC5g=;
        b=KEt7R7TPRgqrGjgZDCTbEwvGsi3WHoikP/8JKHT67Bm3YqIyUaozS38aWDuKNtYakfwz1y
        i2I9beTY2u7P3pAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FB171332D;
        Mon, 29 May 2023 12:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NROFCgWedGRgHAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 29 May 2023 12:43:49 +0000
Message-ID: <6695b7e5-9fa5-fae8-8a66-cc5985b0baaf@suse.cz>
Date:   Mon, 29 May 2023 14:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
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
 <e87a9797-c8ce-1959-884a-7f791adeaafc@suse.cz>
 <20230529103342.esek6r5fvmft2nky@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230529103342.esek6r5fvmft2nky@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 12:33, Mel Gorman wrote:
> On Thu, May 25, 2023 at 03:37:43PM +0200, Vlastimil Babka wrote:
>> On 5/15/23 13:33, Mel Gorman wrote:
>> > isolate_migratepages_block should mark a pageblock as skip if scanning
>> > started on an aligned pageblock boundary but it only updates the skip
>> > flag if the first migration candidate is also aligned. Tracing during
>> > a compaction stress load (mmtests: workload-usemem-stress-numa-compact)
>> > that many pageblocks are not marked skip causing excessive scanning of
>> > blocks that had been recently checked. Update pageblock skip based on
>> > "valid_page" which is set if scanning started on a pageblock boundary.
>> > 
>> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> 
>> I wonder if this has an unintended side-effect that if we resume
>> isolate_migratepages_block() of a partially compacted pageblock to finish
>> it, test_and_set_skip() will now tell us to abort, because we already set
>> the skip bit in the previous call. This would include the
>> cc->finish_pageblock rescan cases.
>> 
>> So unless I miss something that already prevents that, I agree we should not
>> tie setting the skip bit to pageblock_aligned(pfn), but maybe if we are not
>> pageblock aligned, we should ignore the already-set skip bit, as it was most
>> likely being set by us in the previous iteration and should not prevent us
>> from finishing the pageblock?
>> 
> 
> Hmm, I think you're right. While it should not hit the original bug,
> migration candidates are missed until the next compaction scan which
> could be tricky to detect. Something like this as a separate patch?
> Build tested only but the intent is for an unaligned start to set the skip
> bet if already unset but otherwise complete the scan. Like earlier fixes,
> this might overscan some pageblocks in a given context but we are probably
> hitting the limits on how compaction can run efficiently in the current
> scheme without causing other side-effects :(

Yeah that should work! I think it should be even folded to 3/4 but if you
want separate, fine too.

> diff --git a/mm/compaction.c b/mm/compaction.c
> index 91af6a8b7a98..761a2dd7d78a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -792,6 +792,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  	bool skip_on_failure = false;
>  	unsigned long next_skip_pfn = 0;
>  	bool skip_updated = false;
> +	bool start_aligned;
>  	int ret = 0;
>  
>  	cc->migrate_pfn = low_pfn;
> @@ -824,6 +825,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  	}
>  
>  	/* Time to isolate some pages for migration */
> +	start_aligned = pageblock_aligned(start_pfn);
>  	for (; low_pfn < end_pfn; low_pfn++) {
>  
>  		if (skip_on_failure && low_pfn >= next_skip_pfn) {
> @@ -1069,10 +1071,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  
>  			lruvec_memcg_debug(lruvec, page_folio(page));
>  
> -			/* Try get exclusive access under lock */
> +			/* Try get exclusive access under lock. Isolation is
> +			 * only aborted if the start was pageblock aligned
> +			 * as this may be a partial resumed scan that set
> +			 * the bit on a recent scan but the scan must reach
> +			 * the end of the pageblock.
> +			 */
>  			if (!skip_updated && valid_page) {
>  				skip_updated = true;
> -				if (test_and_set_skip(cc, valid_page))
> +				if (test_and_set_skip(cc, valid_page) && start_aligned)
>  					goto isolate_abort;
>  			}
>  

