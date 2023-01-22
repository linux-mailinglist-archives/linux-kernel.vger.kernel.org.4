Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B2E677145
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjAVR7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjAVR7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:59:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81E16AC3;
        Sun, 22 Jan 2023 09:59:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EECAF60B59;
        Sun, 22 Jan 2023 17:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C950C433D2;
        Sun, 22 Jan 2023 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674410382;
        bh=D2pedExuLZNrqCvaz8leJ1LLl8TDRo55BvOVbQvnsHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pYksia5zWbwxyVwR5OHSi2jDVTKl3QUsTXixSdyMlMTtBDZesvn5bZM+dxR/6pX1M
         eD3gIeEcpaO4iOPkeALGtoK1m1rPhWjrJk7yUbpCE7c0zdLicPjFqZPOllycOL+zjT
         HpLpKE5VE+m5+ULT7gZErBxp3/sv0j9+R08waZvs5H+dQkONvziuzS39znoqRZwoXH
         pVO0SOAR3fr9vqqnki18haiC/DrdaNcXHImL2JY7NMiFjTutaE/E0PllSA1avepqv/
         KNtv4hUuatbcIREmt6d9RFsFjs+k1rS+X3vz3dNsOLMgQv3LGI6LJqaG5dbt9oets1
         KJq11C+QseqCQ==
Received: by mail-ot1-f54.google.com with SMTP id g2-20020a9d6b02000000b006864bf5e658so6107905otp.1;
        Sun, 22 Jan 2023 09:59:42 -0800 (PST)
X-Gm-Message-State: AFqh2kpRg52ymA1bA/77EUn152RfDIP5ftZQGsIdRH5AgbPmmQ6qNCXU
        +mS2mN0P2p9bhmpYd+br01zcebHDgeVzrLE2KiI=
X-Google-Smtp-Source: AMrXdXv+qtyo8rkIgtdEIum0rnVQ7nA9lGu+dYgdpObD9i+RSncPEFAN4enCYSMJPIkQXTz+zrtc/hI56H8Zxw7puU4=
X-Received: by 2002:a9d:6a4c:0:b0:684:a3ad:87e8 with SMTP id
 h12-20020a9d6a4c000000b00684a3ad87e8mr1295263otn.225.1674410381648; Sun, 22
 Jan 2023 09:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20230112023006.1873859-1-masahiroy@kernel.org>
 <202301121403.599806C597@keescook> <CAK7LNARaXH9gJVCJKR5GLuyEiJarxhcXoUyxXDo=MZYKLxFmyA@mail.gmail.com>
In-Reply-To: <CAK7LNARaXH9gJVCJKR5GLuyEiJarxhcXoUyxXDo=MZYKLxFmyA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 23 Jan 2023 02:59:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNATOzfM_5ntS9TiT1=04u28tBvmPJsUWyTptZkS630B-oQ@mail.gmail.com>
Message-ID: <CAK7LNATOzfM_5ntS9TiT1=04u28tBvmPJsUWyTptZkS630B-oQ@mail.gmail.com>
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

On Sun, Jan 15, 2023 at 12:04 PM Masahiro Yamada <masahiroy@kernel.org> wro=
te:
>
> On Fri, Jan 13, 2023 at 7:06 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jan 12, 2023 at 11:30:06AM +0900, Masahiro Yamada wrote:
> > >     def main():
> > >         try:
> > >             # simulate large output (your code replaces this loop)
> > >             for x in range(10000):
> > >                 print("y")
> > >             # flush output here to force SIGPIPE to be triggered
> > >             # while inside this try block.
> > >             sys.stdout.flush()
> > >         except BrokenPipeError:
> > >             # Python flushes standard streams on exit; redirect remai=
ning output
> > >             # to devnull to avoid another BrokenPipeError at shutdown
> > >             devnull =3D os.open(os.devnull, os.O_WRONLY)
> > >             os.dup2(devnull, sys.stdout.fileno())
> > >             sys.exit(1)  # Python exits with error code 1 on EPIPE
> >
> > I still think this is wrong -- they should not continue piping, and
> > should just die with SIGPIPE. It should simply be:
> >
> > signal(SIGPIPE, SIG_DFL);
> >
> > Nothing else needed. No wasted CPU cycles, shell handling continues as
> > per normal.
>
>
> I prefer try-and-except because it is Python's coding style,
> and we can do something before the exit.
> (for example, clean up temporary files)
>
>
> >
> > >     if __name__ =3D=3D '__main__':
> > >         main()
> > >
> > >   Do not set SIGPIPE=E2=80=99s disposition to SIG_DFL in order to avo=
id
> > >   BrokenPipeError. Doing that would cause your program to exit
> > >   unexpectedly whenever any socket connection is interrupted while
> > >   your program is still writing to it.
> >
> > This advise is for socket programs, not command-line tools.
>
>
> I still do not understand what is bad
> about using this for command-line tools.
>
>
> >
> > -Kees
> >
> > --
> > Kees Cook
>
>
>
> --
> Best Regards
> Masahiro Yamada




Applied with the typos fixes.




--=20
Best Regards
Masahiro Yamada
