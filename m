Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4514609EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiJXKIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiJXKHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:07:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382306580B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666606046; x=1698142046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+aZ43RWKD9l9XJ1IxZm5qgIR8CoV0o/f/CkwHDYC5es=;
  b=QEZ8K5OCgPQSsHwn1PP7MQ/cBPEk1Vtc7u/ViOJCxHMSmkeTzO4Pnftm
   hRDay4/Tz37TzM40u3iaKkxblbJRNoiJ3yI3gSythIvyK4KGukRO41u1R
   hG/76KAA67GemjCQJdDWCvR4SQPbgHP841Armuev3ok1LP590uwkNyGRY
   0IEuPGdDSa2BCMGrpmnXZ3rEBvVmTOKqvlvnUAx6mOJASfrGQ0KXJJb2L
   1WXu3qjpXEheCbqfE19cm+fJYofEI+Zb/paulfPVpFjdoi7OxtELsDKFg
   09yno+uEgTHYxTOyzHIZdU/rBQaRXAdQkcdymCL4AesikY/IWcu9cAx/u
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="306113142"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="306113142"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 03:07:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="626025505"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="626025505"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 03:07:22 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 7A89A2021B;
        Mon, 24 Oct 2022 13:07:20 +0300 (EEST)
Date:   Mon, 24 Oct 2022 10:07:20 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <Y1Zj2Eb5Tq9pRAhI@paasikivi.fi.intel.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com>
 <Y1ZQpcdK4sdy+5QZ@kroah.com>
 <Y1ZW2WYli7Bfioxr@paasikivi.fi.intel.com>
 <Y1ZfcOxnAzIO5gKc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ZfcOxnAzIO5gKc@kroah.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Oct 24, 2022 at 11:48:32AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 24, 2022 at 09:11:53AM +0000, Sakari Ailus wrote:
> > Hi Greg,
> > 
> > Thanks for the comments.
> > 
> > On Mon, Oct 24, 2022 at 10:45:25AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 24, 2022 at 10:43:52AM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Oct 24, 2022 at 11:26:10AM +0300, Sakari Ailus wrote:
> > > > > container_of() casts the original type to another which leads to the loss
> > > > > of the const qualifier if it is not specified in the caller-provided type.
> > > > > This easily leads to container_of() returning a non-const pointer to a
> > > > > const struct which the C compiler does not warn about.
> > > > > 
> > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > ---
> > > > >  include/linux/container_of.h | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> > > > > index 2f4944b791b81..c7c21d0f41a87 100644
> > > > > --- a/include/linux/container_of.h
> > > > > +++ b/include/linux/container_of.h
> > > > > @@ -13,6 +13,10 @@
> > > > >   * @type:	the type of the container struct this is embedded in.
> > > > >   * @member:	the name of the member within the struct.
> > > > >   *
> > > > > + * WARNING: as container_of() casts the given struct to another, also the
> > > > 
> > > > No need for "also" here (sorry for the grammar nit.)
> > > > 
> > > > > + * possible const qualifier of @ptr is lost unless it is also specified in
> > > > > + * @type. This is not a problem if the containing object is not const. Use with
> > > > > + * care.
> > > > 
> > > > I do not think these last two sentences you added here are needed
> > > > either.
> > > > 
> > > > 
> > > > >   */
> > > > >  #define container_of(ptr, type, member) ({				\
> > > > >  	void *__mptr = (void *)(ptr);					\
> > > > > @@ -27,6 +31,11 @@
> > > > >   * @type:	the type of the container struct this is embedded in.
> > > > >   * @member:	the name of the member within the struct.
> > > > >   *
> > > > > + * WARNING: as container_of() casts the given struct to another, also the
> > > 
> > > Wrong function name here.
> > 
> > I'll address this and the other two issues above in v2.
> > 
> > > 
> > > > > + * possible const qualifier of @ptr is lost unless it is also specified in
> > > > > + * @type. This is not a problem if the containing object is not const. Use with
> > > > > + * care.
> > > > 
> > > > Same comments here.
> > > 
> > > Wait, no one uses this macro, so why not just remove it entirely?
> > 
> > Good question. It appears to be a (relatively) common pattern to look up
> > something and the return its containing object if the lookup was
> > successful. Doing a quick
> > 
> > 	$ git grep 'container_of.*:' drivers include
> 
> And odds are, they all are wrong.
> 
> Any function that has a pointer sent to it that it wants to then cast
> out to the outer size of the structure has to implicitly know that this
> is a valid pointer.  There's no way to check so you have to trust the
> fact that the caller sent you the right thing.
> 
> Trying to check is almost always someone trying to be "over eager" in
> testing things that can never happen.  Just like all of the checks for
> the result of a container_of() call, that's always wrong as well.

I don't see how it would be more wrong than checking for NULL (or an error)
in other macros. The caller won't have to check for those separately and
this tends to avoid accidental NULL pointer dereferences.

But given that the macro was unused after four or so years suggests that we
can probably do fine without it, too.

> > reveals more than 20 instances of the pattern. There are probably more
> > those that use if for testing for NULL. I guess people don't know about
> > this macro, apart from the developers of the staging driver it was added
> > for (commit 05e6557b8ed833546ee2b66ce6b58fecf09f439e).
> 
> Ah, lustre is long-gone, so I'll just add a patch to my tree to remove
> this macro.

Ok. I'll send v2 with this in mind.

-- 
Kind regards,

Sakari Ailus
