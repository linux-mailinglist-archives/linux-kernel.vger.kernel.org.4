Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926BC5EEA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 02:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiI2AUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 20:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiI2AUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 20:20:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C45E4D26F;
        Wed, 28 Sep 2022 17:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 432F7CE1FD9;
        Thu, 29 Sep 2022 00:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7061EC433D7;
        Thu, 29 Sep 2022 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664410832;
        bh=IFNWv2bQzyqo0Al/cMU2C4AhHUuCayGBPVj59KJOOpw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gcdd/X2wMXEZuf/x4apNpl9ygXIEi2/HJPHjBF2e9vStfdEpDUSeGhnW7BBkHHZ1K
         YW0AgK3H8SWEf0X97cHoojKgMmFFWCaFiZ8jR5Ilv3zHq/pPhMc3ap0xepKtm/SE2t
         yTF5U6gww1kxP1hzJXez7Gs3J9r5LniXJPAe/OcwejtguiuwVnM/vV5lthjz7iO0cq
         Fr6lI6NrwMZulIaeFR69wRW7UFb6gP1BtPG3ltrtC1YL6djkYKwbBm6RIpybi3tphp
         XZoBHjJiZJjA+GVezejuOuRxicMlsPhlEoKvDrEiFdbJIJyusm+Q7oFNDMS9nCBBb4
         cZ8GwbiQfKYjA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3bcdfdf0f66dd2fdcffbdeabb5e3ab0bfb2e3489.1663827071.git.rtanwar@maxlinear.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com> <3bcdfdf0f66dd2fdcffbdeabb5e3ab0bfb2e3489.1663827071.git.rtanwar@maxlinear.com>
Subject: Re: [PATCH RESEND v2 4/5] clk: mxl: Add validation for register reads/writes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-lgm-soc@maxlinear.com,
        Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com
Date:   Wed, 28 Sep 2022 17:20:29 -0700
User-Agent: alot/0.10
Message-Id: <20220929002032.7061EC433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2022-09-21 23:24:27)
> Some clocks support parent clock dividers but they do not
> support clock gating (clk enable/disable). Such types of
> clocks might call API's for get/set_reg_val routines with
> width as 0 during clk_prepare_enable() call. Handle such
> cases by first validating width during clk_prepare_enable()
> while still supporting clk_set_rate() correctly.
>=20
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---
>  drivers/clk/x86/clk-cgu.h | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/x86/clk-cgu.h b/drivers/clk/x86/clk-cgu.h
> index 73ce84345f81..46daf9ebd6c9 100644
> --- a/drivers/clk/x86/clk-cgu.h
> +++ b/drivers/clk/x86/clk-cgu.h
> @@ -299,29 +299,51 @@ struct lgm_clk_branch {
>  static inline void lgm_set_clk_val(struct regmap *membase, u32 reg,
>                                    u8 shift, u8 width, u32 set_val)
>  {
> -       u32 mask =3D (GENMASK(width - 1, 0) << shift);
> +       u32 mask;
> =20
> +       /*
> +        * Some clocks support parent clock dividers but they do not
> +        * support clock gating (clk enable/disable). Such types of
> +        * clocks might call this function with width as 0 during
> +        * clk_prepare_enable() call. Handle such cases by not doing
> +        * anything during clk_prepare_enable() but handle clk_set_rate()
> +        * correctly
> +        */
> +       if (!width)
> +               return;

Why are the clk_ops assigned in a way that makes the code get here? Why
can't we have different clk_ops, or not register the clks at all, when
the hardware can't be written?

> +
> +       mask =3D (GENMASK(width - 1, 0) << shift);
>         regmap_update_bits(membase, reg, mask, set_val << shift);
