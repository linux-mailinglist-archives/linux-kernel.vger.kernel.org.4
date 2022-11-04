Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC3619B98
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiKDP15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbiKDP1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:27:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B8F2DA97
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:27:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 130so4803786pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O2Nd6bNvUe0UVcRt3WitzDx9mV2ITpv1BTXOeCveRv8=;
        b=udRcro9xs4r+r6ted7rjPa79NMf0EsS7OK6uHxFq9z46/Z8czPMaZxT/685iGOaWU5
         lVV6U47yiHKL3pVxz332BlQaPXDP7ntcdzw5kwnO5VhlVZeOouUqdBQd3dB12hoNH7uj
         19wzID8mx/+pEcobJBZpArkSVSCsG/fah0GrmxDge/jEUC+jxRTbQt84nBRYSQ4SiFZM
         YAI6OwQ4GXpmBX1+vNqdMkYWOpFnpQ3boXg0arqy9yQ1w3y8O6i49EVDJx8npUl/07FA
         F25NunijPdaLvBjbgVU6zmscMqI+nEKXvmm+nV4/bGlC1t2nWFPV682N2SiEUcRcVmmx
         v/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2Nd6bNvUe0UVcRt3WitzDx9mV2ITpv1BTXOeCveRv8=;
        b=NA5HaH4dA88JxBFCuYJhtWE5DWE7uPgiuIatB5dz6BaEEJ7UnxvLBz6A+qT6O2S7Kh
         aRIDGpxM3M2q8/Mthhe/hiesGCs1DQmfRL9YZIUMuyDPxiSjfYtumslmapTRBU3y2QZa
         0tzUU6jgbxUMtjSGW2spkiKWwTnu+Alb+715bvC7P9uiapIMT4IufolRPCZzXkyoIGnj
         PaOXlXx79ON9A+SNIHP0OUANV0Adnj5BQ9BPHQ4Vs4T55XDRJbJ3FOhlzij0dRG+Es0k
         tTX5Kp/GrI9ZOOBpAd57YevEK7KqYXnHBJOrkhegwxMDMhqC9FYwGW0lNKZgNdT9iVVs
         z1ag==
X-Gm-Message-State: ACrzQf03f4n3P7gLkyXAm5bs4dOZf8THPYkqu+nItjOR6l4PtWUEd/Vc
        3uYkoTXrWYCpAZa40fkJmi67GWUUZYEAAA==
X-Google-Smtp-Source: AMsMyM5rdAb7s+O02h1GUn9LmOSQvSTQUB9WGaUhWTbGZ1jAIxW2thw1XRv+RNRbRTlgrnFhXBzQcQ==
X-Received: by 2002:a05:6a00:88f:b0:530:dec:81fd with SMTP id q15-20020a056a00088f00b005300dec81fdmr36370451pfj.64.1667575655145;
        Fri, 04 Nov 2022 08:27:35 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b00186e8526790sm2812772plg.127.2022.11.04.08.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:27:34 -0700 (PDT)
Date:   Fri, 4 Nov 2022 09:27:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remoteproc: imx_rproc: correct i.MX93 DRAM mapping
Message-ID: <20221104152732.GA1873068@p14s>
References: <20221102111410.38737-1-peng.fan@oss.nxp.com>
 <CANLsYky+FPNi82kDwgJBzdoxS5=SBXBqiRRFNCvt4ihUpJS+9w@mail.gmail.com>
 <DU0PR04MB9417B48835B77695D7BD535788389@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417B48835B77695D7BD535788389@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 06:11:46AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] remoteproc: imx_rproc: correct i.MX93 DRAM mapping
> > 
> > On Wed, 2 Nov 2022 at 05:12, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > According to updated reference mannual, the M33 DRAM view of
> > > 0x[C,D]0000000 maps to A55 0xC0000000, so correct it.
> > >
> > > Fixes: 9222fabf0e39 ("remoteproc: imx_rproc: Support i.MX93")
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index 2c471e46f4ca..9fc978e0393c
> > > 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -134,8 +134,8 @@ static const struct imx_rproc_att
> > imx_rproc_att_imx93[] = {
> > >         { 0x80000000, 0x80000000, 0x10000000, 0 },
> > >         { 0x90000000, 0x80000000, 0x10000000, 0 },
> > >
> > > -       { 0xC0000000, 0xa0000000, 0x10000000, 0 },
> > > -       { 0xD0000000, 0xa0000000, 0x10000000, 0 },
> > > +       { 0xC0000000, 0xC0000000, 0x10000000, 0 },
> > > +       { 0xD0000000, 0xC0000000, 0x10000000, 0 },
> > 
> > But how did this work before?  Were some SoC released with the old
> > mapping?

As it is regularly the case, you have not answered all my questions.

> The current m33 firmware release with Linux SDK only has
> TCM version, so I not have image to test the DDR mapping. 
> 
> Initially we got the information that M33 mapping of DRAM.
> DRAM (offset 0 MB)	DRAM	80000000
> DRAM (offset 256 MB)	DRAM	A0000000
> DRAM (offset 512 MB)	DRAM	C0000000
> 
> However the information is wrong after we check more,
> there is an 256MB hole, 0MB [0x80000000, 0x8fffffff],
> 512MB [0xa0000000, 0xafffffff], 
> 1024MB [0xc0000000, 0xcfffffff]
> 
> I use JTAG to confirm it.
> 
> Thanks,
> Peng.
> > 
> > >  };
> > >
> > >  static const struct imx_rproc_att imx_rproc_att_imx8qm[] = {
> > > --
> > > 2.37.1
> > >
