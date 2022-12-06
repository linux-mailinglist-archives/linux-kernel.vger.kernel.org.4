Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32B644BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLFSrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiLFSq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:46:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28134275C1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 10:46:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF1C0B819DC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 18:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68EEC433C1;
        Tue,  6 Dec 2022 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670352410;
        bh=FffjgYJBEbdlTSZ1kKWwXNaqs4buu/mx0oGIqzrGRT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wiazmU+2SXtRC3zsKbpEnxdo1l60JE6LaY0eC+/wHHbCJFL4DSinloIqv6bXKtZFO
         FMaVFZE06aiOsv4zCaG4mdbvpvw+eDuxnDJbhJI8kCOM8DLfQkiqAXxPlsB6DxEshj
         XljrcftJ+d7fNgtyKX6+oagmG4XUOVJB1s54PsgU=
Date:   Tue, 6 Dec 2022 19:46:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y4+OFzfAh7XqOoWv@kroah.com>
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
 <Y49cGRDBVP3bHJuT@casper.infradead.org>
 <Y49lxZMsKrXRciIg@kroah.com>
 <Y495XgCv+dhGA2Tg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y495XgCv+dhGA2Tg@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 05:18:22PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 06, 2022 at 04:54:45PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Dec 06, 2022 at 03:13:29PM +0000, Matthew Wilcox wrote:
> > > On Mon, Dec 05, 2022 at 01:12:03PM +0100, Greg Kroah-Hartman wrote:
> > > > +/**
> > > > + * container_of_const - cast a member of a structure out to the containing
> > > > + *			structure and preserve the const-ness of the pointer
> > > > + * @ptr:		the pointer to the member
> > > > + * @type:		the type of the container struct this is embedded in.
> > > > + * @member:		the name of the member within the struct.
> > > > + */
> > > > +#define container_of_const(ptr, type, member)				\
> > > > +	_Generic(ptr,							\
> > > > +		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
> > > > +		default: ((type *)container_of(ptr, type, member))	\
> > > > +	)
> > > > +
> > > 
> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > 
> > > I tried doing this:
> > > 
> > > +++ b/include/linux/container_of.h
> > > @@ -15,11 +15,17 @@
> > >   *
> > >   * WARNING: any const qualifier of @ptr is lost.
> > >   */
> > > -#define container_of(ptr, type, member) ({                             \
> > > +#define _c_of(ptr, type, member) ({                                    \
> > >         void *__mptr = (void *)(ptr);                                   \
> > >         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
> > >                       __same_type(*(ptr), void),                        \
> > >                       "pointer type mismatch in container_of()");       \
> > >         ((type *)(__mptr - offsetof(type, member))); })
> > > 
> > > +#define container_of(ptr, type, m)                                     \
> > > +       _Generic(ptr,                                                   \
> > > +               const typeof(*(ptr)) *: (const type *)_c_of(ptr, type, m),\
> > > +               default: ((type *)_c_of(ptr, type, m))                  \
> > > +       )
> > > +
> > >  #endif /* _LINUX_CONTAINER_OF_H */
> > > 
> > > (whitespace damaged, yes the kernel-doc is now in the wrong place, etc)
> > > 
> > > It found a few problems; just building the mlx5 driver (I happened to be
> > > doing some work on it in that tree).  We're definitely not ready to do
> > > that yet, but I'll send a few patches to prepare for it.
> > 
> > Yeah, that's a good long-term goal to have here.  Once everything is
> > moved over, switching all container_of_const() to just container_of()
> > should be simple.
> 
> I found a problem in fs/dcache.c:
> 
> struct qstr {
>         union {
>                 struct {
>                         HASH_LEN_DECLARE;
>                 };
>                 u64 hash_len;
>         };
>         const unsigned char *name;
> };
> 
> (note the const on "name")
> 
> static inline struct external_name *external_name(struct dentry *dentry)
> {
>         return container_of(dentry->d_name.name, struct external_name, name[0]);
> }
> 
> dentry isn't const, but dentry->d_name.name is, so we match the const
> case and the compiler emits a warning.  I don't think there's a way to
> key off the constness of dentry instead of dentry->d_name.name, so
> I've gone with the following for now.  Anybody prefer a different
> approach?
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 52e6d5fdab6b..b51a86f3cec6 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -288,7 +288,8 @@ struct external_name {
>  
>  static inline struct external_name *external_name(struct dentry *dentry)
>  {
> -	return container_of(dentry->d_name.name, struct external_name, name[0]);
> +	return container_of_not_const(dentry->d_name.name,
> +				      struct external_name, name[0]);
>  }

Will just:
	return container_of((unsigned char *)dentry->d_name.name, struct external_name, name[0]);
work by casting away the "const" of the name?

Yeah it's ugly, I never considered the address of a const char * being
used as a base to cast back from.  The vfs is fun :)

>  static void __d_free(struct rcu_head *head)
> @@ -329,7 +330,8 @@ void release_dentry_name_snapshot(struct name_snapshot *name)
>  {
>  	if (unlikely(name->name.name != name->inline_name)) {
>  		struct external_name *p;
> -		p = container_of(name->name.name, struct external_name, name[0]);
> +		p = container_of_not_const(name->name.name,
> +					   struct external_name, name[0]);
>  		if (unlikely(atomic_dec_and_test(&p->u.count)))
>  			kfree_rcu(p, u.head);
>  	}
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 23389af3af94..bf609a072754 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -25,4 +25,7 @@
>  		const typeof(*(ptr)) *: (const type *)__mptr,		\
>  		default: ((type *)__mptr)); })
>  
> +#define container_of_not_const(ptr, type, member) 			\
> +	(type *)container_of(ptr, type, member)
> +

"not_const" feels odd, all you want to do is cast away the pointer
result here, right?

thanks,

greg k-h
