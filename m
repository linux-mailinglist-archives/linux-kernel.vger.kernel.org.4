Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C95714F13
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjE2Ry7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjE2Ry5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:54:57 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA202CD;
        Mon, 29 May 2023 10:54:56 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53f8daa1b6fso786786a12.0;
        Mon, 29 May 2023 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685382896; x=1687974896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXQhl/1DReICEmpN3fsZjB8PYW6gvWRFYFP7IKx3m+s=;
        b=D7L+qlW4ZbhvuXCv6VYVRnroKmEVoht78yHzYiZJ6m2QAHhlimsZSrQaWw+jwGWiYy
         yrgNogKZjClDf/hTyufLfkc4BkN6hWLZC4e7mziU/RusrAVcajN5UV1S8ROw6HEkNuQi
         KDqPVBsZC1I/ybwCuPqHu0I1GWglNJZNhSNFAc+35hO5HoXj7zFXFLuw6iMOscuk1TN8
         VvcRAnUH3FE03V/G9aY5Rn6zcchIscrGceX68YEYdyAncPqiiS16ymr/U2ov30XcML70
         GZJSSm27KxLwmcu6G8x/5RaU8UQbuHm7SzrI/pCVuGRaqd/MvJZA0SIlXqBoybwZzfVl
         X+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685382896; x=1687974896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXQhl/1DReICEmpN3fsZjB8PYW6gvWRFYFP7IKx3m+s=;
        b=VfUI22r/P/qFGz8i2AmdgSdQDpVB49L7BfH7Zh1TFMionmcWwqUFF54a05u/OwRTiK
         u1vBROCWsv9e5+AZ4K4m1XFBQVyNLEE5Ulj3WCrorsU2cwGvMLtvpL+VCaCAmP831TZE
         UwioL2Gnq1IZFk77Kf4PcWa//PaGKI+EfoTEeSV7enEyJt69lqo7PUmEUtxQMKRbQV/8
         q3yzkmZmIrFI8js2dBXlNg17oFu0x3qI5ZoVIFMvGMZJlMGnaMicVLa1OSrZOpppRObP
         fncvIWdCsLE6If2ktBHgQNPDKUvdqWhJfLF5e6Y31MO5i/tWSajKDRGlnwIzHD1lLgNy
         1e4g==
X-Gm-Message-State: AC+VfDzuAR0gdfoMrUJDm6mz5uN0dsw3txqa/CVs3IVdD3lZe4ozBCLi
        A768HZK3wFDpE1GDC2fLPpVhMd5gAZVIYPpSSwM=
X-Google-Smtp-Source: ACHHUZ7qmypDRrl70hrlW+MkwEOcNT8uZXr+Gyh3y3jdUdsZ80CkNjcW6b1CxZTvjCLMDdahrlG+3gxsqJDbqbUydhc=
X-Received: by 2002:a17:902:ab58:b0:1ac:7ae7:3fdf with SMTP id
 ij24-20020a170902ab5800b001ac7ae73fdfmr11925390plb.41.1685382896047; Mon, 29
 May 2023 10:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230418113451.151312-1-kaima@hust.edu.cn> <ZGX/PjYBVGuECcPg@linaro.org>
 <22043583.EfDdHjke4D@sophie-lab>
In-Reply-To: <22043583.EfDdHjke4D@sophie-lab>
From:   Jesse T <mr.bossman075@gmail.com>
Date:   Mon, 29 May 2023 13:54:45 -0400
Message-ID: <CAJFTR8R=QkWSoMstqer_eEwA5YmvEZetENT8hkxx62QCt2ztjg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: clk-imxrt1050: fix memory leak in imxrt1050_clocks_probe
To:     Kai Ma <kaima@hust.edu.cn>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Zhanhao Hu <zero12113@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 12:55=E2=80=AFAM Kai Ma <kaima@hust.edu.cn> wrote:
>
> On Thursday, May 18, 2023 6:34:38 PM CST Abel Vesa wrote:
> > On 23-04-18 11:34:51, Kai Ma wrote:
> > > Use devm_of_iomap() instead of of_iomap() to automatically
> > > handle the unused ioremap region. If any error occurs, regions alloca=
ted by
> > > kzalloc() will leak, but using devm_kzalloc() instead will automatica=
lly
> > > free the memory using devm_kfree().
> > >
> > > Also, fix error handling of hws by adding unregister_hws label, which
> > > unregisters remaining hws when iomap failed.
> > >
> > > Fixes: 7154b046d8f3 ("clk: imx: Add initial support for i.MXRT1050 cl=
ock driver")
> > > Signed-off-by: Kai Ma <kaima@hust.edu.cn>
> >
> > Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> >
> > Stephen, can you apply this through clk-fixes?
> >
>
> Thanks for your review, I am glad to let you know that I am a student at =
a
> university and we collaborate to contribute to the Linux kernel.

That's cool, I am too!
Is there going to be a V2 of
https://lore.kernel.org/linux-arm-kernel/20230426142552.217435-1-zero12113@=
hust.edu.cn/T/

Thanks,
Jesse Taube

> Here we
> have some similar patches for clk. Could you please take care of them?
>
> [1] https://lore.kernel.org/linux-arm-kernel/DU0PR04MB9417B63DE97D4A2A77B=
4176C88969@DU0PR04MB9417.eurprd04.prod.outlook.com/T/
> [2] https://lore.kernel.org/linux-arm-kernel/20230503070607.2462-1-lyx202=
2@hust.edu.cn/T/
> [3] https://lore.kernel.org/linux-arm-kernel/dc0f2863-d5d5-5102-eb8e-ceea=
92c03fda@oss.nxp.com/
> [4] https://lore.kernel.org/linux-arm-kernel/9a2ab7ec-07ee-255f-a143-9b6c=
8df7c1e2@gmail.com/
>
> Thank you very much!
>
> Regards,
> Kai Ma
