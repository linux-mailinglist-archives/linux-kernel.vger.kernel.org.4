Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81383707C97
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjERJRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjERJRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58471FDC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684401409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykr+59pibwgsmmkwH1AJ/j6p5jBksYdr/A2VbmAByCM=;
        b=A6nZbqx5fdL9jRsOf1eE+5teFMXnh+8au5Ldux/JHC5SefLuUu362exelq/q48oXuaODkl
        sq9tjFUZxXKMPaGwEGRicYQnOmyK460SGboF2aADfyNLnSnZk8Eg6lh0y/rYtX2QOBB8hC
        FYg6jlxugGdBXqj6ewC38D/I5ao7HZ0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-w6eFjHsAO4y-fXneohDFJw-1; Thu, 18 May 2023 05:16:48 -0400
X-MC-Unique: w6eFjHsAO4y-fXneohDFJw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ac8393dd5eso9397521fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684401406; x=1686993406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykr+59pibwgsmmkwH1AJ/j6p5jBksYdr/A2VbmAByCM=;
        b=EwtfHsl6mF/PrV/l2tez5boucBJsKC8Y7rmjWqcFLr8sl+ACquz+HEsLjcynyQtXVx
         AuNPxlHGjV40Xr4F/sk0RmMm6hGn3bponop8YOgpynrQjLuV0HVJt7NKuaUSn8VI9/EU
         BZwqrn2FbChtO+a8jRftqGa1mC8XDfy8ETnkLxAvmBpF0kUFWpWejjfLoGddMuJHPwJG
         FRnALavsZBldiCv0YYbjLSSdaeBFUpS5q9ooHlQgSTsjhVkepdb9InbUP945b5ZXyiWI
         Lfa1kP268+iDFBfY7oFIdZOB6DeInlV2FfV5KoPPYsrfUV4IHM2O+hZmR6xy7qcDDQMo
         9BJw==
X-Gm-Message-State: AC+VfDzxvASxL53yFdswKNR4FAj9kwcNjXT/9scHrF1X/n7pOjtVnxMG
        WKC+03d6xNO2SzOUbhKEVCWD1cAoUeiemIMhZfl9Np7BPm70iBk8rNyroUIRwGQY6HZWTvUl4l3
        w31cfj7jXadBsCVk6N+bKXGfp2ttKbNW+csvSzWmq
X-Received: by 2002:a2e:8816:0:b0:2ac:81c3:55eb with SMTP id x22-20020a2e8816000000b002ac81c355ebmr11629622ljh.28.1684401406574;
        Thu, 18 May 2023 02:16:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zpn484g6BawbJTTJiKZvNTbqKySMKaAxWEV3797nfbP0qGwHxcYYeeI6JOqIrYmHRj3hKPfbCz4LDCHUh95U=
X-Received: by 2002:a2e:8816:0:b0:2ac:81c3:55eb with SMTP id
 x22-20020a2e8816000000b002ac81c355ebmr11629611ljh.28.1684401406221; Thu, 18
 May 2023 02:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230414101052.11012-1-ihuguet@redhat.com> <20230516130437.14753-1-mailhol.vincent@wanadoo.fr>
 <CACT4ouc=VfUtZCGr0+y2sGDyWAnagT-zTMv3C2fkgfYXTJtRhA@mail.gmail.com> <CAMZ6RqKs0wBPYE4h3HsxDS0F2ZSvDDb3BrOuwtuBERtEGHy6dg@mail.gmail.com>
In-Reply-To: <CAMZ6RqKs0wBPYE4h3HsxDS0F2ZSvDDb3BrOuwtuBERtEGHy6dg@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Thu, 18 May 2023 11:16:34 +0200
Message-ID: <CACT4oufzafPBOvtYX7W2ossVNeOfBTPwjuce1EG_7YKZN3kpQQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add .editorconfig file for basic formatting
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     corbet@lwn.net, danny@kdrag0n.dev, jgg@nvidia.com, joe@perches.com,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        masahiroy@kernel.org, mic@digikod.net, ojeda@kernel.org,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:59=E2=80=AFAM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
>
> On Thu. 18 May 2023 at 16:53, =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>=
 wrote:
