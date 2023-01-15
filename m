Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F0C66AF33
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 04:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjAODFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 22:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjAODF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 22:05:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FB2A27E;
        Sat, 14 Jan 2023 19:05:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC2C4B80B14;
        Sun, 15 Jan 2023 03:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B98C43396;
        Sun, 15 Jan 2023 03:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673751922;
        bh=DiQUF6QpzAR13IMywXmegzc2eHmYnlOkhoDZnGZrCFE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MGz7x1eNkP8dj+dOJSA5VQ5ykzoAOuF/MiRqr00HfxrPUlhXjQqffmJ+ESVGlvNlZ
         K2lsEG5FI2YmJd54l369+N4BXThpxDxC7lycSrUrAlz6sOddZHmNz5LOwSX3PrUVvK
         Au/pdyNquAwNfrdaqFHtXGzBwvFwSxs6TM1J3cpKbM7tV4mLEE78J4bFfKtoj5l93Q
         gtg3m68haHUTuf0VruCEHyvGnG7XIUM1PSNbwcD6DvPqPxnSFApjz54WrvcxE27L0T
         iz6A/TRDH2YC4UYRwTyoFiYrxCRIYUl03fZiWZ+z+9GQW59OoaNVISMn7hrKjL/NCg
         TtFWOCHuNxLCA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-142b72a728fso26173187fac.9;
        Sat, 14 Jan 2023 19:05:22 -0800 (PST)
X-Gm-Message-State: AFqh2kqmPzvtB+/srWoyol1ht9jxxcG035XuE58tq91KyYyF5OT4yp6Y
        j1lu9j7yEMJ9PiBTcJthKn6WRJY+s6hMaI42OHA=
X-Google-Smtp-Source: AMrXdXuhmnexbTK1zw0fHAGXIP3hshtIpGp4shEbMvVFuWPdx9jxVG2EXbyBkZf4uelrrBgsXumoVUNaOwephiEPFIk=
X-Received: by 2002:a05:6870:50a:b0:15b:9941:ac30 with SMTP id
 j10-20020a056870050a00b0015b9941ac30mr2001023oao.287.1673751921572; Sat, 14
 Jan 2023 19:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20230112023006.1873859-1-masahiroy@kernel.org> <202301121403.599806C597@keescook>
In-Reply-To: <202301121403.599806C597@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 15 Jan 2023 12:04:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARaXH9gJVCJKR5GLuyEiJarxhcXoUyxXDo=MZYKLxFmyA@mail.gmail.com>
Message-ID: <CAK7LNARaXH9gJVCJKR5GLuyEiJarxhcXoUyxXDo=MZYKLxFmyA@mail.gmail.com>
Subject: Re: [PATCH] scripts: handle BrokenPipeError for python scripts
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 7:06 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jan 12, 2023 at 11:30:06AM +0900, Masahiro Yamada wrote:
> >     def main():
> >         try:
> >             # simulate large output (your code replaces this loop)
> >             for x in range(10000):
> >                 print("y")
> >             # flush output here to force SIGPIPE to be triggered
> >             # while inside this try block.
> >             sys.stdout.flush()
> >         except BrokenPipeError:
> >             # Python flushes standard streams on exit; redirect remaini=
ng output
> >             # to devnull to avoid another BrokenPipeError at shutdown
> >             devnull =3D os.open(os.devnull, os.O_WRONLY)
> >             os.dup2(devnull, sys.stdout.fileno())
> >             sys.exit(1)  # Python exits with error code 1 on EPIPE
>
> I still think this is wrong -- they should not continue piping, and
> should just die with SIGPIPE. It should simply be:
>
> signal(SIGPIPE, SIG_DFL);
>
> Nothing else needed. No wasted CPU cycles, shell handling continues as
> per normal.


I prefer try-and-except because it is Python's coding style,
and we can do something before the exit.
(for example, clean up temporary files)


>
> >     if __name__ =3D=3D '__main__':
> >         main()
> >
> >   Do not set SIGPIPE=E2=80=99s disposition to SIG_DFL in order to avoid
> >   BrokenPipeError. Doing that would cause your program to exit
> >   unexpectedly whenever any socket connection is interrupted while
> >   your program is still writing to it.
>
> This advise is for socket programs, not command-line tools.


I still do not understand what is bad
about using this for command-line tools.


>
> -Kees
>
> --
> Kees Cook



--=20
Best Regards
Masahiro Yamada
