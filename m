Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AD567D714
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjAZVAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjAZVAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:00:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923BC7AA1;
        Thu, 26 Jan 2023 13:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wLI4YlaPJ0vdUzGdXt/0yTHNylxA/iLKuoE6TucGDAU=; b=kdSmeM4kphKwe+O4qMDdxOwzWQ
        j+nWeOIfn/TbDYWVkjiqNWyAO19f48sjgdHswSrjat//hLCKkRHTNFCfeoNDqzAvaZ7AgzlgaqiRT
        KVmPcP1kFCfZVdATqhYj72YKKlUnK5+1LeqOJxXYr6fztmKEvGe80qPAR/dlJ+ThuKnMVzI9Zxh60
        tBp+UdcrVlCh2POmKIQAoGfMNfmh/IZTT/uaT+450kU4WunFbEmwKo0UF5yZBqRWjhLLNqnxMzRlS
        3rG1obQakEa4WaPoM0dlqJbbCgz4ukJdNFR/VlAox9SuEQXDJlXH+pYhmMK0BaXUybu+gRdHOCKJC
        6Osowkvw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL9MR-00CZdq-Ap; Thu, 26 Jan 2023 21:00:43 +0000
Date:   Thu, 26 Jan 2023 13:00:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] module: replace module_layout with module_memory
Message-ID: <Y9Lp+5mqxP0bgvrM@bombadil.infradead.org>
References: <20230125185004.254742-1-song@kernel.org>
 <Y9IYTI3pWuKbJ3bC@bombadil.infradead.org>
 <CAPhsuW7ipGS=RhowYSp06DBYOY31sYoup7-Je+CEuKCxJsHavQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7ipGS=RhowYSp06DBYOY31sYoup7-Je+CEuKCxJsHavQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck,

Any chance you can give this branch a good spin on your multi-arch setup
to see what may below up?

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-testing

On Thu, Jan 26, 2023 at 12:01:40PM -0800, Song Liu wrote:
> Hi Luis,
> 
> Thanks for your kind review!
> 
> On Wed, Jan 25, 2023 at 10:06 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> [...]
> > >
> > >         MOD_MEM_TYPE_TEXT,
> > >         MOD_MEM_TYPE_DATA,
> > >         MOD_MEM_TYPE_RODATA,
> > >         MOD_MEM_TYPE_RO_AFTER_INIT,
> > >         MOD_MEM_TYPE_INIT_TEXT,
> > >         MOD_MEM_TYPE_INIT_DATA,
> > >         MOD_MEM_TYPE_INIT_RODATA,
> > >
> > > and allocating them separately.
> >
> > First thanks for doing this work!
> >
> > This seems to not acknolwedge the original goal of the first module_layout and
> > the latched rb-tree use, and that was was for speeding up __module_address()
> > since it *can* even be triggered on NMIs. I say this because the first question
> > that comes to me is the impact to performance on __module_address() I can't
> > see that changing much here, but mention it as it similar consideration
> > should be made in case future changes modify this path.
> 
> To make sure I understand this correctly. Do you mean we need something like
> the following in the commit log?
> 
> """
> This adds slightly more entries to mod_tree (from up to 3 entries per module, to
> up to 7 entries per module). However, this at most adds a small constant
> overhead to __module_address(), which is expected to be fast.
> """

Yes I think this is very useful information for the reviewier.

> > Microbenching something so trivial as __module_address() may not be as useful
> > for an idle system, at the very least being able to compare before and after
> > even on idle may be useful *if* you eventually do some more radical changes
> > here. Modules-related kernel/kallsyms_selftest.c did that for kallsyms_lookup_name()
> > and friend just recently for a minor performance enhancement.
> 
> kernel/kallsyms_selftest.c is new to me. I will give it a try.

It was just merged, be sure to have da35048f2600 ("kallsyms: Fix
scheduling with interrupts disabled in self-test").

> > > Signed-off-by: Song Liu <song@kernel.org>
> > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > >
> > > ---
> > >
> > > This is the preparation work for the type aware module_alloc() discussed
> > > in [1]. While this work is not covered much in the discussion, it is a
> > > critical step of the effort.
> > >
> > > As this part grows pretty big (~1000 lines, + and -), I would like get
> > > some feedback on it, so that I know it is on the right track.
> > >
> > > Please share your comments. Thanks!
> > >
> > > Test coverage: Tested on x86_64.
> >
> > I will likely merge this onto modules-next soon, not because I think it is
> > ready, but just because I think it *is* mostly ready and the next thing
> > we need is exposure and testing. rc5 is pretty late to consider this
> > for v6.3 and so hopefully for this cycle we can at least settle on
> > something which will sit in linux-next since the respective linux-next
> > after v6.3-rc1 is released.
> 
> Yes, this definitely needs more tests. Given different archs use
> module_layout in all sorts of ways. I will be very surprised if I updated
> all them correctly (though I tried hard to).

OK so let's be patient with testing. Getting help from Guenter here
can probably speed up finding issues.

> > > Build tested by kernel test bot in [2]. The only regression in [2] was a
> > > typo in parisc, which is also fixed.
> > >
> > > [1] https://lore.kernel.org/linux-mm/20221107223921.3451913-1-song@kernel.org/T/#u
> >
> > You still never addressed my performance suggestions so don't be
> > surprised if I insist later. Yes you can use existing performance
> > benchmarks, specially now with modules as a hard requirement, to
> > show gains. So I'd like to clarify that if I'm reviewing late it is
> > because:
> >
> > a) my modules patch review queue has been high as of late
> > b) you seem to not have taken these performance suggestions into consideration
> >    before and so I tend to put it at my end of my queue for review.
> 
> I think it will be a lot easier to run performance tests with the
> module support. Let's see what we can do when we get to the
> performance test part.

Fantastic, clearly I'm interested in being able to reproduce so I will
email you offline about some techniques I've used to reproduce some
things easily for testing things with modules.

  Luis
