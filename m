Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369C46E7078
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjDSAee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjDSAec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:34:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8232710F7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 17:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681864467; x=1713400467;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=2CA/TpUSdrKGSjoZ9YX0iDPOx1tUppAJIF4fLz1tJE8=;
  b=PBr59iUylW44AUGXiwDOEgMoKPMD5LdSv5Hlu01Y/TaRxgbymaHR97wy
   5HmZm7X4B7NGNVBBQcfdtJQSxKOLePMcyO0n/W0sLOCgao4RDFFAtSDm+
   Eab+ooqitN4jQY37oRQmEEvyTIG6z5Fau33p6AdoAdR1LKopix+SIkepE
   2TX67dDfWCu1wy5S/jNFcH7fSg6K02XVDkONjFy3pliKMiLIbg6OYandR
   yllrpm8l38TkkXR/sfq+LLyJ+xK2Qv0C862ySkt22l4PTlcidurRB6oxN
   SeC7kXW6ITD4SiX5qcq3PSbK0RI9rWVJ3uswBAtDoPOIQ3FLiaPImWN7P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="345314929"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="345314929"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 17:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="723869369"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="723869369"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 17:34:11 -0700
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
Date:   Wed, 19 Apr 2023 08:33:01 +0800
In-Reply-To: <CAD=FV=V1SAufJUT-d5praYszUN1ssdT61WS7iB-c62R4M6Lsmw@mail.gmail.com>
        (Doug Anderson's message of "Tue, 18 Apr 2023 09:19:21 -0700")
Message-ID: <87wn28u2wy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:

> Hi,
>
> On Mon, Apr 17, 2023 at 8:18=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Doug Anderson <dianders@chromium.org> writes:
>>
>> > Hi,
>> >
>> > On Sun, Apr 16, 2023 at 6:15=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Doug Anderson <dianders@chromium.org> writes:
>> >>
>> >> > Hi,
>> >> >
>> >> > On Thu, Apr 13, 2023 at 8:10=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >>
>> >> >> Douglas Anderson <dianders@chromium.org> writes:
>> >> >>
>> >> >> > Currently when we try to do page migration and we're in "synchro=
nous"
>> >> >> > mode (and not doing direct compaction) then we'll wait an infini=
te
>> >> >> > amount of time for a page lock. This does not appear to be a gre=
at
>> >> >> > idea.
>> >> >> >
>> >> >> > One issue can be seen when I put a device under extreme memory
>> >> >> > pressure. I took a sc7180-trogdor Chromebook (4GB RAM, 8GB zram
>> >> >> > swap). I ran the browser along with Android (which runs from a
>> >> >> > loopback mounted 128K block-size squashfs "disk"). I then manual=
ly ran
>> >> >> > the mmm_donut memory pressure tool [1]. The system is completely
>> >> >> > unusable both with and without this patch since there are 8 proc=
esses
>> >> >> > completely thrashing memory, but it was still interesting to loo=
k at
>> >> >> > how migration was behaving. I put some timing code in and I coul=
d see
>> >> >> > that we sometimes waited over 25 seconds (in the context of
>> >> >> > kcompactd0) for a page lock to become available. Although the 25
>> >> >> > seconds was the high mark, it was easy to see tens, hundreds, or
>> >> >> > thousands of milliseconds spent waiting on the lock.
>> >> >> >
>> >> >> > Instead of waiting, if I bailed out right away (as this patch do=
es), I
>> >> >> > could see kcompactd0 move forward to successfully to migrate oth=
er
>> >> >> > pages instead. This seems like a better use of kcompactd's time.
>> >> >> >
>> >> >> > Thus, even though this didn't make the system any more usable in=
 my
>> >> >> > absurd test case, it still seemed to make migration behave bette=
r and
>> >> >> > that feels like a win. It also makes the code simpler since we h=
ave
>> >> >> > one fewer special case.
>> >> >>
>> >> >> TBH, the test case is too extreme for me.
>> >> >
>> >> > That's fair. That being said, I guess the point I was trying to make
>> >> > is that waiting for this lock could take an unbounded amount of tim=
e.
>> >> > Other parts of the system sometimes hold a page lock and then do a
>> >> > blocking operation. At least in the case of kcompactd there are bet=
ter
>> >> > uses of its time than waiting for any given page.
>> >> >
>> >> >> And, we have multiple "sync" mode to deal with latency requirement=
, for
>> >> >> example, we use MIGRATE_SYNC_LIGHT for compaction to avoid too long
>> >> >> latency.  If you have latency requirement for some users, you may
>> >> >> consider to add new "sync" mode.
>> >> >
>> >> > Sure. kcompactd_do_work() is currently using MIGRATE_SYNC_LIGHT. I
>> >> > guess my first thought would be to avoid adding a new mode and make
>> >> > MIGRATE_SYNC_LIGHT not block here. Then anyone that truly needs to
>> >> > wait for all the pages to be migrated can use the heavier sync mode=
s.
>> >> > It seems to me like the current users of MIGRATE_SYNC_LIGHT would n=
ot
>> >> > want to block for an unbounded amount of time here. What do you thi=
nk?
>> >>
>> >> It appears that you can just use MIGRATE_ASYNC if you think the corre=
ct
>> >> behavior is "NOT block at all".  I found that there are more
>> >> fine-grained controls on this in compaction code, please take a look =
at
>> >> "enum compact_priority" and its comments.
>> >
>> > Actually, the more I think about it the more I think the right answer
>> > is to keep kcompactd as using MIGRATE_SYNC_LIGHT and make
>> > MIGRATE_SYNC_LIGHT not block on the folio lock.
>>
>> Then, what is the difference between MIGRATE_SYNC_LIGHT and
>> MIGRATE_ASYNC?
>
> Aren't there still some differences even if we remove blocking this
> one lock? ...or maybe your point is that maybe the other differences
> have similar properties?

Sorry for confusing words.  Here, I asked you to list the implementation
difference between MIGRATE_ASYNC and MIGRATE_SYNC_LIGHT after your
proposed changes.  Which are waited in MIGRATE_SYNC_LIGHT but not in
MIGRATE_ASYNC?

> OK, so let's think about just using MIGRATE_ASYNC and either leaving
> MIGRATE_SYNC_LIGHT alone or deleting it (if there are no users left).
> The nice thing is that the only users of MIGRATE_SYNC_LIGHT are in
> "compaction.c" and there are only 3 places where it's specified.
>
> 1. kcompactd_do_work() - This is what I was analyzing and where I
> argued that indefinite blocking is less useful than simply trying to
> compact a different page. So sure, moving this to MIGRATE_ASYNC seems
> like it would be OK?
>
> 2. proactive_compact_node() - Just like kcompactd_do_work(), this is
> called from kcompactd and thus probably should have the same mode.
>
> 3. compact_zone_order() - This explicitly chooses between
> MIGRATE_SYNC_LIGHT and MIGRATE_ASYNC, so I guess I'd keep
> MIGRATE_SYNC_LIGHT just for this use case. It looks as if
> compact_zone_order() is called for direct compaction and thus making
> it synchronous can make sense, especially since it seems to go to the
> synchronous case after it failed with the async case. Ironically,
> though, the exact lock I was proposing to not wait on _isn't_ ever
> waited on in direct reclaim (see the comment in migrate_folio_unmap()
> about deadlock), but the other differences between SYNC_LIGHT and
> ASYNC come into play.
>
> If the above sounds correct then I'm OK w/ moving #1 and #2 to
> MIGRATE_ASYNC and leaving #3 as the sole user or MIGRATE_SYNC_LIGHT.
>
>> > kcompactd can accept some blocking but we don't want long / unbounded
>> > blocking. Reading the comments for MIGRATE_SYNC_LIGHT, this also seems
>> > like it fits pretty well. MIGRATE_SYNC_LIGHT says that the stall time
>> > of writepage() is too much. It's entirely plausible that someone else
>> > holding the lock is doing something as slow as writepage() and thus
>> > waiting on the lock can be just as bad for latency.
>>
>> IIUC, during writepage(), the page/folio will be unlocked.
>>
>> But, during page reading, the page/folio will be locked.  I don't really
>> understand why we can wait for page reading but cannot wait for page
>> writeback.
>
> I'm not sure I totally got your point here. It sorta sounds as if
> you're making the same point that I was?

Yes, kind of.  It is a question, not conclusion.

> IIUC by waiting on the lock
> we may be implicitly waiting for someone to finish reading which seems
> as bad as waiting for writing. That was why I was arguing that with
> MIGRATE_SYNC_LIGHT (which says that waiting for the write was too
> slow) that we shouldn't wait for the lock (which may be blocking on a
> read).

Best Regards,
Huang, Ying
