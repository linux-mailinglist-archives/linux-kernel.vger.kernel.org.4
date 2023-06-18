Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7EB7346DD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjFRPv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 11:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFRPv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 11:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F01E4F;
        Sun, 18 Jun 2023 08:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B19F460BC5;
        Sun, 18 Jun 2023 15:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FD1C433CA;
        Sun, 18 Jun 2023 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687103486;
        bh=V3ot2K88MpwMz51CvN4r3BLcrOzGzi0eMF77QypVbpU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MEIBUVXDFCisCsR4stQQrmNAk+Y7E+e470RA1B3CGZVf8ZTpQwyivA+pZML+i7Fux
         ItlxQNrbqTYdIVuVlqeuxzkd2txTUE2j97ZcytTVUqyC0NnWCSAfC1CMcjQUWqwkQt
         b11LXV0LTfJDszA/SzUhoKRt2WwKB0pEiXc3KKnOCgMoP24HFZ8n4QnzHSCvnDEVL6
         70vLvgzdygQ2LmIiqNiMOIrS4y5BBFJ44bVzzaGLf1NviIwe4w1DbDcnDAeI/d5hhk
         NfSBoAmEtbXsAqNqil84CSCiu4oXHZUO1FPImn1VHp96FtF6QDinwvI5WDuBeKrpuZ
         lxwxObwxgeh+Q==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-55a35e2a430so1687568eaf.0;
        Sun, 18 Jun 2023 08:51:26 -0700 (PDT)
X-Gm-Message-State: AC+VfDyjjeoJdFicOPGM3NHbwEXnH7ZxmUF/+WE6JmzowABgsKpBUwQ4
        MehOh4WXuqDaijco/GNuwUDV7MIa7l09qf6LqfA=
X-Google-Smtp-Source: ACHHUZ5v3+Ga+/i8fDBpc3UI9VuOS8COU3PnHfh+EgF+Q4PXY+kM+rYPDrAUuC1ymGj6rsvWY8/beV83ydliFUvmlbY=
X-Received: by 2002:a4a:eb86:0:b0:55e:14a2:e99f with SMTP id
 d6-20020a4aeb86000000b0055e14a2e99fmr4104465ooj.9.1687103485326; Sun, 18 Jun
 2023 08:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230617153025.1653851-1-masahiroy@kernel.org> <20230617200700.GA31221@lxhi-065>
In-Reply-To: <20230617200700.GA31221@lxhi-065>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 19 Jun 2023 00:50:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATbrP4Re+-9rY9d0=Dsk-O4DasZZtV0wM7SWg3Y5eLKmQ@mail.gmail.com>
Message-ID: <CAK7LNATbrP4Re+-9rY9d0=Dsk-O4DasZZtV0wM7SWg3Y5eLKmQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: make clean rule robust against too long argument error
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 5:07=E2=80=AFAM Eugeniu Rosca <erosca@de.adit-jv.co=
m> wrote:
>
> Hello Yamada-san,
>
> Many thanks for your feedback and for your patch.
> It indeed addresses the issue I have reported in [1].
>
> On Sun, Jun 18, 2023 at 12:30:25AM +0900, Masahiro Yamada wrote:
> > Commit cd968b97c492 ("kbuild: make built-in.a rule robust against too
> > long argument error") made a build rule robust against "Argument list
> > too long" error.
> >
> > Eugeniu Rosca reported the same error occurred when cleaning an externa=
l
> > module.
> >
> > The $(obj)/ prefix can be a very long path for external modules.
>
> Confirmed. I am seeing an instance of $(obj) being 150 characters long,
> due to an out-of-tree module deeply buried in a specific Yocto build.
>
> In the current vanilla version of 'make clean' (w/o this patch), the
> $(obj) prefix is applied to each and every file being removed,
> dramatically increasing the strlen of arguments passed to 'rm -rf'.
>
> >
> > Apply a similar solution to 'make clean'.
> >
> > Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.clean | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> > index 3649900696dd..235408a44f90 100644
> > --- a/scripts/Makefile.clean
> > +++ b/scripts/Makefile.clean
> > @@ -37,8 +37,9 @@ __clean-files   :=3D $(wildcard $(addprefix $(obj)/, =
$(__clean-files)))
> >
> >  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > +# Use xargs to make this robust against "Argument list too long" error
>
> Please, correct me if I am wrong, but it looks like the magic/brilliance
> is in the 'patsubst' function, since below version also fails for me:
>
> NOK: cmd_clean =3D printf '%s ' $(__clean-files) | xargs rm -rf

Right.
Now, 'printf' (instead of 'rm') failed with the too long argument list.

GNU Make does not have the length limit, but shell does.
So, the full-path list must be passed via stdout
instead of the command line.


The comment might be confusing.

I will repeat the same comment written in scripts/Makefile.build:

  # To make this rule robust against "Argument list too long" error,
  # remove $(obj)/ prefix, and restore it by a shell command.




--=20
Best Regards
Masahiro Yamada
