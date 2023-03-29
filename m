Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E26CF272
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjC2Sql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC2Sqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:46:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9074830ED;
        Wed, 29 Mar 2023 11:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D67A61D7A;
        Wed, 29 Mar 2023 18:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85928C433EF;
        Wed, 29 Mar 2023 18:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680115598;
        bh=l/ZQEIg0r3dnpJOqbbYfQM5WM0p8Fh/Vcz3IqMRkfnE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IivxkDO5tDlyb5I+0Frr1Ndni142zhBGjvQtkpL2SMsZZqAX20gkL1BrV2/1TFN+o
         HAzSfLxfXoQuHr4wcmsgEBr/IvJxTSDPgU8aGOo22n4+Vnotkddw1POWZb5szug+Pk
         YFWru+jEJtWYkjQefllaw9mTdf+FWsUPOR47TQI6V+EHlkkjLXGPaZz+KN2+UFpPxZ
         KBtFXl9FkEyH2B+O2anstXVYgpLgABSYC9/DIH+b8o4WcJiaFAYeAo7deRvYIudPPK
         lxDDvzw8Vd0Yv1hGkyjjAHqACrnf40uwESAgt3tSm/IB2OkTqck9fSvp1biNnRCHLi
         TEBv0eYMXMyMA==
Message-ID: <2e74c4c93f4bcc6a7af0c3ef5a8edd23.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d1874eb8848d5f97f87337011188640a1463a666.1676649335.git.christophe.jaillet@wanadoo.fr>
References: <d1874eb8848d5f97f87337011188640a1463a666.1676649335.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: Reorder fields in 'struct clk_fractional_divider'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-clk@vger.kernel.org
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 29 Mar 2023 11:46:36 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2023-02-17 07:55:55)
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index cf1adfeaf257..8cec844f5dde 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -1134,13 +1134,13 @@ struct clk_hw *clk_hw_register_fixed_factor_paren=
t_hw(struct device *dev,
>  struct clk_fractional_divider {
>         struct clk_hw   hw;
>         void __iomem    *reg;
> +       u8              flags;
>         u8              mshift;
>         u8              mwidth;
>         u32             mmask;

This member ...

>         u8              nshift;
>         u8              nwidth;
>         u32             nmask;

and this member can be calculated. Doing that would save more bytes when
combined with this patch. Can you make this into a patch series?

> -       u8              flags;
>         void            (*approximation)(struct clk_hw *hw,
>                                 unsigned long rate, unsigned long *parent=
_rate,
>                                 unsigned long *m, unsigned long *n);
