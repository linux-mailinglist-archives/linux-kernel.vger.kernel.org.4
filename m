Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBE772FF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244812AbjFNNFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244265AbjFNNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B881BE9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686747897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALt+QAtmOc2vIx1lT9ggIM9hgO+jgcpEuqlwExO5fmA=;
        b=UoMwz5MNdPgyNQJc7sxCJ81GdJbdLJ03zU8taZotnJMr/a8DmFM5GAFlbmNmdXGq1xle1y
        +uW8LqrIjKZlQZkOWfY3KrkAVxz7hDcvDXCRkcVAB8CFo+J3b8eUlc94kzS6d2IsAtoPOi
        JnRjiwDsm+jCpUtfVuDr/BOFV9v1s2o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-BMK3wpMbO4CYLLEvxfmVWg-1; Wed, 14 Jun 2023 09:04:52 -0400
X-MC-Unique: BMK3wpMbO4CYLLEvxfmVWg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b34243b253so5410171fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747881; x=1689339881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALt+QAtmOc2vIx1lT9ggIM9hgO+jgcpEuqlwExO5fmA=;
        b=guIjs0oYSmBZkqx2J4gC2KxVmLUwDzOZGmWh96ibW/gxllquf0fmHdl1iBnmxnXTEu
         dssA8Q/eO8cfB/yTOGphLVqR9v4TbZKhOP51vw/wbPYRRzOz9NrXgpwPx1VfhPLcZNdd
         vr0dV0PzF1B7jGjZbN6GFyCKOL0c9sBHTuKqrn2fpmmh1mjjnnmJcRYrVDJ41FH8+L/5
         jiDfTqDMbovdyLy//IQjhMGILJAipZmN8o9n5Hr4BqWrldAf2DeseTufmPtR6Jco3rfB
         qX+ryX0NDjP/4Uv5eSVfClcdnrN8PJeUj3HL+x5FXyeur9LGpPdD+bMWlK+J6ra3uq72
         YGYg==
X-Gm-Message-State: AC+VfDy9Pb4OVQmqijU3dMKuOeCgxJT4iRNq3m8ezxU34YkeF30MknZH
        l20JsIvg6Ttq6IeePWnIeDza4eWfCj1+pLF1fHVwmnN/PfZA3lQqvXtdGG9mGiHUtXvLeVm8I5L
        oqRsuiXz2ELLm7ggGeDRoSz6yqTlKWjLC/1iu17vl
X-Received: by 2002:a2e:99cd:0:b0:2af:237b:ced4 with SMTP id l13-20020a2e99cd000000b002af237bced4mr7814528ljj.9.1686747881455;
        Wed, 14 Jun 2023 06:04:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Q4pNRr/ftT2xw6lwh+c2kulFoSqPM1beDeTSeIjq58zZyjtnJ4dAV9sBbe9SVY0kvcZ3uIzxvkdyD73UfoJ0=
X-Received: by 2002:a2e:99cd:0:b0:2af:237b:ced4 with SMTP id
 l13-20020a2e99cd000000b002af237bced4mr7814505ljj.9.1686747881025; Wed, 14 Jun
 2023 06:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <87sfb1oz13.fsf@meer.lwn.net>
 <8f27ad5f-9a9c-3db0-a934-88e1810974f3@digikod.net> <CACT4oue7DgUf+65yat+6t9VrSji1N0njxunObHbRzfjMCAPmYQ@mail.gmail.com>
 <CAMZ6RqJ66wxVAcveVunQ3W6sYihQM43Hi44D7TAee_nUPk+ZXA@mail.gmail.com>
In-Reply-To: <CAMZ6RqJ66wxVAcveVunQ3W6sYihQM43Hi44D7TAee_nUPk+ZXA@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Wed, 14 Jun 2023 15:04:29 +0200
Message-ID: <CACT4ouc23BYWNBrE7w0a8Huy5hrhaix3=0P3kuXFQhwk_uib1g@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
        danny@kdrag0n.dev, masahiroy@kernel.org, jgg@nvidia.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        linux@rasmusvillemoes.dk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 2:55=E2=80=AFPM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
