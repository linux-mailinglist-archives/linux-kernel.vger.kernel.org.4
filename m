Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F71C6003F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJPWns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 18:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJPWnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:43:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022412AE16;
        Sun, 16 Oct 2022 15:43:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk15so15805478wrb.13;
        Sun, 16 Oct 2022 15:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDsdEqeSyYndowz7YCRb9tbG1LI9jdAVJZcV10CPOKY=;
        b=b4WAKvQpKxm/VVN+/HaV58gMgbxFzk34sPNg6kh+QcMqPSoaUAIJMybiayxNxS3Ns6
         OhbeYOtq5BOXilCfMdAi0HykbmZSEw9ycZKw4PMEEPvjOXiY5SEh+nCPadeY7rg7qxKY
         Js4KZnD4YsAG4GUDQH5xXN1CcUuuldr1gGRkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDsdEqeSyYndowz7YCRb9tbG1LI9jdAVJZcV10CPOKY=;
        b=vqiJ7VNZxSnbH82jo9DXL4P0fFyFHEOErkiomXGBCFErxwG04TEmoacFUNHF0QJCC0
         svCkTAYSQJGYfYft+VzDWOm5xpyK/KlXCzvVRrDped1i9ia+2zkf4I+hDIYYHwvVS4O9
         DjBL3xl1Z0Y7nX7YKQOmUak8xFVX98PZYoHyVeFuaabn8W9tbtCyekKnbhZDFlrh3N7A
         W2J9dPxO5Op9TWCfgyfy4EJ/KQBqa/LuRe/ooyN+96j4Gmx6B0Do6G2UIvruul0me9Cy
         t2u9m9gB+fn7TrjmJyGE5AGWS/iJqxTXWCSQTTPkQnwkjYpA//RWVeUd1x/6afDOyjiW
         1Qiw==
X-Gm-Message-State: ACrzQf1ApLqNpRhPYvqFj3reZd3rwwq5NAWA1WlmvccCnJseQJ4Zvdvl
        yBKfW2joiT1iQlWWu1erjEHqUS0rELULb8Oi4Xs=
X-Google-Smtp-Source: AMsMyM6+vvLG/zT8BB8DixOZKoQOE4ds/2ACweWZ+P4b8z80ltXBboupc0jh5MD97+Bmf2y5bMFK/mr1zHT+QkeFydM=
X-Received: by 2002:a5d:6c63:0:b0:230:8257:be9e with SMTP id
 r3-20020a5d6c63000000b002308257be9emr4251960wrz.606.1665960222405; Sun, 16
 Oct 2022 15:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221016155722.3520802-1-clg@kaod.org>
In-Reply-To: <20221016155722.3520802-1-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Sun, 16 Oct 2022 22:43:30 +0000
Message-ID: <CACPK8XfrF2h0zYNPcFwHmGfyohCOYQziqoUAJ6j60bEonFHu0A@mail.gmail.com>
Subject: Re: [PATCH] spi: aspeed: Fix window offset of CE1
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022 at 15:57, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The offset value of the mapping window in the kernel structure is
> calculated using the value of the previous window offset. This doesn't
> reflect how the HW is configured and can lead to erroneous setting of
> the second flash device (CE1).

So .offset is expected to be the absolute address of the window, and
this was okay for the 2400/2500 but was broken on the 2600?

Reviewed-by: Joel Stanley <joel@jms.id.au>


>
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Fixes: e3228ed92893 ("spi: spi-mem: Convert Aspeed SMC driver to spi-mem"=
)
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  drivers/spi/spi-aspeed-smc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 33cefcf18392..b90571396a60 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -398,7 +398,7 @@ static void aspeed_spi_get_windows(struct aspeed_spi =
*aspi,
>                 windows[cs].cs =3D cs;
>                 windows[cs].size =3D data->segment_end(aspi, reg_val) -
>                         data->segment_start(aspi, reg_val);
> -               windows[cs].offset =3D cs ? windows[cs - 1].offset + wind=
ows[cs - 1].size : 0;
> +               windows[cs].offset =3D data->segment_start(aspi, reg_val)=
 - aspi->ahb_base_phy;
>                 dev_vdbg(aspi->dev, "CE%d offset=3D0x%.8x size=3D0x%x\n",=
 cs,
>                          windows[cs].offset, windows[cs].size);
>         }
> --
> 2.37.3
>
