Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0168A632
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjBCW2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjBCW2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:28:03 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A845AA7032
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:27:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n13so6700284plf.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6a3uofuaRWFnhRwy6DM9u/s4KpjQkLkP1c4r8F5Dp4=;
        b=R6y8ck6vSR8fETfTkYUNju+wtcVgRBo/ruWEdX6JWnI8ZRPxnnfY3JbshQ+RIwnaiz
         rStwY5umhUwvhdp+8e4JSZZ/osBRzISBqqTkD0VFvrUUMoNZEYWoLdqB8K3n0AEqhzHZ
         oeZ/AYIehkUbkKyS3wTps5SXt3RZUs9VzaNgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6a3uofuaRWFnhRwy6DM9u/s4KpjQkLkP1c4r8F5Dp4=;
        b=RiMp/pmWg33Ym3tETG3xbyBuYSgucBnzKqM7HEyUd4iFaxhf+iySqNUBNHiOEQnmKg
         fHZy5eTO4M4doVv3h0QpNvttW7tPNB7bdfl1ZP/7jZvLO5AjE7dyRMAfVi93j0B6dlXE
         w7YI9gbwzgR8+rHG575o6Np72ZsqYB0QH4t5Yfid6SNfYuy5lAez18oUf9588ubu+bq9
         yxegeixDVFSiHb/tWeoiiiKWRFoZq8ddBJ+vj+0VsuXYgmn3fiDSTLFGrCxIxRnfn5ZQ
         myc4XpXp8RT+aCcOFkKMXgwa4aC2Tw4od1HPf7+Rrx6fcFtkt3LbRhTZe9bzPlydib5Q
         Jhwg==
X-Gm-Message-State: AO0yUKWAN7xloJXH0KlCC9yYmSYCoTYiScXd+OYjJvYH52Ql5tpDcWFO
        +gBGYT1Sf6T7gF+5lt4Vny5siw==
X-Google-Smtp-Source: AK7set/xjUWMWjOPi5xQ4TcdBEuC7tcdaRzvNmLij3yX1CJXryvQq6Imzuuem+hbuqzyRkgFD3rlbQ==
X-Received: by 2002:a17:90b:3511:b0:22c:1422:e3fb with SMTP id ls17-20020a17090b351100b0022c1422e3fbmr12594858pjb.5.1675463275879;
        Fri, 03 Feb 2023 14:27:55 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090a3e0500b0022c03785e9dsm5347197pjc.18.2023.02.03.14.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:27:55 -0800 (PST)
Message-ID: <63dd8a6b.170a0220.f5c98.9e65@mx.google.com>
X-Google-Original-Message-ID: <202302032223.@keescook>
Date:   Fri, 3 Feb 2023 22:27:54 +0000
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexander Potapenko <glider@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] uaccess: Add minimum bounds check on kernel buffer size
References: <20230203193523.never.667-kees@kernel.org>
 <6c728dfc-d777-4beb-b463-649704c81a5e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c728dfc-d777-4beb-b463-649704c81a5e@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 10:23:13PM +0100, Arnd Bergmann wrote:
> On Fri, Feb 3, 2023, at 20:35, Kees Cook wrote:
> > While there is logic about the difference between ksize and usize,
> > copy_struct_from_user() didn't check the size of the destination buffer
> > (when it was known) against ksize. Add this check so there is an upper
> > bounds check on the possible memset() call, otherwise lower bounds
> > checks made by callers will trigger bounds warnings under -Warray-bounds.
> > Seen under GCC 13:
> >
> > In function 'copy_struct_from_user',
> >     inlined from 'iommufd_fops_ioctl' at
> > ../drivers/iommu/iommufd/main.c:333:8:
> > ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' 
> > offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' 
> > with type 'union ucmd_buffer' [-Warray-bounds=]
> >    59 | #define __underlying_memset     __builtin_memset
> >       |                                 ^
> > ../include/linux/fortify-string.h:453:9: note: in expansion of macro 
> > '__underlying_memset'
> >   453 |         __underlying_memset(p, c, __fortify_size); \
> >       |         ^~~~~~~~~~~~~~~~~~~
> > ../include/linux/fortify-string.h:461:25: note: in expansion of macro 
> > '__fortify_memset_chk'
> >   461 | #define memset(p, c, s) __fortify_memset_chk(p, c, s, \
> >       |                         ^~~~~~~~~~~~~~~~~~~~
> > ../include/linux/uaccess.h:334:17: note: in expansion of macro 'memset'
> >   334 |                 memset(dst + size, 0, rest);
> >       |                 ^~~~~~
> > ../drivers/iommu/iommufd/main.c: In function 'iommufd_fops_ioctl':
> > ../drivers/iommu/iommufd/main.c:311:27: note: 'buf' declared here
> >   311 |         union ucmd_buffer buf;
> >       |                           ^~~
> >
> 
> Hi Kees,
> 
> I started building with gcc-13.0.1 myself but ran into a lot of
> other -Warray-bounds warnings in randconfig builds, so I ended up
> turning it off once more with CONFIG_CC_NO_ARRAY_BOUNDS in order
> to keep building without warnings.

Understood. AFAIK, all the open bugs I (and you) filed with GCC 13 have
been fixed related to -Warray-bounds. The most recent was the misbehavior
between CONFIG_UBSAN_SHIFT and -Warray-bounds. (Though the shift checking
still exposes some warnings since it introduces an implicit bounds check
on the shift variable, but they're not _wrong_ any more.)

> Is there anything else I need to do to get to the point of
> just addressing actual issues instead of false positives?
> Do you already have a patch series for fixing the others?

I've been working through the list that I see when building with
-Warray-bounds and -fstrict-flex-arrays=3. Some are real bugs, as usual.

> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index afb18f198843..ab9728138ad6 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -329,6 +329,10 @@ copy_struct_from_user(void *dst, size_t ksize, 
> > const void __user *src,
> >  	size_t size = min(ksize, usize);
> >  	size_t rest = max(ksize, usize) - size;
> > 
> > +	/* Double check if ksize is larger than a known object size. */
> > +	if (WARN_ON_ONCE(ksize > __builtin_object_size(dst, 1)))
> > +		return -E2BIG;
> > +
> 
> WARN_ON_ONCE() may be a little expensive since that adds two
> comparisons and a static variable to each copy, but it's probably
> fine. 

Yeah. IMO, copy_struct_from_user() is not fast path and having better
bounds checking when coming from userspace is well worth it.

-- 
Kees Cook
