Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E0860DC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiJZH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiJZH4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:56:37 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C719C2FF;
        Wed, 26 Oct 2022 00:56:36 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id w29so2264168qtv.9;
        Wed, 26 Oct 2022 00:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZv0EQODj9uEccYLjpbGQ7puG1gOLqeceGxoxO6cEYU=;
        b=setqzUmYHRSiYre5/T+0kgNI3iXoE9iWKxpsJz875KxymiWnntPWgKRZ9rwbcTNUN+
         qf142g5K0RV1vCxF4WBeQH/oNaDasDsl5RUxFON5MN+c5zTmk0poD8kz/U2d30Tgfq0j
         Ev3nPjCQT5vD/sE31WMpPJeREVdXChUVh4WOsXucDRa8scdMIXYf5IPngJxLyMVtTtW0
         E53lXsrBdo0RJd4Qjxvc6mmAWZk4tLuHENYqn7fzXg0Q4O1m7VUoS6y/haUHlylUjda4
         bfgyJItFGEWb2IYE+VPvJpeZs1CoqsqjP2TrwhMbg8c0fjaa1zw71lwKLwHzNVvRnpNh
         67nw==
X-Gm-Message-State: ACrzQf1n7BL0OKK8asZAE+iCEEENuZg2gKW/yD+FjacK+Ty+pGCAbJ5A
        cDe+Xk8X6xAEpFwenHvR5j1kUMTUiFXTrA==
X-Google-Smtp-Source: AMsMyM4j/Gy1QEfODnznT78OG8URXlMN9UDpoy5OilRFBh/GUR2BXUSkR3qbn90gFSPWlac65RnCqQ==
X-Received: by 2002:ac8:7f8c:0:b0:39c:db49:29cc with SMTP id z12-20020ac87f8c000000b0039cdb4929ccmr35462246qtj.224.1666770995508;
        Wed, 26 Oct 2022 00:56:35 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id e14-20020ac85dce000000b0039764587192sm2764782qtx.57.2022.10.26.00.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 00:56:35 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-35befab86a4so139401637b3.8;
        Wed, 26 Oct 2022 00:56:35 -0700 (PDT)
X-Received: by 2002:a81:9c49:0:b0:34a:de:97b8 with SMTP id n9-20020a819c49000000b0034a00de97b8mr37831330ywa.384.1666770994803;
 Wed, 26 Oct 2022 00:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221026014227.162121-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221026014227.162121-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221026014227.162121-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Oct 2022 09:56:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVg1sFH1gAqo3yf5-m7edfHFO0VM63n=FmDQHhJqSpHyg@mail.gmail.com>
Message-ID: <CAMuHMdVg1sFH1gAqo3yf5-m7edfHFO0VM63n=FmDQHhJqSpHyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD
 clocks support PM
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, Oct 26, 2022 at 3:42 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> There are cases where not all CPG_MOD clocks should be assumed to support
> PM. For example on the CRU block there is a particular sequence that needs
> to be followed to initialize the CSI-2 D-PHY in which individual clocks
> need to be turned ON/OFF, due to which Runtime PM support wasn't used by
> the CRU CSI-2 driver.
>
> This patch adds support to allow indicating if PM is not supported by the
> CPG_MOD clocks. Two new members no_pm_mod_clks and num_no_pm_mod_clks are
> added to struct rzg2l_cpg_info so that MOD clocks which do not support PM
> can be passed by no_pm_mod_clks[] array and when the driver uses Runtime
> PM support the clk ID is matched against the no_pm_mod_clks[] array to see
> if the clk is needed to be included as part of Runtime PM.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Dropped DEF_NO_PM() macro
> * Added genpd member to struct rzg2l_cpg_priv
> * Added no_pm_mod_clks and num_no_pm_mod_clks members
>   to struct rzg2l_cpg_info
> * Updated commit message

Thanks for the update!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c

>
>  static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused, struct device *dev)

Time to rename "unused" to "domain" ;-)

>  {
> +       struct rzg2l_cpg_priv *priv = container_of(unused, struct rzg2l_cpg_priv, genpd);

I can fix that while applying...

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
