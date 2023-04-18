Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463596E6D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjDRT5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRT5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:57:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85DDB745;
        Tue, 18 Apr 2023 12:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D413638A8;
        Tue, 18 Apr 2023 19:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C26C433EF;
        Tue, 18 Apr 2023 19:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681847825;
        bh=NUM/9EfT+oCdQ/ixSz3HeS2pAje1HdCv95koR/4MgXw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JXUejncSyNOOCDo8jBZ27fDUD/UKurH9wZTS0gV6Esh2yl9h727mpeTEyIbN6lb9o
         h24hf90F7jv7CQmfcFVhW+ArrA3OrbDx/Xgfcej1OwEA8yvjJaIlS5JVlCMlkQzyup
         PooDhkPIfFfASUGlRHWF+JrvvOZ0h2BtFwsvpjz088Ddq5YyvoZRXCSh9J7xiZdouG
         8195udD1neDJxPlOrpSh8ql/TijCVTYqHHOiMF70BqgMg3AHIU8dlePTzCaK6XS+LF
         LILwrO52URPOeZRNix4JL0td0cn+qCXVLg2URtN2EPqPJSw7EDwOBQnnmcVYg7cNg0
         sx8dbLU29Dvmg==
Message-ID: <86398a778336846688c33a737e2a9ae2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5e18370b.3c8a8.1877d7fc98a.Coremail.u201911681@hust.edu.cn>
References: <20230413032439.1706448-1-u201911681@hust.edu.cn> <25b06794ffb595229019640e10f256fd.sboyd@kernel.org> <5e18370b.3c8a8.1877d7fc98a.Coremail.u201911681@hust.edu.cn>
Subject: Re: Re: [PATCH] clk: imx: clk-imx8mm: fix memory leak issue in 'imx8mm_clocks_probe'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     abel vesa <abelvesa@kernel.org>, bai ping <ping.bai@nxp.com>,
        fabio estevam <festevam@gmail.com>,
        michael turquette <mturquette@baylibre.com>,
        nxp linux team <linux-imx@nxp.com>,
        peng fan <peng.fan@nxp.com>,
        pengutronix kernel team <kernel@pengutronix.de>,
        sascha hauer <s.hauer@pengutronix.de>,
        shawn guo <shawnguo@kernel.org>,
        hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hao luo <m202171776@hust.edu.cn>
To:     =?utf-8?b?5ZGo5biI5b63?= <u201911681@hust.edu.cn>
Date:   Tue, 18 Apr 2023 12:57:03 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting =E5=91=A8=E5=B8=88=E5=BE=B7 (2023-04-13 19:02:19)
>=20
>=20
>=20
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Stephen Boyd" <sboyd@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023-04-14 03:06:59 (=E6=98=9F=E6=
=9C=9F=E4=BA=94)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Abel Vesa" <abelvesa@kernel.org>, "Bai Pi=
ng" <ping.bai@nxp.com>, "Fabio Estevam" <festevam@gmail.com>, "Michael Turq=
uette" <mturquette@baylibre.com>, "NXP Linux Team" <linux-imx@nxp.com>, "Pe=
ng Fan" <peng.fan@nxp.com>, "Pengutronix Kernel Team" <kernel@pengutronix.d=
e>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.o=
rg>, "Zhou Shide" <u201911681@hust.edu.cn>
> > =E6=8A=84=E9=80=81: hust-os-kernel-patches@googlegroups.com, "Zhou Shid=
e" <u201911681@hust.edu.cn>, linux-clk@vger.kernel.org, linux-arm-kernel@li=
sts.infradead.org, linux-kernel@vger.kernel.org, "Hao Luo" <m202171776@hust=
.edu.cn>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH] clk: imx: clk-imx8mm: fix memory leak i=
ssue in 'imx8mm_clocks_probe'
> >=20
> > Quoting Zhou Shide (2023-04-12 20:24:39)
> > > The function imx8mm_clocks_probe() has two main issues:
> > > - The of_iomap() function may cause a memory leak.
> > > - Memory allocated for 'clk_hw_data' may not be freed properly
> > > in some paths.
> > >=20
> > > To fix these issues, this commit replaces the use of of_iomap()
> > > with devm_of_iomap() and replaces kzalloc() with devm_kzalloc().
> > > This ensures that all memory is properly managed and automatically
> > > freed when the device is removed.
> > >=20
> > > In addition, when devm_of_iomap() allocates memory with an error,
> > > it will first jump to label "unregister_hws" and
> > > then return PTR_ ERR(base).
> > >=20
> > > Fixes: 9c71f9ea35d7 ("clk: imx: imx8mm: Switch to clk_hw based API")
> > > Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
> > > Signed-off-by: Zhou Shide <u201911681@hust.edu.cn>
> > > ---
> > > The issue is discovered by static analysis, and the patch is not test=
ed yet.
> >=20
> > And you're not coordinating with each other?
> What do you mean by "coordinating with each other"?
>=20

I see two patches to the same driver from the same university on the
list. Preferably you coordinate and decide who will fix what smatch
warnings.
