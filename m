Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE3163793B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKXMth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiKXMtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:49:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8022A420;
        Thu, 24 Nov 2022 04:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B59D62111;
        Thu, 24 Nov 2022 12:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E033AC433C1;
        Thu, 24 Nov 2022 12:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669294173;
        bh=cY0zoRDBBqP3t4FgqnJqWRlOpTVPEPD40LQxnSFLXD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAyWKZIRRxmldjMLNe4g1TIt/dn3auYo4I2AlIXGwLzFkcsgexSJ3DuPsyn1zzhM9
         1nVGQ3VIiLxtrLwHWqAqXPPB1bGEIPtSJg23ODXIVfh7qPGVufYazyyJnVWn3iYgub
         EXvh9r7+eqC2Glz2aJWPzNbhxb2dD54/8YAvtLFH1T7QEe8MnDTKDuq/6E0fgHohlu
         Wo0bdNR+0CPShkYNEnQtxKVec9ym46Gev1N+vQ3e9SjUvYVDviLyTIpGETnd7679in
         2mKMUDknZihL4Vd3XAw/pHlDlE0c4CaXXKlQw92O9Ozt+r9cV4FL4wBwUOL4PrfwHj
         M4du5bKF6EgrA==
Date:   Thu, 24 Nov 2022 13:49:27 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arnd.de>
Subject: Re: [PATCH v6 1/3] random: add vgetrandom_alloc() syscall
Message-ID: <20221124124927.argohuob2bslolbt@wittgenstein>
References: <20221121152909.3414096-1-Jason@zx2c4.com>
 <20221121152909.3414096-2-Jason@zx2c4.com>
 <87v8n6lzh9.fsf@oldenburg.str.redhat.com>
 <Y37DDX5RtiGsV6MO@zx2c4.com>
 <87a64g7wks.fsf@oldenburg.str.redhat.com>
 <Y39djiBSmgXfgWJv@zx2c4.com>
 <87cz9c5z1f.fsf@oldenburg.str.redhat.com>
 <Y39iisTmUO2AaKNs@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y39iisTmUO2AaKNs@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 01:24:42PM +0100, Jason A. Donenfeld wrote:
> Hi Florian,
> 
> On Thu, Nov 24, 2022 at 01:15:24PM +0100, Florian Weimer wrote:
> > * Jason A. Donenfeld:
> > 
> > > Hi Florian,
> > >
> > > On Thu, Nov 24, 2022 at 06:25:39AM +0100, Florian Weimer wrote:
> > >> * Jason A. Donenfeld:
> > >> 
> > >> > Hi Florian,
> > >> >
> > >> > On Wed, Nov 23, 2022 at 11:46:58AM +0100, Florian Weimer wrote:
> > >> >> * Jason A. Donenfeld:
> > >> >> 
> > >> >> > + * The vgetrandom() function in userspace requires an opaque state, which this
> > >> >> > + * function provides to userspace, by mapping a certain number of special pages
> > >> >> > + * into the calling process. It takes a hint as to the number of opaque states
> > >> >> > + * desired, and returns the number of opaque states actually allocated, the
> > >> >> > + * size of each one in bytes, and the address of the first state.
> > >> >> > + */
> > >> >> > +SYSCALL_DEFINE3(vgetrandom_alloc, unsigned long __user *, num,
> > >> >> > +		unsigned long __user *, size_per_each, unsigned int, flags)
> > >> >> 
> > >> >> I think you should make this __u64, so that you get a consistent
> > >> >> userspace interface on all architectures, without the need for compat
> > >> >> system calls.
> > >> >
> > >> > That would be quite unconventional. Most syscalls that take lengths do
> > >> > so with the native register size (`unsigned long`, `size_t`), rather
> > >> > than u64. If you can point to a recent trend away from this by
> > >> > indicating some commits that added new syscalls with u64, I'd be happy
> > >> > to be shown otherwise. But AFAIK, that's not the way it's done.
> > >> 
> > >> See clone3 and struct clone_args.

For system calls that take structs as arguments we use u64 in the struct
for proper alignment so we can extend structs without regressing old
kernels. We have a few of those extensible struct system calls.

But we don't really have a lot system calls that pass u64 as a pointer
outside of a structure so far. Neither as register and nor as pointer
iirc. Passing them as a register arg is problematic because of 32bit
arches. But passing as pointer should be fine but it is indeed uncommon.

> > >
> > > The struct is one thing. But actually, clone3 takes a `size_t`:
> > >
> > >     SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
> > >
> > > I take from this that I too should use `size_t` rather than `unsigned
> > > long.` And it doesn't seem like there's any compat clone3.
> > 
> > But vgetrandom_alloc does not use unsigned long, but unsigned long *.
> > You need to look at the contents for struct clone_args for comparison.
> 
> Ah! I see what you mean; that's a good point. The usual register
> clearing thing isn't going to happen because these are addresses.
> 
> I still am somewhat hesitant, though, because `size_t` is really the
> "proper" type to be used. Maybe the compat syscall thing is just a
> necessary evil?

We try to avoid adding new compat-requiring syscalls like the plague
usually. (At least for new syscalls that don't need to inherit behavior
from earlier syscalls they are a revisions of.)

> 
> The other direction would be making this a u32, since 640k ought to be
> enough for anybody and such, but maybe that'd be a mistake too.

I think making this a size_t is fine. We haven't traditionally used u32
for sizes. All syscalls that pass structs versioned by size use size_t.
So I would recommend to stick with that.

Alternatively, you could also introduce a simple struct versioned by
size for this system call similar to mount_setatt() and clone3() and so
on. This way you don't need to worry about future extensibilty. Just a
thought.
