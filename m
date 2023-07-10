Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C9374D8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjGJOMU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGJOMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:12:18 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AE7AD;
        Mon, 10 Jul 2023 07:12:18 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-57012b2973eso58778817b3.2;
        Mon, 10 Jul 2023 07:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688998337; x=1691590337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RYEluLb4R6qDJqCu/Fobryc+g47o+Wn7YP9UuzqITQ=;
        b=CpW/OP5WEt02B5UL4RzvexQG92lvmWrSGHizR2nHJ/+PEFIhnaprHteADY6w5YbjlB
         2s3fLRQdbAoAkSdM54vX4jnf+awsHpvQcNXYNRFrFTrVBB+oZbo+AEdBY2ysNkgw9sd7
         MpD2Uan/bgFpJnnPGUaApI76OhQvTu3G6Qr9gKx4m6NDKNt1jfCXmCpwcJvYldqPUNaQ
         wMXgJ1w/0SzoTmuuiSfCfKqVwM6IRRV+ytwTfRY0fd+6oj6VcGP3S85Kiuus/f+nOP4U
         0RG8IJHsy3+lOGH0dD+IU15m3cDQ2EpME99jF8wH6YTduhc7+391HKXG6ENLgWn49e92
         cbGg==
X-Gm-Message-State: ABy/qLZibr+By/9GJb2+zW+N5IXoRNmufmNJ+UivrHqlgRiiL+Ih4/lj
        6qRBuuW9qcb19ujaoCzVfq96m907yBoOMA==
X-Google-Smtp-Source: APBJJlEZa/mMvRsNfk7fvUjlfKNZFbo1QiBpLh3bKRaHtbbdZM1KPTlz014lOVKI+T1J0cnm7I2Hyg==
X-Received: by 2002:a81:920b:0:b0:579:ed5f:5cd3 with SMTP id j11-20020a81920b000000b00579ed5f5cd3mr13094419ywg.23.1688998337008;
        Mon, 10 Jul 2023 07:12:17 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id t10-20020a81460a000000b00576cd8f9770sm3050417ywa.146.2023.07.10.07.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 07:12:16 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-c5e67d75e0cso5907248276.2;
        Mon, 10 Jul 2023 07:12:16 -0700 (PDT)
X-Received: by 2002:a25:d312:0:b0:c6b:73df:7350 with SMTP id
 e18-20020a25d312000000b00c6b73df7350mr9120556ybf.34.1688998336300; Mon, 10
 Jul 2023 07:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 16:12:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXKavD1JLTMRhF6grRchd9pwDd3oupPPCRDw1Can3nb=w@mail.gmail.com>
Message-ID: <CAMuHMdXKavD1JLTMRhF6grRchd9pwDd3oupPPCRDw1Can3nb=w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in
 RZG2L_GPIO_PORT_PACK() macro
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jun 30, 2023 at 2:05 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Currently we assume all the port pins are sequential ie always PX_0 to
> PX_n (n=1..7) exist, but on RZ/Five SoC we have additional pins P19_1 to
> P28_5 which have holes in them, for example only one pin on port19 is
> available and that is P19_1 and not P19_0.
>
> So to handle such cases include pinmap for each port which would indicate
> the pin availability on each port. With this we also get additional pin
> validation, for example on the RZ/G2L SOC P0 has two pins P0_1 and P0_0
> but with DT/SYSFS could use the P0_2-P0_7.
>
> While at it, update rzg2l_validate_gpio_pin() to use the port pinmap to
> validate the gpio pin.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 167 ++++++++++++------------
>  1 file changed, 86 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 9511d920565e..a0c2e585e765 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -67,10 +67,12 @@
>                                          PIN_CFG_FILCLKSEL)
>
>  /*
> - * n indicates number of pins in the port, a is the register index
> - * and f is pin configuration capabilities supported.
> + * m indicates the bitmap of supported pins, n indicates number
> + * of pins in the port, a is the register index and f is pin
> + * configuration capabilities supported.
>   */
> -#define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) << 28) | ((a) << 20) | (f))
> +#define RZG2L_GPIO_PORT_PACK(m, n, a, f)       ((UL(m) << 32) | (UL(n) << 28) | ((a) << 20) | (f))

Do we actually need 20 bits for the "f" field?
As Biju already commented, "n" can be derived from "m".
If "f" can be shrunk, we might fit everything in 32 bits.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
