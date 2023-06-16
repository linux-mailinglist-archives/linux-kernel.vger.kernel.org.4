Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59F17324EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbjFPBym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjFPByi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:54:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4F5297A;
        Thu, 15 Jun 2023 18:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 233CA61F69;
        Fri, 16 Jun 2023 01:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FC9C433CC;
        Fri, 16 Jun 2023 01:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686880476;
        bh=89sT52+ElbRUq2ljt/SlcehdmzT2f6dY9ia7tDc3ZUU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DDk3vNefAAdE8fmCiwbxgDnRfTxu6cX8Z2N8p3BMnMagIWIwhmTp6nya/kk0Wf1ti
         VTUVpBdq0CUBJa1UahVc21souPJYuPmFIOlBWGz543H2olNRCsuAHpq9K+/z7nxQdZ
         aJXWe1xmxXkeruhmVArdqrrjQfCkziNFezEkqBlTTRPBWO7CO/9EiwOReodIJnmt61
         NJ0qtAKmdsST9aeBBJRmAcMiEUbPn+qnIoZz2v2IP/7e+0d6rehev73bshn4qbIUfc
         lGrAfQdJIl4AZvskzLWe3WP4fYHW3KU7dHuAPiKcf2ysDmSG3X34kNvkbFwdM841S2
         OEmrGXsZ3yhwg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51496f57e59so176131a12.2;
        Thu, 15 Jun 2023 18:54:36 -0700 (PDT)
X-Gm-Message-State: AC+VfDwasivu8VqMHtJyFq2Y3Nq8kM5ZZl6+cdV2RYR7QxM86XuICLfF
        RJhB+4i6F5FxHt+DFnDHdYjFtGBpVBnbK4YvoZA=
X-Google-Smtp-Source: ACHHUZ4Fmo8R9P8CS9FnrCz8uNEsWJLds6OhZ8ooaetttwKsO4qx/QpKi9Xw4DkOKXTwUl7dBloJJiG3JqfOPlcY5n4=
X-Received: by 2002:a05:6402:1118:b0:514:9ab4:3524 with SMTP id
 u24-20020a056402111800b005149ab43524mr293544edv.7.1686880474611; Thu, 15 Jun
 2023 18:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230615091757.24686-1-zhuyinbo@loongson.cn> <968b7c81-a24e-1e0d-31a4-f633a82d17b0@loongson.cn>
 <CAAhV-H4Z13wpOsj5GxkuwMK1D6N6=sArQ52yHjcdiEen=dUpjg@mail.gmail.com>
 <9edfe58a-7901-c2d1-8e01-5f10b3a51287@loongson.cn> <a9292d85-83b5-5b43-6c2a-7e393213c6c9@loongson.cn>
In-Reply-To: <a9292d85-83b5-5b43-6c2a-7e393213c6c9@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 16 Jun 2023 09:54:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4-LCryuQKJrwE65w5BZ66a6PQAq+ZT8mqE7vHa7L3_zw@mail.gmail.com>
Message-ID: <CAAhV-H4-LCryuQKJrwE65w5BZ66a6PQAq+ZT8mqE7vHa7L3_zw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] soc: loongson2_pm: add power management support
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yinbo,

On Fri, Jun 16, 2023 at 9:45=E2=80=AFAM zhuyinbo <zhuyinbo@loongson.cn> wro=
te:
>
>
> Hi huacai,
>
>
> =E5=9C=A8 2023/6/15 =E4=B8=8B=E5=8D=887:15, zhuyinbo =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2023/6/15 =E4=B8=8B=E5=8D=886:00, Huacai Chen =E5=86=99=E9=81=
=93:
> >
> >>> +static void loongson2_pm_status_clear(void)
> >>> +{
> >>> +       u16 value;
> >>> +
> >>> +       value =3D loongson2_pm_readw(LOONGSON2_PM1_STS_REG);
> >>> +       value |=3D (LOONGSON2_PM1_PWRBTN_STS |
> >>> LOONGSON2_PM1_PCIEXP_WAKE_STS |
> >>> +                 LOONGSON2_PM1_WAKE_STS);
> >>> +       loongson2_pm_writew(value, LOONGSON2_PM1_STS_REG);
> >>> +       loongson2_pm_writel(loongson2_pm_readl(LOONGSON2_GPE0_STS_REG=
),
> >>> +                           LOONGSON2_GPE0_STS_REG);
> >> Long-line warnings is removed in latest kernel, so you don't need to
> >> split here.
> >
> >
> > okay, I got it.
> >
> >>
> >>> +}
> >>> +
> >>> +static void loongson2_power_button_irq_enable(void)
> >>
> >> Using loongson2_pm_irq_enable is a little better.
> >
> >
>
> Previously, you suggested that I combine loongson2_pm_irq_enable() and
> power button irq enable code as loongson2_power_button_irq_enable, then
> I remove the function loongson2_pm_irq_enable, in this case that I won't
> be able to call loongson2_pm_irq_enable, so have I misunderstood your
> meaning ? or only rename loongson2_power_button_irq_enable as
> loongson2_pm_irq_enable ?
I'm very sorry for that. At first I only wanted to combine two
functions, but then I found the name  loongson2_pm_irq_enable is
better. So just rename is OK. Thanks.

Huacai
>
> Thanks,
> Yinbo
>
> >
> > ...
> >
> >>> +static int loongson2_suspend_valid_state(suspend_state_t state)
> >>> +{
> >>> +       if (state =3D=3D PM_SUSPEND_MEM)
> >>> +               return 1;
> >>> +
> >>> +       return 0;
> >> "return (state =3D=3D PM_SUSPEND_MEM)" is enough.
> >
> >
> > okay, I got it.
> >
> >
> > Thanks,
> > Yinbo
> >
>
>
