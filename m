Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD46B724403
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbjFFNMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbjFFNMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:12:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88D21BCC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:11:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 822ED1FD6B;
        Tue,  6 Jun 2023 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686057087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0C1+FMsfmCIUNjC0V/gx8XXhCxbJ3Mce3wtjwm0JW5U=;
        b=qlVUVXW/v8Jv28eeMEyDonAWcVZoL1ChLeSpSWfol/k6AMn21oNi8biwXvySNLFhXJztAz
        zLv4xuN8BtHNmCNcQif5JPemExnx92r2SsixqcITSzoSlNCetZlvQPsnRu5rrpxozHNdf9
        MBit2uDAQSihG9L3LIZtJAZyqreXHTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686057087;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0C1+FMsfmCIUNjC0V/gx8XXhCxbJ3Mce3wtjwm0JW5U=;
        b=Z6jjQScc76ruTKzAlUTRjf1smsJ4U2qVej6BIaWowSX0NwDHseiPsF/ZaJZXA9Ck53kmxk
        yG7pnF2L3WOXs+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5705F13776;
        Tue,  6 Jun 2023 13:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Sb9wFH8wf2QcUwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 06 Jun 2023 13:11:27 +0000
Message-ID: <2c802986-3726-f79c-6383-cc03adb9fb0c@suse.cz>
Date:   Tue, 6 Jun 2023 15:11:27 +0200
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
 <152e0730-0ddc-a1f8-7122-275d51741a1d@suse.cz>
 <20230602124825.24a775kwwuf4rs6v@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230602124825.24a775kwwuf4rs6v@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 14:48, Mel Gorman wrote:
> On Fri, Jun 02, 2023 at 02:19:00PM +0200, Vlastimil Babka wrote:
>> On 6/2/23 13:16, Mel Gorman wrote:
>> > On Mon, May 29, 2023 at 02:43:48PM +0200, Vlastimil Babka wrote:
>> >> On 5/29/23 12:33, Mel Gorman wrote:
>> >> > On Thu, May 25, 2023 at 03:37:43PM +0200, Vlastimil Babka wrote:
>> >> >> On 5/15/23 13:33, Mel Gorman wrote:
>> >> >> > isolate_migratepages_block should mark a pageblock as skip if scanning
>> >> >> > started on an aligned pageblock boundary but it only updates the skip
>> >> >> > flag if the first migration candidate is also aligned. Tracing during
>> >> >> > a compaction stress load (mmtests: workload-usemem-stress-numa-compact)
>> >> >> > that many pageblocks are not marked skip causing excessive scanning of
>> >> >> > blocks that had been recently checked. Update pageblock skip based on
>> >> >> > "valid_page" which is set if scanning started on a pageblock boundary.
>> >> >> > 
>> >> >> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> >> >> 
>> >> >> I wonder if this has an unintended side-effect that if we resume
>> >> >> isolate_migratepages_block() of a partially compacted pageblock to finish
>> >> >> it, test_and_set_skip() will now tell us to abort, because we already set
>> >> >> the skip bit in the previous call. This would include the
>> >> >> cc->finish_pageblock rescan cases.
>> >> >> 
>> >> >> So unless I miss something that already prevents that, I agree we should not
>> >> >> tie setting the skip bit to pageblock_aligned(pfn), but maybe if we are not
>> >> >> pageblock aligned, we should ignore the already-set skip bit, as it was most
>> >> >> likely being set by us in the previous iteration and should not prevent us
>> >> >> from finishing the pageblock?
>> >> >> 
>> >> > 
>> >> > Hmm, I think you're right. While it should not hit the original bug,
>> >> > migration candidates are missed until the next compaction scan which
>> >> > could be tricky to detect. Something like this as a separate patch?
>> >> > Build tested only but the intent is for an unaligned start to set the skip
>> >> > bet if already unset but otherwise complete the scan. Like earlier fixes,
>> >> > this might overscan some pageblocks in a given context but we are probably
>> >> > hitting the limits on how compaction can run efficiently in the current
>> >> > scheme without causing other side-effects :(
>> >> 
>> >> Yeah that should work! I think it should be even folded to 3/4 but if you
>> >> want separate, fine too.
>> >> 
>> > 
>> > I was not happy with the test results so limited the scope of the patch
>> > which performed much better both in terms of absolute performance and
>> > compaction activity.
>> 
>> That's surprising. Does that mean that if we isolate COMPACT_CLUSTER_MAX
>> pages, migrate them without failing, but it's not enough to succeed (i.e.
>> there are more pages we need to migrate to free up a whole pageblock), it's
>> better to give up on the rest of the pageblock rather than continue?
> 
> I don't have precise enough data to answer that with certainty but probably
> yes, at least in terms of scan activity. The first version had spikes of
> pages scanned for migration that are not always reproducible and not on
> all machines.

Well, that kinda sucks. So for the patch (with adding the missing NOT below).

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But in raises a question whether we should terminate compaction under the
right conditions after a successful migration immediately, rather than
invoke another iteration of isolate_migratepages_block() where we could skip
over some pages uselessly only to abort at first valid page due to the skip bit.
It would save some cycles and be much more obvious than now, where anyone
trying to understand how it works in detail might conclude it's an oversight?

>> As
>> that's AFAIU the scenario where cc->finish_pageblock is false when we
>> revisit an unfinished pageblock.
>> 
>> > Are you still ok with this version?
>> 
>> It's better than previously in that cc->finish_pageblock == true case is not
>> sabotaged anymore. But the result as described above seems to be a weird
>> non-intuitive and non-obvious heuristic. How did the test differences look like?
>> 
> 
> 5 machines were tested in all (different Intel and AMD generations),
> 2 showed unexpected spikes in scan activity. 1 showed high migration
> scan counts for workloads workload-thpchallenge-kernel-build-xfs
> and workload-usemem-stress-numa-compact. They are both basically
> compaction stressors with the first one using a kernel build
> in the background to generate noise. For the second machine, only
> workload-usemem-stress-numa-compact was affected. In all other test cases
> and machines, the patches were equivalent in terms of behaviour but the
> extreme counter-examples led be to conclude the fix should be as constrained
> as possible unless there is a good reason to do otherwise.
> 
>> > Vlastimil Babka pointed out the following problem with
>> > mm-compaction-update-pageblock-skip-when-first-migration-candidate-is-not-at-the-start.patch
>> > 
>> > 	I wonder if this has an unintended side-effect that if we resume
>> > 	isolate_migratepages_block() of a partially compacted pageblock
>> > 	to finish it, test_and_set_skip() will now tell us to abort,
>> > 	because we already set the skip bit in the previous call. This
>> > 	would include the cc->finish_pageblock rescan cases.
>> > 
>> > He is correct and a partial rescan as implemented in "mm, compaction:
>> > finish pageblocks on complete migration failure" would abort
>> > prematurely.
>> > 
>> > Test and set the skip bit when acquiring "exclusive access" to a pageblock
>> > for migration but only abort if the calling context is rescanning to
>> > finish a pageblock.
>> 
>> Should it say NOT rescanning to finish a pageblock?
>> 
> 
> Yep, it should. The sentence was a last minute update before pushing
> send :(
> 

