Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7423762F123
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241921AbiKRJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiKRJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:27:20 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0B2FCC4;
        Fri, 18 Nov 2022 01:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1668763635; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcXDJLu1asVyUgEijSQXJ9DHNuMXWX+q2Hr7tq2QEPg=;
        b=a8qpL3vt4RiHX1cI7skr1iKHaLiC9Zi1RgGVDY5VDtaaUrfGM3ZniRjf/PrMWfIKibmIo7
        X//YP2bFxvbUaaWOxLKXWJW5jkP+0l8OrWS0d+iBHhtVoMd8ljRgcoM80eiQ8M9oPm8W9C
        eGA7dXx5LuymQ5Eep/++6UeKvA1iq0s=
Date:   Fri, 18 Nov 2022 09:27:05 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] mmc: jz4740: Don't change parent clock rate for some
 SoCs
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Siarhei Volkau <lis8215@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Message-Id: <59EJLR.DQ7KHQEAEUSG2@crapouillou.net>
In-Reply-To: <CAPDyKFrMqCL1-faBadVP3xB-5qiCYsyRUuOHbFZuOWfLdCXwig@mail.gmail.com>
References: <20221108045300.2084671-1-lis8215@gmail.com>
        <20221108045300.2084671-2-lis8215@gmail.com>
        <CAPDyKFrMqCL1-faBadVP3xB-5qiCYsyRUuOHbFZuOWfLdCXwig@mail.gmail.com>
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

Hi,

(Ingenic SoCs maintainer here)

Le ven. 18 nov. 2022 =E0 09:45:48 +0100, Ulf Hansson=20
<ulf.hansson@linaro.org> a =E9crit :
> On Tue, 8 Nov 2022 at 05:53, Siarhei Volkau <lis8215@gmail.com> wrote:
>>=20
>>  Some SoCs have one clock divider for all MMC units, thus changing=20
>> one
>>  affects others as well. This leads to random hangs and memory
>>  corruptions, observed on the JZ4755 based device with two MMC slots
>>  used at the same time.
>=20
> Urgh, that sounds like broken HW to me.
>=20
> The MMC blocks could share a parent clock (that would need a fixed
> rate for it to be applied), assuming there is a separate gate/divider
> available per block. But there isn't'?

They do share a parent clock and have separate gates, and each MMC IP=20
block has an internal divider for the bus frequency derived from that=20
shared clock.

>>=20
>>  List of SoCs affected includes: JZ4725b, JZ4755, JZ4760 and JZ4760b.
>>  However, the MMC driver doesn't distinguish JZ4760 and JZ4770
>>  which shall remain its behavior. For the JZ4755 is sufficient to
>>  use JZ4725b's binding. JZ4750 is outside of the patch.
>>=20
>>  The MMC core has its own clock divisor, rather coarse but suitable=20
>> well,
>>  and it shall keep the role of tuning clock for the MMC host in that
>>  case.
>=20
> The mmc core doesn't have a clock divisor, but it does control the bus
> clock frequency through the ->set_ios() host ops. It needs to do that,
> to be able to conform to the (e)MMC, SD and SDIO specifications.
>=20
> Can you please try to elaborate on the above, so I can better
> understand your point?

Yes, I don't really understand the patch, TBH.

The "clk_set_rate" call will only set the shared clock to the *maximum*=20
clock frequency (host->mmc->f_max) which should be the exact same=20
across all MMC IPs.

So it doesn't matter if it's set 3 times by 3 different instances of=20
the IP, as long as they all request the same value.

Besides, I know for a fact that the mainline driver works fine on the=20
JZ4760(B) and JZ4725B.

Finally... even if it was correct, this change would break=20
compatibility with old Device Tree files.

Cheers,
-Paul

>>=20
>>  Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
>=20
> Kind regards
> Uffe
>=20
>>  ---
>>   drivers/mmc/host/jz4740_mmc.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>=20
>>  diff --git a/drivers/mmc/host/jz4740_mmc.c=20
>> b/drivers/mmc/host/jz4740_mmc.c
>>  index dc2db9c18..d390ff31d 100644
>>  --- a/drivers/mmc/host/jz4740_mmc.c
>>  +++ b/drivers/mmc/host/jz4740_mmc.c
>>  @@ -114,6 +114,7 @@ enum jz4740_mmc_version {
>>          JZ_MMC_JZ4740,
>>          JZ_MMC_JZ4725B,
>>          JZ_MMC_JZ4760,
>>  +       JZ_MMC_JZ4770,
>>          JZ_MMC_JZ4780,
>>          JZ_MMC_X1000,
>>   };
>>  @@ -887,7 +888,13 @@ static int jz4740_mmc_set_clock_rate(struct=20
>> jz4740_mmc_host *host, int rate)
>>          int real_rate;
>>=20
>>          jz4740_mmc_clock_disable(host);
>>  -       clk_set_rate(host->clk, host->mmc->f_max);
>>  +
>>  +       /*
>>  +        * Changing rate on these SoCs affects other MMC units too.
>>  +        * Make sure the rate is configured properly by the CGU=20
>> driver.
>>  +        */
>>  +       if (host->version !=3D JZ_MMC_JZ4725B && host->version !=3D=20
>> JZ_MMC_JZ4760)
>>  +               clk_set_rate(host->clk, host->mmc->f_max);
>>=20
>>          real_rate =3D clk_get_rate(host->clk);
>>=20
>>  @@ -992,6 +999,7 @@ static const struct of_device_id=20
>> jz4740_mmc_of_match[] =3D {
>>          { .compatible =3D "ingenic,jz4740-mmc", .data =3D (void *)=20
>> JZ_MMC_JZ4740 },
>>          { .compatible =3D "ingenic,jz4725b-mmc", .data =3D (void=20
>> *)JZ_MMC_JZ4725B },
>>          { .compatible =3D "ingenic,jz4760-mmc", .data =3D (void *)=20
>> JZ_MMC_JZ4760 },
>>  +       { .compatible =3D "ingenic,jz4770-mmc", .data =3D (void *)=20
>> JZ_MMC_JZ4770 },
>>          { .compatible =3D "ingenic,jz4775-mmc", .data =3D (void *)=20
>> JZ_MMC_JZ4780 },
>>          { .compatible =3D "ingenic,jz4780-mmc", .data =3D (void *)=20
>> JZ_MMC_JZ4780 },
>>          { .compatible =3D "ingenic,x1000-mmc", .data =3D (void *)=20
>> JZ_MMC_X1000 },
>>  --
>>  2.36.1
>>=20


