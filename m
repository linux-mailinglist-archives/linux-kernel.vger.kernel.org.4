Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F2B63B37E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiK1Ulx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiK1Ulu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:41:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DBA614B;
        Mon, 28 Nov 2022 12:41:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD679B80FEE;
        Mon, 28 Nov 2022 20:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175C2C43141;
        Mon, 28 Nov 2022 20:41:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SJg8wj4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669668103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8JvkqslPVbF1sVkadwrc/dHj4sGZrwzWhDSPyXC0iA=;
        b=SJg8wj4KRRLy9GYEMoYu0SdEW67lBhfEBgSjbS7Y5Ldh+fS6U2U9/FkdNSsNEOwiNHtkz+
        sVISLnKzyPz/JOQ+9fHS8ReK3FKr3zPBD/cTq3WYi1UWFnMobHQe+BUx9qRz4Cv/NjcOul
        ZCjbDNFsDLsLQ7hio4Yg3cZ3atcl/4I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f03cb47a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 20:41:42 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id x24so4315413uaf.4;
        Mon, 28 Nov 2022 12:41:42 -0800 (PST)
X-Gm-Message-State: ANoB5pkUysLhsiBhfMXLfR92/8EKPj75epFR6fn8EymTLZrEJqx9sjFs
        0QvNudn1Psf2JwSyBrPwc9mtopLX4SKGpTdjQtY=
X-Google-Smtp-Source: AA0mqf4UPjPrqMrKRlHIidUmjattarRbkI2y9HG3LAX9xwp/oLJ1brY9IeiJRTI7OlH2L1h0PSE8XR88ROmV6anlyfQ=
X-Received: by 2002:ab0:3899:0:b0:419:1b4a:360b with SMTP id
 z25-20020ab03899000000b004191b4a360bmr5012971uav.102.1669668101214; Mon, 28
 Nov 2022 12:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20221128111829.2477505-1-Jason@zx2c4.com> <20221128111829.2477505-4-Jason@zx2c4.com>
 <8f9326ba-f879-4b9e-9e5d-b65cad7cd726@app.fastmail.com> <Y4UKpP7/NOwPIkYe@zx2c4.com>
 <cd01e0b4-579f-48fc-995f-6e1acebd02af@app.fastmail.com> <CAHmME9rp+Nx_S8OgABzadc1+j_FrSRbUvGu2r9W_svrr+HMjSg@mail.gmail.com>
In-Reply-To: <CAHmME9rp+Nx_S8OgABzadc1+j_FrSRbUvGu2r9W_svrr+HMjSg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Nov 2022 21:41:30 +0100
X-Gmail-Original-Message-ID: <CAHmME9oP4whduVJD7LYpjFaS76yhxd3r1YXRfNhpRBw4QCQe3g@mail.gmail.com>
Message-ID: <CAHmME9oP4whduVJD7LYpjFaS76yhxd3r1YXRfNhpRBw4QCQe3g@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] x86: vdso: Wire up getrandom() vDSO implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Nov 28, 2022 at 9:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Arnd,
>
> On Mon, Nov 28, 2022 at 8:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Nov 28, 2022, at 20:23, Jason A. Donenfeld wrote:
> > > On Mon, Nov 28, 2022 at 08:18:12PM +0100, Arnd Bergmann wrote:
> > >> On Mon, Nov 28, 2022, at 12:18, Jason A. Donenfeld wrote:
> > >
> > > That's more or less how v7 was, but Thomas thought the x86 stuff should
> > > be separate. So for v8, the organization is:
> > >
> > > 1) generic syscall
> > > 2) generic vdso
> > > 3) x86 wiring
> > >
> > > The primary advantage is that future archs wanting to add this now can
> > > just look at commit (3) only, and make a similar commit for that new
> > > arch.
> > >
> > > If you think a different organization outweighs that advantage, can you
> > > spell out what division of patches you want, and I'll do that for v9?
> > > Or maybe this v8 is okay?
> >
> > My interest is that at the end of the series, all architectures
> > are hooked up with the same syscall number, which avoids confusion
> > and merge conflicts when we add the next syscall to all tables.
> >
> > How about one patch to add all the syscall table entries, and then
> > have the x86 specific change just turn on the Kconfig symbol that
> > actually enables the syscall?
>
> Okay, I can split it that way. If I gather your meaning correctly:
>
> 1) generic syscall C code
> 2) #define __NR_... in asm-generic/unistd.h x86/.../unistd.h,
> x86/.../syscall_64.tbl
> 3) generic vdso C code
> 4) hook up x86 vdso, and select the right Kconfig symbol to start
> compiling the code
>
> Is that what you have in mind? If so, I'll name (2) "arch: wire up
> vgetrandom_alloc() syscall number".

Well, I just did this, and it seems clean enough. The result is in:
https://git.zx2c4.com/linux-rng/log/?h=vdso
if you're curious to poke at it ahead of v9.

Jason
