Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3D74F79E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGKR5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjGKR5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:57:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2DF10EF;
        Tue, 11 Jul 2023 10:57:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbf7fbe722so68332425e9.3;
        Tue, 11 Jul 2023 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689098250; x=1691690250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIFkoFyB9SW01SkRjiPF7cZKlQPCkHMlbvXQ3wgbocE=;
        b=PwU/eI3gWiMbv8rCV0Uqye+GFPG76AhQmwZ2FnpaQwJ9y7M4sV6dtyY3iqO4/x+lwu
         ypWOQfiykvDHKN0jp9jwIoKnGcpvU+u03UdwFNoX1pyFBHTSKCg7RVmmpQz8OOe2Grdb
         fjIpGPyF199rb/ohsmNUCNFbcUlVv61jzvHMSZHsGGqNCqn9BZfH8Bh5NOmaI3hbzdzl
         6Phl2rkqt1NxmpHW4FoEt0Q+1O9jrYeR3jDS+S6wpoAr+oicD12M53elgOux1EMVOOnq
         pWkxTr+/z8WB16hnrNjDu/o2FPu6cC++NZLpoQdKcmzih8yHr/iqaW0xkcEg4TvGEJ2o
         Jeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689098250; x=1691690250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIFkoFyB9SW01SkRjiPF7cZKlQPCkHMlbvXQ3wgbocE=;
        b=SkiQiOWOkvTkRmThybQpqlqNo7eza+hfglF3z/WfxhwxF7IbwdJ+7DVkLrj8HLxUt6
         NyXsn+2rw2A6S5nzv16/LskxD1VEVHGFSDmUPQkHHC+aP+zlmIp7MS3LrRWkdk3p6duq
         QU8uaV7K+Qp61yKcFnRjInpKtFw2G5LvPrUJXa1EZQt5YNN25AxWelQBphzETvodhUV8
         FgQopCkd921YaoVH/5CmrPDsLTVa4/5aISzzZLWN2foLDBCTQNfqlh/ZJcQiArMTXKzM
         f5ODnhIevBFEuGGF/47ncqIRZ21YGt1wgKTkzZFJ+dbQOCLhjYB5Sr5Yk/xtS6WvIZCF
         +JOQ==
X-Gm-Message-State: ABy/qLbXOQ/+X6AStsCgMFbo1VzCZ9H3ZajgI7/1/mmZNKYydRxWfnZf
        humQ03oc1N1FeGoa5JSIawI=
X-Google-Smtp-Source: APBJJlHAMpKa+EZaUNoo4wd5oPaMTWpVHMeokblQ7Fn42upmiGHcDty8+Z2Gl9UlIys9DMRnWeJPoQ==
X-Received: by 2002:a1c:7714:0:b0:3fa:aeac:e96c with SMTP id t20-20020a1c7714000000b003faaeace96cmr14348052wmi.9.1689098250022;
        Tue, 11 Jul 2023 10:57:30 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id o5-20020a1c7505000000b003fbd9e390e1sm13591421wmc.47.2023.07.11.10.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:57:29 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/21] thermal/drivers/sun8i: convert to use
 devm_request*_irq_probe()
Date:   Tue, 11 Jul 2023 19:57:26 +0200
Message-ID: <2687714.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230710095926.15614-2-frank.li@vivo.com>
References: <20230710095926.15614-1-frank.li@vivo.com>
 <20230710095926.15614-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 10. julij 2023 ob 11:59:06 CEST je Yangtao Li napisal(a):
> There are more than 700 calls to devm_request_threaded_irq method and
> more than 1000 calls to devm_request_irq method. Most drivers only
> request one interrupt resource, and these error messages are basically
> the same. If error messages are printed everywhere, more than 2000 lines
> of code can be saved by removing the msg in the driver.
>=20
> And tglx point out that:
>=20
>   If we actually look at the call sites of
>   devm_request_threaded_irq() then the vast majority of them print more or
>   less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
>=20
>      519 messages total (there are probably more)
>=20
>      352 unique messages
>=20
>      323 unique messages after lower casing
>=20
>          Those 323 are mostly just variants of the same patterns with
>          slight modifications in formatting and information provided.
>=20
>      186 of these messages do not deliver any useful information,
>          e.g. "no irq", "
>=20
>      The most useful one of all is: "could request wakeup irq: %d"
>=20
>   So there is certainly an argument to be made that this particular
>   function should print a well formatted and informative error message.
>=20
>   It's not a general allocator like kmalloc(). It's specialized and in the
>   vast majority of cases failing to request the interrupt causes the
>   device probe to fail. So having proper and consistent information why
>   the device cannot be used _is_ useful.
>=20
> So convert to use devm_request*_irq_probe() API, which ensure that all
> error handling branches print error information.
>=20
> In this way, when this function fails, the upper-layer functions can
> directly return an error code without missing debugging information.
> Otherwise, the error message will be printed redundantly or missing.
>=20
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/thermal/sun8i_thermal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index 195f3c5d0b38..a952804ff993 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -512,9 +512,9 @@ static int sun8i_ths_probe(struct platform_device *pd=
ev)
>  	 * registered yet, we deffer the registration of the interrupt to
>  	 * the end.
>  	 */
> -	ret =3D devm_request_threaded_irq(dev, irq, NULL,
> -					sun8i_irq_thread,
> -					IRQF_ONESHOT, "ths", tmdev);
> +	ret =3D devm_request_threaded_irq_probe(dev, irq, NULL,
> +					      sun8i_irq_thread,
> +					      IRQF_ONESHOT, "ths", tmdev, NULL);
>  	if (ret)
>  		return ret;
> =20
>=20




