Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A198730F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbjFOGi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244020AbjFOGhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7256F30E9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686810945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4wlkttPOcasVDRYX1HT0XHqYNDJfm6yG6bhk7nZo7o=;
        b=ZJlZQzCx4MwBE4O8FUYvQ8BvwM3TkHT6tHQ229xjJYXbjzsnvYvWC8uWjkQm7jrJJri8en
        vdtDNlc/VU1baqFJF2Tsfi+SF6AJ0vTSVq+7HhILfbmYlX10N4MTpn2NvBsBhKDV7h6hM6
        WpL7qNLqQVAfhuLjpGwLe4/XEU1Ib0g=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-aVWubZCdNO64MUtqpU1GzQ-1; Thu, 15 Jun 2023 02:35:43 -0400
X-MC-Unique: aVWubZCdNO64MUtqpU1GzQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b448e0a667so94661fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686810942; x=1689402942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4wlkttPOcasVDRYX1HT0XHqYNDJfm6yG6bhk7nZo7o=;
        b=cpYAfKZKW4JFj61JNSZUr3ZSon5BUfet63Aqru+738EYJngc0TuyVT61u8AcWgo3rP
         E66nzN3gLjBZvj03EgiR0W8VGx6Hfrh1mgWnLY6hNmD+km5AGNgaIsSt8yOumnkTH90j
         Jg3ZibS/tv0LCBX8sTls7eVU+z5G9hp5NQKeq+GuS2Cv5oohpj9yXEplVAyLpkWimqwj
         FZo/D2jrOiXABbLOXQz7Jd3I5dJ4ApuOLwZ4sqY9cx6PcKTfnMZb6BY1vBpWVcAMNVZq
         +uL1r0S2FEIeMeze/tgP+YM1kWW3056TLB/zrrGnqGzb2k10hDP0ec55+Y+4YIdskuav
         evUA==
X-Gm-Message-State: AC+VfDyhTooqrlMckpaR9DuvCGR/3blYuJN5H6Q8D4sRQzlm3LBXtv3N
        B/HeFKvzSGq5VUkWiRAgwXvbSdU6V7eoBESevAMDGQJ1Uic21S9btjKIbZjC7ljye2u7IlMK7Jg
        VwrWdRx1A43666Az1La1ZlFhFcaiC6835fiSuPmuh
X-Received: by 2002:a2e:b04e:0:b0:2ad:b01b:d458 with SMTP id d14-20020a2eb04e000000b002adb01bd458mr8414319ljl.30.1686810942357;
        Wed, 14 Jun 2023 23:35:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6f83OZtGZDJ49SzhCci8d+5XJ8YZTzKwOqDFtlyv+wgb2h1O4LvehRyu/wZ89Hr0Q/2At4SRGj9zzxLMJWjWg=
X-Received: by 2002:a2e:b04e:0:b0:2ad:b01b:d458 with SMTP id
 d14-20020a2eb04e000000b002adb01bd458mr8414295ljl.30.1686810941918; Wed, 14
 Jun 2023 23:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <87sfb1oz13.fsf@meer.lwn.net>
 <8f27ad5f-9a9c-3db0-a934-88e1810974f3@digikod.net> <CACT4oue7DgUf+65yat+6t9VrSji1N0njxunObHbRzfjMCAPmYQ@mail.gmail.com>
 <CAMZ6RqJ66wxVAcveVunQ3W6sYihQM43Hi44D7TAee_nUPk+ZXA@mail.gmail.com>
 <CACT4ouc23BYWNBrE7w0a8Huy5hrhaix3=0P3kuXFQhwk_uib1g@mail.gmail.com> <CAMZ6RqKHTYcGfBX=RZWqzSD+PFpOoH8A_dM0vY6yp2P3Acd=Wg@mail.gmail.com>
