Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C24677971
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjAWKpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjAWKpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:45:16 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE1A193F0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:45:07 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id k12so8799358qvj.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08p1jI+6elfnKuSSg94O9FjfIBDWaypOUdxAVSVIN8c=;
        b=qbt32op16iZdSOpUE7NV6oN6Iv1e2e+6+dHassM44taEGZadZYg1kmLpEb0cfLgxU2
         BSGfv31CaTHZFo6h+hLGn75Fyd4TW7wbwgRzksOCCWVG4m8dX4aszl7ZKO/PUwtwdDhe
         JQe55IWSA/GhvlOn5/WxufJB+3ypKcN7HzVrQ822xGuuo2+V2tvJQ+rHXquiHIqAjHoD
         4d5eF7SRnPnvUtdrHkX+nT1immOlW14jaISYgwjj9TfS2Y2eDuGqI4eNQ0dmws1Yq36W
         I6UsyyWnhFV6OYipNVnrAZ+u/gks1n0QR+w0aYsyzCOL4p81BitGA0E3x8r5qri814W0
         5ltQ==
X-Gm-Message-State: AFqh2krKX6ydXNt2pzLptqyl+6xx7h2RYMS18bSvt9moi25G6yXtnANT
        GMRq05f14FSfKbnTPlLpr5vAVR5h0+LUMw==
X-Google-Smtp-Source: AMrXdXtPmwOh5PD1/HgLhNnVDZoBt8FfqtqfambkdOo5pBCTMn6K/zTYqNI8YAyzCVuQ21ConN8I4g==
X-Received: by 2002:a05:6214:aa4:b0:535:5cd2:e716 with SMTP id ew4-20020a0562140aa400b005355cd2e716mr20207889qvb.51.1674470706685;
        Mon, 23 Jan 2023 02:45:06 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a29c100b00704c6263924sm14778755qkp.13.2023.01.23.02.45.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 02:45:06 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5018be4ae8eso102826867b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:45:06 -0800 (PST)
X-Received: by 2002:a0d:cbd7:0:b0:46f:bd6:957d with SMTP id
 n206-20020a0dcbd7000000b0046f0bd6957dmr2346573ywd.383.1674470705864; Mon, 23
 Jan 2023 02:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20221123025141.4012-1-jaimeliao.tw@gmail.com>
In-Reply-To: <20221123025141.4012-1-jaimeliao.tw@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Jan 2023 11:44:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU7f25OFOg7ek-37fFQbQ7Wupo2aPgAdA5QrY2HMp5d=g@mail.gmail.com>
Message-ID: <CAMuHMdU7f25OFOg7ek-37fFQbQ7Wupo2aPgAdA5QrY2HMp5d=g@mail.gmail.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix missing setting address
To:     JaimeLiao <jaimeliao.tw@gmail.com>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        jaimeliao@mxic.com.tw, leoyu@mxic.com.tw, alvinzhou@mxic.com.tw,
        juliensu@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaime,

CC linux-renesas-soc

Thanks for your patch!

On Wed, Nov 23, 2022 at 3:55 AM JaimeLiao <jaimeliao.tw@gmail.com> wrote:
> In the RPC manual mode, if the data direction is not set
> (such as the flash erase command), the address misses the
> setting.

This patch never received review comments.
As of commit fff53a551db50f5e ("memory: renesas-rpc-if: Correct QSPI
data transfer in Manual mode") in v5.16-rc1, RPCIF_SMADR is written
before the switch() statement, hence this patch can be ignored.

See also
https://lore.kernel.org/all/CAMuHMdWpvuC2Cm41jCQm+rT8MZB5GN+Z0bPz941QzsHX17Ux-g@mail.gmail.com

> Signed-off-by: JaimeLiao <jaimeliao.tw@gmail.com>

> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -571,6 +571,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
>                 }
>                 break;
>         default:
> +               regmap_write(rpc->regmap, RPCIF_SMADR, rpc->smadr);
>                 regmap_write(rpc->regmap, RPCIF_SMENR, rpc->enable);
>                 regmap_write(rpc->regmap, RPCIF_SMCR,
>                              rpc->smcr | RPCIF_SMCR_SPIE);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