> > Hi Vincent,
> >
> > On Tue, May 16, 2023 at 3:05=E2=80=AFPM Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:
> > >
> > > Hi =C3=8D=C3=B1igo,
> > >
> > > Thank you very much for this patch. I would really love to see .edito=
rconfig
> > > added to the Linux tree.
> > >
> > > I need to work on different project and so, since last year, I applie=
d the v2 of
> > > this series to my local tree and it works great.
> > >
> > > On Fri, Apr 14, 2023 at 12:11=E2=80=AFPM =C3=8D=C3=B1igo Huguet <ihug=
uet@redhat.com> wrote:
> > > > EditorConfig is a specification to define the most basic code forma=
tting
> > > > stuff, and it's supported by many editors and IDEs, either directly=
 or
> > > > via plugins, including VSCode/VSCodium, Vim, emacs and more.
> > > >
> > > > It allows to define formatting style related to indentation, charse=
t,
> > > > end of lines and trailing whitespaces. It also allows to apply diff=
erent
> > > > formats for different files based on wildcards, so for example it i=
s
> > > > possible to apply different configs to *.{c,h}, *.py and *.rs.
> > > >
> > > > In linux project, defining a .editorconfig might help to those peop=
le
> > > > that work on different projects with different indentation styles, =
so
> > > > they cannot define a global style. Now they will directly see the
> > > > correct indentation on every fresh clone of the project.
> > > >
> > > > See https://editorconfig.org
> > > >
> > > > Link: https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kd=
rag0n.dev/
> > > > Link: https://lore.kernel.org/lkml/20230404075540.14422-1-ihuguet@r=
edhat.com/
> > > > Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> > > > Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> > > > Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> > > > ---
> > > > v2:
> > > >  - added special rule for patch files so it doesn't remove
> > > >    trailing whitespaces, making them unusable.
> > > > v3:
> > > >  - moved all rules from [*] section to all the individual
> > > >    sections so they doesn't affect to unexpected files.
> > >
> > > I understand from from the past discussions that trim_trailing_whites=
pace or the
> > > default indentation can not be apply broadly to all files. But what a=
bout those
> > > three parameters?
> > >
> > >   [*]
> > >   charset =3D utf-8
> > >   end_of_line =3D lf
> > >   insert_final_newline =3D true
> > >
> > > Those looks safe to me. Are there files for which we do not want utf-=
8 or for
> > > which we do not what a final empty newline?
> >
> > Yes, I think that they are probably safe to use, but Miguel thought it
> > was better to be more cautious, and I agree. We can expand adding more
> > file formats when we detect those that are not covered.
>
> I think you are referring to this message from Miguel:
>
>   While UTF-8 and LF are probably OK for all files, I am not 100% sure ab=
out:
>
>   +insert_final_newline =3D true
>   +indent_style =3D tab
>   +indent_size =3D 8
>
> Link: https://lore.kernel.org/lkml/CANiq72k2rrByxzj1c4azAVJq-V7BqQcmBwtm3=
XM9T8r3r3-ysQ@mail.gmail.com/
>
> So it seems that we all agree on the UTF-8 and LF. Or did I miss
> another message?

It seems so. The patch you link is the original path sent by Danny
months ago. This is v3 of my own patch, that I sent without knowing
that Danny's one existed:
https://lore.kernel.org/lkml/20230404075540.14422-1-ihuguet@redhat.com/

Although there were no explicit complains about UTF-8 and LF, I feel
that it's safer to not add a [*] section at all.

>
> Regardless, with or without my nitpick addressed, it looks good to me:
>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

I was going to prepare a v4 with small modifications, at the light of
the results I posted here:
https://lore.kernel.org/lkml/CACT4ouf2M1k7SaMgqv1Fj33Wen7UKuUyKp-Y9oer+THiW=
EebNg@mail.gmail.com/

I was waiting for some feedback about them, but no responses received
so far so I will go ahead making the changes with my own criteria.

