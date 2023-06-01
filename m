Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6551771A081
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjFAOlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjFAOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:41:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D7118C;
        Thu,  1 Jun 2023 07:41:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 469AF64608;
        Thu,  1 Jun 2023 14:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BD2C4339B;
        Thu,  1 Jun 2023 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685630467;
        bh=fKcNy26Ot13k/n7UuJGvVszN9Le6Ytdc+ch3JGpTnm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nepBlgSuMwWPO8KXzxrAkpVSePJRt9d/4qLbEggBDOBVFe+Qf+dbJ2V0tVFbZgX5z
         wJ1FWiNARn80QP67yVBfhK6OWqAZWGC9uq2LhwP/fsp0ZDJ5nVCJA+MPqo4Q3q+yEt
         MLaMh4oM7AzCptfc4KtjPpQnKM23mMe+6N8ilwmCovQqnpADRrioKccuU9tJF37XN2
         qxh9WD6+00XsViRh+hdojT1SuW8PHkngMkbCQXXiFUd9cT9gjP/BlE7PR4GXxvLqWy
         PsrigFITXBZ7ryu2zqNZee3AxvVKAmNAt05rFfGPldzZFWXFAvhsRBjNiZ6FjqTvJA
         sDEbf1RdnYHwg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2afb2875491so12142241fa.1;
        Thu, 01 Jun 2023 07:41:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDwnFL6dL20SPNFy/TPITnKXeu059kjNYWMJiY491NrB01KKFrol
        u5duAYIef+XK+kfwArHRRgTpT5xW3upDva3k3b4=
X-Google-Smtp-Source: ACHHUZ4yo59UWvjyjGKifTNOAp2GpzUk9Bw0Ta78Yradc0BnhsIRm7sWUvBss2qlLPYn/4AjMU7EvC/uHKkYRTC6P5g=
X-Received: by 2002:a2e:7e04:0:b0:2af:231a:f9f0 with SMTP id
 z4-20020a2e7e04000000b002af231af9f0mr5136777ljc.42.1685630465613; Thu, 01 Jun
 2023 07:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230601121001.1071533-1-masahiroy@kernel.org>
 <20230601121001.1071533-8-masahiroy@kernel.org> <CAMj1kXFJOHsgopUOR7+jvC8s6bvSCZ3XAkQM1FbnZ8Qj6azvQA@mail.gmail.com>
 <CAK7LNATDJmh1aas86YW4yrG_8Rqgz7r82NwaPj1x5c7tg-d-jg@mail.gmail.com>
In-Reply-To: <CAK7LNATDJmh1aas86YW4yrG_8Rqgz7r82NwaPj1x5c7tg-d-jg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 1 Jun 2023 16:40:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHQHVy5KRmeQzDb=d1QQXZKZGy+iLk2wg5Mfp0Ap+TDMA@mail.gmail.com>
Message-ID: <CAMj1kXHQHVy5KRmeQzDb=d1QQXZKZGy+iLk2wg5Mfp0Ap+TDMA@mail.gmail.com>
Subject: Re: [PATCH 7/7] modpost: detect section mismatch for R_ARM_REL32
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 16:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Jun 1, 2023 at 9:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Thu, 1 Jun 2023 at 14:10, Masahiro Yamada <masahiroy@kernel.org> wro=
te:
> > >
> > > For ARM, modpost fails to detect some types of section mismatches.
> > >
> > >   [test code]
> > >
> > >     .section .init.data,"aw"
> > >     bar:
> > >             .long 0
> > >
> > >     .section .data,"aw"
> > >     .globl foo
> > >     foo:
> > >             .long bar - .
> > >
> > > It is apparently a bad reference, but modpost does not report anythin=
g.
> > >
> > > The test code above produces the following relocations.
> > >
> > >   Relocation section '.rel.data' at offset 0xe8 contains 1 entry:
> > >    Offset     Info    Type            Sym.Value  Sym. Name
> > >   00000000  00000403 R_ARM_REL32       00000000   .init.data
> > >
> > > Currently, R_ARM_REL32 is just skipped.
> > >
> > > Handle it like R_ARM_ABS32.
> >
> > OK, so the reason we can handle these in the same way is because we
> > never calculate the resulting value, right? Because that value would
> > be different for these cases.
>
> Right.
>
> '- loc' is unnecessary here because modpost never calculates the
> resulting instruction.
>
> modpost wants to know the location of the referenced symbol.
> (the offset from the start of the section).
>
> For the same reason, I omitted '- loc' for
> PC-relative ones such as R_ARM_CALL, R_ARM_JUMP24, etc.
>

OK makes sense - I just wanted to double check
