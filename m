Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4306A64556D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLGI3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiLGI3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:29:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E7C32048
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 00:29:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 878C2B80113
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8030BC433B5;
        Wed,  7 Dec 2022 08:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670401775;
        bh=3AD67SM32SUbY58Vpbj0Moju2qM6ijkHn95jCjZgB4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyMzJh0lKe66obh/uh9LP6l+Gmsvy1ZuEFN7XQ7+m7zfcm1z1uLeIYRH0EPRVC09/
         EL4P3s9nBAxtBuNlQkVgtMRTJSXmokgzYZecPo3qULSgad91CrRLncAl8QStqJnG4s
         TXRYjxtBkAj/+PSPG/TVAEcZgX6k7/2Nqg9zxfa4=
Date:   Wed, 7 Dec 2022 09:29:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y5BO669ZFB3Vp5iX@kroah.com>
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
 <Y49cGRDBVP3bHJuT@casper.infradead.org>
 <Y49lxZMsKrXRciIg@kroah.com>
 <Y495XgCv+dhGA2Tg@casper.infradead.org>
 <Y4+OFzfAh7XqOoWv@kroah.com>
 <Y4+jrBBRQ6XfNMfY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4+jrBBRQ6XfNMfY@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 08:18:52PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 06, 2022 at 07:46:47PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Dec 06, 2022 at 05:18:22PM +0000, Matthew Wilcox wrote:
> > >  static inline struct external_name *external_name(struct dentry *dentry)
> > >  {
> > > -	return container_of(dentry->d_name.name, struct external_name, name[0]);
> > > +	return container_of_not_const(dentry->d_name.name,
> > > +				      struct external_name, name[0]);
> > >  }
> > 
> > Will just:
> > 	return container_of((unsigned char *)dentry->d_name.name, struct external_name, name[0]);
> > work by casting away the "const" of the name?
> > 
> > Yeah it's ugly, I never considered the address of a const char * being
> > used as a base to cast back from.  The vfs is fun :)
> 
> Yes, that also works.  This isn't particularly common in the VFS, it's
> just the dcache.  And I understand why it's done like this; you don't
> want rando filesystems modifying dentry names without also updating
> the hash.

Agreed.

> I feel like all the options here are kind of ugly.  Seeing casts in
> the arguments to container_of should be a red flag!

True, but this should be rare, and so they can stand out and they can be
commented about why they are needed, which is good to have.

> Here's a bit of a weird option ...
> 
> +#define container_of_2(ptr, p_m, type, member)                         \
> +       _Generic(ptr,                                                   \
> +               const typeof(*(ptr)) *: (const type *)container_of(ptr->p_m, type, member), \
> +               default: ((type *)container_of(ptr->p_m, type, member)))
> +
> 
>  static inline struct external_name *external_name(struct dentry *dentry)
>  {
> -       return container_of(dentry->d_name.name, struct external_name, name[0]);
> +       return container_of_2(dentry, d_name.name, struct external_name,
> +                               name[0]);
>  }
> 
> so we actually split the first argument into two -- the pointer which
> isn't const, then the pointer member which might be const, but we don't
> use it for the return result of container_of_2.

Ick, that papers over this oddity.  I think it would be better to make
it obvious what is happening here with a cast and a comment instead of
allowing people to use a different macro to "fix it up".  The danger is
of course that this new call would be used when people don't realize it
shouldn't be used.  Let's not even give them that ability please.

thanks,

greg k-h
