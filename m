Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655EB612303
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJ2MsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ2MsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:48:14 -0400
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751695D725
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=HNZRQvJ17SI6CZ8q+B6eKT5nfyu7tN4BA1nyGluKsSk=; b=at9ZpwUAFCJZPj42nan5X3L1Rr
        042sI+2l+PxQf0VrCZlM0HkgpHNuzOIJvdYPdIHkLNGWOQHyJJ09Ta3INYPj8OyWn5Iqd3j8glla6
        E6OE/8gEse6QrMXR6uFYbEuvrECEFVrZo3K2Wdnw7BPPQPHB1pJwbSrxJd/Lev3VS0cRYXKnRrRhw
        /6HD7aBuKNkGsmKo0/erYBEKM/63UXxtP8Md3sOf1QKcye7Cej/AmklzVG7TN8BbkGGAMXg/xCgUG
        Bbs+lrZVNaPtU0R2e2mU979lCAffZ5znwTZsJ0N2OC0tqhPatx4/cb824e7J2HToX8YrsbpULlKht
        m9Akmgog==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1oolFt-00BWbo-Fu; Sat, 29 Oct 2022 13:48:05 +0100
Date:   Sat, 29 Oct 2022 13:48:05 +0100
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5fc38b2ddbbca7f5c680@syzkaller.appspotmail.com
Subject: Re: [PATCH] jfs: Fix fortify moan in symlink
Message-ID: <Y10hBcMrAYPZzghw@gallifrey>
References: <20221022203913.264855-1-linux@treblig.org>
 <202210241021.6E9E1EF65@keescook>
 <Y1beLWto/J2W1Stu@gallifrey>
 <202210281526.B32C79C4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <202210281526.B32C79C4@keescook>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-12-amd64 (x86_64)
X-Uptime: 13:47:38 up 231 days, 23:13,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kees Cook (keescook@chromium.org) wrote:
> On Mon, Oct 24, 2022 at 07:49:17PM +0100, Dr. David Alan Gilbert wrote:
> > * Kees Cook (keescook@chromium.org) wrote:
> > > On Sat, Oct 22, 2022 at 09:39:14PM +0100, linux@treblig.org wrote:
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > 
> > > > JFS has in jfs_incore.h:
> > > > 
> > > >       /* _inline may overflow into _inline_ea when needed */
> > > >       /* _inline_ea may overlay the last part of
> > > >        * file._xtroot if maxentry = XTROOTINITSLOT
> > > >        */
> > > >       union {
> > > >         struct {
> > > >           /* 128: inline symlink */
> > > >           unchar _inline[128];
> > > >           /* 128: inline extended attr */
> > > >           unchar _inline_ea[128];
> > > >         };
> > > >         unchar _inline_all[256];
> > > > 
> > > > and currently the symlink code copies into _inline;
> > > > if this is larger than 128 bytes it triggers a fortify warning of the
> > > > form:
> > > > 
> > > >   memcpy: detected field-spanning write (size 132) of single field
> > > >      "ip->i_link" at fs/jfs/namei.c:950 (size 18446744073709551615)
> > > 
> > > Which compiler are you using for this build?
> > 
> > I think that report was the same on gcc on Fedora 37 and whatever
> > syzkaller was running.
> > 
> > > This size report (SIZE_MAX)
> > > should be impossible to reach. But also, the size is just wrong --
> > > i_inline is 128 bytes, not SIZE_MAX. So, the detection is working
> > > (132 > 128), but the report is broken, and I can't see how...
> > 
> > Yeh, and led me down a blind alley for a while thinking something had
> > really managed to screwup the strlen somehow.
> 
> This looks like a GCC bug (going at least back to GCC 10.2)[1], but some
> extra care around the macro appears to make it go away, so the reporting
> variable doesn't get confused/re-evaluated:

Thanks for chasing that; are you also going to file a gcc bug?

Dave

> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 09a032f6ce6b..9e2d96993c30 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -550,13 +550,18 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>  
>  #define __fortify_memcpy_chk(p, q, size, p_size, q_size,		\
>  			     p_size_field, q_size_field, op) ({		\
> -	size_t __fortify_size = (size_t)(size);				\
> -	WARN_ONCE(fortify_memcpy_chk(__fortify_size, p_size, q_size,	\
> -				     p_size_field, q_size_field, #op),	\
> +	const size_t __fortify_size = (size_t)(size);			\
> +	const size_t __p_size = (p_size);				\
> +	const size_t __q_size = (q_size);				\
> +	const size_t __p_size_field = (p_size_field);			\
> +	const size_t __q_size_field = (q_size_field);			\
> +	WARN_ONCE(fortify_memcpy_chk(__fortify_size, __p_size,		\
> +				     __q_size, __p_size_field,		\
> +				     __q_size_field, #op),		\
>  		  #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
>  		  __fortify_size,					\
>  		  "field \"" #p "\" at " __FILE__ ":" __stringify(__LINE__), \
> -		  p_size_field);					\
> +		  __p_size_field);					\
>  	__underlying_##op(p, q, __fortify_size);			\
>  })
>  
> 
> 
> [1] https://syzkaller.appspot.com/bug?id=23d613df5259b977dac1696bec77f61a85890e3d
> 
> -- 
> Kees Cook
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
