Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4487F6D2D7D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 03:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjDAB6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 21:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjDAB5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 21:57:53 -0400
X-Greylist: delayed 167 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Mar 2023 18:55:56 PDT
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D161BF5D;
        Fri, 31 Mar 2023 18:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680313641; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=e872dxYKwpEmkU7ojBV5oxWY5yPEVsfRppSkHWLXyxK2QRHALoTZ9ES6HSu0fkI63hh9IOHCYdBwTS+ZbV3+Zls/3GA3nO3hcXl2iwSghOjUxIyJB7J0KVAyoSIes/wZwCZms0/cpoarR9COjb43mAeXnzLWeCHMbajgc4zEIsY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1680313641; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=S+zGGBqMP5BV/39K5ihbzESIqXi6/hEN1mEtg1ES/40=; 
        b=btAeaJbnSX/otV9mzt0oRQCU3prXUl72yptb7/sh1Rrl+y5PyRWVjtijnSRkb0rbpdnfco6kN+279LU0EcEzyRo5BGMA2nO840LEOWEg21t6GbsNdQjSf/bjTBAOYBdTfyUNPAVSNfb3ULDG3e3CuyskO3jjDA0PU6jWsoJES5A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1680313641;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=S+zGGBqMP5BV/39K5ihbzESIqXi6/hEN1mEtg1ES/40=;
        b=UEXpHn7Z+mCjHatAbJ0EA4GpqEOoPHeQOAUlyvlwbEosnOLM6kNtXZ5N2bV2ZanW
        isQtmIrTPnWFFUtF/Y9pg4r5PEyaECLlf5/XHGVjA+QObak+fM3wcVGtNDAVk2cgnOb
        B8pu/N9Ybs16FU1NHih8uOiB3KMgSfSEtNDRa2so=
Received: from edelgard.fodlan.icenowy.me (120.85.97.183 [120.85.97.183]) by mx.zohomail.com
        with SMTPS id 1680313639213673.7042963583667; Fri, 31 Mar 2023 18:47:19 -0700 (PDT)
Message-ID: <40cdea465fef49a8a337b48e2a748138c66a08eb.camel@icenowy.me>
Subject: Re: [PATCH v7 0/6] RISC-V non-coherent function pointer based CMO +
 non-coherent DMA support for AX45MP
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor Dooley <conor@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date:   Sat, 01 Apr 2023 09:47:05 +0800
In-Reply-To: <0d5590e4-e78b-4197-bf17-9de54466470d@spud>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
         <b2dcda17-5850-47c1-94bc-4ca87f900581@spud>
         <CA+V-a8s+=OY6CX4XTUwyAE9b=rdJZZfgAaY2nU+6aqnu=X9nxQ@mail.gmail.com>
         <0d5590e4-e78b-4197-bf17-9de54466470d@spud>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-03-31=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 21:15 +0100=EF=BC=
=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Mar 31, 2023 at 08:09:16PM +0000, Lad, Prabhakar wrote:
> > Hi Conor,
> >=20
> > On Fri, Mar 31, 2023 at 7:05=E2=80=AFPM Conor Dooley <conor@kernel.org>
> > wrote:
> > >=20
> > > On Thu, Mar 30, 2023 at 09:42:11PM +0100, Prabhakar wrote:
> > >=20
> > > > - This series requires testing on Cores with zicbom and T-Head
> > > > SoCs
> > >=20
> > > I don't actually know if there are Zicbom parts, may need to test
> > > that
> > > on QEMU.
> > > I had to revert unrelated content to boot, but my D1 NFS setup
> > > seems to
> > > work fine with these changes, so where it is relevant:
> > > Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-
> > > kicking on D1
> > >=20
> > Thank you for testing this. By any chance did you compare the
> > performance?
>=20
> No, just tyre kicking. Icenowy had some benchmark for it IIRC, I
> think
> mining some coin or w/e. +CC them.

I previously tested the function pointer based CMO, it do not affect
the performance beyond the measurement error. Maybe it's because CMO
operations are only done at the start and end of DMA operations.

My previous test system is LiteX + OpenC906.
