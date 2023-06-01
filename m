Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5029171A050
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjFAOhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjFAOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDCE7A;
        Thu,  1 Jun 2023 07:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12BDE645AE;
        Thu,  1 Jun 2023 14:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766AFC433D2;
        Thu,  1 Jun 2023 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685630184;
        bh=q1nm3XJmvtIncOu+ub6wBefta37W073Fq2RfF3BrwDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LE40csoZczJkWldp40THH+Zdkrug4V3qCiiGTMCHovAP5L53U7rCfGoH7brYaYPLu
         pTRgmznANKlibPSIjoOc3ePcv+AkSLvEVMmo/FOFoTuvkABUbt2wzvU0LhJbaTpyjR
         8wdfk6GFIFQhzdvOJa3Kxwwzz22Y316Quw8oQpqbw4ipd4wfm+yNJNVFZe/eUIX0gO
         pr/hpnjSsK5wCd5ECoe4WviYL0qA9D2kItgny4/NOxbl1/lWlM93zGuQq/LBndfqsS
         1ZyYaOW92/x4Rs5pHszq/9XGftSXTnv/h47DPhD34prD2ih8aUE6eWeHZZ9F2FPiaz
         x7d/oDSVI0SJA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-39810ce3e13so736485b6e.2;
        Thu, 01 Jun 2023 07:36:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDzfHNJzVLMjQ+LMGQIq6X4beW5hEeZ6V0uf/WBwxqydozoBhkNE
        T91+Jm2LN3bt35J8WBs5EK7KpqxhJvCjoTohFEo=
X-Google-Smtp-Source: ACHHUZ5pUe+/Kf89/ly7ZacrZOuVJ/6VUnojFj9HTrAI35BR4gk4B4HGEQvavxSygBDSsGq2RMFOP/CbSCp/LJOlihI=
X-Received: by 2002:a05:6808:150a:b0:398:34b9:5200 with SMTP id
 u10-20020a056808150a00b0039834b95200mr9477506oiw.51.1685630183791; Thu, 01
 Jun 2023 07:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230601121001.1071533-1-masahiroy@kernel.org>
 <20230601121001.1071533-8-masahiroy@kernel.org> <CAMj1kXFJOHsgopUOR7+jvC8s6bvSCZ3XAkQM1FbnZ8Qj6azvQA@mail.gmail.com>
In-Reply-To: <CAMj1kXFJOHsgopUOR7+jvC8s6bvSCZ3XAkQM1FbnZ8Qj6azvQA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 1 Jun 2023 23:35:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATDJmh1aas86YW4yrG_8Rqgz7r82NwaPj1x5c7tg-d-jg@mail.gmail.com>
Message-ID: <CAK7LNATDJmh1aas86YW4yrG_8Rqgz7r82NwaPj1x5c7tg-d-jg@mail.gmail.com>
Subject: Re: [PATCH 7/7] modpost: detect section mismatch for R_ARM_REL32
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Thu, Jun 1, 2023 at 9:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Thu, 1 Jun 2023 at 14:10, Masahiro Yamada <masahiroy@kernel.org> wrote=
:
> >
> > For ARM, modpost fails to detect some types of section mismatches.
> >
> >   [test code]
> >
> >     .section .init.data,"aw"
> >     bar:
> >             .long 0
> >
> >     .section .data,"aw"
> >     .globl foo
> >     foo:
> >             .long bar - .
> >
> > It is apparently a bad reference, but modpost does not report anything.
> >
> > The test code above produces the following relocations.
> >
> >   Relocation section '.rel.data' at offset 0xe8 contains 1 entry:
> >    Offset     Info    Type            Sym.Value  Sym. Name
> >   00000000  00000403 R_ARM_REL32       00000000   .init.data
> >
> > Currently, R_ARM_REL32 is just skipped.
> >
> > Handle it like R_ARM_ABS32.
>
> OK, so the reason we can handle these in the same way is because we
> never calculate the resulting value, right? Because that value would
> be different for these cases.

Right.

'- loc' is unnecessary here because modpost never calculates the
resulting instruction.

modpost wants to know the location of the referenced symbol.
(the offset from the start of the section).

For the same reason, I omitted '- loc' for
PC-relative ones such as R_ARM_CALL, R_ARM_JUMP24, etc.







--
Best Regards

Masahiro Yamada