>
> On Wed. 14 Jun. 2023 at 20:40, =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com=
> wrote:
> > On Fri, Jun 9, 2023 at 3:23=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > On 09/06/2023 09:50, Jonathan Corbet wrote:
> > > > =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com> writes:
> > > >
> > > >> EditorConfig is a specification to define the most basic code form=
atting
> > > >> stuff, and it's supported by many editors and IDEs, either directl=
y or
> > > >> via plugins, including VSCode/VSCodium, Vim, emacs and more.
> > > >>
> > > >> It allows to define formatting style related to indentation, chars=
et,
> > > >> end of lines and trailing whitespaces. It also allows to apply dif=
ferent
> > > >> formats for different files based on wildcards, so for example it =
is
> > > >> possible to apply different configs to *.{c,h}, *.py and *.rs.
> > > >>
> > > >> In linux project, defining a .editorconfig might help to those peo=
ple
> > > >> that work on different projects with different indentation styles,=
 so
> > > >> they cannot define a global style. Now they will directly see the
> > > >> correct indentation on every fresh clone of the project.
> > > >>
> > > >> See https://editorconfig.org
> > > >>
> > > >> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> > > >> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> > > >> Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> > > >
> > > > So I must confess to still being really nervous about installing a =
file
> > > > that will silently reconfigure the editors of everybody working on =
the
> > > > kernel source; I wish there were a straightforward way to do this a=
s an
> > > > opt-in thing.  We're talking about creating a flag-day behavioral c=
hange
> > > > for, potentially, thousands of kernel developers.  Something tells =
me
> > > > that we might just hear from a few of them.
> > > >
> > > > I wonder if we should, instead, ship a file like this as something =
like
> > > > Documentation/process/editorconfig, then provide a "make editorconf=
ig"
> > > > command that installs it in the top-level directory for those who w=
ant
> > > > it?
> > > >
> > > > Or perhaps I'm worrying too much?
> > >
> > > This is a legitimate concern. :)
> > >
> > > A safe approach would be to rename the ".editorconfig" file to someth=
ing
> > > like ".editorconfig.default" and create ".editorconfig" symlinks in a=
ll
> > > (parent) directories where enforcing this rules don't change anything
> > > because the children files are already correctly formatted. Again, a
> > > script (provided in another patch) to check and potentially update su=
ch
> > > links would be useful.
> > >
> >
> > I can't think of an easy way to create that script. Formatting is done
> > by each editor using the rules from .editorconfig, but I didn't find
> > any available good script or tool to check if a file complies or not.
> > Creating that script is not trivial.
> >
> > I neither think it is good to enable it for some folders and not for
> > others: developers will be surprised of having assistance in some
> > files and not in others, I would be bothered with such inconsistency.
> >
> > Right now I see 2 possibilities:
> > - Provide an .editorconfig.default so those that want to use it, can
> > do it. But I wouldn't mess with cherry-picking directories that
> > already complies and those that don't, just the developer chooses to
> > use it or not, and that's all.
> > - Provide an .editorconfig directly, and those that don't want to use
> > it, either disable it in their editors or manually delete the file.
> >
> > Please tell me what approach you prefer.
>
> Personally, I vote for the latter. My honest opinion is that we are
> putting too much consideration into the risk of rejections.

I completely agree.

> =C3=8D=C3=B1igo previously stated that editors such as Kate can not opt o=
ut. I
> think that the reason is simply that no one has complained about it so
> far. I did some research on the internet with the keyword "kate
> disable editorconfig", and nothing  relevant appeared. A deeper
> research made me found this:

I have not "complained", but I have filled a request just today, that
I think won't reach far: https://bugs.kde.org/show_bug.cgi?id=3D471008

>   KatePart has support for reading configurations from
>   .editorconfig files, when the editorconfig library is
>   installed. KatePart automatically searches for a .editorconfig
>   whenever you open a file. It gives priority to .kateconfig
>   files, though.
>
> source: https://docs.kde.org/stable5/en/kate/katepart/config-variables.ht=
ml
>
> So it appears that for Kate, installing the editorconfig lib is a
> prerequisite. I think it falls in the opt-in category.

I'm not 100% sure, but I think that this is a requisite at build time.
So unless you build Kate from source, it will be built-in without
opt-out choice.

>
> Is there really an editor with default opt-in and no options to
> opt-out? I doubt...

Kate is the only one I have seen so far, but it's difficult to know.

> I really think we should have the .editorconfig at the root and for
> the rare edge cases where the user really wants to opt-out, I
> sincerely believe that there will be solutions. I have seen many
> projects using it and I do not recall push backs or complaints.
>


--=20
=C3=8D=C3=B1igo Huguet

