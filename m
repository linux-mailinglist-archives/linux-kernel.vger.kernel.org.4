Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A968B609E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJXJsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiJXJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AFD2E691
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:48:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC7AD6114F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9491EC433D6;
        Mon, 24 Oct 2022 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666604915;
        bh=zsSgP6O6PMReNmIT7HnjsUjfYy70VyQ1SSf+r1MAStY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XakPhmMEFKa1uaAqTpxO3pwM2lhYISY5KdvvbLy8RckypSErDZpgGwG6dtLqXuUpM
         cFCy2NUc6bhBAz4iVcr5Ud82GTz6G2J/wNNcFIFOPuf0hIgYFRaxES6+qQWdNumS4o
         X6B8fBL09OfDlSiAU4ZyjezmidAmEVpOIYwhZ1mw=
Date:   Mon, 24 Oct 2022 11:48:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <Y1ZfcOxnAzIO5gKc@kroah.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com>
 <Y1ZQpcdK4sdy+5QZ@kroah.com>
 <Y1ZW2WYli7Bfioxr@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ZW2WYli7Bfioxr@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:11:53AM +0000, Sakari Ailus wrote:
> Hi Greg,
> 
> Thanks for the comments.
> 
> On Mon, Oct 24, 2022 at 10:45:25AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 24, 2022 at 10:43:52AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 24, 2022 at 11:26:10AM +0300, Sakari Ailus wrote:
> > > > container_of() casts the original type to another which leads to the loss
> > > > of the const qualifier if it is not specified in the caller-provided type.
> > > > This easily leads to container_of() returning a non-const pointer to a
> > > > const struct which the C compiler does not warn about.
> > > > 
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > >  include/linux/container_of.h | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> > > > index 2f4944b791b81..c7c21d0f41a87 100644
> > > > --- a/include/linux/container_of.h
> > > > +++ b/include/linux/container_of.h
> > > > @@ -13,6 +13,10 @@
> > > >   * @type:	the type of the container struct this is embedded in.
> > > >   * @member:	the name of the member within the struct.
> > > >   *
> > > > + * WARNING: as container_of() casts the given struct to another, also the
> > > 
> > > No need for "also" here (sorry for the grammar nit.)
> > > 
> > > > + * possible const qualifier of @ptr is lost unless it is also specified in
> > > > + * @type. This is not a problem if the containing object is not const. Use with
> > > > + * care.
> > > 
> > > I do not think these last two sentences you added here are needed
> > > either.
> > > 
> > > 
> > > >   */
> > > >  #define container_of(ptr, type, member) ({				\
> > > >  	void *__mptr = (void *)(ptr);					\
> > > > @@ -27,6 +31,11 @@
> > > >   * @type:	the type of the container struct this is embedded in.
> > > >   * @member:	the name of the member within the struct.
> > > >   *
> > > > + * WARNING: as container_of() casts the given struct to another, also the
> > 
> > Wrong function name here.
> 
> I'll address this and the other two issues above in v2.
> 
> > 
> > > > + * possible const qualifier of @ptr is lost unless it is also specified in
> > > > + * @type. This is not a problem if the containing object is not const. Use with
> > > > + * care.
> > > 
> > > Same comments here.
> > 
> > Wait, no one uses this macro, so why not just remove it entirely?
> 
> Good question. It appears to be a (relatively) common pattern to look up
> something and the return its containing object if the lookup was
> successful. Doing a quick
> 
> 	$ git grep 'container_of.*:' drivers include

And odds are, they all are wrong.

Any function that has a pointer sent to it that it wants to then cast
out to the outer size of the structure has to implicitly know that this
is a valid pointer.  There's no way to check so you have to trust the
fact that the caller sent you the right thing.

Trying to check is almost always someone trying to be "over eager" in
testing things that can never happen.  Just like all of the checks for
the result of a container_of() call, that's always wrong as well.
thanks,

> reveals more than 20 instances of the pattern. There are probably more
> those that use if for testing for NULL. I guess people don't know about
> this macro, apart from the developers of the staging driver it was added
> for (commit 05e6557b8ed833546ee2b66ce6b58fecf09f439e).

Ah, lustre is long-gone, so I'll just add a patch to my tree to remove
this macro.

thanks,

greg k-h
