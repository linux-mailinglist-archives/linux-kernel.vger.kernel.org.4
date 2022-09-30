Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46155F05AF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiI3HZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiI3HZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:25:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A94713C846
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:25:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mf1wm6SD8z4x1V;
        Fri, 30 Sep 2022 17:25:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1664522747;
        bh=vldn3sCX6fLDQTDH63JsyZiUXyqsjpGMojYXIgEPshU=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=eG0A5f5SymRiSEQGqQ5aIP0vjmM5RtTOlCpAEM55fviuoC5HLicGq8JkNhJhEzoRt
         O9pInta3f1O79v8QsJkinR/VhUq5hCWO6nKtxdktUw0UVZHfU1LEwT4G6AOyIIM/aY
         wZzW9/ky/Qh84lH2yqxXCSoUgjZNWCpieKH4yOplyS6aEcvFz90O2bCi1TkAukuqo8
         ngKyrscdFJ6kuI2TvxV5rXT2vr0/ZEhcjX4XHzLgEyjXrD5w/r/NO25gVal0bFDMv6
         zMkWkClrQURX+e1M3axJFoJxnV1zaFKoLZv82357MZDMiHKaC2qt6vQaWcnnXEmUXq
         rKkYiLAi5DgaA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        ruanjinjie <ruanjinjie@huawei.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "Julia.Lawall@inria.fr" <Julia.Lawall@inria.fr>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] powerpc/mpic_msgr: fix cast removes address space
 of expression warnings
In-Reply-To: <4d3b7f83-498e-deb2-ce2a-c17d4b22a078@csgroup.eu>
References: <20220901085416.204378-1-ruanjinjie@huawei.com>
 <4d3b7f83-498e-deb2-ce2a-c17d4b22a078@csgroup.eu>
Date:   Fri, 30 Sep 2022 17:25:39 +1000
Message-ID: <87sfk9pbm4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 01/09/2022 =C3=A0 10:54, ruanjinjie a =C3=A9crit=C2=A0:
>> [Vous ne recevez pas souvent de courriers de ruanjinjie@huawei.com. D=C3=
=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutSend=
erIdentification ]
>>=20
>> When build Linux kernel, encounter the following warnings:
>>=20
>> ./arch/powerpc/sysdev/mpic_msgr.c:230:38: warning: cast removes address =
space '__iomem' of expression
>> ./arch/powerpc/sysdev/mpic_msgr.c:230:27: warning: incorrect type in ass=
ignment (different address spaces)
>>=20
>> The data type of msgr->mer and msgr->base are 'u32 __iomem *', but
>> converted to 'u32 *' and 'u8 *' directly and cause above warnings, now
>> recover their data types to fix these warnings.
>
> I think the best would be to change MPIC_MSGR_MER_OFFSET to 0x40 and=20
> then drop the casts completely:
>
> 	msgr->mer =3D msgr->base + MPIC_MSGR_MER_OFFSET;

Or:

#define MPIC_MSGR_MER_OFFSET    (0x100 / sizeof(u32))

To document that it's 0x100 bytes, but the the offset is in units of u32.

cheers
