Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818EA5BE727
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiITNdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiITNda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:33:30 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC1856B8C;
        Tue, 20 Sep 2022 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1663680802; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1czWZauFxNtX7yu8h4BjguhMKq0iDi8NktR4AukipiQ=;
        b=n46staB1GBYhjWfq1N9F6myYR2vdoXdTj2V6+MQWPBI+mdAopEqZN5jDHIMi8eDgrZpupY
        IqqJU+2W6AHKBftMB++SKoiQaIIm/GCh0KR5UVPqlLsnwkPGUk2bXyusyTWACpeFYt7S8D
        ke9VnSKXTAzjAjKLq1bYFW8HaOBHfN4=
Date:   Tue, 20 Sep 2022 14:33:13 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Usefulness of CONFIG_MACH_JZ47*
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        MIPS Creator CI20 Development 
        <mips-creator-ci20-dev@googlegroups.com>
Message-Id: <DBGIIR.8W0JWG83D6FE2@crapouillou.net>
In-Reply-To: <F21B5D44-94D8-4BDB-BB34-9CBFC5F2B891@goldelico.com>
References: <af10570000d7e103d70bbea590ce8df4f8902b67.1661330532.git.christophe.jaillet@wanadoo.fr>
        <UC07HR.REF39SO0Y5PG2@crapouillou.net>
        <CDEACE3D-5433-457B-AF77-E41F39A04CA4@goldelico.com>
        <H34IIR.IGTU7CQ36OZK3@crapouillou.net>
        <F21B5D44-94D8-4BDB-BB34-9CBFC5F2B891@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar., sept. 20 2022 at 14:31:38 +0200, H. Nikolaus Schaller=20
<hns@goldelico.com> a =E9crit :
> Hi Paul,
>=20
>>  Am 20.09.2022 um 11:09 schrieb Paul Cercueil <paul@crapouillou.net>:
>>=20
>>  Hi Nikolaus,
>>=20
>>  Le mar., sept. 20 2022 at 08:31:30 +0200, H. Nikolaus Schaller=20
>> <hns@goldelico.com> a =E9crit :
>>>  Hi Paul,
>>>  it seems as if there aren't many places left over where the=20
>>> MACH_JZ47* configs are still in use:
>>>  drivers/char/hw_ramdom/Kconfig
>>>  drivers/clk/ingenic/Kconfig
>>>  drivers/gpu/drm/ingenic/Kconfig
>>>  drivers/pinctrl/pinctrl-ingenic.c
>>>  Is it possible to get rid of them and just have=20
>>> CONFIG_MACH_INGENIC_GENERIC?
>>>  This might simplify my defconfig for multiple machines.
>>=20
>>  CONFIG_MIPS_GENERIC_KERNEL=3Dy
>=20
> This breaks compilation for me, e.g.
>=20
> arch/mips/mm/cache.c:203:6: error: 'cpu_has_tx39_cache' undeclared=20
> (first use in this function)

v6.0-rc does not have 'cpu_has_tx39_cache' anywhere in that file, or in=20
arch/mips/ for that matter. It was removed in v5.18.

And a v5.17 kernel compiles fine here with these options enabled. So=20
it's a problem on your side, I guess.

>>  CONFIG_BOARD_INGENIC=3Dy
>=20
> This config option does not exist (at least in v6.0-rc). Probably you=20
> refer to CONFIG_INGENIC_GENERIC_BOARD.

No, I do not, and yes, it exists.

> As far as I see, this does not choose to build any device tree blob.
>=20
> I tried some patch to get the .dtb built, but the resulting kernel=20
> does not show any activity.
>=20
> If I e.g. switch back from CONFIG_INGENIC_GENERIC_BOARD=3Dy to=20
> CONFIG_JZ4780_CI20=3Dy the kernel works.

Because in the first case you build a generic kernel, which does not=20
embed any .dtb, and you are responsible for providing the kernel with=20
the blob at boot time; while if you build with CONFIG_JZ4780_CI20=3Dy it=20
embeds the .dtb inside the kernel.

You can embed the .dtb into the generic kernel at compile-time too,=20
have a look at "Kernel type -> Kernel appended dtb support." Not sure=20
why you'd want that for a generic kernel, though.

>>=20
>>  Then you can support all Ingenic-based boards alongside other MIPS=20
>> boards.
>=20
> Yes, I know, but why are the MACH_JZ47* not replaced by=20
> CONFIG_MACH_INGENIC_GENERIC if they are almost unused or completely=20
> removed?

They *are* used.

> BTW: there are also seems to be some board specific CONFIGs in=20
> processor specific code (e.g. CONFIG_JZ4780_CI20 in irqchip code).

rgrep CI20 drivers/irqchip/

returns nothing for me.

> So selecting a MACH is not sufficient to get these features.
>=20
> All this looks a little fragile and incomplete... Maybe if I find=20
> some time (which is unfortunately quite unlikely) I can propose some=20
> fixes.

It is not "fragile and incomplete", it works as intended, and it's a=20
feature I use often.

-Paul


