Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C631C7308DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjFNT5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjFNT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:57:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4D1FEF;
        Wed, 14 Jun 2023 12:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FB3462272;
        Wed, 14 Jun 2023 19:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A54C433C0;
        Wed, 14 Jun 2023 19:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686772627;
        bh=GZ5mggTqw3teUuvhXLevUDfehWEgkhXaVlZpI7pRM+8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=G1FQlghZ+qpoY1+fjk1mP61XCz4qQB2uWxd18kFRsMgFVQCivvXg4WTGaEKrnvwQA
         W3wjff3ZWKZYsUR0vO4MOIqIrOqpfvohOJlh73pUP7n9qeA0O2h04H51kKXhP2kro1
         Sxq7NQ5aOfgzNt8VD+xDfovd2N4E96+3ERRn5yyTED3xCaNoIKdc2QVlkB9D+muWim
         Hnks3S5h52/W8AqwZukzSlL2sbx6hlCv9XaJQ0SyKgu9Fs5/sjN4sQ+hlBgyNofLzA
         hP/ZBtVzW3TBjKV4nwCEtAepOado/aTds3W3BAMA99eNxp0pL+fFxqWCZFfmSvhmEV
         JNcM+uvxaCr3A==
Message-ID: <f45dff2afd6fa0c32e79aef1b604cf0c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230614012913.122220-2-yang.lee@linux.alibaba.com>
References: <20230614012913.122220-1-yang.lee@linux.alibaba.com> <20230614012913.122220-2-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next 2/3] clk: stm32: core: Fix unsigned comparison with less than zero
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Date:   Wed, 14 Jun 2023 12:57:05 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Li (2023-06-13 18:29:12)
> The return value of the divider_ro_round_rate() is long.
> However, the return value is being assigned to an unsigned
> long variable 'rate', so making 'rate' to long.
>=20
> silence the warnings:
> ./drivers/clk/stm32/clk-stm32-core.c:451:6-10: WARNING: Unsigned expressi=
on compared with zero: rate < 0
> ./drivers/clk/stm32/clk-stm32-core.c:461:5-9: WARNING: Unsigned expressio=
n compared with zero: rate < 0
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5519
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/clk/stm32/clk-stm32-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-s=
tm32-core.c
> index d5aa09e9fce4..067b918a8894 100644
> --- a/drivers/clk/stm32/clk-stm32-core.c
> +++ b/drivers/clk/stm32/clk-stm32-core.c
> @@ -431,7 +431,7 @@ static int clk_stm32_composite_determine_rate(struct =
clk_hw *hw,
>  {
>         struct clk_stm32_composite *composite =3D to_clk_stm32_composite(=
hw);
>         const struct stm32_div_cfg *divider;
> -       unsigned long rate;
> +       long rate;
> =20

Instead of this can you convert this code to use
divider_ro_determine_rate() and divider_determine_rate()?
