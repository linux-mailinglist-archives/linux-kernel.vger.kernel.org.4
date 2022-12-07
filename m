Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17450645F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLGQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:40:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69765C8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Sd4SxWaT71FmvSDVWiBw7YRjZK3pQuzvjU74TL/s14=; b=VWSg17yuc7hkOPqXOFOwpCrx33
        bmEbRS5WWK0+aaIzJVptDdkazFLWObtjIR9JteCnNlGvzV7++KW1RJ4nSRSYmls1r+J5NnGe94IqC
        Ys8ojAGOAShvughEGIOtogTXi9d9smWsIOgTXA2D5WJji2xtulT6Hu2oENi3M7W5dEqBuQjJkJTP4
        AGk9+E2UYUj5ZzjpWYqgkoNG8+9Gy384fTT143Vh63rLVjVQfaiZLn3O0F3AQuSw0IMcjJl6Fth7j
        wlvtYwFNQXCJiZfBf5Jo1K2fNTaJ+GOBug9OSt507xTN9/hr5j2CQcesX65T1dqplcHJY1Zo0VAcy
        r771A/qg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2xTQ-00609X-5E; Wed, 07 Dec 2022 16:40:44 +0000
Date:   Wed, 7 Dec 2022 16:40:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y5DCDI69xFI+Y2gT@casper.infradead.org>
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
 <Y49cGRDBVP3bHJuT@casper.infradead.org>
 <Y49lxZMsKrXRciIg@kroah.com>
 <Y495XgCv+dhGA2Tg@casper.infradead.org>
 <Y4+OFzfAh7XqOoWv@kroah.com>
 <Y4+jrBBRQ6XfNMfY@casper.infradead.org>
 <41c6f1b8-5c09-d7d4-14b7-214a9f844156@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c6f1b8-5c09-d7d4-14b7-214a9f844156@rasmusvillemoes.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 10:26:54AM +0100, Rasmus Villemoes wrote:
> On 06/12/2022 21.18, Matthew Wilcox wrote:
> > On Tue, Dec 06, 2022 at 07:46:47PM +0100, Greg Kroah-Hartman wrote:
> >> On Tue, Dec 06, 2022 at 05:18:22PM +0000, Matthew Wilcox wrote:
> >>>  static inline struct external_name *external_name(struct dentry *dentry)
> >>>  {
> >>> -	return container_of(dentry->d_name.name, struct external_name, name[0]);
> >>> +	return container_of_not_const(dentry->d_name.name,
> >>> +				      struct external_name, name[0]);
> >>>  }
> >>
> >> Will just:
> >> 	return container_of((unsigned char *)dentry->d_name.name, struct external_name, name[0]);
> >> work by casting away the "const" of the name?
> >>
> >> Yeah it's ugly, I never considered the address of a const char * being
> >> used as a base to cast back from.  The vfs is fun :)
> > 
> > Yes, that also works.  This isn't particularly common in the VFS, it's
> > just the dcache.  And I understand why it's done like this; you don't
> > want rando filesystems modifying dentry names without also updating
> > the hash.
> > 
> > I feel like all the options here are kind of ugly.  Seeing casts in
> > the arguments to container_of should be a red flag!
> > 
> > Here's a bit of a weird option ...
> > 
> > +#define container_of_2(ptr, p_m, type, member)                         \
> > +       _Generic(ptr,                                                   \
> > +               const typeof(*(ptr)) *: (const type *)container_of(ptr->p_m, type, member), \
> > +               default: ((type *)container_of(ptr->p_m, type, member)))
> > +
> > 
> >  static inline struct external_name *external_name(struct dentry *dentry)
> >  {
> > -       return container_of(dentry->d_name.name, struct external_name, name[0]);
> > +       return container_of_2(dentry, d_name.name, struct external_name,
> > +                               name[0]);
> >  }
> > 
> > so we actually split the first argument into two -- the pointer which
> > isn't const, then the pointer member which might be const, but we don't
> > use it for the return result of container_of_2.
> 
> Wait, what? The const-ness or not of dentry is completely irrelevant,
> we're not doing any pointer arithmetic on that to obtain some other
> pointer that morally should have the same const-ness. We're
> dereferencing dentry to get a pointer value, and _that_ pointer value is
> then subject to the pointer arithmetic.

... and this runs up against the fundamental duality of "what does const
mean".  If you declare a region of memory as const, it is read only.
But a pointer to const memory simply means "you may not alter it".
It does not mean "this is read only".  But the compiler doesn't know
that, so of course it warns that you're casting away constness.

> Note that external_name might as well have had the prototype
> 
> static inline struct external_name *external_name(const struct dentry
> *dentry)
> 
> and then your container_of_2 would break.

Fair point.  Actually, it probably should have that prototype since
it doesn't modify dentry.

> I think that if we want to move towards container_of preserving the
> constness of the member pointer, the right fix here is indeed a cast,
> but not inside container_of, but rather to cast away the const afterwards:
> 
>   return (struct external_name *)container_of(dentry->d_name.name,
> struct external_name, name[0]);
> 
> knowing that yes, the dentry only keeps a const pointer to the name[]
> member for good reasons, but the callers very much do need to modify the
> rest of the struct.

I dislike repeating the name of the struct twice.  More than I dislike
container_of_not_const() which gets to reuse the type name.

We could also do ...

	return NOT_CONST(container_of(dentry->d_name.name,
					struct external_name, name[0]);

and have NOT_CONST be the warning sign that we're doing something
unusual.