>
> > With v3, the most used files are covered, and since there are
> > thousands of files with many different purposes, it's very difficult
> > to answer if there are files where we don't want these settings.
> >
> > For example, if there are a few files that, who knows why, need a
> > different encoding, we can silently corrupt the file and cause a bad
> > debugging time for a developer. For the end of line and final newline,
> > we already saw that there are files where they are undesired, like
> > patch files. There might be more.
> >
> > >
> > > >  - added some extensions and files from a patch from Danny
> > > >    Lin that didn't get to be merged:
> > > >    https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag=
0n.dev/
> > > >    However, the following file types hasn't been added
> > > >    because they don't have a clear common style:
> > > >    rst,pl,cocci,tc,bconf,svg,xsl,manual pages
> > > > ---
> > > >  .editorconfig                          | 30 ++++++++++++++++++++++=
++++
> > > >  .gitignore                             |  1 +
> > > >  Documentation/process/4.Coding.rst     |  4 ++++
> > > >  Documentation/process/coding-style.rst |  4 ++++
> > > >  4 files changed, 39 insertions(+)
> > > >  create mode 100644 .editorconfig
> > > >
> > > > diff --git a/.editorconfig b/.editorconfig
> > > > new file mode 100644
> > > > index 000000000000..dce20d45c246
> > > > --- /dev/null
> > > > +++ b/.editorconfig
> > > > @@ -0,0 +1,30 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +root =3D true
> > > > +
> > > > +# 8 width tabs
> > > > +[{*.{c,h},Kconfig,Makefile,Makefile.*,*.mk}]
> > > > +charset =3D utf-8
> > > > +end_of_line =3D lf
> > > > +trim_trailing_whitespace =3D true
> > > > +insert_final_newline =3D true
> > > > +indent_style =3D tab
> > > > +indent_size =3D 8
> > > > +
> > > > +# 4 spaces
> > > > +[{*.{json,pm,py,rs},tools/perf/scripts/*/bin/*}]
> > > > +charset =3D utf-8
> > > > +end_of_line =3D lf
> > > > +trim_trailing_whitespace =3D true
> > > > +insert_final_newline =3D true
> > > > +indent_style =3D space
> > > > +indent_size =3D 4
> > > > +
> > > > +# 2 spaces
> > > > +[{*.{rb,yaml},.clang-format}]
> > > > +charset =3D utf-8
> > > > +end_of_line =3D lf
> > > > +trim_trailing_whitespace =3D true
> > > > +insert_final_newline =3D true
> > > > +indent_style =3D space
> > > > +indent_size =3D 2
> > > > diff --git a/.gitignore b/.gitignore
> > > > index 70ec6037fa7a..e4b3fe1d029b 100644
> > > > --- a/.gitignore
> > > > +++ b/.gitignore
> > > > @@ -100,6 +100,7 @@ modules.order
> > > >  #
> > > >  !.clang-format
> > > >  !.cocciconfig
> > > > +!.editorconfig
> > > >  !.get_maintainer.ignore
> > > >  !.gitattributes
> > > >  !.gitignore
> > > > diff --git a/Documentation/process/4.Coding.rst b/Documentation/pro=
cess/4.Coding.rst
> > > > index 1f0d81f44e14..c2046dec0c2f 100644
> > > > --- a/Documentation/process/4.Coding.rst
> > > > +++ b/Documentation/process/4.Coding.rst
> > > > @@ -66,6 +66,10 @@ for aligning variables/macros, for reflowing tex=
t and other similar tasks.
> > > >  See the file :ref:`Documentation/process/clang-format.rst <clangfo=
rmat>`
> > > >  for more details.
> > > >
> > > > +Some basic editor settings, such as indentation and line endings, =
will be
> > > > +set automatically if you are using an editor that is compatible wi=
th
> > > > +EditorConfig. See the official EditorConfig website for more infor=
mation:
> > > > +https://editorconfig.org/
> > > >
> > > >  Abstraction layers
> > > >  ******************
> > > > diff --git a/Documentation/process/coding-style.rst b/Documentation=
/process/coding-style.rst
> > > > index 007e49ef6cec..ec96462fa8be 100644
> > > > --- a/Documentation/process/coding-style.rst
> > > > +++ b/Documentation/process/coding-style.rst
> > > > @@ -735,6 +735,10 @@ for aligning variables/macros, for reflowing t=
ext and other similar tasks.
> > > >  See the file :ref:`Documentation/process/clang-format.rst <clangfo=
rmat>`
> > > >  for more details.
> > > >
> > > > +Some basic editor settings, such as indentation and line endings, =
will be
> > > > +set automatically if you are using an editor that is compatible wi=
th
> > > > +EditorConfig. See the official EditorConfig website for more infor=
mation:
> > > > +https://editorconfig.org/
> > > >
> > > >  10) Kconfig configuration files
> > > >  -------------------------------
> > > > --
>


--=20
=C3=8D=C3=B1igo Huguet

