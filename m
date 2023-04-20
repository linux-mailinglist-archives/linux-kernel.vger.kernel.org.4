Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E866E878A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjDTBkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjDTBkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:40:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473131BF0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681954814; x=1713490814;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=G1DkaHEZt8/FNUw8vlJ9t05zmgqwE4zlsOzsNff0UvY=;
  b=F2UEoHcIXGR88fy8ArMPmtgzvnGc5d9sOpaheVH5AWhUA6i5Hq1ln0y0
   D/+UNcM1kHk+46i0VXOvvGJHGdb7vHTHKfOm8lFtZujM5zdWliB7Cs5sF
   JlyX71P96h9F4jtO+pgsX2pMyJeQP3s/ljtqx8L3j7XZmL2UEtIa7Wdy0
   Tg4QPKk1prEi9eIDxI7rn/l9u74Bi7knbAkldbThqBTD48bjcizFmqOju
   AXDFHtibUQeDq10sK3Qm6LXLnFnM1NuvAv+kwAJksMV6ELe5UmIPBampI
   vqigER6d2NnL4WrqAXZfF/D96diThvEiMLMKldXDB66O3ujxsEKtj4tQp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334425788"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="334425788"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 18:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="669184169"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="669184169"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 18:40:11 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC PATCH] migrate_pages: Never block waiting for the page lock
References: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
        <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
        <87ildvwbr5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAD=FV=WCWWuGO7D9X6By-fQ0ZB63iDsAvcPwza-F6tbA-Z_M6w@mail.gmail.com>
        <87edohvpzk.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAD=FV=V1SAufJUT-d5praYszUN1ssdT61WS7iB-c62R4M6Lsmw@mail.gmail.com>
        <87wn28u2wy.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAD=FV=XBjG85VAKqAmffBnWH+-zcY2JJ_MoGuPev4r3xjn=B-Q@mail.gmail.com>
