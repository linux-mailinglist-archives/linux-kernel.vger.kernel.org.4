Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B5E72526F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbjFGDi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjFGDiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:38:25 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE14E54
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 20:38:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VkYyk7Z_1686109097;
Received: from 30.221.128.210(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VkYyk7Z_1686109097)
          by smtp.aliyun-inc.com;
          Wed, 07 Jun 2023 11:38:18 +0800
Message-ID: <b0233597-4702-b398-3a01-363b388da9cc@linux.alibaba.com>
Date:   Wed, 7 Jun 2023 11:38:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/4] mm: compaction: Update pageblock skip when first
 migration candidate is not at the start
To:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
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
 <2c802986-3726-f79c-6383-cc03adb9fb0c@suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <2c802986-3726-f79c-6383-cc03adb9fb0c@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/2023 9:11 PM, Vlastimil Babka wrote:
> On 6/2/23 14:48, Mel Gorman wrote:
>> On Fri, Jun 02, 2023 at 02:19:00PM +0200, Vlastimil Babka wrote:
>>> On 6/2/23 13:16, Mel Gorman wrote:
>>>> On Mon, May 29, 2023 at 02:43:48PM +0200, Vlastimil Babka wrote:
>>>>> On 5/29/23 12:33, Mel Gorman wrote:
>>>>>> On Thu, May 25, 2023 at 03:37:43PM +0200, Vlastimil Babka wrote:
>>>>>>> On 5/15/23 13:33, Mel Gorman wrote:
>>>>>>>> isolate_migratepages_block should mark a pageblock as skip if scanning
>>>>>>>> started on an aligned pageblock boundary but it only updates the skip
>>>>>>>> flag if the first migration candidate is also aligned. Tracing during
>>>>>>>> a compaction stress load (mmtests: workload-usemem-stress-numa-compact)
>>>>>>>> that many pageblocks are not marked skip causing excessive scanning of
>>>>>>>> blocks that had been recently checked. Update pageblock skip based on
>>>>>>>> "valid_page" which is set if scanning started on a pageblock boundary.
>>>>>>>>
>>>>>>>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>>>>>>>
>>>>>>> I wonder if this has an unintended side-effect that if we resume
>>>>>>> isolate_migratepages_block() of a partially compacted pageblock to finish
>>>>>>> it, test_and_set_skip() will now tell us to abort, because we already set
>>>>>>> the skip bit in the previous call. This would include the
>>>>>>> cc->finish_pageblock rescan cases.
>>>>>>>
>>>>>>> So unless I miss something that already prevents that, I agree we should not
>>>>>>> tie setting the skip bit to pageblock_aligned(pfn), but maybe if we are not
>>>>>>> pageblock aligned, we should ignore the already-set skip bit, as it was most
>>>>>>> likely being set by us in the previous iteration and should not prevent us
>>>>>>> from finishing the pageblock?
>>>>>>>
>>>>>>
>>>>>> Hmm, I think you're right. While it should not hit the original bug,
>>>>>> migration candidates are missed until the next compaction scan which
>>>>>> could be tricky to detect. Something like this as a separate patch?
>>>>>> Build tested only but the intent is for an unaligned start to set the skip
>>>>>> bet if already unset but otherwise complete the scan. Like earlier fixes,
>>>>>> this might overscan some pageblocks in a given context but we are probably
>>>>>> hitting the limits on how compaction can run efficiently in the current
>>>>>> scheme without causing other side-effects :(
>>>>>
>>>>> Yeah that should work! I think it should be even folded to 3/4 but if you
>>>>> want separate, fine too.
>>>>>
>>>>
>>>> I was not happy with the test results so limited the scope of the patch
>>>> which performed much better both in terms of absolute performance and
>>>> compaction activity.
>>>
>>> That's surprising. Does that mean that if we isolate COMPACT_CLUSTER_MAX
>>> pages, migrate them without failing, but it's not enough to succeed (i.e.
>>> there are more pages we need to migrate to free up a whole pageblock), it's
>>> better to give up on the rest of the pageblock rather than continue?
>>
>> I don't have precise enough data to answer that with certainty but probably
>> yes, at least in terms of scan activity. The first version had spikes of
>> pages scanned for migration that are not always reproducible and not on
>> all machines.
> 
> Well, that kinda sucks. So for the patch (with adding the missing NOT below).
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> But in raises a question whether we should terminate compaction under the
> right conditions after a successful migration immediately, rather than
> invoke another iteration of isolate_migratepages_block() where we could skip
> over some pages uselessly only to abort at first valid page due to the skip bit.
> It would save some cycles and be much more obvious than now, where anyone
> trying to understand how it works in detail might conclude it's an oversight?

IIUC, for direct compactor, we can terminate compaction if there is a 
suitable free page, that means other pages scanning in this pageblock 
are uselessly like you said, and we can skip them to save cpu cycles. So 
we can remove below COMPACT_CONTINUE validation in __compact_finished():

	/*
	 * Always finish scanning a pageblock to reduce the possibility of
	 * fallbacks in the future. This is particularly important when
	 * migration source is unmovable/reclaimable but it's not worth
	 * special casing.
	 */
	if (!pageblock_aligned(cc->migrate_pfn))
		return COMPACT_CONTINUE;

And in this case, we also should call update_cached_migrate() to record 
the partial cc->migrate_pfn, which is the start position for next 
scanning. Please correct me if I missed something. Thanks.

>>> As
>>> that's AFAIU the scenario where cc->finish_pageblock is false when we
>>> revisit an unfinished pageblock.
>>>
>>>> Are you still ok with this version?
>>>
>>> It's better than previously in that cc->finish_pageblock == true case is not
>>> sabotaged anymore. But the result as described above seems to be a weird
>>> non-intuitive and non-obvious heuristic. How did the test differences look like?
>>>
>>
>> 5 machines were tested in all (different Intel and AMD generations),
>> 2 showed unexpected spikes in scan activity. 1 showed high migration
>> scan counts for workloads workload-thpchallenge-kernel-build-xfs
>> and workload-usemem-stress-numa-compact. They are both basically
>> compaction stressors with the first one using a kernel build
>> in the background to generate noise. For the second machine, only
>> workload-usemem-stress-numa-compact was affected. In all other test cases
>> and machines, the patches were equivalent in terms of behaviour but the
>> extreme counter-examples led be to conclude the fix should be as constrained
>> as possible unless there is a good reason to do otherwise.
>>
>>>> Vlastimil Babka pointed out the following problem with
>>>> mm-compaction-update-pageblock-skip-when-first-migration-candidate-is-not-at-the-start.patch
>>>>
>>>> 	I wonder if this has an unintended side-effect that if we resume
>>>> 	isolate_migratepages_block() of a partially compacted pageblock
>>>> 	to finish it, test_and_set_skip() will now tell us to abort,
>>>> 	because we already set the skip bit in the previous call. This
>>>> 	would include the cc->finish_pageblock rescan cases.
>>>>
>>>> He is correct and a partial rescan as implemented in "mm, compaction:
>>>> finish pageblocks on complete migration failure" would abort
>>>> prematurely.
>>>>
>>>> Test and set the skip bit when acquiring "exclusive access" to a pageblock
>>>> for migration but only abort if the calling context is rescanning to
>>>> finish a pageblock.
>>>
>>> Should it say NOT rescanning to finish a pageblock?
>>>
>>
>> Yep, it should. The sentence was a last minute update before pushing
>> send :(
>>
> 
