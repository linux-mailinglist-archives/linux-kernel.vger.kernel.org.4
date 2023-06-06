Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA43724BA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbjFFSp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjFFSp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:45:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B259E101;
        Tue,  6 Jun 2023 11:45:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2565c66f73fso952963a91.0;
        Tue, 06 Jun 2023 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686077127; x=1688669127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihp/RsQ3eH+JwS8DEasH6zQrmC0PRAWpOlivpEAgI9A=;
        b=nYM3Li/wDWaBDuujrOjeHmZFnojX1AKzmqpT9QqMUC9IQZz6ArpT5hOc5u8jYYsoAl
         Ie4fjBC8sAM0b3UKR+lcoeQnDFVUWUX1FXxph+sZgk390OmQ+42O7pRgVswSP7WBerLy
         Dw5Nbm4mQR6SIFl7+Q2OkmhoJnpRcXFEGHZ7Z/aGCiqvooUWf4YieQvLIdwq3w77zEOb
         DHZm8GBzyzO/9C/RGzbNLFtrXIwnrpdwTdBj2e7Bo6NONb8jcPo9thrHBYQl7V3R8w3j
         vdT2MgfBj7VSYHLWIuhzNS4GPqDhy6IUHkK0qzmBgipDsPNK1vjEBsuwR1UFvfuFq4Eu
         wZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077127; x=1688669127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihp/RsQ3eH+JwS8DEasH6zQrmC0PRAWpOlivpEAgI9A=;
        b=TDC5BOgjDg+n3CRN8YnwWbRqaYaF6IEsR5Eo+HuhDlFPsO5QCyBJImJlb+o/sBfpEU
         x6KauQThiEtzVXjni179EbgmWipQP/rGVNpE0J28lZWgAIHXM3sL/LhMD9Iukcbm/B8F
         mbpj28n57qSVFvGhft+QUFf+wOdk6cTQx4iTGqOYfhdhrx3gDHerg0WSIpV0j90eCjhf
         hybFZVHjeIwDtxtTiP9aieA2Fds5N6LrAi+K6wG+ETFCfl4uUDZm6dkklSNJ4jFC4KZL
         gmlSVStdFRUb649e8IdwSM2YtNP/EzhGjS41fub/MQFs+v+rqE9VZDlkGAHge+4HSU2n
         gBSA==
X-Gm-Message-State: AC+VfDymY4mh3LBGmSsNvF0+wGvy9P+dJu501MlqPe+2OCw+UFIh/P/x
        Y0Cn4ZKKtWl3jvmRsHupBYqn7lStTHvtxaxySlc=
X-Google-Smtp-Source: ACHHUZ72XUN60eCtHhAYDOIFOd1G1P4dz2CahNpmPahNZZj4FV428arsa43zuqJ1XRCFGTQIm09OsHfT0A177A+v3dY=
X-Received: by 2002:a17:90b:4a48:b0:255:54c4:9a75 with SMTP id
 lb8-20020a17090b4a4800b0025554c49a75mr3394449pjb.2.1686077126938; Tue, 06 Jun
 2023 11:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230506195325.876871-1-aford173@gmail.com>
In-Reply-To: <20230506195325.876871-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 6 Jun 2023 15:45:15 -0300
Message-ID: <CAOMZO5AwixYybR1am=V4m1AnTkum+0Wn0xegU_y6Po9Y--G0mA@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023 at 4:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> Currently, certain clocks are derrived as a divider from their
> parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
> is set, the parent clock is not properly set which can lead
> to some relatively inaccurate clock values.
>
> Unlike imx/clk-composite-93 and imx/clk-divider-gate, it
> cannot rely on calling a standard determine_rate function,
> because the 8m composite clocks have a pre-divider and
> post-divider. Because of this, a custom determine_rate
> function is necessary to determine the maximum clock
> division which is equivalent to pre-divider * the
> post-divider.
>
> With this added, the system can attempt to adjust the parent rate
> when the proper flags are set which can lead to a more precise clock
> value.
>
> On the imx8mplus, no clock changes are present.
> On the Mini and Nano, this can help achieve more accurate
> lcdif clocks. When trying to get a pixel clock of 31.500MHz
> on an imx8m Nano, the clocks divided the 594MHz down, but
> left the parent rate untouched which caused a calulation error.
>
> Before:
> video_pll              594000000
>   video_pll_bypass     594000000
>     video_pll_out      594000000
>       disp_pixel       31263158
>         disp_pixel_clk 31263158
>
> Variance =3D -236842 Hz
>
> After this patch:
> video_pll               31500000
>   video_pll_bypass      31500000
>     video_pll_out       31500000
>       disp_pixel        31500000
>         disp_pixel_clk  31500000
>
> Variance =3D 0 Hz
>
> All other clocks rates and parent were the same.
> Similar results on imx8mm were found.
>
> Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support to dete=
rmine_rate"")
> Signed-off-by: Adam Ford <aford173@gmail.com>

This works fine on my imx8mm-evk, so:

Tested-by: Fabio Estevam <festevam@gmail.com>
