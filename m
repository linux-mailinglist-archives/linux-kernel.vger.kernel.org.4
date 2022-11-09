Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DB6622B32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiKIMPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKIMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:15:49 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706813F0F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:15:48 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d20so15853019plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 04:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yybp5GQkINWOGNJfWdB4Wuog9A6gcJ2pt653sLMEWvA=;
        b=SCqUdVWMgRBRF5if0NYhIo9YJLY3EzcceIYuHAdGuVfdc0dt8tITUguFKB8l42msOp
         9zi49zCHJKTs3USdfW+NnzKaM3uSsRxg2OzJSr4ycwGVJ1PdBEBfJMuUQ98fNMpOAITF
         8ZvuqHcNVjiRNbfmBx961B949M6vm/achhz33E8tVNXNlR1yPpkJBNchEOpxter52lRq
         nPjEpsfZi7fe4ox/ubHDkI862st4zHYtI/5qPTWGwR9x4GpdY2sbq79mgudcQZCAz9po
         jaOdyoJBPv2ZJy83KhgkxJ6ambSn2wtRdbUdz5smTpjrmrvG9BELgXwLjNBOJ6zoemEI
         mzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yybp5GQkINWOGNJfWdB4Wuog9A6gcJ2pt653sLMEWvA=;
        b=ycPLWC43513NVt6zvBmuYmLHdjqO/pcYlJ0qJHl2G6CJKW8Q3URE1TXRi3hkbTgQ1H
         dXlWff7TpvrP3G3xE2yA0LHhCw7aC+y4UTeFBDGOT8zxRM8hThIxByTfT6CI5IxUunmR
         hQRZiXd9W3MY0QEy+hFnoV1U22lSPzZ6OAyJ4/hRWrALlPlWifRydjLdyPzOvWKFVUf9
         WCX+/MwbDk89xlw06cEb3WOa+iQZxlUXcDEYF/BOs/vYqv8LiPU+w86TVI87+Tc7D2go
         Zwe+CYPyr3W0fl6xDmSf5vO7WHNemZGwOeiA0NEqcUveHltEspV/BDeqAexuS5WJH8ZZ
         Jt+w==
X-Gm-Message-State: ACrzQf3+sgzgGcPb0fTEmy1MGgls/GNV8XLek4aExpM6gcsYpfOoNQzm
        3Ets7fqQ4MD0OKoVHd82wdKgqje3VrgbjA3n2/r6kj45Z5BLwQ==
X-Google-Smtp-Source: AMsMyM7VP/8HEW9l66u8NEL4a3twNyQ9cwzwT7IBL2QiPspRTi3I6iqZgP4JV5H5B8A2lmw8lMHoYf0PS2sXG2vpfOA=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr80652557pjb.164.1667996148432; Wed, 09
 Nov 2022 04:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com> <20221108082533.21384-2-hayashi.kunihiko@socionext.com>
In-Reply-To: <20221108082533.21384-2-hayashi.kunihiko@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 13:15:11 +0100
Message-ID: <CAPDyKFoiowaut9EhDeBH0ci50WJ7y8UFivxqExxS0EfV_KAhpw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: f-sdh30: Add reset control support
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 at 09:25, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Add reset control support for F_SDH30 controller. This is optional.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

This needs an update to the DT doc too, which is also the case for patch4.

That said, please convert the DT doc into the yaml based format as the
first step.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index 3f5977979cf2..7f4553b28180 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/property.h>
>  #include <linux/clk.h>
> +#include <linux/reset.h>
>
>  #include "sdhci-pltfm.h"
>  #include "sdhci_f_sdh30.h"
> @@ -21,6 +22,7 @@
>  struct f_sdhost_priv {
>         struct clk *clk_iface;
>         struct clk *clk;
> +       struct reset_control *rst;
>         u32 vendor_hs200;
>         struct device *dev;
>         bool enable_cmd_dat_delay;
> @@ -150,6 +152,16 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>                 ret = clk_prepare_enable(priv->clk);
>                 if (ret)
>                         goto err_clk;
> +
> +               priv->rst = devm_reset_control_get_optional_shared(dev, NULL);
> +               if (IS_ERR(priv->rst)) {
> +                       ret = PTR_ERR(priv->rst);
> +                       goto err_rst;
> +               }
> +
> +               ret = reset_control_deassert(priv->rst);
> +               if (ret)
> +                       goto err_rst;
>         }
>
>         /* init vendor specific regs */
> @@ -175,6 +187,8 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>         return 0;
>
>  err_add_host:
> +       reset_control_assert(priv->rst);
> +err_rst:
>         clk_disable_unprepare(priv->clk);
>  err_clk:
>         clk_disable_unprepare(priv->clk_iface);
> @@ -191,8 +205,9 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>         sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
>                           0xffffffff);
>
> -       clk_disable_unprepare(priv->clk_iface);
> +       reset_control_assert(priv->rst);
>         clk_disable_unprepare(priv->clk);
> +       clk_disable_unprepare(priv->clk_iface);
>
>         sdhci_free_host(host);
>         platform_set_drvdata(pdev, NULL);
> --
> 2.25.1
>
