Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5909E5F561F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJEOHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJEOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:07:18 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80587694E;
        Wed,  5 Oct 2022 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1664978835;
        bh=ZECf7KU7iOtafZ/0dVIWw4XP10VzhUl+beIW14xajGs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EuwaX8ZTGMEpX9G1rX17oNj+i9mW50v02g13o4NKOGgKIZ9wtrvAemwbG4JRj/l3V
         /LopbJT0lM72TxG2x2lYsjqi8Rz4+W6GId/7KRK8vv783Pq6cil46bDLfglz1/Jci+
         k88H1cZWZZU24AiuCCuMHs9TMIeJVm072nJvHa8A=
Received: from [IPv6:240e:358:1191:4a00:dc73:854d:832e:3] (unknown [IPv6:240e:358:1191:4a00:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id EB82165C3E;
        Wed,  5 Oct 2022 10:07:09 -0400 (EDT)
Message-ID: <ad45e0e0409b07ecb719743e4febb2853143986d.camel@xry111.site>
Subject: Re: build failure of next-20221005 due to 4078ec1ef5ed ("LoongArch:
 Use TLB for ioremap()")
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 05 Oct 2022 22:06:56 +0800
In-Reply-To: <CADVatmOmtd0jfzNvpyMiQnN0nUn3qZFjLnTjxrn7km3p-grwpQ@mail.gmail.com>
References: <Yz1t6rPLOzKT8Id+@debian>
         <CAAhV-H7FoDEEtqF_ZOwTGPeGK-4wpzsxEqvO+iuq=KpEuDUofQ@mail.gmail.com>
         <CADVatmOmtd0jfzNvpyMiQnN0nUn3qZFjLnTjxrn7km3p-grwpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

Try:

#define iounmap(addr) ((void)(addr))

This is how we normally silence an unused variable or parameter warning.
Not sure if the kernel uses the same convention though.

On Wed, 2022-10-05 at 13:54 +0100, Sudip Mukherjee wrote:
> On Wed, Oct 5, 2022 at 1:30 PM Huacai Chen <chenhuacai@kernel.org>
> wrote:
> >=20
> > Hi, Sudip,
> >=20
> > This seems a false positive. When the implementation of iounmap() is
> > empty (but this is completely legal I think), these drivers will
> > cause
> > "unused variable error".
>=20
> And that error will fail the build as allmodconfig will have
> CONFIG_WERROR=3Dy.
>=20

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
