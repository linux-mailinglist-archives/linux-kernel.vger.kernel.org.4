Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAE9695364
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBMVvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBMVvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:51:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B421717B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:51:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3182B22459;
        Mon, 13 Feb 2023 21:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676325059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9NOANQ/j8mNxhV9ZOxgGkAaTG41rz166SP38LuJvG8=;
        b=p8yCJdA2kUyyStWh6301z3L5TcuBh46826gh6pyFNhpJCOMq53RWt6BWkaaHzTxaaaIQQi
        Gsl2nVC1GLXoGNIczT3In/BY2gs+WKu+ljqvO2bNw+xxVYuhSaFAUB0W7okkDV1TGp3OA6
        SaMyTWYXmHHU1rEuUXcF1yWpvJAY5po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676325059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9NOANQ/j8mNxhV9ZOxgGkAaTG41rz166SP38LuJvG8=;
        b=sJFwGlTSNQQ+CHBYXXx4U8vPYoSb2kzWSjZFgnMarp1+h6TuLEJDrAvIvilNhHcRXKE2/X
        MFYzMK+xk7EHmcAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E225B138E6;
        Mon, 13 Feb 2023 21:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RJZiNsKw6mO2VgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Feb 2023 21:50:58 +0000
Message-ID: <bddb8cd0-398b-bd57-5d19-7b046db6c0ea@suse.cz>
Date:   Mon, 13 Feb 2023 22:50:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/4] mm, compaction: Finish pageblocks on complete
 migration failure
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
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
References: <20230125134434.18017-1-mgorman@techsingularity.net>
 <20230125134434.18017-5-mgorman@techsingularity.net>
 <a55cf026-a2f9-ef01-9a4c-398693e048ea@suse.cz>
