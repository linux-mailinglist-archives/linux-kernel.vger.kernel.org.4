Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422446692BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbjAMJPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241467AbjAMJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:14:17 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D9140C2;
        Fri, 13 Jan 2023 01:12:15 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id g9so3965290qtu.2;
        Fri, 13 Jan 2023 01:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqMrCvqCQ4045lh8vjHp/Z6q3B3wdMLy3QiBa0za+Eg=;
        b=wfok/kU1KiQLBK8061ohHfgoSKK1pMm/flqK2jjTzdw+u2XIo1+GVNx4LtcEUcYTzj
         uimvAONiu8BCVj/4184NdIPNXzaj2MYzkrbZ8+/IyBbWf2y0Joup80kAlQ9paOuirBPG
         Oz4h69INfFs0L8DL0ODjdLTnXnUyQZFkTGpL/HCKbufvN7vUpuIbPpyJ/5DyJpbHRUv4
         8stsUNFb+DPVa1kPvJAbW1M1UYw5Ti6xh3wzhYWajPAzCDx6O7SahXC8rMOrn+ztzcVw
         LW+RDYim7bKC0pp1wxwyhr/dqAczJDf6VOWGkjuXMbBTRENeCvtzRCv3CEtrAI0Tfra2
         InkA==
X-Gm-Message-State: AFqh2koc5y1OVznbxD1PDoBnnUqYWqmG+ijpmmAi3/nmHMR6saZ3sPGw
        9WAXrJhCMDlTkOsbSYiAZKlLSVIL6UZqVQ==
X-Google-Smtp-Source: AMrXdXuSt1yXH+2aX6Q+FuvAzlEqUm9hdczPYtKv/jQ6Da81MMMK83zA/9FW5EeDmK9V9t9K5MHYaQ==
X-Received: by 2002:ac8:7766:0:b0:3a5:f9cb:886f with SMTP id h6-20020ac87766000000b003a5f9cb886fmr106122783qtu.29.1673601134708;
        Fri, 13 Jan 2023 01:12:14 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a258e00b006e07228ed53sm12270052qko.18.2023.01.13.01.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 01:12:14 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id c124so21625147ybb.13;
        Fri, 13 Jan 2023 01:12:14 -0800 (PST)
X-Received: by 2002:a25:b944:0:b0:7b2:4421:82be with SMTP id
 s4-20020a25b944000000b007b2442182bemr2669630ybm.380.1673601133864; Fri, 13
 Jan 2023 01:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20230113080550.1736-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230113080550.1736-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Jan 2023 10:12:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVw+fCqEewmY7BA4q0a=WAaDguaTChGKwUXFtWMCV8SaQ@mail.gmail.com>
Message-ID: <CAMuHMdVw+fCqEewmY7BA4q0a=WAaDguaTChGKwUXFtWMCV8SaQ@mail.gmail.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
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

Hi Wolfram,

On Fri, Jan 13, 2023 at 9:10 AM Wolfram Sang
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

Thanks for your patch!

> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +#include <linux/sys_soc.h>
>
>  #include <memory/renesas-rpc-if.h>
>
> @@ -163,6 +164,36 @@ static const struct regmap_access_table rpcif_volatile_table = {
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
> +       { /* Sentinel. */ }
> +};
>
>  /*
>   * Custom accessor functions to ensure SM[RW]DR[01] are always accessed with

> @@ -321,12 +359,9 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
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
> +                          RPCIF_PHYCNT_STRTIM(rpc->info->strtim),
> +                          RPCIF_PHYCNT_STRTIM(rpc->info->strtim));

I'm not sure this is guaranteed to work, as using rpc->info->strtim as
the mask may not clear all bits (e.g. on R-Car M3-W it is 6, not 7), and
the initial values of the bits are documented to be undefined.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
