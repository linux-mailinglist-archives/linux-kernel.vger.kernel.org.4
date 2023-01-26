Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0167C79B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbjAZJkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbjAZJkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:40:06 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800F25DC25;
        Thu, 26 Jan 2023 01:40:04 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id x5so834266qti.3;
        Thu, 26 Jan 2023 01:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8fNfyYZhsT1/JpFO8G7PbMcHmUwBkqtAaCc9yPq2jo=;
        b=4rY+LMQKb1OxAqCO3cVu62ivVrLaup1PChxZ4dxqCONeVNrnQygoXxQ/5+SFaLI5u1
         ZHh0/gbPHSJ7IZykpbDAhUqHfgRlZqBGeUebPFyUFQuOqQ8wfssSvjri7iA3VeNslzQf
         0tt9L52YooV4hJHHkBIvBtBDevrs7in96Pjz65ai0FBOY6Ve6O+m88O+XlnlGHCotuVY
         JLvBfXwlVd2XSywfNpRIwcaQRYbAkRHrd28O7LeFni5xPM9oArJ9aHR8rCC3vS2gLy/o
         E84VmWCSBsZJj8lsoNA17btp4bd/2AxEcjRh1GYUJ3DPF6qrRO472FRav5yRL3+NSUsn
         PThQ==
X-Gm-Message-State: AO0yUKVdoZe4tj5PHn8sZ4RnnKiam1sxZHhpor9767V3IZiHXU9gMolX
        wcI6xLQfjntM5dbpzdGlSccAn2dMy08aJA==
X-Google-Smtp-Source: AK7set9LqHd2fU1m9TPZiG7NkI0yCA030y6ISmYI7sIU9bO5cQ6KW3DG7TdKm4IQK91YJkVYBWGDJw==
X-Received: by 2002:ac8:594a:0:b0:3a6:8f7c:5936 with SMTP id 10-20020ac8594a000000b003a68f7c5936mr10619116qtz.25.1674726003249;
        Thu, 26 Jan 2023 01:40:03 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id ce14-20020a05622a41ce00b003b62deadddcsm437598qtb.42.2023.01.26.01.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:40:02 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id b1so1278222ybn.11;
        Thu, 26 Jan 2023 01:40:02 -0800 (PST)
X-Received: by 2002:a25:d505:0:b0:7bf:d201:60cb with SMTP id
 r5-20020a25d505000000b007bfd20160cbmr2880622ybe.365.1674726002527; Thu, 26
 Jan 2023 01:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Jan 2023 10:39:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXY0c4qKCi057CtJdhUJ+443rtyCjwYyK3qGgwWTZ2a0A@mail.gmail.com>
Message-ID: <CAMuHMdXY0c4qKCi057CtJdhUJ+443rtyCjwYyK3qGgwWTZ2a0A@mail.gmail.com>
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Hi Wolfram,

On Wed, Jan 18, 2023 at 12:38 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Cong Dang <cong.dang.xn@renesas.com>
>
> According to the datasheets, the Strobe Timing Adjustment bit (STRTIM)
> setting is different on R-Car SoCs, i.e.
>
> R-Car H3 ES1.*  : STRTIM[2:0] is set to 0x0
> R-Car M3 ES1.*  : STRTIM[2:0] is set to 0x6
> other R-Car Gen3: STRTIM[2:0] is set to 0x7
> other R-Car Gen4: STRTIM[3:0] is set to 0xf
>
> To fix this issue, a DT match data was added to specify the setting
> for special use cases.
>
> Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
> Signed-off-by: Hai Pham  <hai.pham.ud@renesas.com>
> [wsa: rebased, restructured a little, added Gen4 support]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since V1:
>
> * use proper mask when updating STRTIM bits (thanks, Geert!)

Thanks for the update!

> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c

> @@ -163,6 +165,36 @@ static const struct regmap_access_table rpcif_volatile_table = {
>         .n_yes_ranges   = ARRAY_SIZE(rpcif_volatile_ranges),
>  };
>
> +static const struct rpcif_info rpcif_info_r8a7795_es1 = {
> +       .type = RPCIF_RCAR_GEN3,
> +       .strtim = 0,
> +};
> +
> +static const struct rpcif_info rpcif_info_r8a7796_es1 = {
> +       .type = RPCIF_RCAR_GEN3,
> +       .strtim = 6,
> +};
> +
> +static const struct rpcif_info rpcif_info_gen3 = {
> +       .type = RPCIF_RCAR_GEN3,
> +       .strtim = 7,
> +};
> +
> +static const struct rpcif_info rpcif_info_rz_g2l = {
> +       .type = RPCIF_RZ_G2L,
> +       .strtim = 7,
> +};
> +
> +static const struct rpcif_info rpcif_info_gen4 = {
> +       .type = RPCIF_RCAR_GEN4,
> +       .strtim = 15,
> +};
> +
> +static const struct soc_device_attribute rpcif_info_match[]  = {
> +       { .soc_id = "r8a7795", .revision = "ES1.*", .data = &rpcif_info_r8a7795_es1 },
> +       { .soc_id = "r8a7796", .revision = "ES1.*", .data = &rpcif_info_r8a7796_es1 },

As we do have a separate compatible value for R-Car M3-W+ aka R-Car M3-W ES3.0
("renesas,r8a77961-rpc-if"), and there is no R-Car M3-W ES2.x (see the PRR
screwup handling in renesas_soc_init()), you can just match against
"renesas,r8a7796-rpc-if instead.

> +       { /* Sentinel. */ }
> +};
>
>  /*
>   * Custom accessor functions to ensure SM[RW]DR[01] are always accessed with

> @@ -321,12 +360,10 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
>         /* DMA Transfer is not supported */
>         regmap_update_bits(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_HS, 0);
>
> -       if (rpc->type == RPCIF_RCAR_GEN3)
> -               regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> -                                  RPCIF_PHYCNT_STRTIM(7), RPCIF_PHYCNT_STRTIM(7));:q

> -       else if (rpc->type == RPCIF_RCAR_GEN4)
> -               regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> -                                  RPCIF_PHYCNT_STRTIM(15), RPCIF_PHYCNT_STRTIM(15));
> +       regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> +                          /* create mask with all affected bits set */
> +                          RPCIF_PHYCNT_STRTIM(BIT(fls(rpc->info->strtim)) - 1),

fls(0) = 0, and BIT(-1) is undefined, so this won't work for R-Car
H3 ES1.x.  So I'm afraid you cannot handle this without storing the
actual mask ;-)

However, that issue will be moot as soon as we drop upstream support
for R-Car H3 ES1.x.  I cannot test RPC on R-Car H3 ES1.x anyway, as
the RPC is locked by TF/A, and the firmware cannot be upgraded easily
due to lack of upstream TF/A support for R-Car H3 ES1.x

> +                          RPCIF_PHYCNT_STRTIM(rpc->info->strtim));
>
>         regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET1, RPCIF_PHYOFFSET1_DDRTMG(3),
>                            RPCIF_PHYOFFSET1_DDRTMG(3));

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
