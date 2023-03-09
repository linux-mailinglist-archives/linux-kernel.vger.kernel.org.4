Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ED06B30EA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjCIWkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjCIWjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:39:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A25FAEFB;
        Thu,  9 Mar 2023 14:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1PvKmwZcyksJ2SYGDMFjiDpKB95k8a9eLSUB6squPR0=; b=e+XG5W33Iv56l/VtXIFplLKSnZ
        d82PzigQYiiLbpPJwLWpUzu2PRbKFhAR5erVIz/43/1qpvjnMYdsXBlklyehdvzjGQDrOV0FM0JTQ
        lkS5kw7lWQBnwy1DDpxFKB/qNQeR7J9sUmj51XIqfhU6zYvDod7vH+GBwyMpWakVZfq0MdYYFNYCY
        Lz706Sgj+1myU4dubM/sXVt7gBF8IcEaEpQmZr2vKDy8jWU7zMUquef0Wa8zeCp7HDkmNm+Wkr6Fo
        sbqubBSB0uy2vs3FHuLWCKqPHSBR/zx2ZK8E9nCMq+PZ6p6l3Tq8Mjo/mux+fu6BFuK+LoXSHw51Z
        VlHbB+mQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paOtm-00CBrd-QA; Thu, 09 Mar 2023 22:38:10 +0000
Date:   Thu, 9 Mar 2023 14:38:10 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
Message-ID: <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
 <20230302211759.30135-11-nick.alcock@oracle.com>
 <ZAoGLhRpTr5f7AD/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAoGLhRpTr5f7AD/@kroah.com>
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

On Thu, Mar 09, 2023 at 05:15:42PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 02, 2023 at 09:17:52PM +0000, Nick Alcock wrote:
> > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> > are used to identify modules. As a consequence, uses of the macro
> > in non-modules will cause modprobe to misidentify their containing
> > object file as a module when it is not (false positives), and modprobe
> > might succeed rather than failing with a suitable error message.
> > 
> > So remove it in the files in this commit, none of which can be built as
> > modules.
> > 
> > Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: linux-modules@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > ---
> >  drivers/tty/n_null.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
> > index f913b665af725..c24f75942c49d 100644
> > --- a/drivers/tty/n_null.c
> > +++ b/drivers/tty/n_null.c
> > @@ -63,7 +63,6 @@ static void __exit n_null_exit(void)
> >  module_init(n_null_init);
> >  module_exit(n_null_exit);
> >  
> > -MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Alan Cox");
> >  MODULE_ALIAS_LDISC(N_NULL);
> >  MODULE_DESCRIPTION("Null ldisc driver");
> > -- 
> > 2.39.1.268.g9de2f9a303
> > 
> 
> Nope, sorry, this is not good to do, please fix kbuild instead of
> forcing a tree-wide change like this.

Masahiro Yamada already NACK'd it such effort:

https://lkml.kernel.org/r/CAK7LNAQLttPD=Ae==e0CYeQtS78=o_JZFK+zxa29JnUYio52Ug@mail.gmail.com

And his descriptiuon of the reasoning and logic is explained here:              

https://lore.kernel.org/all/CAK7LNASL7_RgfASstBvN6AzhR=nMU=HsQvODf5q13Xud8tBWRQ@mail.gmail.com/

Let me summarize it though with a few quotes from him:

"Having false-positives in modules.builtin should be OK"
"In this sense, having always-builtin entries in module.builtin is OK."

The reason Nick wants to do this work is that his future patches
(which have been under review for years and I'm starting to chew on
it and provide guidance on now) extend our ability to have more
elaborate symbol to address mapping with more metdata, which does
include information such as if something came from a module. So
long term *I* certainly am interested in a deterministic way to
determine if something could be a module.

For a more elaborate attempt on my part to try to describe the problem
and some side ideas I had if we wanted an alternative:

https://lore.kernel.org/all/Y/kXDqW+7d71C4wz@bombadil.infradead.org/

I should also mention Christoph has also suggested we eventually move
towards automatically generating the module license tag from the SPDX
tag:

https://lore.kernel.org/all/Y5BNCbFyvNA1Xp%2FX@infradead.org

I agree with Christoph and I think we should get there. For now we want
1-1 mapping of real modules to the tag for both reasons of us not going
to revert 8b41fc4454e and of later us wanting to do the full swoop
automation of the module license tag.

Although having modprobe not fail even if your module listed cannot be
a module is non-fatal, the long term goal of cleaning this up is
desirable anyway.

If you have constructive ways to provide an alternative for this in kbuild,
and help with the long term goals Nick has, patches or suggestions to
are greatly welcomed.

The simplest alternative I've come up with is the -DMODULE_POSSIBLE I
mentioned in the thread above. But as I mentioned in that same thread
the difficulty is in gathering the possible-obj-m without incurring a
slow down on the build.

  Luis
