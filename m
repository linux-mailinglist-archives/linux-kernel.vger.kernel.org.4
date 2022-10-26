Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9660DCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiJZH6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiJZH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:58:37 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD59A98C7;
        Wed, 26 Oct 2022 00:58:36 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id ml12so9798819qvb.0;
        Wed, 26 Oct 2022 00:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3WQcdE0WzwCWNl9OlEV6pv3M37aoXQt24XvswxJUCM=;
        b=MklElcdvI85ZWmYTMkPWgBay2Z124a6V8jrAw4WiLfi43L+nZp3yY3o7BfsgiqKJmy
         R4pXeBUzGUa7+bFI4uLb1T/tZJq0+4RBYs4CDfZ3t2Ps/zuiWU/IwTnNsQzuKPOeFkyJ
         T6O2hmgOPsVSC40ABGeFU3egi/OC4YdypSgF5u6V5e+ly6IOKq/7B3DpnXw1Ij4FWZm5
         R2Kz8K7VnU2fGRFQQXtxe77yC+I+8Ym7FvqhQnszYJU/YjfgqxmiS1vRbSMIPcza4qv2
         3rWS4m2KjaTlFArefqWbDMzfN9TZmpUReOACKNdP4lhUJ3qdDq+uDGfosN2b2g2G6IYS
         yhkw==
X-Gm-Message-State: ACrzQf3C4j0X1I3H7ptT0k1LQOHCkpV9t/Tl7hcwxoXi//m2t4LKkaAN
        zF1qcy7tvB4CZit97cyuw3BMXuUdubB/9g==
X-Google-Smtp-Source: AMsMyM41MnUS2Hloi2O7nf+sbHjyKCJuL/JnX5IN4I5NWOeJkBUYlzbPDbQwxbAT0A0iqRP1ZSYlpg==
X-Received: by 2002:ad4:5be7:0:b0:4b3:fe6c:904b with SMTP id k7-20020ad45be7000000b004b3fe6c904bmr36303486qvc.42.1666771115415;
        Wed, 26 Oct 2022 00:58:35 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id a25-20020a05620a16d900b006b615cd8c13sm3306437qkn.106.2022.10.26.00.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 00:58:35 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-333a4a5d495so139335527b3.10;
        Wed, 26 Oct 2022 00:58:35 -0700 (PDT)
X-Received: by 2002:a81:12c8:0:b0:36a:bd6b:92fb with SMTP id
 191-20020a8112c8000000b0036abd6b92fbmr20336268yws.316.1666771114757; Wed, 26
 Oct 2022 00:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221026014227.162121-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221026014227.162121-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221026014227.162121-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Oct 2022 09:58:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVa28=84ZovtWazx0w=xWLDZioK0+CVnoE=NALjMewSkg@mail.gmail.com>
Message-ID: <CAMuHMdVa28=84ZovtWazx0w=xWLDZioK0+CVnoE=NALjMewSkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: renesas: r9a07g044: Add CRU_SYSCLK and
 CRU_VCLK to no PM list
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, Oct 26, 2022 at 3:42 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> CRU_SYSCLK and CRU_VCLK clocks need to be turned ON/OFF in particular
> sequence for the CRU block hence add these clocks to
> r9a07g044_no_pm_mod_clks[] array.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Dropped usage of DEF_NO_PM() macro
> * Added CRU_SYSCLK and CRU_VCLK to no PM list
> * Updated commit message

Thanks for the update!

> --- a/drivers/clk/renesas/r9a07g044-cpg.c
> +++ b/drivers/clk/renesas/r9a07g044-cpg.c
> @@ -412,6 +412,11 @@ static const unsigned int r9a07g044_crit_mod_clks[] __initconst = {
>         MOD_CLK_BASE + R9A07G044_DMAC_ACLK,
>  };
>
> +static const unsigned int r9a07g044_no_pm_mod_clks[] __initconst = {

This cannot be __initconst, so please drop this keyword.

> +       MOD_CLK_BASE + R9A07G044_CRU_SYSCLK,
> +       MOD_CLK_BASE + R9A07G044_CRU_VCLK,
> +};

I believe I haven't seen patches yet to add support for these clocks?
Perhaps these can be combined?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
