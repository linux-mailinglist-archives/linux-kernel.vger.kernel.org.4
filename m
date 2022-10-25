Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A42360C5C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJYHrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiJYHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:46:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FB67B1F1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02848B81A99
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621DFC433D6;
        Tue, 25 Oct 2022 07:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666684006;
        bh=nBoTP4tEFx4CkrBDxFl7aUbkBwpWy6P5VCH8o58NWSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTmo+eYuA9oQI7SHJpztmHDd114YnLxzMHQPu828gkPfvBE4MiEAMence3z6527cx
         hokxbS7PyspkI4MgyHVgwLjEvCRX0TNEmqVxbRZmp52XMxaiXqLyOibTg8xbXlfcvy
         UQi07rJupICNhE2cbAwqBXIiT3y24s2J+N9x4HJg=
Date:   Tue, 25 Oct 2022 09:47:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <Y1eUm5pnZUWdPrp/@kroah.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com>
 <Y1ZQpcdK4sdy+5QZ@kroah.com>
 <Y1ZUIEYcjQZMdSfp@smile.fi.intel.com>
 <202210241035.1487F523@keescook>
 <CAJZ5v0jczp8J89EdywFDbzPmmeKmoQ3wNFUmKxH_1xS7LPNzkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jczp8J89EdywFDbzPmmeKmoQ3wNFUmKxH_1xS7LPNzkA@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 07:51:11PM +0200, Rafael J. Wysocki wrote:
> On Mon, Oct 24, 2022 at 7:39 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Oct 24, 2022 at 12:00:16PM +0300, Andy Shevchenko wrote:
> > > + Kees
> > >
> > > On Mon, Oct 24, 2022 at 10:45:25AM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Oct 24, 2022 at 10:43:52AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Mon, Oct 24, 2022 at 11:26:10AM +0300, Sakari Ailus wrote:
> > > > > > container_of() casts the original type to another which leads to the loss
> > > > > > of the const qualifier if it is not specified in the caller-provided type.
> > > > > > This easily leads to container_of() returning a non-const pointer to a
> > > > > > const struct which the C compiler does not warn about.
> > >
> > > ...
> > >
> > > > > >   * @type:      the type of the container struct this is embedded in.
> > > > > >   * @member:    the name of the member within the struct.
> > > > > >   *
> > > > > > + * WARNING: as container_of() casts the given struct to another, also the
> > > >
> > > > Wrong function name here.
> > > >
> > > > > > + * possible const qualifier of @ptr is lost unless it is also specified in
> > > > > > + * @type. This is not a problem if the containing object is not const. Use with
> > > > > > + * care.
> > > > >
> > > > > Same comments here.
> > > >
> > > > Wait, no one uses this macro, so why not just remove it entirely?
> > >
> > > Kees, do you know why and what for we have container_of_safe()?
> >
> > It looks like it was designed to handle the cases where the pointer was
> > ERR_OR_NULL:
> >
> >        IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) : \
> >                ((type *)(__mptr - offsetof(type, member))); })
> >
> > i.e. just pass through the NULL/ERR instead of attempting the cast,
> > which would fail spectacularly. :)
> >
> > It seems like this version should actually be used everywhere instead of
> > nowhere... (i.e. just drop container_of() and rename container_of_safe()
> > to container_of())
> 
> As a rule, though, users of container_of() don't check the pointer
> returned by it against NULL, so I'm not sure how much of an
> improvement that would be.

Nor should they.  This is just tiny pointer math, that always assumes a
valid pointer is passed in.  It should never be used in any code path
where a valid pointer is NOT passed into it.

thanks,

greg k-h
