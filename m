Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D059640D3B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiLBS36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiLBS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:29:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825B8E5AB3;
        Fri,  2 Dec 2022 10:29:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D67262395;
        Fri,  2 Dec 2022 18:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F8DC433D7;
        Fri,  2 Dec 2022 18:29:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aAusH9Za"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670005788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2zFy2zlqTBHP8UTky3opDng5ciA04KXTN+qAlc7bu/M=;
        b=aAusH9ZacdgKy2qK0SH8ug67jkatGLBOTc7F74Xxylrt4bXR5wzZClmPueE/z6CWp0UA9Z
        /wnfule5isjMZWf3ctoOFpugNh1ROH4GJQOGZj5uGriDmZYnUd/xUTioSPJc2Kooy2ZSD2
        tjYYfV83PtsDq939fvf8wGgmDf/InmQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7e7c3024 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Dec 2022 18:29:47 +0000 (UTC)
Date:   Fri, 2 Dec 2022 19:29:39 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 1/4] random: add vgetrandom_alloc() syscall
Message-ID: <Y4pEEy43LYlV35bh@zx2c4.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-2-Jason@zx2c4.com>
 <877czc7m0g.fsf@oldenburg.str.redhat.com>
 <Y4d5SyU3akA9ZBaJ@zx2c4.com>
 <87v8mtpvxe.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v8mtpvxe.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Fri, Dec 02, 2022 at 06:17:17PM +0100, Florian Weimer wrote:
> * Jason A. Donenfeld:
> 
> > I don't think zapping that memory is supported, or even a sensible thing
> > to do. In the first place, I don't think we should suggest that the user
> > can dereference that pointer, at all. In that sense, maybe it's best to
> > call it a "handle" or something similar (a "HANDLE"! a "HWND"? a "HRNG"?
> 
> Surely the caller has to carve up the allocation, so the returned
> pointer is not opaque at all.  From Adhemerval's glibc patch:
> 
>       grnd_allocator.cap = new_cap;
>       grnd_allocator.states = new_states;
> 
>       for (size_t i = 0; i < num; ++i)
> 	{
> 	  grnd_allocator.states[i] = new_block;
> 	  new_block += size_per_each;
> 	}
>       grnd_allocator.len = num;
>     }
> 
> That's the opposite of a handle, really.

Right. (And the same code is in the commit message example too.)

> 
> >> But it will constrain future
> >> evolution of the implementation because you can't add registration
> >> (retaining a reference to the passed-in area in getrandom) after the
> >> fact.  But I'm not sure if this is possible with the current interface,
> >> either.  Userspace has to make some assumptions about the life-cycle to
> >> avoid a memory leak on thread exit.
> >
> > It sounds like this is sort of a different angle on Rasmus' earlier
> > comment about how munmap leaks implementation details. Maybe there's
> > something to that after all? Or not? I see two approaches:
> >
> > 1) Keep munmap as the allocation function. If later on we do fancy
> >    registration and in-kernel state tracking, or add fancy protection
> >    flags, or whatever else, munmap should be able to identify these
> >    pages and carry out whatever special treatment is necessary.
> 
> munmap is fine, but the interface needs to say how to use it, and what
> length to pass.

Glad we're on the same page. Indeed I've now documented this for my
in-progress v11. A blurb like:

+ * sys_vgetrandom_alloc - Allocate opaque states for use with vDSO getrandom().
+ *
+ * @num:          On input, a pointer to a suggested hint of how many states to
+ *                allocate, and on return the number of states actually allocated.
+ *
+ * @size_per_each: On input, must be zero. On return, the size of each state allocated,
+ *                so that the caller can split up the returned allocation into
+ *                individual states.
+ *
+ * @addr:         Reserved, must be zero.
+ *
+ * @flags:        Reserved, must be zero.
+ *
+ * The getrandom() vDSO function in userspace requires an opaque state, which
+ * this function allocates by mapping a certain number of special pages into
+ * the calling process. It takes a hint as to the number of opaque states
+ * desired, and provides the caller with the number of opaque states actually
+ * allocated, the size of each one in bytes, and the address of the first
+ * state, which may be split up into @num states of @size_per_each bytes each,
+ * by adding @size_per_each to the returned first state @num times.
+ *
+ * Returns the address of the first state in the allocation on success, or a
+ * negative error value on failure.
+ *
+ * The returned address of the first state may be passed to munmap(2) with a
+ * length of `(size_t)num * (size_t)size_per_each`, in order to deallocate the
+ * memory, after which it is invalid to pass it to vDSO getrandom().

What do you think of that text?

> > Then they're caught holding the bag? This doesn't seem much different
> > from userspace shooting themselves in general, like writing garbage into
> > the allocated states and then trying to use them. If this is something
> > you really, really are concerned about, then maybe my cheesy dumb xor
> > thing mentioned above would be a low effort mitigation here.
> 
> So the MAP_LOCKED is just there to prevent leakage to swap?

Right. I can combine that with MLOCK_ONFAULT and NORESERVED to avoid
having to commit the memory immediately. I've got this in my tree for
v11.

In case you're curious to see the WIP, it's in here:
https://git.zx2c4.com/linux-rng/log/?h=vdso

Jason