In-Reply-To: <a55cf026-a2f9-ef01-9a4c-398693e048ea@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 18:42, Vlastimil Babka wrote:
> On 1/25/23 14:44, Mel Gorman wrote:
>> Commit 7efc3b726103 ("mm/compaction: fix set skip in
>> fast_find_migrateblock") address an issue where a pageblock selected
>> by fast_find_migrateblock() was ignored. Unfortunately, the same fix
>> resulted in numerous reports of khugepaged or kcompactd stalling for
>> long periods of time or consuming 100% of CPU.
>>
>> Tracing showed that there was a lot of rescanning between a small subset
>> of pageblocks because the conditions for marking the block skip are not
>> met. The scan is not reaching the end of the pageblock because enough
>> pages were isolated but none were migrated successfully. Eventually it
>> circles back to the same block.
>>
>> Pageblock skip tracking tries to minimise both latency and excessive
>> scanning but tracking exactly when a block is fully scanned requires an
>> excessive amount of state. This patch forcibly rescans a pageblock when
>> all isolated pages fail to migrate even though it could be for transient
>> reasons such as page writeback or page dirty. This will sometimes migrate
>> too many pages but pageblocks will be marked skip and forward progress
>> will be made.
>>
>> "Usemen" from the mmtests configuration
>> workload-usemem-stress-numa-compact was used to stress compaction.
>> The compaction trace events were recorded using a 6.2-rc5 kernel that
>> includes commit 7efc3b726103 and count of unique ranges were measured. The
>> top 5 ranges were
>>
>>    3076 range=(0x10ca00-0x10cc00)
>>    3076 range=(0x110a00-0x110c00)
>>    3098 range=(0x13b600-0x13b800)
>>    3104 range=(0x141c00-0x141e00)
>>   11424 range=(0x11b600-0x11b800)
>>
>> While this workload is very different than what the bugs reported,
>> the pattern of the same subset of blocks being repeatedly scanned is
>> observed. At one point, *only* the range range=(0x11b600 ~ 0x11b800)
>> was scanned for 2 seconds. 14 seconds passed between the first
>> migration-related event and the last.
>>
>> With the series applied including this patch, the top 5 ranges were
>>
>>       1 range=(0x11607e-0x116200)
>>       1 range=(0x116200-0x116278)
>>       1 range=(0x116278-0x116400)
>>       1 range=(0x116400-0x116424)
>>       1 range=(0x116424-0x116600)
>>
>> Only unique ranges were scanned and the time between the first
>> migration-related event was 0.11 milliseconds.
>>
>> Fixes: 7efc3b726103 ("mm/compaction: fix set skip in fast_find_migrateblock")
>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> While this seems like it will mostly prevent the issue at hand (I think
> kcompactd is still a hazard, see below), I'm not super happy about some of
> the implementation details.

For the record, after some discussion with Mel, my concerns are not a blocker
and the series can proceed from mm-stable to 6.3.

> 1. it modifies code that was meant to quickly skip an order-aligned block
> where a page migration failed during MIGRATE_ASYNC direct compaction, as
> it's very unlikely to sucessfully form a free page of that order in that
> block. Now instead it will finish the whole pageblock in that case, which
> could be lots of useless work and thus exactly the opposite of what we
> wanted for MIGRATE_ASYNC direct compaction.

There are both advantages and disadvantages to this so not clear win or lose.

> 2. The conditions "cc->direct_compaction" and "(cc->mode < MIGRATE_SYNC)"
> seem a bit hazardous. I think we can have a compaction where these are not
> true, and yet it uses fast_find_migrateblock() and thus can exhibit the bug
> but won't be forced to rescan?
> AFAICS kcompactd_do_work()
> - is MIGRATE_SYNC_LIGHT
> - has ignore_skip_hint = false
> - has direct_compaction = false
> 
> so AFAICS it will use fast_find_migrateblock() and not bail out in one of
> the preconditions. But the cc->direct_compaction condition here won't apply.

This is only a concern once we attempt to un-revert 7efc3b726103 again so
only necessary to be addressed as part of future series leading to the un-revert.

> So it might be better to leave the current "skip the rest of block" check
> alone, and add a separate check for the finish_pageblock rescan that will
> not miss some cases where it should apply - maybe it could check for a
> complete migration failure specifically as well?
>> ---
>>  mm/compaction.c | 30 ++++++++++++++++++++++--------
>>  1 file changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 4b3a0238879c..937ec2f05f2c 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -2394,6 +2394,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>>  			cc->finish_pageblock = true;
>>  		}
>>  
>> +rescan:
>>  		switch (isolate_migratepages(cc)) {
>>  		case ISOLATE_ABORT:
>>  			ret = COMPACT_CONTENDED;
>> @@ -2436,15 +2437,28 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>>  				goto out;
>>  			}
>>  			/*
>> -			 * We failed to migrate at least one page in the current
>> -			 * order-aligned block, so skip the rest of it.
>> +			 * If an ASYNC or SYNC_LIGHT fails to migrate a page
>> +			 * within the current order-aligned block, scan the
>> +			 * remainder of the pageblock. This will mark the
>> +			 * pageblock "skip" to avoid rescanning in the near
>> +			 * future. This will isolate more pages than necessary
>> +			 * for the request but avoid loops due to
>> +			 * fast_find_migrateblock revisiting blocks that were
>> +			 * recently partially scanned.
>>  			 */
>> -			if (cc->direct_compaction &&
>> -						(cc->mode == MIGRATE_ASYNC)) {
>> -				cc->migrate_pfn = block_end_pfn(
>> -						cc->migrate_pfn - 1, cc->order);
>> -				/* Draining pcplists is useless in this case */
>> -				last_migrated_pfn = 0;
>> +			if (cc->direct_compaction && !cc->finish_pageblock &&
>> +						(cc->mode < MIGRATE_SYNC)) {
>> +				cc->finish_pageblock = true;
>> +
>> +				/*
>> +				 * Draining pcplists does not help THP if
>> +				 * any page failed to migrate. Even after
>> +				 * drain, the pageblock will not be free.
>> +				 */
>> +				if (cc->order == COMPACTION_HPAGE_ORDER)
>> +					last_migrated_pfn = 0;
>> +
>> +				goto rescan;
>>  			}
>>  		}
>>  
> 
> 
