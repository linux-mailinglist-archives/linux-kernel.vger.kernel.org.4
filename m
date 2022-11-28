Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC0B63B452
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiK1Vk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiK1VkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:40:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F12F66E;
        Mon, 28 Nov 2022 13:40:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B0C1B8101F;
        Mon, 28 Nov 2022 21:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987A5C433C1;
        Mon, 28 Nov 2022 21:40:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l29kvSGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669671599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tfs5wzpKdXXvhME6DzZepIuBzlpHQXgovK4ad1gZ15Q=;
        b=l29kvSGaXSZQ+bbI72z4UBsL7Ki877+bxUGmtzQH3YL82BbZHKRvxP8MNWh0p7C/CODQBp
        YAQQT1BaiuVMctPMwIXdIz5mz3VB3Ulgevh7VssRhCHTJYMZDyC1u9HPkVlxT49YoUMLJv
        fWeFXG/MNOgEkYQH0POQUOwETCVsjK8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7a8f84e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 21:39:58 +0000 (UTC)
Date:   Mon, 28 Nov 2022 22:39:54 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>
Subject: Re: [PATCH v8 3/3] x86: vdso: Wire up getrandom() vDSO implementation
Message-ID: <Y4Uqqv4X2j/+dFww@zx2c4.com>
References: <20221128111829.2477505-1-Jason@zx2c4.com>
 <20221128111829.2477505-4-Jason@zx2c4.com>
 <8f9326ba-f879-4b9e-9e5d-b65cad7cd726@app.fastmail.com>
 <Y4UKpP7/NOwPIkYe@zx2c4.com>
 <cd01e0b4-579f-48fc-995f-6e1acebd02af@app.fastmail.com>
 <CAHmME9rp+Nx_S8OgABzadc1+j_FrSRbUvGu2r9W_svrr+HMjSg@mail.gmail.com>
 <2cb4b4a7-1d39-4f63-aee0-b4fc43efa68d@app.fastmail.com>
 <CAHmME9r6Hqy3KTJoNpXzJ4weUyFs=5xEPQEe94x4hO6QZWo-5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9r6Hqy3KTJoNpXzJ4weUyFs=5xEPQEe94x4hO6QZWo-5g@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:29:29PM +0100, Jason A. Donenfeld wrote:
> On Mon, Nov 28, 2022 at 10:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Nov 28, 2022, at 21:02, Jason A. Donenfeld wrote:
> > > On Mon, Nov 28, 2022 at 8:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > Okay, I can split it that way. If I gather your meaning correctly:
> > >
> > > 1) generic syscall C code
> > > 2) #define __NR_... in asm-generic/unistd.h x86/.../unistd.h,
> > > x86/.../syscall_64.tbl
> >
> > I mean all syscall*.tbl files, not just x86. There are currently
> > eight architectures using asm-generic/unistd.h, the rest use
> > syscall.tbl.
> 
> Oh okay, I'll add this to all of the *.tbl files.

Alright, so, it's looking like this now:

commit 16751c0ac4efaf1cefd793a79c469f9d62ddb3ed
Author: Jason A. Donenfeld <Jason@zx2c4.com>
Date:   Mon Nov 28 21:37:14 2022

    arch: allocate vgetrandom_alloc() syscall number

    Add vgetrandom_alloc() as syscall 451 (or 561 on alpha) by adding it to
    all of the various syscall.tbl an unistd.h files.

    Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

 arch/alpha/kernel/syscalls/syscall.tbl              | 1 +
 arch/arm/tools/syscall.tbl                          | 1 +
 arch/arm64/include/asm/unistd32.h                   | 2 ++
 arch/ia64/kernel/syscalls/syscall.tbl               | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl               | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl         | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl           | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl           | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl           | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl             | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl            | 1 +
 arch/s390/kernel/syscalls/syscall.tbl               | 1 +
 arch/sh/kernel/syscalls/syscall.tbl                 | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl              | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl              | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl              | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl             | 1 +
 include/uapi/asm-generic/unistd.h                   | 5 ++++-
 tools/include/uapi/asm-generic/unistd.h             | 5 ++++-
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 1 +
 23 files changed, 30 insertions(+), 2 deletions(-)
