Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C77C6DFE12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjDLSzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342E30EE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D89A62EA1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 18:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A029CC433EF;
        Wed, 12 Apr 2023 18:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681325731;
        bh=80lswzO6OtNXjWeNdQIQxbpgjZlOBp21NVRzi8tcsow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DKEyHL4r3u0/fi+M9kO818KvubZhyzNoaPKG5XgwNbJLumlXquCLqW/HowEVAgXo9
         yffXWly7ij7afBE0sPVFZFjXxK/BAKPZlEfx6/sr4c1iCFsoEFcM3flAN1u4KTZ8FM
         Fg66miXYUj+j0miqVfilUgy+aqHPuvEBVm/oFXHk=
Date:   Wed, 12 Apr 2023 11:55:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out COUNT_ARGS() and
 CONCATENATE()
Message-Id: <20230412115531.17bb1aed232952c79aba0f2a@linux-foundation.org>
In-Reply-To: <ZDaqi1jE0Fkg5BSp@smile.fi.intel.com>
References: <20230411102454.85898-1-andriy.shevchenko@linux.intel.com>
        <20230411152119.c9bb83a8566e37f6d8dbc590@linux-foundation.org>
        <ZDaqi1jE0Fkg5BSp@smile.fi.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 15:56:43 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Apr 11, 2023 at 03:21:19PM -0700, Andrew Morton wrote:
> > On Tue, 11 Apr 2023 13:24:54 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > > The COUNT_ARGS() and CONCATENATE() macros may be used in some places
> > > without need of the full kernel.h dependency train with it.
> > > 
> > > Here is the attempt on cleaning it up by splitting out these macros().
> > > 
> > > --- a/include/linux/kernel.h
> > > +++ b/include/linux/kernel.h
> > > @@ -13,6 +13,7 @@
> > >  
> > >  #include <linux/stdarg.h>
> > >  #include <linux/align.h>
> > > +#include <linux/args.h>
> > 
> > A more energetic patch would have included args.h into each file which
> > calls COUNT_ARGS() and CONCATENATE(), and not included args.h into
> > kernel.h.  And that appears to be very easy - only bpf uses these things?
> > 
> > In fact these macros are so weird and ugly I'd be inclined to move them
> > into some bpf header so we don't have to see them again.  No
> > args.h, which might avoid encouraging others to use them.
> 
> We have more users than one 

I cant find any?

> and a couple of users that reimplement this macro
> under different names.

Where are these?

What the heck does it do and why is it so ugly and why isn't it
documented.  Shudder.

I suppose if there are other callers(?) then we could hide it in a
countargs.h and not include that into kernel.h.