Date:   Thu, 20 Apr 2023 09:39:02 +0800
In-Reply-To: <CAD=FV=XBjG85VAKqAmffBnWH+-zcY2JJ_MoGuPev4r3xjn=B-Q@mail.gmail.com>
        (Doug Anderson's message of "Wed, 19 Apr 2023 12:30:55 -0700")
Message-ID: <87h6tbtjrd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:

> Hi,
>
> On Tue, Apr 18, 2023 at 5:34=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> >> >> >> TBH, the test case is too extreme for me.
>> >> >> >
>> >> >> > That's fair. That being said, I guess the point I was trying to =
make
>> >> >> > is that waiting for this lock could take an unbounded amount of =
time.
>> >> >> > Other parts of the system sometimes hold a page lock and then do=
 a
>> >> >> > blocking operation. At least in the case of kcompactd there are =
better
>> >> >> > uses of its time than waiting for any given page.
>> >> >> >
>> >> >> >> And, we have multiple "sync" mode to deal with latency requirem=
ent, for
>> >> >> >> example, we use MIGRATE_SYNC_LIGHT for compaction to avoid too =
long
>> >> >> >> latency.  If you have latency requirement for some users, you m=
ay
>> >> >> >> consider to add new "sync" mode.
>> >> >> >
>> >> >> > Sure. kcompactd_do_work() is currently using MIGRATE_SYNC_LIGHT.=
 I
>> >> >> > guess my first thought would be to avoid adding a new mode and m=
ake
>> >> >> > MIGRATE_SYNC_LIGHT not block here. Then anyone that truly needs =
to
>> >> >> > wait for all the pages to be migrated can use the heavier sync m=
odes.
>> >> >> > It seems to me like the current users of MIGRATE_SYNC_LIGHT woul=
d not
>> >> >> > want to block for an unbounded amount of time here. What do you =
think?
>> >> >>
>> >> >> It appears that you can just use MIGRATE_ASYNC if you think the co=
rrect
>> >> >> behavior is "NOT block at all".  I found that there are more
>> >> >> fine-grained controls on this in compaction code, please take a lo=
ok at
>> >> >> "enum compact_priority" and its comments.
>> >> >
>> >> > Actually, the more I think about it the more I think the right answ=
er
>> >> > is to keep kcompactd as using MIGRATE_SYNC_LIGHT and make
>> >> > MIGRATE_SYNC_LIGHT not block on the folio lock.
>> >>
>> >> Then, what is the difference between MIGRATE_SYNC_LIGHT and
>> >> MIGRATE_ASYNC?
>> >
>> > Aren't there still some differences even if we remove blocking this
>> > one lock? ...or maybe your point is that maybe the other differences
>> > have similar properties?
>>
>> Sorry for confusing words.  Here, I asked you to list the implementation
>> difference between MIGRATE_ASYNC and MIGRATE_SYNC_LIGHT after your
>> proposed changes.  Which are waited in MIGRATE_SYNC_LIGHT but not in
>> MIGRATE_ASYNC?
>
> Ah, got it! It's not always the easiest to follow all the code paths,
> but let's see what I can find.
>
> I guess to start with, though, I will assert that someone seems to
> have believed that there was an important difference between
> MIGRATE_ASYNC and MIGRATE_SYNC_LIGHT besides waiting on the lock in
> migrate_folio_unmapt() since (as I found in my previous digging) the
> "direct reclaim" path never grabs this lock but explicitly sometimes
> chooses MIGRATE_ASYNC some times and MIGRATE_SYNC_LIGHT other times.
>
> OK, so looking at mainline Linux and comparing differences in behavior
> between SYNC_LIGHT and ASYNC and thoughts about which one should be
> used for kcompactd. Note that I won't go _too_ deep into all the
> differences...
>
> --
>
> In nfs.c:
>
> 1. We will wait for the fscache if SYNC_LIGHT but not ASYNC. No idea
> what would be the most ideal for calls from kcompactd.

This appears like something like disk writing.

> In compaction.c:
>
> 2. We will update the non-async "compact_cached_migrate_pfn" for
> SYNC_LIGHT but not ASYNC since we keep track of sync and async
> progress separately.
>
> 3. compact_lock_irqsave() note contentions for ASYNC but not
> SYNC_LIGHT and cause an earlier abort. Seems like kcompactd would want
> the SYNC_LIGHT behavior since this isn't about things indefinitely
> blocking.
>
> 4. isolate_migratepages_block() will bail if too_many_isolated() for
> ASYNC but not SYNC_LIGHT. My hunch is that kcompactd wants the
> SYNC_LIGHT behavior for kcompact.
>
> 5. If in direct compaction, isolate_migratepages_block() sets
> "skip_on_failure" for ASYNC but not SYNC_LIGHT. My hunch is that
> kcompactd wants the SYNC_LIGHT behavior for kcompact.
>
> 6. suitable_migration_source() considers more things suitable
> migration sources when SYNC_LIGHT but not (ASYNC+direct_compaction).
> Doesn't matter since kcompactd isn't direct compaction and non-direct
> compaction is the same.
>
> 7. fast_isolate_around() does less scanning when SYNC_LIGHT but not
> (ASYNC+direct_compaction). Again, it doesn't matter for kcompactd.
>
> 8. isolate_freepages() uses a different stride with SYNC_LIGHT vs.
> ASYNC. My hunch is that kcompactd wants the SYNC_LIGHT behavior for
> kcompact.
>
> In migrate.c:
>
> 9. buffer_migrate_lock_buffers() will block waiting to lock buffers
> with SYNC_LIGHT but not ASYNC. I don't know for sure, but this feels
> like something we _wouldn't_ want to block on in kcompactd and instead
> should look for easier pickings.

IIUC, this is similar as page lock.

> 10. migrate_folio_unmap() has the case we've already talked about
>
> 11. migrate_folio_unmap() does batch flushes for async because it
> doesn't need to worry about a class of deadlock. Somewhat recent code
> actually ends up running this code first even for sync modes to get
> the batch.
>
> 12. We'll retry a few more times for SYNC_LIGHT than ASYNC. Seems like
> the more retries won't really hurt for kcompactd.
>
> --
>
> So from looking at all the above, I'll say that kcompactd should stick
> with SYNC_LIGHT and we should fix #10. In other words, like my
> original patch except that we keep blocking on the lock in the full
> SYNC modes.
>
> It's possible that we should also change case #9 I listed above. Do
> you know if locking buffers is likely to block on something as slow as
> page reading/writing?

IIUC, this is related to page reading/writing.  Buffer head is used by
ext2/4 to read/write.

Thank you very much for your research.  It looks like ASYNC isn't
appropriate for kcompactd.

From the comments of SYNC_LIGHT,

 * MIGRATE_SYNC_LIGHT in the current implementation means to allow blocking
 *	on most operations but not ->writepage as the potential stall time
 *	is too significant

To make SYNC_LIGHT block on less operations than before, I guess that
you need to prove the stall time can be long with the operation with
not-so-extreme test cases.

Best Regards,
Huang, Ying
