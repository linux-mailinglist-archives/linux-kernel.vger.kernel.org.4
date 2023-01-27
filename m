Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD03C67DEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjA0IRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjA0IRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:17:41 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BDC38B6D;
        Fri, 27 Jan 2023 00:17:40 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id q15so3478687qtn.0;
        Fri, 27 Jan 2023 00:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tZu0UE1EZs3pbGlFy1jD9C1pnUem8vGmVvI+vwGtGs=;
        b=n3cQ/Ja05wkmEk/tAdwersiUjH5fzCXyT2iJCXUg977GH4IFQmvoNKX6DTmVttRVcg
         qnanpKpf34J0Mxe1BjzQkeSQlpsFPNWb44YbriaKuD59kN/a6CPw4jnCduupn6QW+83n
         aNOVzm+CWxM7jPk78ByGFziY5itnFfRx1DZPiYP85tVm5Mzi7fT46v+cCeuzFogarhQz
         cJS+e2xidQxVQBQmFsCzi60PftKmdyqy2+GUaOBKnzp2cx08TClFrZUu/cbw1Rwi/vp3
         piZXj4N/LftJeFM2uk4wMV+duJTCGk3a6cyBKHtP1WpZz2t7Cx1ZcW0iA5Bjx4acc56l
         yBqw==
X-Gm-Message-State: AFqh2krM9VCYeeHdw8AIhEIkZtZRc8Wo4Lvydi5GYEjEsOg1TSR83gYx
        STF/GPubbyvF9rKk5M4flGZyQhnUdDu7Rg==
X-Google-Smtp-Source: AMrXdXsreJJlm0sHjp0anKyqKV6lR9bU8C3C2yEhCcLM6h6NeeXPUmxChnKQ25RL6qlRvLobZE7QWA==
X-Received: by 2002:ac8:718d:0:b0:3b2:4393:62ce with SMTP id w13-20020ac8718d000000b003b2439362cemr54134500qto.21.1674807459719;
        Fri, 27 Jan 2023 00:17:39 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id el5-20020a05622a430500b00343057845f7sm2278488qtb.20.2023.01.27.00.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 00:17:39 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-4c131bede4bso57349997b3.5;
        Fri, 27 Jan 2023 00:17:38 -0800 (PST)
X-Received: by 2002:a0d:f281:0:b0:508:2f2c:8e5f with SMTP id
 b123-20020a0df281000000b005082f2c8e5fmr730726ywf.384.1674807458484; Fri, 27
 Jan 2023 00:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20230126173513.36659-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230126173513.36659-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Jan 2023 09:17:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX6epwBa9fT9MoU=oC9k6YV2L9NXOEd84QkLnSr2vkDBA@mail.gmail.com>
Message-ID: <CAMuHMdX6epwBa9fT9MoU=oC9k6YV2L9NXOEd84QkLnSr2vkDBA@mail.gmail.com>
Subject: Re: [PATCH v3] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Cong Dang <cong.dang.xn@renesas.com>,
        Hai Pham <hai.pham.ud@renesas.com>,
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

Hi Wolfram,

On Thu, Jan 26, 2023 at 6:41 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> According to the datasheets, the Strobe Timing Adjustment bit (STRTIM)
> setting is different on R-Car SoCs, i.e.
>
> R-Car M3 ES1.*  : STRTIM[2:0] is set to 0x6
> other R-Car Gen3: STRTIM[2:0] is set to 0x7
> other R-Car Gen4: STRTIM[3:0] is set to 0xf
>
> To fix this issue, a DT match data was added to specify the setting
> for special use cases.
>
> Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
> Signed-off-by: Hai Pham  <hai.pham.ud@renesas.com>
> [wsa: rebased, restructured, added Gen4 support]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Changes since v2:
> * dropped support for H3 ES1 (we don't support it upstream anymore)
> * M3-W ES1 now handled via 'compatible' (Thanks, Geert!)
> * -> dropped soc_device_match()
> * removed old rpcif_type entry in struct rpcif (Thanks, Prabhakar)

Thanks for the update!

> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c

> @@ -276,9 +296,9 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
>         rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(rpc->dirmap))
>                 return PTR_ERR(rpc->dirmap);
> -       rpc->size = resource_size(res);
>
> -       rpc->type = (uintptr_t)of_device_get_match_data(dev);
> +       rpc->size = resource_size(res);

Nit: No need to move the initialization of rpc->size.

> +       rpc->info = of_device_get_match_data(dev);
>         rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>
>         return PTR_ERR_OR_ZERO(rpc->rstc);

> @@ -321,12 +341,10 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
>         /* DMA Transfer is not supported */
>         regmap_update_bits(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_HS, 0);
>
> -       if (rpc->type == RPCIF_RCAR_GEN3)
> -               regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> -                                  RPCIF_PHYCNT_STRTIM(7), RPCIF_PHYCNT_STRTIM(7));
> -       else if (rpc->type == RPCIF_RCAR_GEN4)
> -               regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> -                                  RPCIF_PHYCNT_STRTIM(15), RPCIF_PHYCNT_STRTIM(15));
> +       regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> +                          /* create mask with all affected bits set */
> +                          RPCIF_PHYCNT_STRTIM(BIT(fls(rpc->info->strtim)) - 1),

Note that this relies on the strtim value being 4 or higher.
As this value is not user-configurable, but fixed in the driver,
it's probably OK.

> +                          RPCIF_PHYCNT_STRTIM(rpc->info->strtim));
>
>         regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET1, RPCIF_PHYOFFSET1_DDRTMG(3),
>                            RPCIF_PHYOFFSET1_DDRTMG(3));

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
