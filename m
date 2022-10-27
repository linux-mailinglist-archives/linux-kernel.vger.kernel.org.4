Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0617B610625
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiJ0XJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiJ0XJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B224900C1;
        Thu, 27 Oct 2022 16:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDD2162591;
        Thu, 27 Oct 2022 23:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF58C43470;
        Thu, 27 Oct 2022 23:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666912150;
        bh=hkVd0MHbdzv+0Fr8xN0jWV93AyTqcsDg/4xXphAOWoY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pQYR3IBIYxC2QnaF5LND3DsXVVjn40xDYIyLCoihxWofX3ZqgAAbOJXAoN5nGPzos
         BP2ceaLG0LYEVVnTQC+ausc84DRwddiqM6pORsTRgVEmFl+HCo71CG0KCyCVyTPup0
         7hta12meYHD6jgaMM6prV62LyaEAeYslaERDhUL1BYTmvDuJctdYvK3apQw9A0YRud
         r5QETThHHgd7sXa0+pgIxoqz2ywZU/h19H3zY6gzpRRkfFeOXLguiLUr0deb1l+1io
         Md0rj7W6MN6D+3cXAkxHi2pszbD8TyEyoMqKPLWvldCSgbUwGT/7T2sXflpmfCYXWK
         WrXm5LTs2svTg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221027101159.942843-6-peng.fan@oss.nxp.com>
References: <20221027101159.942843-1-peng.fan@oss.nxp.com> <20221027101159.942843-6-peng.fan@oss.nxp.com>
Subject: Re: [PATCH 5/6] clk: imx: keep hsio bus clock always on
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, abel.vesa@linaro.org,
        abelvesa@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Thu, 27 Oct 2022 16:09:08 -0700
User-Agent: alot/0.10
Message-Id: <20221027230910.4AF58C43470@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2022-10-27 03:11:58)
> From: Jacky Bai <ping.bai@nxp.com>
>=20
> During Linux System suspend/resume stress test after System Sleep
> enabled, system will stuck sometimes. It is because NICMIX is powered
> down, which HSIOMIX(always on) is not powered down. When NICMIX
> powering down, HSIOMIX will get a hardware handshake, without HSIO ROOT
> clk, the handshake will lose. Then after NICMIX power on when system
> resume, the access to HSIOMIX through NICMIX would be broken. So keep HSIO
> ROOT always on.
>=20
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
>  [Peng Fan] rewrite commit message
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx93.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index 422ad3c89845..74e8d810db7f 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -109,7 +109,7 @@ static const struct imx93_clk_root {
>         { IMX93_CLK_CCM_CKO2,           "ccm_cko2_root",        0x1d00, C=
KO2_SEL, },
>         { IMX93_CLK_CCM_CKO3,           "ccm_cko3_root",        0x1d80, C=
KO1_SEL, },
>         { IMX93_CLK_CCM_CKO4,           "ccm_cko4_root",        0x1e00, C=
KO2_SEL, },
> -       { IMX93_CLK_HSIO,               "hsio_root",            0x1e80, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_HSIO,               "hsio_root",            0x1e80, L=
OW_SPEED_IO_SEL, CLK_IS_CRITICAL},

Similarly add a comment for critical flag please.
