Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D5B637932
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiKXMsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiKXMsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:48:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA6A15FF2;
        Thu, 24 Nov 2022 04:48:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACD59B827C3;
        Thu, 24 Nov 2022 12:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9A5C433D6;
        Thu, 24 Nov 2022 12:48:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lwpiMWCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669294088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/iPOoMMmL4tvnQvG7VP2tfYPchuElz8eQWQJu8d7BG8=;
        b=lwpiMWCeo8PJ+2goZDFh5g0EJGNIrVyYCTN5EE8uPQg1v76iQP9FKkGpopHAPbGJj+rykC
        L1yZ956qoQgV6cJ5/8i9d1aY1dmAACW54StSUMZLM10rTVVSCgrfKD1JsiysQa0/657smN
        yNWmX/WdMjZr+wwNSzPgcwypQkfXq4I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9d876d02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 24 Nov 2022 12:48:08 +0000 (UTC)
Date:   Thu, 24 Nov 2022 13:48:06 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v6 1/3] random: add vgetrandom_alloc() syscall
Message-ID: <Y39oBtR8t+XNPS0d@zx2c4.com>
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
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

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
> > >> >> > +                unsigned long __user *, size_per_each, unsigned int, flags)
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
> 
> The other direction would be making this a u32, since 640k ought to be
> enough for anybody and such, but maybe that'd be a mistake too.
> 
> So I'm not sure. Anybody else on the list with experience adding
> syscalls have an opinion?

Looks like set_mempolicy, get_mempoliy, and migrate_pages pass an
unsigned long pointer and I don't see any compat stuff around it:

    SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
                    unsigned long, maxnode)
    
    SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
                    unsigned long __user *, nmask, unsigned long, maxnode,
                    unsigned long, addr, unsigned long, flags)

    SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned long, maxnode,
                    const unsigned long __user *, old_nodes,
                    const unsigned long __user *, new_nodes)
     

In contrast sched_setaffinity and get_robust_list take a unsigned long
pointer and does have a compat wrapper:

    SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
                    unsigned long __user *, user_mask_ptr)

    SYSCALL_DEFINE3(get_robust_list, int, pid,
                    struct robust_list_head __user * __user *, head_ptr,
                    size_t __user *, len_ptr)

Jason
