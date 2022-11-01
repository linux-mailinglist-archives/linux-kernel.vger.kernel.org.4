Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6741615352
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiKAUbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiKAUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:31:43 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D251CFC9;
        Tue,  1 Nov 2022 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667334698; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OnhnDCARi1SHGfCOfq1wUCr5JDb84bNveYmRAJuiXeQ=;
        b=CtDS//rGDFIqK8Hw6/xNTRXwLJ94vLlvhho1KiuNJN4BoA4Trk7wkkNNhVMGl9xjizpE7c
        6FSsJH9ungA/Oein3L9MOUrzFXP83d67P3AdB12lHtEN4dCVPZnff1+KmbhuaUmP4kf+Ps
        LsAT/GEYQ2lVodMHXKocBpRG5eVbyYI=
Date:   Tue, 01 Nov 2022 20:31:28 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v6 3/3] clk: Add Ingenic JZ4755 CGU driver
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <GOROKR.IRJ4PQUI1UN7@crapouillou.net>
In-Reply-To: <20221101192216.5EE5DC433D6@smtp.kernel.org>
References: <20221027192024.484320-1-lis8215@gmail.com>
        <20221027192024.484320-4-lis8215@gmail.com>
        <20221027215716.77250C433D6@smtp.kernel.org>
        <ZODGKR.IJ47UDRQGD431@crapouillou.net>
        <20221101192216.5EE5DC433D6@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Le mar. 1 nov. 2022 =C3=A0 12:22:14 -0700, Stephen Boyd <sboyd@kernel.org>=20
a =C3=A9crit :
> Quoting Paul Cercueil (2022-10-28 00:48:35)
>>  Hi Stephen,
>>=20
>>  Le jeu. 27 oct. 2022 =EF=BF=BD 14:57:14 -0700, Stephen Boyd=20
>> <sboyd@kernel.org>
>>  a =EF=BF=BDcrit :
>>  > Quoting Siarhei Volkau (2022-10-27 12:20:23)
>>  >>  diff --git a/drivers/clk/ingenic/jz4755-cgu.c
>>  >> b/drivers/clk/ingenic/jz4755-cgu.c
>>  >>  new file mode 100644
>>  >>  index 000000000..d2eb3ae0c
>>  >>  --- /dev/null
>>  >>  +++ b/drivers/clk/ingenic/jz4755-cgu.c
>>  >>  @@ -0,0 +1,346 @@
>>  > [...]
>>  >>  +static void __init jz4755_cgu_init(struct device_node *np)
>>  >>  +{
>>  >>  +       int retval;
>>  >>  +
>>  >>  +       cgu =3D ingenic_cgu_new(jz4755_cgu_clocks,
>>  >>  +                             ARRAY_SIZE(jz4755_cgu_clocks),=20
>> np);
>>  >>  +       if (!cgu) {
>>  >>  +               pr_err("%s: failed to initialise CGU\n",=20
>> __func__);
>>  >>  +               return;
>>  >>  +       }
>>  >>  +
>>  >>  +       retval =3D ingenic_cgu_register_clocks(cgu);
>>  >>  +       if (retval)
>>  >>  +               pr_err("%s: failed to register CGU Clocks\n",
>>  >> __func__);
>>  >>  +
>>  >>  +       ingenic_cgu_register_syscore_ops(cgu);
>>  >>  +}
>>  >>  +CLK_OF_DECLARE_DRIVER(jz4755_cgu, "ingenic,jz4755-cgu",
>>  >> jz4755_cgu_init);
>>  >
>>  > Is there another driver that probes this device?
>>  > CLK_OF_DECLARE_DRIVER()
>>  > is for the situation where we want to probe this device again with
>>  > another platform driver. Please add a comment indicating what that
>>  > other
>>  > driver is.
>>=20
>>  See: 03d570e1a4dc ("clk: ingenic: Use CLK_OF_DECLARE_DRIVER macro")
>>=20
>=20
> Does that mean this is also a simple-mfd?

Yes - there's the USB PHY registers randomly in the middle of the=20
clocks IP.

-Paul


