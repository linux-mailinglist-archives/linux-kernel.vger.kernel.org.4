Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428EB62CB31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiKPUij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiKPUia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:38:30 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06252EA3;
        Wed, 16 Nov 2022 12:38:26 -0800 (PST)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2AGKc80C003458;
        Thu, 17 Nov 2022 05:38:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2AGKc80C003458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668631088;
        bh=c7CHuhEkcILYlod524PGOT/hdlG/esbc7n/dEx43MCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rl7XjlFmmOZyOTwUmKDz97vVfo1RSfJB+BDQppKrZuXnHlIGgqKvNkB4y4JtL8w9t
         lRI/YyS9+fMTNzRoTwnLW+dPpKaw2JQn87aNhY7+/widowFmUhLrL8bnHNaGH1Eq5P
         w8QucvurLElJWmxeWRlNFBlLRzywJbsgKKlFTftLHh3tHTCY6gCxoeLeyBXz+d136P
         KyUorvVg31SvGrn+mPdF5wlyprs2jrGMMRKDDm7MhLlpwwevS16fEWEIr2CnKLfuYk
         dke04EqQiLN89F8EHP3bTcGevS/AjAdLmhF00CAfTWauIoQUnlPp5XdmEfazjInV+T
         OteBsD2RxFWkw==
X-Nifty-SrcIP: [209.85.161.42]
Received: by mail-oo1-f42.google.com with SMTP id r10-20020a4aa2ca000000b0049dd7ad4128so2675295ool.13;
        Wed, 16 Nov 2022 12:38:08 -0800 (PST)
X-Gm-Message-State: ANoB5pl7xkAE0uufHBYuSZwvIUnIS+IB1zydqNpbkDJDut11+tUkK6aG
        MaITemnwpQ8MmcRC+QZJU51h1vXUDKh5pukEecU=
X-Google-Smtp-Source: AA0mqf7Jdd4+gJIc4WyDecmKpKyBiZDFqnp8KV+X1D/zE9vJzobdNIxOxLQ1R2YFgxPjqz2agdgQjup91QEIiBlMcvk=
X-Received: by 2002:a4a:dc13:0:b0:49f:87d0:ef5c with SMTP id
 p19-20020a4adc13000000b0049f87d0ef5cmr4521997oov.96.1668631087318; Wed, 16
 Nov 2022 12:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20221027162839.410720-1-masahiroy@kernel.org> <202211161056.1B9611A@keescook>
In-Reply-To: <202211161056.1B9611A@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 17 Nov 2022 05:37:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNATWbvpovH8qsGMX-5-31QiQ6pjKNnm+YEDEqr4io1hrSw@mail.gmail.com>
Message-ID: <CAK7LNATWbvpovH8qsGMX-5-31QiQ6pjKNnm+YEDEqr4io1hrSw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: fix SIGPIPE error message for AR=gcc-ar and AR=llvm-ar
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 4:01 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Oct 28, 2022 at 01:28:39AM +0900, Masahiro Yamada wrote:
> > Jiri Slaby reported that building the kernel with AR=gcc-ar shows:
> >   /usr/bin/ar terminated with signal 13 [Broken pipe]
> >
> > Nathan Chancellor reported the latest AR=llvm-ar shows
> >   error: write on a pipe with no reader
> >
> > The latter occurs since LLVM commit 51b557adc131 ("Add an error message
> > to the default SIGPIPE handler").
> >
> > The resulting vmlinux is correct, but it is better to silence it.
> >
> > 'head -n1' exits after reading the first line, so the pipe is closed.
> >
> > Use 'sed -n 1p' to eat the stream till the end.
>
> I think this is wrong because it needlessly consumes CPU time. SIGPIPE
> is _needed_ to stop a process after we found what we needed, but it's up
> to the caller (the shell here) to determine what to do about it.
>
> Similarly, that LLVM commit is wrong -- tools should _not_ catch their
> own SIGPIPEs. They should be caught by their callers.
>
> For example, see:
>
> $ seq 10000 | head -n1
> 1
>
> ^^^ no warnings from the shell (caller of "seq")
> And you can see it _is_ being killed by SIGPIPE:
>
> $ strace seq 1000 | head -n1
> ...
> write(1, "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14"..., 8192) = 8192
> 1
> write(1, "\n1861\n1862\n1863\n1864\n1865\n1866\n1"..., 4096) = -1 EPIPE (Broken pipe)
> --- SIGPIPE {si_signo=SIGPIPE, si_code=SI_USER, si_pid=3503448, si_uid=1000} ---
> +++ killed by SIGPIPE +++
>
> If we use "sed -n 1p" seq will continue to run, consuming needless time
> and CPU resources.
>
> So, I strongly think this is the wrong solution. SIGPIPE should be
> ignored for ar, and LLVM should _not_ catch its own SIGPIPE.
>
> -Kees


I thought of this - it is just wasting CPU time,
but I did not come up with a better idea on the kbuild side.

I do not want to use 2>/dev/null because it may hide
non-SIGPIPE (i.e. real) errors.


I think you guys will be keen on fixing llvm.
I hope gcc as well?



-- 
Best Regards
Masahiro Yamada
