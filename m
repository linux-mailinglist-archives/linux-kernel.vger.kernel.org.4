Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDA16C8758
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCXVOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjCXVOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:14:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E71CDDA;
        Fri, 24 Mar 2023 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=UqmSnaARsVlunnEmxrrJ9WDls/RPk2SXuv1lTe4E1dw=; b=uhM3XUaVQ+S23qekRBBOLWrA+j
        dNC0QsDIew21OU/LKUx/LzASKD30+9j0q7dyI4o9n6px/5HyeK9lw3a8//U/aQNRbLC+t7D8f3jKs
        2s4rSJAkR5Ez6XNUZaayOEkiQLEhNf6A3yM3Ts4N6bzzdPKIXLusJ41XEsal9VPBwSLFE+uF7yGpi
        J20/atqKBNbRpY5kNskg7TBnSJ7V32NzJVRiSKT4CNQlYT++yc5momtkiV1Am/xMbAAjD0gUCRDue
        FerXlrrIMsLcHIi0coq7sPxgRaKhEbAPo9qHa7M2LQNoYRG5VPFI2rPRksbWxvSTcogbZCCrWfuAI
        H3bKglow==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfojj-005cuz-2k;
        Fri, 24 Mar 2023 21:14:11 +0000
Date:   Fri, 24 Mar 2023 14:14:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZB4SoxgM6vydrxrj@bombadil.infradead.org>
References: <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
 <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
 <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com>
 <ZB4BP0ZgxNirBNOJ@bombadil.infradead.org>
 <CAHk-=whkj6=wyi201JXkw9iT_eTUTsSx+Yb9d4OgmZFjDJA18g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whkj6=wyi201JXkw9iT_eTUTsSx+Yb9d4OgmZFjDJA18g@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 01:28:51PM -0700, Linus Torvalds wrote:
> On Fri, Mar 24, 2023 at 1:00 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On the modules side of things we can be super defensive on the second
> > vmalloc allocation defensive [0] but other than this the initial kread
> > also needs care too.
> 
> Please don't re-implement semaphores. They are a *classic* concurrency limiter.
> 
> In fact, probably *THE* classic one.
> 
> So just do something like this instead:
> 
>    --- a/kernel/module/main.c
>    +++ b/kernel/module/main.c
>    @@ -2937,6 +2937,11 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
>         return load_module(&info, uargs, 0);
>     }
> 
>    +#define CONCURRENCY_LIMITER(name, n) \
>    +    struct semaphore name = __SEMAPHORE_INITIALIZER(name, n)
>    +
>    +static CONCURRENCY_LIMITER(module_loading_concurrency, 50);
>    +
>     SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs,
> int, flags)
>     {
>         struct load_info info = { };
>    @@ -2955,8 +2960,12 @@ SYSCALL_DEFINE3(finit_module, int, fd, const
> char __user *, uargs, int, flags)
>                       |MODULE_INIT_COMPRESSED_FILE))
>                 return -EINVAL;
> 
>    +    err = down_killable(&module_loading_concurrency);
>    +    if (err)
>    +            return err;
>         len = kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
>                                        READING_MODULE);
>    +    up(&module_loading_concurrency);
>         if (len < 0)
>                 return len;
> 
> NOTE! Entirely untested. Surprise surprise.

I'll give it a good wack thanks.

But it still begs the question if *other* vmalloc user-interfacing
places need similar practices. It's not just system calls that use it
willy nilly but anything that could in the end use it. Surely a lot of
"issues" could only happen in an insane pathological use case, but it's
a generic thing to keep in mind in the end.

> I'm a tiny bit worried about deadlocks here, so somebody needs to make
> sure that the kernel_read_file_from_fd() case cannot possibly in turn
> cause a "request_module()" recursion.

Automount on a path where the module lies in a path for a modue not
loaded yet triggering a kernel module autoload is the only thing
I can think of that could cause that, but that just calls userspace
modprobe. And I think that'd be an insane setup.

> We most definitely have had module recursion before, but I *think*
> it's always just in the module init function (ie one module requests
> another when ithe mod->init() function is called).

Since you up() right after the kernel_read_file_from_fd() we would not
be racing module inits with this. If however we place the up() after
the load_module() then that does incur that recurssion possibilty.

> I think by the time we have opened the module file descriptors and are
> just reading the data, we should be ok and the above would never
> deadlock, but I want people to at least think about it.
> 
> Of course, with that "max 50 concurrent loaders" limit, maybe it's
> never an issue anyway. Even if you get a recursion a few deep, at most
> you just wait for somebody else to get out of their loaders. Unless
> *everybody* ends up waiting on some progress.

Yeah, these certainly are pathalogical corner cases. I'm more interested
in solving doing something sane for 1000 CPUs or 2000 CPUs for now, even
if the issue was the kernel (not userspace) to blame (and even if those
use cases are being fixed now like the queued up linux-next ACPI
CPU frequency modules per CPU).

  Luis
