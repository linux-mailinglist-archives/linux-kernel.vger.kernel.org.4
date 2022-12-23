Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E66654ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiLWJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbiLWJtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:49:32 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06108FE4;
        Fri, 23 Dec 2022 01:45:59 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id i20so3309890qtw.9;
        Fri, 23 Dec 2022 01:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yset/1Xy0Y/0VkAi2M9vT3aKztL1wDsleDOE/lWQlFc=;
        b=WJPqtGElsjMfNvNfrDKJ64MogHEaUJpKlCwqYX08V1RM/GZgWhKG8MWTmjaHovwVNg
         jDcFJJa/8Y6ZAUbHi3o+A4C4u+/NIQPll9B5U7tT4WyZ436nWGy32jiTlGiAGWdX2eRR
         cKst1KjWWre9CPICul7Mbvux1Wr2v4utYQ14SKBW+QJbbRbza2MD4lUdf1gP+O2zGdBw
         EQsnxN8QO9P7lp9IwW5uB2+hJIJppI2JP3sCA6aufaLybmAkwnoLHNRSJ2OMsSQfuq0k
         nCfzqFiL1ZkCFOjZ3+s67ysXnnYyxl09+s3+yoQJa5bGHQm/IGLZ1oZkGfDQlgRx8icj
         SVLA==
X-Gm-Message-State: AFqh2kptB6Azzd9l25Q2PtoIfZ7VP1tNPiUy294E+6FuXOAol8h+qMqt
        ppRVaDicqr37V9kP7Cxp9t+qofvZDA0y+Q==
X-Google-Smtp-Source: AMrXdXvELRO6sLXza4/8/TtdXCbUI5a5NGL0PtHcRiiGQ4RsH1U7PR466D7/U6KfdZBbSSHv2iLwVA==
X-Received: by 2002:a05:622a:1b12:b0:3a8:a6f:fb7 with SMTP id bb18-20020a05622a1b1200b003a80a6f0fb7mr10317504qtb.11.1671788716421;
        Fri, 23 Dec 2022 01:45:16 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a405100b006fcb77f3bd6sm2063608qko.98.2022.12.23.01.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 01:45:15 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 192so4753286ybt.6;
        Fri, 23 Dec 2022 01:45:15 -0800 (PST)
X-Received: by 2002:a25:ab49:0:b0:6de:6183:c5c3 with SMTP id
 u67-20020a25ab49000000b006de6183c5c3mr967754ybi.89.1671788715557; Fri, 23 Dec
 2022 01:45:15 -0800 (PST)
MIME-Version: 1.0
References: <1671747798-12935-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1671747798-12935-1-git-send-email-khoroshilov@ispras.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Dec 2022 10:45:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXehA_n78nLXCwBdKV=So=6Vzjt5eye7ZE4bS_BvHnzEA@mail.gmail.com>
Message-ID: <CAMuHMdXehA_n78nLXCwBdKV=So=6Vzjt5eye7ZE4bS_BvHnzEA@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: cpg-mssr: Fix use after free if
 cpg_mssr_common_init() failed
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
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

Hi Alexey,

On Thu, Dec 22, 2022 at 11:23 PM Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
> If cpg_mssr_common_init() fails after assigning priv to global variable
> cpg_mssr_priv, it deallocates priv, but cpg_mssr_priv keeps dangling
> pointer that potentially can be used later.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 1f7db7bbf031 ("clk: renesas: cpg-mssr: Add early clock support")
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Thanks for your patch!

> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -1025,6 +1025,7 @@ static int __init cpg_mssr_common_init(struct device *dev,
>         if (priv->base)
>                 iounmap(priv->base);
>         kfree(priv);
> +       cpg_mssr_priv = NULL;

While this is correct, I think it would be better to just postpone
the initial assignment to cpg_mssr_priv until everything in
cpg_mssr_common_init() has succeeded, i.e. just below the
"return 0;" above.

>
>         return error;
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
