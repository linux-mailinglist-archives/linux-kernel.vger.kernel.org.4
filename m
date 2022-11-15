Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7B62987D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbiKOMR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbiKOMRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:17:08 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76301FF8E;
        Tue, 15 Nov 2022 04:17:07 -0800 (PST)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2AFCGmEO014751;
        Tue, 15 Nov 2022 21:16:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2AFCGmEO014751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668514609;
        bh=DzEq60ykSG5bYhq7I51xfa+aMo2N2iDeazHRRzbLNkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UJBM0I1frGShIVdDRgoEwA77I0IMhI1KAhHzd6XYrG7Fh3dXbMRTXsODnocs/yTJ3
         vXvbyGFMm0ov26HgA0TADMwQ4BSJbe9en/xcr50YvDOqmWAfZErcdwNg0p/NhI2eiH
         lm5rsZtCEn7sSqqX8C1y0Jtk3cfItKIz3X/9RUfWGVoxW/UHguSiq2nS9VkSXMTpnl
         pSHVXzbVAzPvBVk+96+PdVALgQxvxMA5NQtiKhxftOrOEyH+YPtVcWe0D+JoVmmD9y
         tXVIX1hREoPghlBijQ1TztIXNnljPSKn1yGHkm2Ndot43BIYZxZufbU5RwkvewmHuE
         HjsLqgR4br6Ig==
X-Nifty-SrcIP: [209.85.160.51]
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13bd19c3b68so15996862fac.7;
        Tue, 15 Nov 2022 04:16:49 -0800 (PST)
X-Gm-Message-State: ANoB5pkshMViMSfIDyNbAF+Uk+XKrp1zaWH6EP9KRD9Ryowyi38SG0Br
        fCgkHOuMaSM1CnvvS8IcLSxj6HBQV7+5wwmcl5s=
X-Google-Smtp-Source: AA0mqf6mmAah35Of30QCc4t3crf2yofcTDeglomR5PcNgtqbYn0wAg4XKxQcg/Q7T7cBiJ/FmPWFuuanDNj1TiDKxIM=
X-Received: by 2002:a05:6870:538d:b0:13b:a31f:45fd with SMTP id
 h13-20020a056870538d00b0013ba31f45fdmr104263oan.194.1668514608102; Tue, 15
 Nov 2022 04:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20221114174617.211980-1-masahiroy@kernel.org> <Y3La2mwCgD8r/5PI@dev-arch.thelio-3990X>
In-Reply-To: <Y3La2mwCgD8r/5PI@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 15 Nov 2022 21:16:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNARCM=rUm8mA8GRQ7ufeyfneGf4OEvHmESKt=zuxs2KrHw@mail.gmail.com>
Message-ID: <CAK7LNARCM=rUm8mA8GRQ7ufeyfneGf4OEvHmESKt=zuxs2KrHw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: revive parallel execution for .tmp_initcalls.lds rule
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 9:18 AM Nathan Chancellor <nathan@kernel.org> wrote=
:
>
> On Tue, Nov 15, 2022 at 02:46:17AM +0900, Masahiro Yamada wrote:
> > Prior to commit 5d45950dfbb1 ("kbuild: move vmlinux.o link to
> > scripts/Makefile.vmlinux_o"), jobserver-exec was invoked from the shell
> > script, link-vmlinux.sh. It can get access to the jobserver because
> > Makefile adds '+' prefix, as in:
> >
> >     +$(call if_changed_dep,link_vmlinux)
> >
> > Since 5d45950dfbb1, jobserver-exec is invoked from Makefile, but the
> > '+' prefix is missing, hence jobserver-exec has no access to the
> > jobserver.
> >
> > Fixes: 5d45950dfbb1 ("kbuild: move vmlinux.o link to scripts/Makefile.v=
mlinux_o")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> At least it doesn't seem like compile times were majorly affected. I
> benchmarked arm64 allmodconfig (worst case scenario with ThinLTO):


Ah, sorry.

./scripts/generate_initcall_order.pl always runs in two threads
(the parent and a single child) because it is given only
one argument (vmlinux.a).

So, using jobserver-exec is meaningless.
Also, the code for parallel execution control in
./scripts/generate_initcall_order.pl is meaningless.



BTW, allmodconfig is not the worst case because most of the objects
go into modules instead of vmlinux.

allyesconfig would add more symbols to vmlinux although I did not test it.







>
> Benchmark 1: 094226ad94f4 ("Linux 6.1-rc5")
>   Time (mean =C2=B1 =CF=83):     899.036 s =C2=B1  1.133 s    [User: 4931=
4.495 s, System: 3840.796 s]
>   Range (min =E2=80=A6 max):   898.118 s =E2=80=A6 900.302 s    3 runs
>
> Benchmark 2: 0f45cbb5399b ("kbuild: revive parallel execution for .tmp_in=
itcalls.lds rule")
>   Time (mean =C2=B1 =CF=83):     898.482 s =C2=B1  0.152 s    [User: 4932=
9.703 s, System: 3836.408 s]
>   Range (min =E2=80=A6 max):   898.306 s =E2=80=A6 898.584 s    3 runs
>
> Summary
>   '0f45cbb5399b ("kbuild: revive parallel execution for .tmp_initcalls.ld=
s rule")' ran
>     1.00 =C2=B1 0.00 times faster than '094226ad94f4 ("Linux 6.1-rc5")'
>
> > ---
> >
> >  scripts/Makefile.vmlinux_o | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> > index 0edfdb40364b..ae52d3b3f063 100644
> > --- a/scripts/Makefile.vmlinux_o
> > +++ b/scripts/Makefile.vmlinux_o
> > @@ -19,7 +19,7 @@ quiet_cmd_gen_initcalls_lds =3D GEN     $@
> >
> >  .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
> >               vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
> > -     $(call if_changed,gen_initcalls_lds)
> > +     +$(call if_changed,gen_initcalls_lds)
> >
> >  targets :=3D .tmp_initcalls.lds
> >
> > --
> > 2.34.1
> >



--
Best Regards

Masahiro Yamada
