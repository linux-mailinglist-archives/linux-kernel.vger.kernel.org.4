Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB046610617
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiJ0XFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiJ0XFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:05:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384185A2E1;
        Thu, 27 Oct 2022 16:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C941F6258A;
        Thu, 27 Oct 2022 23:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2288CC433D7;
        Thu, 27 Oct 2022 23:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666911931;
        bh=kMiSzIp8QDq8Q/JDWrd3tsQMI+u2ReRt1KdGThVt6sM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SMdBv5HyjHZ/qmlwreA2kqytkytGSznE9Wx00Go/Yv25WmZwSIMX8mN7V44PGH/Cq
         C1OYefQsJQpJCzC5ON9S3Huif7Z7rhHRq6zuSdPSoXSrGut1Y0jewOa6p0GaM1GKtO
         vb7FK28RxGReFh/5aelUUKD3i4JSdQYwRnnyd/TgKm9/4ZXq8ndoDImiR9bqi0pLXW
         NEYxl0jOlHp1uOAzhZHMxc9mCI7NTc4Dkzvn+Xg0NlQHd4fHm8HdRiNGm5BEiIJUE4
         C+XIoEUTV8/+mBwZtCOlSm/0xEncEKobekqLofgFMaH90WpYg3Gqu7dSV8WWtEjO48
         37q5SJy7a05ug==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221027101159.942843-7-peng.fan@oss.nxp.com>
References: <20221027101159.942843-1-peng.fan@oss.nxp.com> <20221027101159.942843-7-peng.fan@oss.nxp.com>
Subject: Re: [PATCH 6/6] clk: imx93: keep sys ctr clock always on
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, abel.vesa@linaro.org,
        abelvesa@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Thu, 27 Oct 2022 16:05:29 -0700
User-Agent: alot/0.10
Message-Id: <20221027230531.2288CC433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2022-10-27 03:11:59)
> From: Jacky Bai <ping.bai@nxp.com>
>=20
> Keep sys ctr clock always on to make sure its register
> can be accessed for cpuidle.
>=20
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx93.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index 74e8d810db7f..91db356564c1 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -238,7 +238,7 @@ static const struct imx93_clk_ccgr {
>         { IMX93_CLK_HSIO_32K_GATE,      "hsio_32k",     "osc_32k",       =
       0x9dc0, },
>         { IMX93_CLK_ENET1_GATE,         "enet1",        "wakeup_axi_root"=
,      0x9e00, },
>         { IMX93_CLK_ENET_QOS_GATE,      "enet_qos",     "wakeup_axi_root"=
,      0x9e40, },
> -       { IMX93_CLK_SYS_CNT_GATE,       "sys_cnt",      "osc_24m",       =
       0x9e80, },
> +       { IMX93_CLK_SYS_CNT_GATE,       "sys_cnt",      "osc_24m",       =
       0x9e80, CLK_IS_CRITICAL},

Please add a comment like

	/* Critical because clk accessed during CPU idle */

>         { IMX93_CLK_TSTMR1_GATE,        "tstmr1",       "bus_aon_root",  =
       0x9ec0, },
>         { IMX93_CLK_TSTMR2_GATE,        "tstmr2",       "bus_wakeup_root"=
,      0x9f00, },
>         { IMX93_CLK_TMC_GATE,           "tmc",          "osc_24m",       =
       0x9f40, },
