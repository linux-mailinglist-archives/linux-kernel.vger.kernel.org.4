Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46F360B709
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiJXTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiJXTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:14:49 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2A13D5BC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:53:00 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id g16so6071208qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODsrsWS79TZ9u82LUQmpT+8SG3CGzlKkIICyAV1vbKE=;
        b=JO2IMB7qZt2AnJOyN9ZFzUnOHtmqg0mKEfR7l0eOnPbHaYMcKDYa3QCEkRsBKcT4AS
         Gkep1ZHExpU7BsIYj0IPH2I876Ns2zDING27ujVHv8tWEwIe7p3qWd92T0o4Ljkbx7Mh
         mljhGUSj226S6VELC4+X7gPVrfFvnLkyg9izfrw4jsY2MIXy3HN+QwHOakcj8bqFgoww
         8/OxGBag2u/5zvxQG8VE0c7ZERoCOI8UiiTreEd/p0E2N0+5o6xOMJPkrliux8wZysOx
         KSFVio/VBcOVXP0JgqQl+PqhK2oUb0k/Tc+nBnA+ZKqO7EmmuWcziB21068HI1Pxdto6
         Z3IA==
X-Gm-Message-State: ACrzQf2VslPlAbHdsPkjZRKI5jjJ6kXXqx9UxBU4nhmjIZtgQ8MdIZgo
        tZK5NT3nJLIF8TyoB69kKkEPbEtnv50Vn0nr5yU=
X-Google-Smtp-Source: AMsMyM7YynqK6N8zgQh4XrvsCLd/RTTaZ1KTeCNfFXdMnXjRVJ3DDgYjYsVjkuh3YA41BP+sXu41EaPrRc76pEEkLhc=
X-Received: by 2002:a05:622a:13c6:b0:39c:c34f:29ec with SMTP id
 p6-20020a05622a13c600b0039cc34f29ecmr28604577qtk.153.1666633884490; Mon, 24
 Oct 2022 10:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com> <Y1ZQpcdK4sdy+5QZ@kroah.com> <Y1ZUIEYcjQZMdSfp@smile.fi.intel.com>
 <202210241035.1487F523@keescook>
In-Reply-To: <202210241035.1487F523@keescook>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Oct 2022 19:51:11 +0200
Message-ID: <CAJZ5v0jczp8J89EdywFDbzPmmeKmoQ3wNFUmKxH_1xS7LPNzkA@mail.gmail.com>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 7:39 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Oct 24, 2022 at 12:00:16PM +0300, Andy Shevchenko wrote:
> > + Kees
> >
> > On Mon, Oct 24, 2022 at 10:45:25AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 24, 2022 at 10:43:52AM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Oct 24, 2022 at 11:26:10AM +0300, Sakari Ailus wrote:
> > > > > container_of() casts the original type to another which leads to the loss
> > > > > of the const qualifier if it is not specified in the caller-provided type.
> > > > > This easily leads to container_of() returning a non-const pointer to a
> > > > > const struct which the C compiler does not warn about.
> >
> > ...
> >
> > > > >   * @type:      the type of the container struct this is embedded in.
> > > > >   * @member:    the name of the member within the struct.
> > > > >   *
> > > > > + * WARNING: as container_of() casts the given struct to another, also the
> > >
> > > Wrong function name here.
> > >
> > > > > + * possible const qualifier of @ptr is lost unless it is also specified in
> > > > > + * @type. This is not a problem if the containing object is not const. Use with
> > > > > + * care.
> > > >
> > > > Same comments here.
> > >
> > > Wait, no one uses this macro, so why not just remove it entirely?
> >
> > Kees, do you know why and what for we have container_of_safe()?
>
> It looks like it was designed to handle the cases where the pointer was
> ERR_OR_NULL:
>
>        IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) : \
>                ((type *)(__mptr - offsetof(type, member))); })
>
> i.e. just pass through the NULL/ERR instead of attempting the cast,
> which would fail spectacularly. :)
>
> It seems like this version should actually be used everywhere instead of
> nowhere... (i.e. just drop container_of() and rename container_of_safe()
> to container_of())

As a rule, though, users of container_of() don't check the pointer
returned by it against NULL, so I'm not sure how much of an
improvement that would be.

If NULL is passed to container_of(), there will be a spectacular
failure, sooner or later ...
