Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18F7637975
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiKXM54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:57:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA02B2BB28;
        Thu, 24 Nov 2022 04:57:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 600E96211E;
        Thu, 24 Nov 2022 12:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD85C433D6;
        Thu, 24 Nov 2022 12:57:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fTaIQZQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669294668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i+qfzrjPpTg7l95a1LUNnDUw+egwKvhI2kFeU80Ity4=;
        b=fTaIQZQc1zt7FFg/pS1WD3gaYyipr6aQNCfVsAmAIcYjzAE41MO+gerG6SOdKR8prVJTLk
        LMhAfD331KmLeKvQH0Q9EvnBnC3TM/24a5eI1rg/N9gXxFh03rAp+XQwvLD2um/MIhNcCd
        hISDUTgB7DLNG3cA1hjTys+f/6UOeBg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4751f210 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 24 Nov 2022 12:57:48 +0000 (UTC)
Date:   Thu, 24 Nov 2022 13:57:45 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arnd.de>
Subject: Re: [PATCH v6 1/3] random: add vgetrandom_alloc() syscall
Message-ID: <Y39qSe30VYa0ftK4@zx2c4.com>
References: <20221121152909.3414096-1-Jason@zx2c4.com>
 <20221121152909.3414096-2-Jason@zx2c4.com>
 <87v8n6lzh9.fsf@oldenburg.str.redhat.com>
 <Y37DDX5RtiGsV6MO@zx2c4.com>
 <87a64g7wks.fsf@oldenburg.str.redhat.com>
 <Y39djiBSmgXfgWJv@zx2c4.com>
 <87cz9c5z1f.fsf@oldenburg.str.redhat.com>
 <Y39iisTmUO2AaKNs@zx2c4.com>
 <20221124124927.argohuob2bslolbt@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221124124927.argohuob2bslolbt@wittgenstein>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Thanks a bunch for chiming in.

On Thu, Nov 24, 2022 at 01:49:27PM +0100, Christian Brauner wrote:
> Alternatively, you could also introduce a simple struct versioned by
> size for this system call similar to mount_setatt() and clone3() and so
> on. This way you don't need to worry about future extensibilty. Just a
> thought.

Briefly considered that, but it seemed a bit heavy for something like
this. I'm not super heavily opposed, but just seemed like a bit much.

> > > >> >> > +SYSCALL_DEFINE3(vgetrandom_alloc, unsigned long __user *, num,
> > > >> >> > +		unsigned long __user *, size_per_each, unsigned int, flags)
> > > >> >> 
> > > >> >> I think you should make this __u64, so that you get a consistent
> > > >> >> userspace interface on all architectures, without the need for compat
> > > >> >> system calls.
> > > >> >
> > > >> > That would be quite unconventional. Most syscalls that take lengths do
> > > >> > so with the native register size (`unsigned long`, `size_t`), rather
> > > >> > than u64. If you can point to a recent trend away from this by
> > > >> > indicating some commits that added new syscalls with u64, I'd be happy
> > > >> > to be shown otherwise. But AFAIK, that's not the way it's done.
> > > >> 
> > > >> See clone3 and struct clone_args.
> 
> For system calls that take structs as arguments we use u64 in the struct
> for proper alignment so we can extend structs without regressing old
> kernels. We have a few of those extensible struct system calls.
> 
> But we don't really have a lot system calls that pass u64 as a pointer
> outside of a structure so far. Neither as register and nor as pointer
> iirc.

Right, the __u64_aligned business seemed to be mostly about
extensibility.

> > > > The struct is one thing. But actually, clone3 takes a `size_t`:
> > > >
> > > >     SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
> > > >
> > > > I take from this that I too should use `size_t` rather than `unsigned
> > > > long.` And it doesn't seem like there's any compat clone3.
> > > 
> > > But vgetrandom_alloc does not use unsigned long, but unsigned long *.
> > > You need to look at the contents for struct clone_args for comparison.
> > 
> > Ah! I see what you mean; that's a good point. The usual register
> > clearing thing isn't going to happen because these are addresses.
> > 
> > I still am somewhat hesitant, though, because `size_t` is really the
> > "proper" type to be used. Maybe the compat syscall thing is just a
> > necessary evil?
>
> I think making this a size_t is fine. We haven't traditionally used u32
> for sizes. All syscalls that pass structs versioned by size use size_t.
> So I would recommend to stick with that.

This isn't quite a struct versioned by size. This is:

    void *vgetrandom_alloc([inout] size_t *num, [out] size_t *size_per_each, unsigned int flags);

You give it an input 'num' and some flags (currently flags=0), and it
gives you back an output 'num' size, an output 'size_per_each' size, and
an opaque pointer value mapping as its return value.

I do like the idea of keeping size_t so that the type is "right". But
the other arguments are equally compelling as well, so not sure.

Jason
