Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0036C3830
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCURbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCURbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:31:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC5113FA;
        Tue, 21 Mar 2023 10:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A8661D54;
        Tue, 21 Mar 2023 17:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC44C433D2;
        Tue, 21 Mar 2023 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679419874;
        bh=be0SOJijbIAFiA4S90OBb78y61Nkl7wEB41PUf9Nang=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=go3Zx3kIkA/vKDOMA+8kgvYmqQCbJGGPq0BhEPX/RbYLsGLKJNxsbUsi00qnUeyWo
         6nQyG9WEIf1kZVLGFXF7ul0wDUrJUdrtHdkFa3mNSvdQhY64CsJOuLKCCgSbI/cVQr
         oCuOn8DswhW46Z4VKLPfzccKfRyAYiupv4pFnYb0VBHpZUP1UjymBGS1ev5xVukR74
         gtm5B0WNo/zqJIm2tjMtaEShhZ+JM1uPJJjt/3AEoXRHenps3YqSE4OVClrEuIvHtl
         ZxZ6wWXh/OhFbaRDtVwDy7ls1fPtBSjddunXoSX+iyBZcgUTiAJ/xKZFGTBhF8rGkx
         vH9fEGefFLdrA==
Message-ID: <d3b057408117a71bcd153f4a91bcdfe1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230320204042.980708-4-mmyangfl@gmail.com>
References: <20230320204042.980708-1-mmyangfl@gmail.com> <20230320204042.980708-4-mmyangfl@gmail.com>
Subject: Re: [PATCH v5 3/5] clk: hisilicon: Add complex clock for Hi3798
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     David Yang <mmyangfl@gmail.com>
Date:   Tue, 21 Mar 2023 10:31:12 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Yang (2023-03-20 13:40:36)
> @@ -59,6 +61,131 @@ static const struct hisi_fixed_rate_clock hi3798_fixe=
d_rate_clks[] =3D {
>         { HI3798_FIXED_250M, "250m", NULL, 0, 250000000, },
>  };
> =20
> +struct hi3798_complex_clock {
> +       unsigned int    id;
> +       const char      *name;
> +       const char      *parent_name;
> +       unsigned long   flags;
> +       unsigned long   offset;
> +       u32             mask;
> +       u32             value;
> +       const char      *alias;
> +};
> +
> +struct hi3798_clk_complex {
> +       struct clk_hw   hw;
> +       void __iomem    *reg;
> +       u32             mask;
> +       u32             value;
> +};
> +
> +#define to_complex_clk(_hw) container_of(_hw, struct hi3798_clk_complex,=
 hw)

Missing header include for container_of()

> +
> +static int hi3798_clk_complex_prepare(struct clk_hw *hw)
> +{
> +       struct hi3798_clk_complex *clk =3D to_complex_clk(hw);
> +       u32 val;
> +
> +       val =3D readl_relaxed(clk->reg);
> +       val &=3D ~(clk->mask);
> +       val |=3D clk->value;
> +       writel_relaxed(val, clk->reg);
> +
> +       return 0;
> +}
> +
> +static void hi3798_clk_complex_unprepare(struct clk_hw *hw)
> +{
> +       struct hi3798_clk_complex *clk =3D to_complex_clk(hw);
> +       u32 val;
> +
> +       val =3D readl_relaxed(clk->reg);
> +       val &=3D ~(clk->mask);
> +       writel_relaxed(val, clk->reg);
> +}
> +
> +static int hi3798_clk_complex_is_prepared(struct clk_hw *hw)
> +{
> +       struct hi3798_clk_complex *clk =3D to_complex_clk(hw);
> +       u32 val;
> +
> +       val =3D readl_relaxed(clk->reg);
> +       return (val & clk->mask) =3D=3D clk->value;
> +}
> +
> +static const struct clk_ops hi3798_clk_complex_ops =3D {
> +       .prepare =3D hi3798_clk_complex_prepare,
> +       .unprepare =3D hi3798_clk_complex_unprepare,
> +       .is_prepared =3D hi3798_clk_complex_is_prepared,
> +};
> +
> +static int hi3798_clk_register_complex(const struct hi3798_complex_clock=
 *clks, int nums,
> +                                      struct hisi_clock_data *data)
> +{
> +       void __iomem *base =3D data->base;
> +       int i;
> +       int ret;
> +
> +       for (i =3D 0; i < nums; i++) {
> +               struct hi3798_clk_complex *p_clk;
> +               struct clk *clk;
> +               struct clk_init_data init;
> +
> +               p_clk =3D kzalloc(sizeof(*p_clk), GFP_KERNEL);

Use devm?

> +               if (!p_clk) {
> +                       ret =3D -ENOMEM;
> +                       goto err_kzalloc;
> +               }
> +
> +               init.name =3D clks[i].name;
> +               init.ops =3D &hi3798_clk_complex_ops;
> +
> +               init.flags =3D 0;
> +               init.parent_names =3D
> +                       (clks[i].parent_name ? &clks[i].parent_name : NUL=
L);
> +               init.num_parents =3D (clks[i].parent_name ? 1 : 0);
> +
> +               p_clk->reg =3D base + clks[i].offset;
> +               p_clk->mask =3D clks[i].mask;
> +               p_clk->value =3D clks[i].value;
> +               p_clk->hw.init =3D &init;
> +
> +               clk =3D clk_register(NULL, &p_clk->hw);

Use devm? Also, please use devm_clk_hw_register()

> +               if (IS_ERR(clk)) {
> +                       kfree(p_clk);
> +err_kzalloc:
> +                       pr_err("%s: failed to register clock %s\n",
> +                              __func__, clks[i].name);
> +                       goto err;
> +               }
> +
> +               if (clks[i].alias)
> +                       clk_register_clkdev(clk, clks[i].alias, NULL);

Do you use this clkdev lookup? You have an OF clk provider. Hopefully
this can be removed.

> +
> +               data->clk_data.clks[clks[i].id] =3D clk;
> +       }
> +
> +       return 0;
> +
> +err:
> +       while (i--)
> +               clk_unregister(data->clk_data.clks[clks[i].id]);
> +
> +       return ret;
> +}
> +
