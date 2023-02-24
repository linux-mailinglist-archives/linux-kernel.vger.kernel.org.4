Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E446A242F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBXWVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBXWUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:20:53 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EDD6F40C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:20:51 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31OMKMDs009639
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 17:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677277225; bh=6fm/FfBxnlH1bffCH8EtXcjgROJyMeAHLkxTJ2yy5Os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RYewRHl3Tj9t2sn/YXmg7A7he+ZYQX0P4Wm9MdaaG8VUB4BQvJwFYz+xkdvuKAzFp
         rxrwEko4V9XasqwksFw4rTXcnDTmKjHtkWsiQCk9m0wsfqcscSwHNLaVg/jwsnWrH+
         HaZmXupzCNYmmOsFafNiofnNDOnFSUk8gOvug4dT2mKqPcZuV4a65dbd9vOqwaCkLI
         CudeLdU2Mt2LcbLI2X2vE/WCD0RV2ceE0HvDs0TgsyG8iMRHeOyOKNPFJ34nqHS55s
         NbVqaBmd3Q8g2euWQwpvMvKgedW38EntI5ezbfjM7deP5HtQq+Fvfu11GawkukTJ4L
         u1pKe05tO3kUw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5A8E315C5815; Fri, 24 Feb 2023 17:20:22 -0500 (EST)
Date:   Fri, 24 Feb 2023 17:20:22 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the ext4 tree
Message-ID: <Y/k4Jvph15ugcY54@mit.edu>
References: <20230220152938.45f62d5a@canb.auug.org.au>
 <Y/ODNJ3MfoD6dUru@casper.infradead.org>
 <20230221175436.599166f9@canb.auug.org.au>
 <20230223144722.635ab483@canb.auug.org.au>
 <5f228150-0e29-6d58-3dcf-776bc2a630b7@gmail.com>
 <20230224161128.0949d8ae@canb.auug.org.au>
 <CAHk-=whssVtOq-6r-n6+=gVLC=zXCsr5TBq6Ke+JaGeQW3d8Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whssVtOq-6r-n6+=gVLC=zXCsr5TBq6Ke+JaGeQW3d8Cw@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay in taking a look at things; this week has been
horribly crazy busy for me.

The conflict is with the folio changes in mm-stable and with Jan's
"ext4: Cleanup data=journal writeback path" patch series.  Both of
these touch mpage_prepare_extent_to_map() in fs/ext4/inode.c quite
extensively.

[1] https://lore.kernel.org/r/20230111152736.9608-1-jack@suse.cz

I've just tried taking Jan's patch series and applying it linux-next
(which contains the mm-stable branch).  Dealing with each chage one by
one, there were conflits with patches #1, #4, #5, and #7.  One at the
time, the conflict resolutions weren't _that_ bad, but looking at the
combined conflict after doing a "git merge" it was quite scary indeed.

Maybe Linus's git merging-fu is much stronger than mine, but I
certainly wouldn't wnat to try to resolve it just using "git merge"!

So here's my proposed path forawrd.

1)  So far the only testing Jan's patch series (modified so it sits on
top of linux-next) is "it builds, ship it".  So I'll kick off a full
xfstests test on that series, and make sure I don't see any
regressions.  After that, I'll post it on linux-ext4 for Jan to
examine.

(Since it's well after work hours in Europe on a Friday, Jan probably
won't get to it until Monday, which is fine.)

2) I'll drop Jan's patch set from the ext4 dev branch, and run the
following full xfstests runs on this dev "lite" branch.  (a) the dev
"lite" branch by itself.  (b) the dev "lite" branch merged with tip of
Linux's tree.  (c) the dev "lite" branch merged with linux-next.

99.9% of the time, when there are problems, they are detected by my
full set of xfstests regression testing, since random users running
linux-next tend not stress file system all that much, and the 0-day
bot doesn't do nearly as much testing as I do.  (I test a dozen
different ext4 fs configs[2], while the 0-day tests only a single
one.)

[2] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/ext4/cfg/all.list

3)  I'll then send the ext4 dev branch (minus the data=writepage
cleanups) as a pull request to Linus.  Next week, after Jan has a
chance to review my patch conflict resolutions, I'll send a second
pull request with the data=writepage cleanups.  (As usual, I'll do my
full set of test runs before sending the pull request.)

Linus, are you OK with this plan?

						- Ted
