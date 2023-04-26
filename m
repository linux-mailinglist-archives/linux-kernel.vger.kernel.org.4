Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914276EFC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbjDZV1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZV1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:27:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E35E65
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=P+zvqaA+N/jOdHwRNjllwVTW5FbdEn0G9xqqOFN5Erw=; b=YZkEEswWkyh/1QDUlVD4KYOc6Q
        GV0aIkxVeSJXRKI1c8eNMHPAWmzPxTkL/BKuHJPNhxtZ+q8qNL+PyHXsLpJuTSCdNHXKEQu0bqNg6
        T6f3w/dMqoZ0iMJqSgd0vsDV4yLdQqQ55CvpQQ//LPpJCHDf/n9L5wcAfnqJv47Pq4CFP/UPwIDMt
        jmMGVLufXfkAHqZRTS2yzCWg1t/1qwelNdHzd0I+x7AGaDLRjmVY4yzQjiBfiNvFVmqkDs8G5Cpuv
        yqxd+XSkB3ooM6JWhXkyEQc+uXn5+WaM/boTMOnEbU59GInIj/3R6n4ufg7dqLWOQTlhwgqAf6HCm
        72Qz1fbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prmf9-002rdk-Tq; Wed, 26 Apr 2023 21:26:56 +0000
Date:   Wed, 26 Apr 2023 22:26:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
Message-ID: <ZEmXH1FpOgT/u6/j@casper.infradead.org>
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
 <20230422051858.1696-1-hdanton@sina.com>
 <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
 <20230425010917.1984-1-hdanton@sina.com>
 <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
 <20230426100918.ku32k6mqoogsnijn@techsingularity.net>
 <ZEk/uVlbX2wWgagN@casper.infradead.org>
 <CAD=FV=UyLf9GLz7xJyzhW2V_JycwUppwGfe7th17f_KXmMGOqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UyLf9GLz7xJyzhW2V_JycwUppwGfe7th17f_KXmMGOqw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 01:46:58PM -0700, Doug Anderson wrote:
> On Wed, Apr 26, 2023 at 8:14 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > I'm not generally a fan of lock-with-timeout approaches.  I think the
> > rationale for this one makes sense, but we're going to see some people
> > try to use this for situations where it doesn't make sense.
> 
> Although it won't completely prevent the issue, I could add a comment

People don't read comments.

> > Hm.  If the problem is that we want to wait for the lock unless the
> > lock is being held for I/O, we can actually tell that in the caller.
> >
> >         if (folio_test_uptodate(folio))
> >                 folio_lock(folio);
> >         else
> >                 folio_trylock(folio);
> >
> > (the folio lock isn't held for writeback, just taken and released;
> > if the folio is uptodate, the folio lock should only be taken for a
> > short time; if it's !uptodate then it's probably being read)
> 
> The current place in patch #3 where I'm using folio_lock_timeout()
> only calls it if a folio_trylock() already failed [2]. So I guess the
> idea would be that if the trylock failed and folio_test_uptodate()
> returns 0 then we immediately fail, otherwise we call the unbounded
> folio_trylock()?

Looking at the actual code, here's what I'd do:

+++ b/mm/migrate.c
@@ -1156,6 +1156,14 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
                if (current->flags & PF_MEMALLOC)
                        goto out;

+               /*
+                * In "light" mode, we can wait for transient locks (eg
+                * inserting a page into the page table), but it's not
+                * worth waiting for I/O.
+                */
+               if (mode == MIGRATE_SYNC_LIGHT && !folio_test_uptodate(folio))
+                       goto out;
+
                folio_lock(src);
        }
        locked = true;

> I put some traces in and ran my test and it turns out that in every
> case (except one) where the tre initial folio_trylock() failed I saw
> folio_test_uptodate() return 0. Assuming my test case is typical, I
> think that means that coding it with folio_test_uptodate() is roughly
> the same as just never waiting at all for the folio lock in the
> SYNC_LIGHT case. In the original discussion of my v1 patch people
> didn't like that idea. ...so I think that for now I'm going to keep it
> with the timeout flow.

I think that means that your specific test is generally going to
exercise the case where the lock is held because we're waiting for I/O.
That's exactly what you set it up to produce, after all!  But it won't
affect the cases where the folio lock is being held for other reasons,
which your testcase is incredibly unlikely to produce.
