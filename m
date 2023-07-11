Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B694174F7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjGKSVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGKSVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:21:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85ECA7;
        Tue, 11 Jul 2023 11:21:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso63216625e9.1;
        Tue, 11 Jul 2023 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689099711; x=1691691711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGWHx9YJ+sHVNTsptq70WfauAMDUdyhwhtAtAzyLwys=;
        b=prNF0Bq4jlrRmDZIFceo67OVeHpV7LyMJF62uFY4evVYGhKXZ2KX7vOp1GYtUqEJqQ
         1YkCBn4nq7Rg0+FXaukk9empTRsaqwHd7B2sfWgLgnRTx4Mg/poRPgQtnUpNRMiTfNaI
         labMKzslQ2IyO/Ku2bj48xvMm/9cmg/J1cMbMau66Zwffgfaeg3vIcZ6cVv4zIT1cPwN
         tIr8PyoYZt0PT81072nSpa3+XuAyLgO11ic0zgo0r2pbsDbb3I6uGlEDJroFNg/exYb0
         yppraMnyaP2moBsaIJL5NPqh1JFbFBrJT74gopugLkeBhFhEoP37awDrn9KjJXlrOKlH
         4msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689099711; x=1691691711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGWHx9YJ+sHVNTsptq70WfauAMDUdyhwhtAtAzyLwys=;
        b=lUGYXrdPVA6fDGdyWbXh+GVQK3tl38pM9cSpFk1KXYf2tKlsuQvkLeqHvbyEOHh5js
         XiarNyNOpLf4p33yedktp2AnItWDsiiQI6K8H7nW2mHiaXgjCyyecwl6KvaZC0oPo9nC
         H3Nyie6vCNjwN7dg+kupFAx7DKdIYd8p4WLZQx3Ve5Xxbb3u900ve6Zvm3BOSI94ouKY
         DQ4EecA1vNFFIZlRhcNiQp0ejzWK48sBJB4zbw+jnvjbxFmiuVjF39KSdzp1Uqcr9aOv
         hCR9kVCHDAdhGVKmkEqjXtOqbGG3aio/0LcF/42ydpqPUip3ehMp8ghjxPURUqwQMRwU
         GGjg==
X-Gm-Message-State: ABy/qLZaxL+f6s4eF7nU1X3v5ONVLg2L23jpA3DlUe2SAK1EmINPqqK3
        8LBYSLx0QXcoioRRIfLWmww=
X-Google-Smtp-Source: APBJJlEFb9G4bpiHa136SPi/MkE+zBko96esqUm3GHlYDJ7dCzh9UL1oaa67tntEVLsezYDMO5yv7A==
X-Received: by 2002:a7b:ce8a:0:b0:3fb:be07:5343 with SMTP id q10-20020a7bce8a000000b003fbbe075343mr14767059wmj.27.1689099711063;
        Tue, 11 Jul 2023 11:21:51 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003fbd597bccesm13649262wmi.41.2023.07.11.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 11:21:50 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 13/18] soc: sunxi: Move power-domain driver to the genpd dir
Date:   Tue, 11 Jul 2023 20:21:48 +0200
Message-ID: <8241854.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20230711142204.751754-1-ulf.hansson@linaro.org>
References: <20230711142204.751754-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 11. julij 2023 ob 16:22:04 CEST je Ulf Hansson napisal(a):
> To simplify with maintenance let's move the sunxi power-domain driver to
> the new genpd directory. Going forward, patches are intended to be managed
> through a separate git tree, according to MAINTAINERS.
> 
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: <linux-sunxi@lists.linux.dev>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/genpd/Makefile                    | 1 +
>  drivers/genpd/sunxi/Makefile              | 2 ++
>  drivers/{soc => genpd}/sunxi/sun20i-ppu.c | 0
>  drivers/soc/sunxi/Makefile                | 1 -
>  4 files changed, 3 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/genpd/sunxi/Makefile
>  rename drivers/{soc => genpd}/sunxi/sun20i-ppu.c (100%)
> 
> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> index baf2021235a7..76f2a411e6bc 100644
> --- a/drivers/genpd/Makefile
> +++ b/drivers/genpd/Makefile
> @@ -9,3 +9,4 @@ obj-y					+= 
renesas/
>  obj-y					+= rockchip/
>  obj-y					+= samsung/
>  obj-y					+= starfive/
> +obj-y					+= sunxi/
> diff --git a/drivers/genpd/sunxi/Makefile b/drivers/genpd/sunxi/Makefile
> new file mode 100644
> index 000000000000..ec1d7a2fb21d
> --- /dev/null
> +++ b/drivers/genpd/sunxi/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_SUN20I_PPU)		+= sun20i-ppu.o
> diff --git a/drivers/soc/sunxi/sun20i-ppu.c
> b/drivers/genpd/sunxi/sun20i-ppu.c similarity index 100%
> rename from drivers/soc/sunxi/sun20i-ppu.c
> rename to drivers/genpd/sunxi/sun20i-ppu.c
> diff --git a/drivers/soc/sunxi/Makefile b/drivers/soc/sunxi/Makefile
> index 90ff2ebe7655..549159571d4f 100644
> --- a/drivers/soc/sunxi/Makefile
> +++ b/drivers/soc/sunxi/Makefile
> @@ -1,4 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_SUNXI_MBUS) +=	sunxi_mbus.o
>  obj-$(CONFIG_SUNXI_SRAM) +=	sunxi_sram.o
> -obj-$(CONFIG_SUN20I_PPU) +=	sun20i-ppu.o




