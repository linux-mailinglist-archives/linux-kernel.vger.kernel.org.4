Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B9B65A2B2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 05:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiLaEgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 23:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLaEgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 23:36:37 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B13713F81
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 20:36:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672461372; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=JQdUWp1o75bn5Cm6C7l8IRKkaAqi68sc936SBl6G1IK4mNvCmGGe/lPLTCja8CWImORj2rOE0TowDYRu/AGGfHyYyDlQduBx00MeCWbHJLkAEYoG6sK5hpG7G0ZFD9Pc/HUwd+OftRioA9bKt7NLhm4niKFF5ZV53GeWwWh0Qio=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1672461372; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UZUtlTKpQdPfubcQzf2LyoQlsOR8ISvYrlk080SW5kw=; 
        b=VNykuMGWFgnD0l92ENbYSiYzHz3Hn2xd2Wqxp30ctE6hHvcp3KSwbala7ssa7VoNe6o1MXE/hoHkFI+eZ40V/ctlXQ96VahywGYcGfIUtKzC9OtMaUKaM9FD9VaJ9g0eA961RoBSO0rCHXxS7C0D+aaS3YDiOMJAHXl12Q69Osg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672461372;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=UZUtlTKpQdPfubcQzf2LyoQlsOR8ISvYrlk080SW5kw=;
        b=Z3C94yCn3uAtN7rcoUjw4ddTfVUjfEroMCME1T4QtV0QWBmFJaPJlqr3CysNZB7C
        kwXV5U1l6R5QdCnc7y8eHmkBqIgnKffQvTfNAZwBSt0ey4MDnnGvNP1QlHKPCZcCYSl
        Sz7rtFnSzGHFVnf1+Is5f6nAArDfCAKQ/pQE6H/4=
Received: from edelgard.fodlan.icenowy.me (120.85.97.2 [120.85.97.2]) by mx.zohomail.com
        with SMTPS id 1672461369384205.65724335826928; Fri, 30 Dec 2022 20:36:09 -0800 (PST)
Message-ID: <5818a83e644eb9c868d4cf65117983e08ba1c17f.camel@icenowy.me>
Subject: Re: [PATCH 1/2] riscv: errata: fix T-Head dcache.cva encoding
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sat, 31 Dec 2022 12:36:04 +0800
In-Reply-To: <Y69iNMQ60gXYkKus@curiosity>
References: <20221227020258.303900-1-uwu@icenowy.me>
         <CAJF2gTSGvEnTqEqR9f+zU8T3VS8FoCtsgSk=9hz6cWxAL630zQ@mail.gmail.com>
         <Y69iNMQ60gXYkKus@curiosity>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-12-31=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 01:12 +0300=EF=BC=
=8CSergey Matyukevich=E5=86=99=E9=81=93=EF=BC=9A
> > > The dcache.cva encoding shown in the comments are wrong, it's for
> > > dcache.cval1 (which is restricted to L1) instead.
> > >=20
> > > Fix this in the comment and in the hardcoded instruction.
> > >=20
> > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > ---
> > > The code is tested on a LiteX SoC with OpenC906 core, and it
> > > successfully boots to Systemd on a SD card connected to
> > > LiteSDCard.
> > >=20
> > > This change should be not noticable on C906, but on multi-core
> > > C910
> > > cluster it should fixes something. Unfortunately TH1520 seems to
> > > be not
> > > so ready to test mainline patches on.
> > >=20
> > > =C2=A0arch/riscv/include/asm/errata_list.h | 4 ++--
> > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/include/asm/errata_list.h
> > > b/arch/riscv/include/asm/errata_list.h
> > > index 4180312d2a70..605800bd390e 100644
> > > --- a/arch/riscv/include/asm/errata_list.h
> > > +++ b/arch/riscv/include/asm/errata_list.h
> > > @@ -102,7 +102,7 @@ asm
> > > volatile(ALTERNATIVE(=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0 * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > > =C2=A0 *=C2=A0=C2=A0 0000001=C2=A0=C2=A0=C2=A0 01001=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 rs1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 00000=C2=A0 0001011
> > > =C2=A0 * dcache.cva rs1 (clean, virtual address)
> > > - *=C2=A0=C2=A0 0000001=C2=A0=C2=A0=C2=A0 00100=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 rs1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 00000=C2=A0 0001011
> > > + *=C2=A0=C2=A0 0000001=C2=A0=C2=A0=C2=A0 00101=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 rs1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 00000=C2=A0 0001011
> > > =C2=A0 *
> > > =C2=A0 * dcache.cipa rs1 (clean then invalidate, physical address)
> > > =C2=A0 * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > > @@ -115,7 +115,7 @@ asm
> > > volatile(ALTERNATIVE(=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0 *=C2=A0=C2=A0 0000000=C2=A0=C2=A0=C2=A0 11001=C2=A0=C2=A0=C2=
=A0=C2=A0 00000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 00000=C2=A0 0001011
> > > =C2=A0 */
> > > =C2=A0#define THEAD_inval_A0 ".long 0x0265000b"
> > > -#define THEAD_clean_A0 ".long 0x0245000b"
> > > +#define THEAD_clean_A0 ".long 0x0255000b"
> > > =C2=A0#define THEAD_flush_A0 ".long 0x0275000b"
> > > =C2=A0#define THEAD_SYNC_S=C2=A0=C2=A0 ".long 0x0190000b"
>=20
> Nice catch ! I experimented with T-Head RVB-ICE board on the up-to-
> date
> upstream kernel, using device tree and some other bits from the
> vendor
> kernel [1]. Without this patch, emmc on this board does not work
> since
> noncoherent dma sync operations use incorrect 'clean' instruction.
> Applying this patch fixes emmc operations, so

Thanks for testing on C910! I don't think this patch will make a
significant difference on C906, so it's valuable!

>=20
> Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
>=20
> [1] https://github.com/T-head-Semi/linux/tree/linux-5.10.4
>=20
> Regards,
> Sergey

