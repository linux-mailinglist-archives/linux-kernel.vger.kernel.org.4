Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA56B50FB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCJTdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCJTdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:33:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A45077E1A;
        Fri, 10 Mar 2023 11:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K9Cygl7DA9aU5qKOixWj1nX9PAr6z1jX+jUPuASkdwQ=; b=UMje3y6RljHfke/W4Z/YIe/+N3
        8MGZQ1bjoZZRDzU8TrmwLHbr+WAuGH12ryyAb6Yr8R5ZMTgPO+OveoVOsWKuk9Sep7daxWSd/FNOS
        qP/GwG/JRedHVF8grkIOK5RUxOJsFmRqnge1PBKrYyppbG+1ejcnBQMhhdPRhnkXMzTofiKkImB4g
        6p1r/jwWlfQ1RwChzi81v1cEqmdZxW//rOGzopFjXfv0r/Tkaw6io4AqsuLOA0ScqjMACJcO0EPMZ
        TfxvpUELIXyy0IoT4qz3nH9YxeP3uh8xSEpqL6imIqT+Apy65yPRE9MMTlTV4a5lzebVYYdOhxMbT
        jigdMl3g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paiUl-00Fuzn-5g; Fri, 10 Mar 2023 19:33:39 +0000
Date:   Fri, 10 Mar 2023 11:33:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
Message-ID: <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
 <20230302211759.30135-11-nick.alcock@oracle.com>
 <ZAoGLhRpTr5f7AD/@kroah.com>
 <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
 <ZArc0ib697JIwKou@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZArc0ib697JIwKou@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:31:30AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 09, 2023 at 02:38:10PM -0800, Luis Chamberlain wrote:
> > On Thu, Mar 09, 2023 at 05:15:42PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Mar 02, 2023 at 09:17:52PM +0000, Nick Alcock wrote:
> > > > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> > > > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> > > > are used to identify modules. As a consequence, uses of the macro
> > > > in non-modules will cause modprobe to misidentify their containing
> > > > object file as a module when it is not (false positives), and modprobe
> > > > might succeed rather than failing with a suitable error message.
> > > > 
> > > > So remove it in the files in this commit, none of which can be built as
> > > > modules.
> > > > 
> > > > Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> > > > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > > Cc: linux-modules@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > > ---
> > > >  drivers/tty/n_null.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
> > > > index f913b665af725..c24f75942c49d 100644
> > > > --- a/drivers/tty/n_null.c
> > > > +++ b/drivers/tty/n_null.c
> > > > @@ -63,7 +63,6 @@ static void __exit n_null_exit(void)
> > > >  module_init(n_null_init);
> > > >  module_exit(n_null_exit);
> > > >  
> > > > -MODULE_LICENSE("GPL");
> > > >  MODULE_AUTHOR("Alan Cox");
> > > >  MODULE_ALIAS_LDISC(N_NULL);
> > > >  MODULE_DESCRIPTION("Null ldisc driver");
> > > > -- 
> > > > 2.39.1.268.g9de2f9a303
> > > > 
> > > 
> > > Nope, sorry, this is not good to do, please fix kbuild instead of
> > > forcing a tree-wide change like this.
> > 
> > Masahiro Yamada already NACK'd it such effort:
> > 
> > https://lkml.kernel.org/r/CAK7LNAQLttPD=Ae==e0CYeQtS78=o_JZFK+zxa29JnUYio52Ug@mail.gmail.com
> > 
> > And his descriptiuon of the reasoning and logic is explained here:              
> > 
> > https://lore.kernel.org/all/CAK7LNASL7_RgfASstBvN6AzhR=nMU=HsQvODf5q13Xud8tBWRQ@mail.gmail.com/
> > 
> > Let me summarize it though with a few quotes from him:
> > 
> > "Having false-positives in modules.builtin should be OK"
> > "In this sense, having always-builtin entries in module.builtin is OK."
> 
> None of that matters, sorry.
> 
> Again, all I am saying is that you can not have some MODULE_() macros
> that are ok for code that is built in, and some that are not, for
> "reasons" that have to do how you all are treating the build system
> infrastructure as you are now putting arbritrary requirements for all
> driver authors (of which there are thousands) to know this.

As noted once again, it is not putting hard requirement. Future tooling
not yet added would just not benefit from distinguishing symbols for
your modules.

I'm happy to live with module authors not wanting to remove the module
license tag from their modules if they can never actually be modules
from not benefitting from the above tooling gains as its just cherry
on top tooling gains.

Solving this in way that does not impeed on current build system
improvements is a challenge and I'm happy to punt that out to future
work.

> Just change the macros to work properly in both cases, I can't believe
> this is all that hard as obviously all of the other macros work both
> ways, right?  That should not require any kbuild changes.

Patches are welcomed.

> > The reason Nick wants to do this work is that his future patches
> > (which have been under review for years and I'm starting to chew on
> > it and provide guidance on now) extend our ability to have more
> > elaborate symbol to address mapping with more metdata, which does
> > include information such as if something came from a module. So
> > long term *I* certainly am interested in a deterministic way to
> > determine if something could be a module.
> > 
> > For a more elaborate attempt on my part to try to describe the problem
> > and some side ideas I had if we wanted an alternative:
> > 
> > https://lore.kernel.org/all/Y/kXDqW+7d71C4wz@bombadil.infradead.org/
> > 
> > I should also mention Christoph has also suggested we eventually move
> > towards automatically generating the module license tag from the SPDX
> > tag:
> > 
> > https://lore.kernel.org/all/Y5BNCbFyvNA1Xp%2FX@infradead.org
> 
> That too would be wonderful, and I would love to see that, but it does
> not remove the base problem here that you are somehow forcing all driver
> authors to change their code for the build system changes which should
> not be affecting them at all at this point in time.

By you, you mean Masahiro Yamada's patch. That is just collateral for
tooling being built upon by Nick.  And as Masahiro has pointed out
more than once already, this is not a regression / fatal issue.

> If you all do trigger off of the SPDX tags, then the removal of all
> MODULE_LICENSE() instances would be great too, but I don't think you are
> there yet (and it also wouldn't require removal all at once as you could
> just stub out that macro to be nothing.)  But this is not the real issue
> here...

That's future work.

> Maybe the solution is to stop triggering on MODULE_LICENSE() as
> something magic for the build, as obviously that is the root problem
> here.  Or something else, I don't know, but what you all are doing here
> does not seem correct at all, sorry, and is only going to cause more
> long-term problems with maintenance and headaches for driver authors.

I already suggested what I think *could* be done as an alternative and
the problem is not easy to resolve.

Feel free to ignore the patches for your drivers which remove the module
macros even if they are not modules. In lieu of alternative suggestions,
that's what we have now, and it is much better than what Nick was suggesting
before which Masahiro NACK'd.

Most other module developers seem happy with the change, and this has also
helped fix SPDX tags where there wasn't some too.

So if you don't take the patches it is not the end of the world and Nick
can move on with that effort for folks who do want to clarify this.

  Luis
