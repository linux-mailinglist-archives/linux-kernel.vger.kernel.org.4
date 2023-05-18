Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B496C707B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjERHy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjERHyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782462691
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684396448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NarRAVVByNE1Lz6J+a3HI4ZDlba2EqAebjv+hNn3hp8=;
        b=SCQiRId9/Bhxt2Y9hfY5+aeWkPWdzsgxmCxxPzjkyQCXi7BBOytsxo6ZFHB+MQlRW0RZsQ
        +m7Pq5WNkzGA/Vf3ssZjxq19kehWo92sFM0H2yJ+5zxyx6YO4/vOjRMt0q+GoM0rjZPUJu
        ulB9Fb3DFyqD864WLQ6CM4d/ZRme8E8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-IaR2Yz-0N52siz3xC04MCg-1; Thu, 18 May 2023 03:54:05 -0400
X-MC-Unique: IaR2Yz-0N52siz3xC04MCg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2af08de8c2fso9071621fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684396443; x=1686988443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NarRAVVByNE1Lz6J+a3HI4ZDlba2EqAebjv+hNn3hp8=;
        b=XUWamza9sQWjl+D2un63StlVWaYS9xKh68aKi6lwzeGrzL5lZQJXQKTkcXKqNyV5j/
         tdA3dqt1RLyJVfXGejrnRSHFzoXN+Hd2SaAVxR5eefhj6AIHC7lp8OtgyUV9YjquzzoZ
         jf0IxWym/hWJytK4uZ7L9DpyJqXd2tM7SrhhOr1s8zPfTzm4qI3Cg1k1yCym6Z/awrSQ
         Gt1/CmmNi+u5Yl7UP4m6h0MSB5l1TjJ/iWrR/Xc6d6ztKwmoQGCYWz2sSn+f+PP4wzmu
         i3zJt/djb35deu7ndpol0pTOJZh/s9CDpFSZ9QhnxhxLRq1jAOntmjDTic32LsUfOtga
         Q8cA==
X-Gm-Message-State: AC+VfDynwXpwfFh+LHWSyC1taaV4RI9oq8qJR86zremMnih1Diyvgy3+
        7nsjVXFYsE5KHiS30WTLI8LAD8pjT7WrrWiLnRhy1gLMC9Du+Ddrta+cz0ynoSAQp2iAJ/+A13u
        FMJLkJ3b7PzB2eodzDeR7gkDLQ7wNOtEOFvKwoapR
X-Received: by 2002:a2e:86c6:0:b0:2a7:acb7:cabc with SMTP id n6-20020a2e86c6000000b002a7acb7cabcmr11385653ljj.40.1684396443729;
        Thu, 18 May 2023 00:54:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6jHgoT9fnUEPUHQexB3i6ab+LICpjMLnNDzfXRan5uKLqCX5qxytZvN3ihU8NbhraSE0Tg+dR6mGUbog7SHtg=
X-Received: by 2002:a2e:86c6:0:b0:2a7:acb7:cabc with SMTP id
 n6-20020a2e86c6000000b002a7acb7cabcmr11385643ljj.40.1684396443386; Thu, 18
 May 2023 00:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230414101052.11012-1-ihuguet@redhat.com> <20230516130437.14753-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20230516130437.14753-1-mailhol.vincent@wanadoo.fr>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Thu, 18 May 2023 09:53:51 +0200
Message-ID: <CACT4ouc=VfUtZCGr0+y2sGDyWAnagT-zTMv3C2fkgfYXTJtRhA@mail.gmail.com>
Subject: Re: [PATCH v3] Add .editorconfig file for basic formatting
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     corbet@lwn.net, danny@kdrag0n.dev, jgg@nvidia.com, joe@perches.com,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        masahiroy@kernel.org, mic@digikod.net, ojeda@kernel.org,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Tue, May 16, 2023 at 3:05=E2=80=AFPM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> Hi =C3=8D=C3=B1igo,
>
> Thank you very much for this patch. I would really love to see .editorcon=
fig
> added to the Linux tree.
>
> I need to work on different project and so, since last year, I applied th=
e v2 of
> this series to my local tree and it works great.
>
> On Fri, Apr 14, 2023 at 12:11=E2=80=AFPM =C3=8D=C3=B1igo Huguet <ihuguet@=
redhat.com> wrote:
> > EditorConfig is a specification to define the most basic code formattin=
g
> > stuff, and it's supported by many editors and IDEs, either directly or
> > via plugins, including VSCode/VSCodium, Vim, emacs and more.
> >
> > It allows to define formatting style related to indentation, charset,
> > end of lines and trailing whitespaces. It also allows to apply differen=
t
> > formats for different files based on wildcards, so for example it is
> > possible to apply different configs to *.{c,h}, *.py and *.rs.
> >
> > In linux project, defining a .editorconfig might help to those people
> > that work on different projects with different indentation styles, so
> > they cannot define a global style. Now they will directly see the
> > correct indentation on every fresh clone of the project.
> >
> > See https://editorconfig.org
> >
> > Link: https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0=
n.dev/
> > Link: https://lore.kernel.org/lkml/20230404075540.14422-1-ihuguet@redha=
t.com/
> > Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> > Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> > Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> > ---
> > v2:
> >  - added special rule for patch files so it doesn't remove
> >    trailing whitespaces, making them unusable.
> > v3:
> >  - moved all rules from [*] section to all the individual
> >    sections so they doesn't affect to unexpected files.
>
> I understand from from the past discussions that trim_trailing_whitespace=
 or the
