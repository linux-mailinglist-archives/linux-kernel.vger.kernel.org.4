Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD746E3D29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 03:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDQBPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 21:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDQBPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 21:15:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A491FE0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 18:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681694150; x=1713230150;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=IJ6evs6TW37+brfn0Z0UYuw5IHHOBHHjxO0DDMC2qdI=;
  b=RrYRCurD3pSkYEYBj70nDMV0Llkf6lbjSrBZ7rUylYPUOkPFbD8qGdIC
   2p6wRjoBP4s6bI/ml/eKpNM5gwKU2AKA7E809Sx9MyXoaNpdY/UDubyFF
   K4BuoxY38m9ZtQCyWoLM+aTGPFYkQeRphIOF2mB64+9FV7NTTZ/kbaK0j
   yFUuGujGnEFLN2vPRuMLLzRkvc/wl2fswHwJiq7PWKXI6WKF1lRRcG0t8
   9x4Q63S0RFvdDaANvro3fBQsB9JqZ1QDTpMXQIdK2IJIhQ7pWo2SxAJV5
   IdgcSjdyh8j/ZxYdo4SpgIKhr8H2Wo4wcVppBePWcIHTaiSGjEzSFrL3g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="431069564"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="431069564"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 18:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="814601989"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="814601989"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 18:15:48 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH] migrate_pages: Never block waiting for the page lock
References: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
        <87v8hz17o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
Date:   Mon, 17 Apr 2023 09:14:38 +0800
In-Reply-To: <CAD=FV=XPBaGGLJVG9UGoJss6EU5=esqyt=aWsp2nOm2YcVOc8g@mail.gmail.com>
        (Doug Anderson's message of "Fri, 14 Apr 2023 08:25:49 -0700")
Message-ID: <87ildvwbr5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:

> Hi,
>
> On Thu, Apr 13, 2023 at 8:10=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Douglas Anderson <dianders@chromium.org> writes:
>>
>> > Currently when we try to do page migration and we're in "synchronous"
>> > mode (and not doing direct compaction) then we'll wait an infinite
>> > amount of time for a page lock. This does not appear to be a great
>> > idea.
>> >
>> > One issue can be seen when I put a device under extreme memory
>> > pressure. I took a sc7180-trogdor Chromebook (4GB RAM, 8GB zram
>> > swap). I ran the browser along with Android (which runs from a
>> > loopback mounted 128K block-size squashfs "disk"). I then manually ran
>> > the mmm_donut memory pressure tool [1]. The system is completely
>> > unusable both with and without this patch since there are 8 processes
>> > completely thrashing memory, but it was still interesting to look at
>> > how migration was behaving. I put some timing code in and I could see
>> > that we sometimes waited over 25 seconds (in the context of
>> > kcompactd0) for a page lock to become available. Although the 25
>> > seconds was the high mark, it was easy to see tens, hundreds, or
>> > thousands of milliseconds spent waiting on the lock.
>> >
>> > Instead of waiting, if I bailed out right away (as this patch does), I
>> > could see kcompactd0 move forward to successfully to migrate other
>> > pages instead. This seems like a better use of kcompactd's time.
>> >
>> > Thus, even though this didn't make the system any more usable in my
>> > absurd test case, it still seemed to make migration behave better and
>> > that feels like a win. It also makes the code simpler since we have
>> > one fewer special case.
>>
>> TBH, the test case is too extreme for me.
>
> That's fair. That being said, I guess the point I was trying to make
> is that waiting for this lock could take an unbounded amount of time.
> Other parts of the system sometimes hold a page lock and then do a
> blocking operation. At least in the case of kcompactd there are better
> uses of its time than waiting for any given page.
>
>> And, we have multiple "sync" mode to deal with latency requirement, for
>> example, we use MIGRATE_SYNC_LIGHT for compaction to avoid too long
>> latency.  If you have latency requirement for some users, you may
>> consider to add new "sync" mode.
>
> Sure. kcompactd_do_work() is currently using MIGRATE_SYNC_LIGHT. I
> guess my first thought would be to avoid adding a new mode and make
> MIGRATE_SYNC_LIGHT not block here. Then anyone that truly needs to
> wait for all the pages to be migrated can use the heavier sync modes.
> It seems to me like the current users of MIGRATE_SYNC_LIGHT would not
> want to block for an unbounded amount of time here. What do you think?

It appears that you can just use MIGRATE_ASYNC if you think the correct
behavior is "NOT block at all".  I found that there are more
fine-grained controls on this in compaction code, please take a look at
"enum compact_priority" and its comments.

Best Regards,
Huang, Ying
