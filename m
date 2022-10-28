Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC73610B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJ1Hsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJ1Hss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:48:48 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154501BE1E0;
        Fri, 28 Oct 2022 00:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666943325; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biY8c9UIA8tRU0N6X5LV3ObrP5qOGMkHf6HMaHaU6fU=;
        b=T8ALAdRLQ3Qrz/Wa9O149SH/+i4hnqwKFlecDqEsJgO3GQstkdGJxbceRP8483YV16P31W
        V7eXajhrBo2nCa5+SNLBLEZ1ylh8yaaBDBfQanG+tMxKdWCKOctJTiFtPzJYNsYbQdt03N
        0B2jVvf/kkaK7EHFOaJVPewvBaa9o6o=
Date:   Fri, 28 Oct 2022 08:48:35 +0100
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
Message-Id: <ZODGKR.IJ47UDRQGD431@crapouillou.net>
In-Reply-To: <20221027215716.77250C433D6@smtp.kernel.org>
References: <20221027192024.484320-1-lis8215@gmail.com>
        <20221027192024.484320-4-lis8215@gmail.com>
        <20221027215716.77250C433D6@smtp.kernel.org>
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

Hi Stephen,

Le jeu. 27 oct. 2022 =E0 14:57:14 -0700, Stephen Boyd <sboyd@kernel.org>=20
a =E9crit :
> Quoting Siarhei Volkau (2022-10-27 12:20:23)
>>  diff --git a/drivers/clk/ingenic/jz4755-cgu.c=20
>> b/drivers/clk/ingenic/jz4755-cgu.c
>>  new file mode 100644
>>  index 000000000..d2eb3ae0c
>>  --- /dev/null
>>  +++ b/drivers/clk/ingenic/jz4755-cgu.c
>>  @@ -0,0 +1,346 @@
> [...]
>>  +static void __init jz4755_cgu_init(struct device_node *np)
>>  +{
>>  +       int retval;
>>  +
>>  +       cgu =3D ingenic_cgu_new(jz4755_cgu_clocks,
>>  +                             ARRAY_SIZE(jz4755_cgu_clocks), np);
>>  +       if (!cgu) {
>>  +               pr_err("%s: failed to initialise CGU\n", __func__);
>>  +               return;
>>  +       }
>>  +
>>  +       retval =3D ingenic_cgu_register_clocks(cgu);
>>  +       if (retval)
>>  +               pr_err("%s: failed to register CGU Clocks\n",=20
>> __func__);
>>  +
>>  +       ingenic_cgu_register_syscore_ops(cgu);
>>  +}
>>  +CLK_OF_DECLARE_DRIVER(jz4755_cgu, "ingenic,jz4755-cgu",=20
>> jz4755_cgu_init);
>=20
> Is there another driver that probes this device?=20
> CLK_OF_DECLARE_DRIVER()
> is for the situation where we want to probe this device again with
> another platform driver. Please add a comment indicating what that=20
> other
> driver is.

See: 03d570e1a4dc ("clk: ingenic: Use CLK_OF_DECLARE_DRIVER macro")

Cheers,
-Paul