In-Reply-To: <CAMZ6RqKHTYcGfBX=RZWqzSD+PFpOoH8A_dM0vY6yp2P3Acd=Wg@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Thu, 15 Jun 2023 08:35:30 +0200
Message-ID: <CACT4oudDKALZ0ZQPrOj2o3cRBRoaGMK_S+hQx-q4ENfv4UCtnQ@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 4:40=E2=80=AFAM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
>
> On Wed. 14 Jun. 2023 at 22:04, =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com=
> wrote:
> > On Wed, Jun 14, 2023 at 2:55=E2=80=AFPM Vincent MAILHOL <mailhol.vincen=
t@wanadoo.fr> wrote:
> > > On Wed. 14 Jun. 2023 at 20:40, =C3=8D=C3=B1igo Huguet <ihuguet@redhat=
.com> wrote:
>
> (...)
>
> > > > Right now I see 2 possibilities:
> > > > - Provide an .editorconfig.default so those that want to use it, ca=
n
> > > > do it. But I wouldn't mess with cherry-picking directories that
> > > > already complies and those that don't, just the developer chooses t=
o
> > > > use it or not, and that's all.
> > > > - Provide an .editorconfig directly, and those that don't want to u=
se
> > > > it, either disable it in their editors or manually delete the file.
> > > >
> > > > Please tell me what approach you prefer.
> > >
> > > Personally, I vote for the latter. My honest opinion is that we are
> > > putting too much consideration into the risk of rejections.
> >
> > I completely agree.
> >
> > > =C3=8D=C3=B1igo previously stated that editors such as Kate can not o=
pt out. I
> > > think that the reason is simply that no one has complained about it s=
o
> > > far. I did some research on the internet with the keyword "kate
> > > disable editorconfig", and nothing  relevant appeared. A deeper
> > > research made me found this:
> >
> > I have not "complained", but I have filled a request just today, that
> > I think won't reach far: https://bugs.kde.org/show_bug.cgi?id=3D471008
>
> Wow! That's a lot of investment on your side. Clearly, there is no
> appetite from the maintainers. But if something needs to be done
> (which I doubt), I think it should be on the editor's side rather than
> on the project using that .editorconfig file.
>
> > >   KatePart has support for reading configurations from
> > >   .editorconfig files, when the editorconfig library is
> > >   installed. KatePart automatically searches for a .editorconfig
> > >   whenever you open a file. It gives priority to .kateconfig
> > >   files, though.
> > >
> > > source: https://docs.kde.org/stable5/en/kate/katepart/config-variable=
s.html
> > >
> > > So it appears that for Kate, installing the editorconfig lib is a
> > > prerequisite. I think it falls in the opt-in category.
> >
> > I'm not 100% sure, but I think that this is a requisite at build time.
> > So unless you build Kate from source, it will be built-in without
> > opt-out choice.
>
> It seems you are right. On Ubuntu, the "kate" package actually depends
> on "libeditorconfig0", so indeed, that's a hard dependency. My bad.
>
> That said, on source based distribution, it should be configurable.
> Taking gentoo as an example, you get an editorconfig USEFLAG which
> allows to choose whether or not you enable editorconfig during the
> compilation:
>
>   https://packages.gentoo.org/packages/kde-frameworks/ktexteditor
>
> I continued my investigation. Here is the commit which adds
> editorconfig to ktexteditor (used by kate):
>
>   https://github.com/KDE/ktexteditor/commit/f9f133b6ac72dfa12bdeeab1a37c5=
e9dc9a9354e
>
> Looking at what the code does, it first walk through the absolute path
> in reverse and if it finds a .kateconfig file, it does an early
> return:
>
>   https://github.com/KDE/ktexteditor/blob/f9f133b6ac72dfa12bdeeab1a37c5e9=
dc9a9354e/src/document/katedocument.cpp#L2578
>
> This should act as a kill switch. Not tested, but adding a .kateconfig
> seems like a valid opt out method. This is consistent with the
> paragraph I quoted in my previous message:
>
>   It gives priority to .kateconfig files, though.
>
> Problem solved?

Very good catch. I have tried and adding an empty .kateconfig file
makes that .editorconfig is ignored. For me this is a simple enough
workaround. We can document it as a comment in the top of
.editorconfig file.

>
> > > Is there really an editor with default opt-in and no options to
> > > opt-out? I doubt...
> >
> > Kate is the only one I have seen so far, but it's difficult to know.
> >
> > > I really think we should have the .editorconfig at the root and for
> > > the rare edge cases where the user really wants to opt-out, I
> > > sincerely believe that there will be solutions. I have seen many
> > > projects using it and I do not recall push backs or complaints.
>


--=20
=C3=8D=C3=B1igo Huguet

