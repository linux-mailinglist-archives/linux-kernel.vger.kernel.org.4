Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7692643CA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiLFF1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLFF07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:26:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDCA95AC;
        Mon,  5 Dec 2022 21:26:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C0DE611E0;
        Tue,  6 Dec 2022 05:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8992C433D6;
        Tue,  6 Dec 2022 05:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670304418;
        bh=J1AYXuRzWTFTLlyZLTqLYJyYKG7GrOlsE78RJhxCyQw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=slX8spyWfo7MphFQ0dHRAmnAPph+D/QC+Q1j9Bd5hnurSPMYNt+u5U2IlsYzvwvFf
         BD2ZwvM1Q+LcQAJoz3xm7aEKm96/xudOoaqRsYVPU2s5dSGpeHV0OBN76NAJojp0AT
         OLmX91Wn2iBrR3ffBLr4CMOLOEHeM+OsaRHm0/Gf4DOlve3QsSiaJTK+prvgfW3Pwj
         Ve6OviJqqfxSG0tuu7Xb63jB0UTpa82Ng4Hc4AFozzgJGMNZwwutDFoT1UH3bV9g2g
         a8H2yfEYmA+mrl/XAdHS8vpaz7mLXPG3oFMOHD8pQR+p0ohxXvArPoTVZJA+Xbr26o
         5vgMT6V8IRtGA==
Date:   Mon, 05 Dec 2022 21:26:55 -0800
From:   Kees Cook <kees@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>
CC:     linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_kbuild=3A_fix_SIGPIPE_err?= =?US-ASCII?Q?or_message_for_AR=3Dgcc-ar_and_AR=3Dllvm-ar?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAK7LNASBwfyt_2dbT1-MEcGwF8hQogJgjYnEE-e-twtL1WNYhg@mail.gmail.com>
References: <20221027162839.410720-1-masahiroy@kernel.org> <202211161056.1B9611A@keescook> <CAK7LNATWbvpovH8qsGMX-5-31QiQ6pjKNnm+YEDEqr4io1hrSw@mail.gmail.com> <202211161406.EF075E28E9@keescook> <CAK7LNASBwfyt_2dbT1-MEcGwF8hQogJgjYnEE-e-twtL1WNYhg@mail.gmail.com>
Message-ID: <9E7D1CE1-3956-4BCC-9FCD-AEF0684E3DC3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 5, 2022 8:24:41 PM PST, Masahiro Yamada <masahiroy@kernel=2Eorg=
> wrote:
>On Thu, Nov 17, 2022 at 7:07 AM Kees Cook <keescook@chromium=2Eorg> wrote=
:
>>
>> On Thu, Nov 17, 2022 at 05:37:31AM +0900, Masahiro Yamada wrote:
>> > On Thu, Nov 17, 2022 at 4:01 AM Kees Cook <keescook@chromium=2Eorg> w=
rote:
>> > >
>> > > On Fri, Oct 28, 2022 at 01:28:39AM +0900, Masahiro Yamada wrote:
>> > > > Jiri Slaby reported that building the kernel with AR=3Dgcc-ar sho=
ws:
>> > > >   /usr/bin/ar terminated with signal 13 [Broken pipe]
>> > > >
>> > > > Nathan Chancellor reported the latest AR=3Dllvm-ar shows
>> > > >   error: write on a pipe with no reader
>> > > >
>> > > > The latter occurs since LLVM commit 51b557adc131 ("Add an error m=
essage
>> > > > to the default SIGPIPE handler")=2E
>> > > >
>> > > > The resulting vmlinux is correct, but it is better to silence it=
=2E
>> > > >
>> > > > 'head -n1' exits after reading the first line, so the pipe is clo=
sed=2E
>> > > >
>> > > > Use 'sed -n 1p' to eat the stream till the end=2E
>> > >
>> > > I think this is wrong because it needlessly consumes CPU time=2E SI=
GPIPE
>> > > is _needed_ to stop a process after we found what we needed, but it=
's up
>> > > to the caller (the shell here) to determine what to do about it=2E
>> > >
>> > > Similarly, that LLVM commit is wrong -- tools should _not_ catch th=
eir
>> > > own SIGPIPEs=2E They should be caught by their callers=2E
>> > >
>> > > For example, see:
>> > >
>> > > $ seq 10000 | head -n1
>> > > 1
>> > >
>> > > ^^^ no warnings from the shell (caller of "seq")
>> > > And you can see it _is_ being killed by SIGPIPE:
>> > >
>> > > $ strace seq 1000 | head -n1
>> > > =2E=2E=2E
>> > > write(1, "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14"=2E=2E=2E, =
8192) =3D 8192
>> > > 1
>> > > write(1, "\n1861\n1862\n1863\n1864\n1865\n1866\n1"=2E=2E=2E, 4096) =
=3D -1 EPIPE (Broken pipe)
>> > > --- SIGPIPE {si_signo=3DSIGPIPE, si_code=3DSI_USER, si_pid=3D350344=
8, si_uid=3D1000} ---
>> > > +++ killed by SIGPIPE +++
>> > >
>> > > If we use "sed -n 1p" seq will continue to run, consuming needless =
time
>> > > and CPU resources=2E
>> > >
>> > > So, I strongly think this is the wrong solution=2E SIGPIPE should b=
e
>> > > ignored for ar, and LLVM should _not_ catch its own SIGPIPE=2E
>> > >
>> > > -Kees
>> >
>> >
>> > I thought of this - it is just wasting CPU time,
>> > but I did not come up with a better idea on the kbuild side=2E
>> >
>> > I do not want to use 2>/dev/null because it may hide
>> > non-SIGPIPE (i=2Ee=2E real) errors=2E
>>
>> Yes, I've opened an upstream LLVM bug for this:
>> https://github=2Ecom/llvm/llvm-project/issues/59037
>>
>> --
>> Kees Cook
>
>
>
>BTW, Python does something similar by default=2E
>(noisy back-trace for SIGPIPE)
>
>
>
>
>
>masahiro@zoe:/tmp$ cat test=2Epy
>#!/usr/bin/python3
>for i in range(4000):
>    print(i)
>
>masahiro@zoe:/tmp$ =2E/test=2Epy  |  head -n1
>0
>Traceback (most recent call last):
>  File "/tmp/=2E/test=2Epy", line 3, in <module>
>    print(i)
>BrokenPipeError: [Errno 32] Broken pipe

Eww=2E Well, same problem, IMO=2E For any Python scripts that are going to=
 have potentially truncated output, they need to do:

from signal import signal, SIGPIPE, SIG_DFL
signal(SIGPIPE,SIG_DFL)

>This page
>https://www=2Egeeksforgeeks=2Eorg/broken-pipe-error-in-python/
>
>suggests some workarounds=2E

(As suggested in this page=2E)

>What would you suggest for python scripts?

They need to be fixed=2E A command line tool internally catching SIGPIPE i=
s wrong=2E :)

-Kees


--=20
Kees Cook
