Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20187713858
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjE1HaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE1HaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4E3D9;
        Sun, 28 May 2023 00:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72C5360E9E;
        Sun, 28 May 2023 07:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D943BC433D2;
        Sun, 28 May 2023 07:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685259019;
        bh=oGy/fpG9JCLiydgHe4qcscmOq33gjRh/dp/hY2T5fDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ckh3SPGtTbB1cW25lV0oYSLn5B7ee3A8v1cJSjpi9CQC9vt8eCR7xCE0CPQW/7evT
         sZW6HBxUEfidm+KJerIB0tQQAq4omyE1DIjyUPbCUWuIpPZfnlwM9qSTMb15mDN6l2
         qHgkFf2RRomQAAA8IEUfAY+OdeKqQlDn89bcXxeRf9p3Pm8QD7hHY+bXALO59WWXU8
         ptlbWFojGvWwpAARFzrf6zgZ8iG8HIXt19zJlysmjvmWdbLuO8f4nyRJTJV5O+HHdl
         OeB9F1JzJMDrMpOJd89Z03cSSIrnevNmBNq1TYLOYhv7JGe1Mkm8YptGBrjg+io6vY
         M95/2AluusXJg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6af8127031cso938388a34.2;
        Sun, 28 May 2023 00:30:19 -0700 (PDT)
X-Gm-Message-State: AC+VfDw8nhp/6zrnBDdNBQXjVTzEUIFdMkiEdHGXVlW9Tm6rp8NT9YEJ
        wpUxK11547/IbD8O8cbQS/DUQGLFF3FJbKoxN0s=
X-Google-Smtp-Source: ACHHUZ4civ0H8UhnroTGIXb+bes32eYRy1nhys7T6Kt9aS9Ut/Yi9rwuqn1KzCDwQv925j6siaFSR2N5tUHVEEVa724=
X-Received: by 2002:a05:6870:3842:b0:19e:c953:d854 with SMTP id
 z2-20020a056870384200b0019ec953d854mr2724186oal.52.1685259019161; Sun, 28 May
 2023 00:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org>
 <20230521160426.1881124-21-masahiroy@kernel.org> <CAKwvOdmwb3a-YvA4qN6=ed1YeQY_yG0qJnboX23CjCMOH8HmMQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmwb3a-YvA4qN6=ed1YeQY_yG0qJnboX23CjCMOH8HmMQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 28 May 2023 16:29:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrzN2HR30rNM1Vx0S37X3t2b5rxELC=AVixQKrWu8y_w@mail.gmail.com>
Message-ID: <CAK7LNAQrzN2HR30rNM1Vx0S37X3t2b5rxELC=AVixQKrWu8y_w@mail.gmail.com>
Subject: Re: [PATCH v6 20/20] modpost: show offset from symbol for section
 mismatch warnings
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 3:27=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > Currently, modpost only shows the symbol names and section names, so it
> > repeats the same message if there are multiple relocations in the same
> > symbol. It is common the relocation spans across multiple instructions.
> >
> > It is better to show the offset from the symbol.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index e7561fa57478..4da96746a03b 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1135,8 +1135,8 @@ static void default_mismatch_handler(const char *=
modname, struct elf_info *elf,
> >
> >         sec_mismatch_count++;
> >
> > -       warn("%s: section mismatch in reference: %s (section: %s) -> %s=
 (section: %s)\n",
> > -            modname, fromsym, fromsec, tosym, tosec);
> > +       warn("%s: section mismatch in reference: %s+0x%x (section: %s) =
-> %s (section: %s)\n",
> > +            modname, fromsym, (unsigned int)(faddr - from->st_value), =
fromsec, tosym, tosec);
>
> Is the cast necessary if you use the %p format specifier instead of 0x%x?

No.

faddr and from->st_value are offsets from
the start of the section. They are not pointers.

%p does not make sense.






>
> >
> >         if (mismatch->mismatch =3D=3D EXTABLE_TO_NON_TEXT) {
> >                 if (match(tosec, mismatch->bad_tosec))
> > --
> > 2.39.2
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Best Regards
Masahiro Yamada
