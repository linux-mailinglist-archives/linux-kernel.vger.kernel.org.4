Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6835163787E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKXME5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiKXMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:04:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AEEDEAF6;
        Thu, 24 Nov 2022 04:03:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A526A620F6;
        Thu, 24 Nov 2022 12:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C855C433D6;
        Thu, 24 Nov 2022 12:03:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="axgdK4U0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669291409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=svvOs5KTAIBgEAm2FbMOmQp4ZCHzoNvCSIQoIKLpoyA=;
        b=axgdK4U0SE+UdXCyY3HU7gyH9aSxGnz6XHp7NBuDL4/cp+eV5Ia7cD4bdsmPVVPxc8fLjC
        gpRRYex+xQlSug/Tuj6U1uqIRjZPOqEcJHIsN56JLUdXzw7xauGMvChxT89SCKLLCgk9OE
        t/zAmQ/EQyQ2ulFKAD4pWecvKsdIj84=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2340bdb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 24 Nov 2022 12:03:29 +0000 (UTC)
Date:   Thu, 24 Nov 2022 13:03:26 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v6 1/3] random: add vgetrandom_alloc() syscall
Message-ID: <Y39djiBSmgXfgWJv@zx2c4.com>
References: <20221121152909.3414096-1-Jason@zx2c4.com>
 <20221121152909.3414096-2-Jason@zx2c4.com>
 <87v8n6lzh9.fsf@oldenburg.str.redhat.com>
 <Y37DDX5RtiGsV6MO@zx2c4.com>
 <87a64g7wks.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a64g7wks.fsf@oldenburg.str.redhat.com>
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

On Thu, Nov 24, 2022 at 06:25:39AM +0100, Florian Weimer wrote:
> * Jason A. Donenfeld:
> 
> > Hi Florian,
> >
> > On Wed, Nov 23, 2022 at 11:46:58AM +0100, Florian Weimer wrote:
> >> * Jason A. Donenfeld:
> >> 
> >> > + * The vgetrandom() function in userspace requires an opaque state, which this
> >> > + * function provides to userspace, by mapping a certain number of special pages
> >> > + * into the calling process. It takes a hint as to the number of opaque states
> >> > + * desired, and returns the number of opaque states actually allocated, the
> >> > + * size of each one in bytes, and the address of the first state.
> >> > + */
> >> > +SYSCALL_DEFINE3(vgetrandom_alloc, unsigned long __user *, num,
> >> > +		unsigned long __user *, size_per_each, unsigned int, flags)
> >> 
> >> I think you should make this __u64, so that you get a consistent
> >> userspace interface on all architectures, without the need for compat
> >> system calls.
> >
> > That would be quite unconventional. Most syscalls that take lengths do
> > so with the native register size (`unsigned long`, `size_t`), rather
> > than u64. If you can point to a recent trend away from this by
> > indicating some commits that added new syscalls with u64, I'd be happy
> > to be shown otherwise. But AFAIK, that's not the way it's done.
> 
> See clone3 and struct clone_args.

The struct is one thing. But actually, clone3 takes a `size_t`:

    SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)

I take from this that I too should use `size_t` rather than `unsigned
long.` And it doesn't seem like there's any compat clone3.

Jason