> default indentation can not be apply broadly to all files. But what about=
 those
> three parameters?
>
>   [*]
>   charset =3D utf-8
>   end_of_line =3D lf
>   insert_final_newline =3D true
>
> Those looks safe to me. Are there files for which we do not want utf-8 or=
 for
> which we do not what a final empty newline?

Yes, I think that they are probably safe to use, but Miguel thought it
was better to be more cautious, and I agree. We can expand adding more
file formats when we detect those that are not covered.

With v3, the most used files are covered, and since there are
thousands of files with many different purposes, it's very difficult
to answer if there are files where we don't want these settings.

For example, if there are a few files that, who knows why, need a
different encoding, we can silently corrupt the file and cause a bad
debugging time for a developer. For the end of line and final newline,
we already saw that there are files where they are undesired, like
patch files. There might be more.

>
> >  - added some extensions and files from a patch from Danny
> >    Lin that didn't get to be merged:
> >    https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0n.d=
ev/
> >    However, the following file types hasn't been added
> >    because they don't have a clear common style:
> >    rst,pl,cocci,tc,bconf,svg,xsl,manual pages
> > ---
> >  .editorconfig                          | 30 ++++++++++++++++++++++++++
> >  .gitignore                             |  1 +
> >  Documentation/process/4.Coding.rst     |  4 ++++
> >  Documentation/process/coding-style.rst |  4 ++++
> >  4 files changed, 39 insertions(+)
> >  create mode 100644 .editorconfig
> >
> > diff --git a/.editorconfig b/.editorconfig
> > new file mode 100644
> > index 000000000000..dce20d45c246
> > --- /dev/null
> > +++ b/.editorconfig
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +root =3D true
> > +
> > +# 8 width tabs
> > +[{*.{c,h},Kconfig,Makefile,Makefile.*,*.mk}]
> > +charset =3D utf-8
> > +end_of_line =3D lf
> > +trim_trailing_whitespace =3D true
> > +insert_final_newline =3D true
> > +indent_style =3D tab
> > +indent_size =3D 8
> > +
> > +# 4 spaces
> > +[{*.{json,pm,py,rs},tools/perf/scripts/*/bin/*}]
> > +charset =3D utf-8
> > +end_of_line =3D lf
> > +trim_trailing_whitespace =3D true
> > +insert_final_newline =3D true
> > +indent_style =3D space
> > +indent_size =3D 4
> > +
> > +# 2 spaces
> > +[{*.{rb,yaml},.clang-format}]
> > +charset =3D utf-8
> > +end_of_line =3D lf
> > +trim_trailing_whitespace =3D true
> > +insert_final_newline =3D true
> > +indent_style =3D space
> > +indent_size =3D 2
> > diff --git a/.gitignore b/.gitignore
> > index 70ec6037fa7a..e4b3fe1d029b 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -100,6 +100,7 @@ modules.order
> >  #
> >  !.clang-format
> >  !.cocciconfig
> > +!.editorconfig
> >  !.get_maintainer.ignore
> >  !.gitattributes
> >  !.gitignore
> > diff --git a/Documentation/process/4.Coding.rst b/Documentation/process=
/4.Coding.rst
> > index 1f0d81f44e14..c2046dec0c2f 100644
> > --- a/Documentation/process/4.Coding.rst
> > +++ b/Documentation/process/4.Coding.rst
> > @@ -66,6 +66,10 @@ for aligning variables/macros, for reflowing text an=
d other similar tasks.
> >  See the file :ref:`Documentation/process/clang-format.rst <clangformat=
>`
> >  for more details.
> >
> > +Some basic editor settings, such as indentation and line endings, will=
 be
> > +set automatically if you are using an editor that is compatible with
> > +EditorConfig. See the official EditorConfig website for more informati=
on:
> > +https://editorconfig.org/
> >
> >  Abstraction layers
> >  ******************
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/pro=
cess/coding-style.rst
> > index 007e49ef6cec..ec96462fa8be 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -735,6 +735,10 @@ for aligning variables/macros, for reflowing text =
and other similar tasks.
> >  See the file :ref:`Documentation/process/clang-format.rst <clangformat=
>`
> >  for more details.
> >
> > +Some basic editor settings, such as indentation and line endings, will=
 be
> > +set automatically if you are using an editor that is compatible with
> > +EditorConfig. See the official EditorConfig website for more informati=
on:
> > +https://editorconfig.org/
> >
> >  10) Kconfig configuration files
> >  -------------------------------
> > --
> > 2.39.2
>


--=20
=C3=8D=C3=B1igo Huguet

