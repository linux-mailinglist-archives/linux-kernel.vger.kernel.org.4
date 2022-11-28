Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6513C63AEB7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiK1RRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiK1RR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:17:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8C26AEC;
        Mon, 28 Nov 2022 09:17:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B6F7B80E74;
        Mon, 28 Nov 2022 17:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B3AC433D6;
        Mon, 28 Nov 2022 17:17:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lgJAHmRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669655843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zx+xERd2IzI+idUZ4FTTj35GNfBVVHdMcem2M32A5rM=;
        b=lgJAHmRg2fviMIGsKiHeOq7t5Opiaxy9sLeRGvooCfpC14Ba2i2UirnTWC1TWN9LNqTWhG
        rAqareEvPn8JYyokXvOEY0/F4scn16gSLgMItFYXjfu7to/dCLFcmNEoBxomLwHdsMIs5t
        I+UW36utDQAg5MqAIbJi5i7GOwFrFig=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b9d4e8ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 17:17:22 +0000 (UTC)
Date:   Mon, 28 Nov 2022 18:17:16 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 1/3] random: add vgetrandom_alloc() syscall
Message-ID: <Y4TtHMvCjTVc1do9@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
 <20221124165536.1631325-2-Jason@zx2c4.com>
 <87bkouyd90.ffs@tglx>
 <Y4PF+pBlNZGfZ0sr@zx2c4.com>
 <8f25aa1e-cb42-4ef0-a1ff-93dcf8651213@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f25aa1e-cb42-4ef0-a1ff-93dcf8651213@app.fastmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Nov 28, 2022 at 02:54:39PM +0100, Arnd Bergmann wrote:
> On Sun, Nov 27, 2022, at 21:18, Jason A. Donenfeld wrote:
> >> 
> >> config GENERIC_VDSO_RANDOM_WHATEVER
> >>        bool
> >>        select VGETRANDOM_ALLOC
> >> 
> >> This gives a clear Kconfig dependency instead of the random
> >> ADVISE_SYSCALLS select.
> >
> > That's much better indeed. I was trying to straddle the two conventions
> > of `#define __ARCH_...` for syscalls and a Kconfig for vDSO functions,
> > but doing it all together as you've suggested is nicer.
> >
> > I'll try to figure this out, though so far futzing around suggests there
> > might have to be both, because of unistd.h being a userspace header.
> > That is, include/uapi/asm-generic/unistd.h typically needs a `#if
> > __ARCH_WANT..., #define ...` in it. I'll give it a spin and you'll see
> > for v8. At the very least it should get rid of the more awkward
> > `select ADVISE_SYSCALLS if X86_64` part, and will better separate the
> > arch code from non-arch code.
> 
> I think you should not need an __ARCH_WANT_SYS_* symbol for this,
> the only place we actually need them for is the asm-generic/unistd.h
> header which is still used on a couple of architectures (I have
> an experimental series for replacing it with a generic syscall.tbl
> file, but it's not ready for 6.2). In most cases, the __ARCH_WANT_SYS_*
> symbols are only used for syscalls that are part of the table for
> old architectures but get skipped on newer targets that always had
> a replacement syscalls (e.g. getrlimit getting replaced by prlimit64)
> 
> I think we should just reserve the syscall number for all architectures
> right away and #define the __NR_* macro. libc will generally need
> a runtime check anyway, and defining it now avoids the problem of
> the tables getting out of sync.
> 
> The Kconfig symbol is fine in this case.

Oh, great, okay. I'll get rid of the __ARCH stuff entirely then. I
jumped the gun and posted v8 earlier today, but I'll include this in a
v9, whenever it makes sense to send that. So when reading v8, just
assume all he __ARCH_WANT_SYS_* business has been removed.

Jason
