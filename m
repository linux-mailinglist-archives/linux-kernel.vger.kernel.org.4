Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DD16E57C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjDRDSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRDS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:18:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EB5E6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681787908; x=1713323908;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=W/5Kj2EAfX48G345cd/tj2ACbFyXz/pZDq4aXPDHLTY=;
  b=Pe40T1u/sPgjv5VO07pjYrpOAdMlpTN196ZfO3bCAcM5c4J2CR/+mpMy
   Mu1GW2ioQGrk1zAik4akP4Xn/7AsgYc/4eRCL2Kg4+uhEwPATdMrExN1K
   Be7kyGmMt9EQtDahS0uqjvzfpSQYPRlgjk/HBbWD3r9dPuSVmLyQls6A2
   sARhYvvpUrWB1xJdZPisQQCsC+RBtSdUDe8IvXfeYXkLIJOQxsQl1v62O
   w6w0BpPUVwI8PiIGZesLuKj6WLI3Bne+D/Q1bhUGClosNlfeCav29Rh8C
   L3y0bw4VrRq5EDwI8AZnKTr2iRVMWR7dZWGy4Y45LRqJ4lQrXAvrDUe7M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="345061268"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="345061268"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 20:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="760203647"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="760203647"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 20:18:15 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH] migrate_pages: Never block waiting for the page lock
References: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
        <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
        <87ildvwbr5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAD=FV=WCWWuGO7D9X6By-fQ0ZB63iDsAvcPwza-F6tbA-Z_M6w@mail.gmail.com>
Date:   Tue, 18 Apr 2023 11:17:03 +0800
In-Reply-To: <CAD=FV=WCWWuGO7D9X6By-fQ0ZB63iDsAvcPwza-F6tbA-Z_M6w@mail.gmail.com>
        (Doug Anderson's message of "Mon, 17 Apr 2023 07:28:28 -0700")
Message-ID: <87edohvpzk.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> On Sun, Apr 16, 2023 at 6:15=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Doug Anderson <dianders@chromium.org> writes:
>>
>> > Hi,
>> >
>> > On Thu, Apr 13, 2023 at 8:10=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Douglas Anderson <dianders@chromium.org> writes:
>> >>
>> >> > Currently when we try to do page migration and we're in "synchronou=
s"
>> >> > mode (and not doing direct compaction) then we'll wait an infinite
>> >> > amount of time for a page lock. This does not appear to be a great
>> >> > idea.
>> >> >
>> >> > One issue can be seen when I put a device under extreme memory
>> >> > pressure. I took a sc7180-trogdor Chromebook (4GB RAM, 8GB zram
>> >> > swap). I ran the browser along with Android (which runs from a
>> >> > loopback mounted 128K block-size squashfs "disk"). I then manually =
ran
>> >> > the mmm_donut memory pressure tool [1]. The system is completely
>> >> > unusable both with and without this patch since there are 8 process=
es
>> >> > completely thrashing memory, but it was still interesting to look at
>> >> > how migration was behaving. I put some timing code in and I could s=
ee
>> >> > that we sometimes waited over 25 seconds (in the context of
>> >> > kcompactd0) for a page lock to become available. Although the 25
>> >> > seconds was the high mark, it was easy to see tens, hundreds, or
>> >> > thousands of milliseconds spent waiting on the lock.
>> >> >
>> >> > Instead of waiting, if I bailed out right away (as this patch does)=
, I
>> >> > could see kcompactd0 move forward to successfully to migrate other
>> >> > pages instead. This seems like a better use of kcompactd's time.
>> >> >
>> >> > Thus, even though this didn't make the system any more usable in my
>> >> > absurd test case, it still seemed to make migration behave better a=
nd
>> >> > that feels like a win. It also makes the code simpler since we have
>> >> > one fewer special case.
>> >>
>> >> TBH, the test case is too extreme for me.
>> >
>> > That's fair. That being said, I guess the point I was trying to make
>> > is that waiting for this lock could take an unbounded amount of time.
>> > Other parts of the system sometimes hold a page lock and then do a
>> > blocking operation. At least in the case of kcompactd there are better
>> > uses of its time than waiting for any given page.
>> >
>> >> And, we have multiple "sync" mode to deal with latency requirement, f=
or
>> >> example, we use MIGRATE_SYNC_LIGHT for compaction to avoid too long
>> >> latency.  If you have latency requirement for some users, you may
>> >> consider to add new "sync" mode.
>> >
>> > Sure. kcompactd_do_work() is currently using MIGRATE_SYNC_LIGHT. I
>> > guess my first thought would be to avoid adding a new mode and make
>> > MIGRATE_SYNC_LIGHT not block here. Then anyone that truly needs to
>> > wait for all the pages to be migrated can use the heavier sync modes.
>> > It seems to me like the current users of MIGRATE_SYNC_LIGHT would not
>> > want to block for an unbounded amount of time here. What do you think?
>>
>> It appears that you can just use MIGRATE_ASYNC if you think the correct
>> behavior is "NOT block at all".  I found that there are more
>> fine-grained controls on this in compaction code, please take a look at
>> "enum compact_priority" and its comments.
>
> Actually, the more I think about it the more I think the right answer
> is to keep kcompactd as using MIGRATE_SYNC_LIGHT and make
> MIGRATE_SYNC_LIGHT not block on the folio lock.

Then, what is the difference between MIGRATE_SYNC_LIGHT and
MIGRATE_ASYNC?

> kcompactd can accept some blocking but we don't want long / unbounded
> blocking. Reading the comments for MIGRATE_SYNC_LIGHT, this also seems
> like it fits pretty well. MIGRATE_SYNC_LIGHT says that the stall time
> of writepage() is too much. It's entirely plausible that someone else
> holding the lock is doing something as slow as writepage() and thus
> waiting on the lock can be just as bad for latency.

IIUC, during writepage(), the page/folio will be unlocked.

But, during page reading, the page/folio will be locked.  I don't really
understand why we can wait for page reading but cannot wait for page
writeback.

Best Regards,
Huang, Ying

> I'll try to send out a v2 with this approach today and we can see what
> people think.
>
> -Doug
