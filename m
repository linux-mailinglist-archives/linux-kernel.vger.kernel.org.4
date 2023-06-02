Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4CA7201E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjFBMUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjFBMUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:20:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D73E61
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:19:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA4D621A29;
        Fri,  2 Jun 2023 12:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685708340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xWrTD5r3jCFB8Ro7kFCjCemNpQRRhZYXC/icNbB4pz0=;
        b=vJE4plNwu48kv93eChJPcQq0SrSzNmjhLUYo5xeeAsj29f/zw65u9n8OHkOtXwgdt0l0Oj
        hKS/4zp7ZYL/4vKA0E2HWFKko0CjVrXabK0AGVDEFKETA73XpsTMPR3euhkYFPAUFnsOpp
        gr9tQEAMGRyln8UOQAeuTh5p2osQVf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685708340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xWrTD5r3jCFB8Ro7kFCjCemNpQRRhZYXC/icNbB4pz0=;
        b=IcZettIc5WV0fAbWv8VDuC3jOQbeBSwcywGEVnm8ORZ/5iGBSt8VaLXG8KAZUBikIFaFva
        cD0AuG6/KPdL9rDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A640213A2E;
        Fri,  2 Jun 2023 12:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Rs7TJzTeeWQhFAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 02 Jun 2023 12:19:00 +0000
Message-ID: <152e0730-0ddc-a1f8-7122-275d51741a1d@suse.cz>
Date:   Fri, 2 Jun 2023 14:19:00 +0200
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
 <6695b7e5-9fa5-fae8-8a66-cc5985b0baaf@suse.cz>
 <20230602111622.swtxhn6lu2qwgrwq@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230602111622.swtxhn6lu2qwgrwq@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 13:16, Mel Gorman wrote:
> On Mon, May 29, 2023 at 02:43:48PM +0200, Vlastimil Babka wrote:
>> On 5/29/23 12:33, Mel Gorman wrote:
>> > On Thu, May 25, 2023 at 03:37:43PM +0200, Vlastimil Babka wrote:
>> >> On 5/15/23 13:33, Mel Gorman wrote:
>> >> > isolate_migratepages_block should mark a pageblock as skip if scanning
>> >> > started on an aligned pageblock boundary but it only updates the skip
>> >> > flag if the first migration candidate is also aligned. Tracing during
>> >> > a compaction stress load (mmtests: workload-usemem-stress-numa-compact)
>> >> > that many pageblocks are not marked skip causing excessive scanning of
>> >> > blocks that had been recently checked. Update pageblock skip based on
>> >> > "valid_page" which is set if scanning started on a pageblock boundary.
>> >> > 
>> >> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> >> 
>> >> I wonder if this has an unintended side-effect that if we resume
>> >> isolate_migratepages_block() of a partially compacted pageblock to finish
>> >> it, test_and_set_skip() will now tell us to abort, because we already set
>> >> the skip bit in the previous call. This would include the
>> >> cc->finish_pageblock rescan cases.
>> >> 
>> >> So unless I miss something that already prevents that, I agree we should not
>> >> tie setting the skip bit to pageblock_aligned(pfn), but maybe if we are not
>> >> pageblock aligned, we should ignore the already-set skip bit, as it was most
>> >> likely being set by us in the previous iteration and should not prevent us
>> >> from finishing the pageblock?
>> >> 
>> > 
>> > Hmm, I think you're right. While it should not hit the original bug,
>> > migration candidates are missed until the next compaction scan which
>> > could be tricky to detect. Something like this as a separate patch?
>> > Build tested only but the intent is for an unaligned start to set the skip
>> > bet if already unset but otherwise complete the scan. Like earlier fixes,
>> > this might overscan some pageblocks in a given context but we are probably
>> > hitting the limits on how compaction can run efficiently in the current
>> > scheme without causing other side-effects :(
>> 
>> Yeah that should work! I think it should be even folded to 3/4 but if you
>> want separate, fine too.
>> 
> 
> I was not happy with the test results so limited the scope of the patch
> which performed much better both in terms of absolute performance and
> compaction activity.

That's surprising. Does that mean that if we isolate COMPACT_CLUSTER_MAX
pages, migrate them without failing, but it's not enough to succeed (i.e.
there are more pages we need to migrate to free up a whole pageblock), it's
better to give up on the rest of the pageblock rather than continue? As
that's AFAIU the scenario where cc->finish_pageblock is false when we
revisit an unfinished pageblock.

Are you still ok with this version?

It's better than previously in that cc->finish_pageblock == true case is not
sabotaged anymore. But the result as described above seems to be a weird
non-intuitive and non-obvious heuristic. How did the test differences look like?

> Thanks
> 
> --8<--
> mm: compaction: Update pageblock skip when first migration candidate is not at the start -fix
> 
> Vlastimil Babka pointed out the following problem with
> mm-compaction-update-pageblock-skip-when-first-migration-candidate-is-not-at-the-start.patch
> 
> 	I wonder if this has an unintended side-effect that if we resume
> 	isolate_migratepages_block() of a partially compacted pageblock
> 	to finish it, test_and_set_skip() will now tell us to abort,
> 	because we already set the skip bit in the previous call. This
> 	would include the cc->finish_pageblock rescan cases.
> 
> He is correct and a partial rescan as implemented in "mm, compaction:
> finish pageblocks on complete migration failure" would abort
> prematurely.
> 
> Test and set the skip bit when acquiring "exclusive access" to a pageblock
> for migration but only abort if the calling context is rescanning to
> finish a pageblock.

Should it say NOT rescanning to finish a pageblock?

> This is a fix for the mmotm patch
> mm-compaction-update-pageblock-skip-when-first-migration-candidate-is-not-at-the-start.patch
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/compaction.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 91af6a8b7a98..300aa968a0cf 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1069,11 +1069,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  
>  			lruvec_memcg_debug(lruvec, page_folio(page));
>  
> -			/* Try get exclusive access under lock */
> +			/*
> +			 * Try get exclusive access under lock. If marked for
> +			 * skip, the scan is aborted unless the current context
> +			 * is a rescan to reach the end of the pageblock.
> +			 */
>  			if (!skip_updated && valid_page) {
>  				skip_updated = true;
> -				if (test_and_set_skip(cc, valid_page))
> +				if (test_and_set_skip(cc, valid_page) &&
> +				    !cc->finish_pageblock) {
>  					goto isolate_abort;
> +				}
>  			}
>  
>  			/*

