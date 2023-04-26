Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392956EF78F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbjDZPOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbjDZPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:14:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E350B4C0A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yammpa9IiLASda95uMVgcL3LerSIgwp4czXb64R8Cec=; b=lNE3M2oQhcK/lgbvTsfH5CFeA6
        FlCPQsdftdyG8+wIg+keOf8qqmWL3NO+UGv16+1KFu44peZ955HlTUOUzLPRkzfQOOhv8/yd8mMkX
        dNySdSp0+1fwJNYrRVecPtnKgypUM0BL3BEdgxL/BrqmZ2CSJhX4ARnSN9xypqIYUVGb0X5y9EPrn
        WS7cLZBq/p/HSS1e77eNFM2CWJX0vBOwuehZhPH3nIUxKAbfbRwD+memVM8zhS0Disad60d3dwv3l
        iqIcFyHgG3veoPHr2OceeP3Vrm521mLwUUAUKbRvucWs03tBbvpTv/fFYvZktGCcrtC2LGmKFiE6Y
        XUQrSmcA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prgqH-002a2L-Bk; Wed, 26 Apr 2023 15:14:01 +0000
Date:   Wed, 26 Apr 2023 16:14:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Doug Anderson <dianders@chromium.org>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
Message-ID: <ZEk/uVlbX2wWgagN@casper.infradead.org>
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
 <20230422051858.1696-1-hdanton@sina.com>
 <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
 <20230425010917.1984-1-hdanton@sina.com>
 <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
 <20230426100918.ku32k6mqoogsnijn@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426100918.ku32k6mqoogsnijn@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:09:18AM +0100, Mel Gorman wrote:
> On Tue, Apr 25, 2023 at 07:19:48AM -0700, Doug Anderson wrote:
> > On Mon, Apr 24, 2023 at 6:09???PM Hillf Danton <hdanton@sina.com> wrote:
> > > Take a look at another case of lock wait [1].
> > >
> > > [1] https://lore.kernel.org/lkml/CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com/
> > 
> > So is this an explicit NAK on this approach, then? It still feels
> > worthwhile to me given the current kcompactd design where there is a
> > single thread that's in charge of going through and cleaning up all of
> > memory. Any single pags isn't _that_ important for kcompactd to deal
> > with and it's nice not to block the whole task's ability to make
> > progress. kcompactd is already very much designed in this model (which
> > is why SYNC_LIGHT exists in the first place) and that's why my patch
> > series was relatively simple/short. That being said, if people really
> > don't think I should pursue this then I won't send another version and
> > we can drop it.
> 
> I don't consider it to be an explicit NAK but lets
> cc Linus because it's a valid question. Linus, the patch is
> https://lore.kernel.org/lkml/20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid/
> asnd it's adding folio_lock_timeout which in older terms is a
> lock_page_timout. The intended use is kcompactd doing out-of-line
> compaction (like kswapd does out-of-line reclaim) to try lock a page in
> MIGRATE_SYNC_LIGHT mode but if it cannot be locked quickly then give up
> and move on to another migration candidate. The MIGRATE_SYNC_LIGHT is
> expected to incur some delays while trying to make forward progress and
> the overall problem is that kcompactd can sometimes stall for many seconds
> and sometimes minutes on one page.
> 
> The reason I don't consider this patch a NAK candidate is that this is not
> conditional locking as such because no special action is taken if the lock
> cannot be acquired. In the referenced mail, I think the context for the IO
> NOWAIT stuff is "try lock and if that fails, delegate the work to an async
> context". That is not necessarily a universal win and it's potentially
> complex. It's not a universal win because it's unknown how long it would
> take to acquire the lock and it may be a short enough period to be cheaper
> than the setup_for_async+context_switch+completion handler. If that happens
> often enough in a short window then delegation may be slower overall than
> doing the work synchronously. It's potentially complex because the setup
> for async handling and completion needs code that must be maintained.
> 
> The kcompactd case using folio_lock_timeout is different. If the lock
> fails, it's not being explicitly delegated to another context, the page
> is simply ignored and kcompactd moves on. Fair enough, another context
> may end up migrating the same page in direct compaction or kcompactd
> at a later time but there is no complex setup for that and it's not
> explicit delegation. It's vaguely similar to how shrink_folio_list()
> calls folio_trylock and if that fails, keep the page on the LRU for a
> future attempt with the main difference being that some time is spent on
> trylock. This is *also* not necessarily a universal win because kcompactd
> could find a suitable migration candidate quicker by a plain trylock but
> that's what MIGRATE_ASYNC is for, MIGRATE_SYNC_LIGHT is expected to delay
> for short periods of time when MIGRATE_ASYNC fails and the problem being
> solved is the folio lock taking minutes to acquire.

I'm not generally a fan of lock-with-timeout approaches.  I think the
rationale for this one makes sense, but we're going to see some people
try to use this for situations where it doesn't make sense.  I almost
wonder if we shouldn't spin rather than sleep on this lock, since the
window of time we're willing to wait is so short.  I'm certainly not
willing to NAK this patch since it's clearly fixing a real problem.

Hm.  If the problem is that we want to wait for the lock unless the
lock is being held for I/O, we can actually tell that in the caller.

	if (folio_test_uptodate(folio))
		folio_lock(folio);
	else
		folio_trylock(folio);

(the folio lock isn't held for writeback, just taken and released;
if the folio is uptodate, the folio lock should only be taken for a
short time; if it's !uptodate then it's probably being read)
