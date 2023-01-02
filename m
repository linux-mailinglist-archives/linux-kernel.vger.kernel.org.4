Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD2D65B25C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjABMt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjABMtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:49:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5811FC2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:49:44 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id k19so10906483pfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TMEbty0JviNpn+Yg5A0C6kfJvNq8b2Lmd3piEj6ZucM=;
        b=xNxnlhnsuQeYEWCioPL1Rr8t7KdGqG8JqqAo1ZY4yCPqKI1ekX1RVvn6hfY6VcXbiQ
         bhLkJpVx4XcTjJcJd3vHyyi1bBw02wB8HWKsF1+Kfe8CWyQXlb45h2DrifhTSLj1n6fO
         0TCR8WkxW9vO4Uqxw/deI2DBs6S4lAgTSbURM/T1FoIr/N1C8/cra+0sXxD2P1wY6nI2
         6ZwBR6i3mC/5uT1JKqyCyGCWn99hhfFaXpMF1PvYDPaVu36RVyAw+LFmAW4AoRfzS8I7
         gBflxdrFhwI0/xQ4z1/s4+NvgfWQamHqiYlKidycHuMaMN4Fq01IcacExFziiS0cb/Lj
         OnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMEbty0JviNpn+Yg5A0C6kfJvNq8b2Lmd3piEj6ZucM=;
        b=U6eNJtKhtG0dKrWxz1soszoFEx+EXjk/azfbq4BFX60d61xvw2fu8X1I5tmZkU1ox4
         NSRxCDGyftqy3YuqGl+jsIFGKKulwFMniVidRNrF20WrM8fBwtToDdGVRAHPiQwJf/Q+
         6svjfZ3FFCKu7+Ay4ngIAXgdHa+gRyg6rYUgC3+bOWSq9HXP2c3IMsBVNJ/2VHw8lsVo
         u8k/HqDs8bf7s3mE47wvtdEhwEkt33ioZFKVoI/LH7d9fMEkK+cnbgZKHRsNc3JKocE2
         2MuwG30sAZSzoU2dxRMQwE7DoeWbUu8xlUmNiOqH59idCmOL2i5lNWguYDNnBMPyyt/n
         8yuQ==
X-Gm-Message-State: AFqh2krqBvOXjMYMueQtVf9u0G5jWjPUv8M0zHTwtHrZrietAvjuvT+U
        J+9l3LtFGu3aYGqEwEwPiOAwsdPrnBcP7imBT4CBfA==
X-Google-Smtp-Source: AMrXdXvzgF7HAsl+aefGp8qa6WXa410ObFc+WdoziWwxlwHOMP/uW5ZYac6nTWvIBRT8mIXKtl58wGKLROQKlWPQDzE=
X-Received: by 2002:a63:5841:0:b0:477:b650:494b with SMTP id
 i1-20020a635841000000b00477b650494bmr2384311pgm.434.1672663784228; Mon, 02
 Jan 2023 04:49:44 -0800 (PST)
MIME-Version: 1.0
References: <7c686fecb11b4ec1f55cd7075dc7cfcdd9b445ba.1670697358.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7c686fecb11b4ec1f55cd7075dc7cfcdd9b445ba.1670697358.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 13:49:08 +0100
Message-ID: <CAPDyKFo7W3EVCFjACB+zaMi8O-wTmCX2winydAB_XtxfnA0Qiw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sunlpus: Fix an error handling path in spmmc_drv_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2022 at 19:36, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If an error occurs after successful clk_prepare_enable() call in the probe,
> the clk is not clk_disable_unprepare()'ed.
>
> Use devm_clk_get_enabled() instead of devm_clk_get() to fix, and simplify
> the probe and the remove function accordingly.
>
> Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This changes the order of resource releasing when the driver is removed,
> but it looks ok to me.
> ---
>  drivers/mmc/host/sunplus-mmc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
> index db5e0dcdfa7f..3e8856a82188 100644
> --- a/drivers/mmc/host/sunplus-mmc.c
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -878,7 +878,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>         if (IS_ERR(host->base))
>                 return PTR_ERR(host->base);
>
> -       host->clk = devm_clk_get(&pdev->dev, NULL);
> +       host->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>         if (IS_ERR(host->clk))
>                 return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
>
> @@ -896,10 +896,6 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       ret = clk_prepare_enable(host->clk);
> -       if (ret)
> -               return dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");
> -
>         ret = mmc_of_parse(mmc);
>         if (ret)
>                 goto probe_free_host;
> @@ -944,7 +940,6 @@ static int spmmc_drv_remove(struct platform_device *dev)
>
>         mmc_remove_host(host->mmc);
>         pm_runtime_get_sync(&dev->dev);
> -       clk_disable_unprepare(host->clk);

I don't think this improves code quality, but rather the opposite.

Removing the call to clk_disable_unprepare() here, makes the untrained
eye, to believe that the calls to pm_runtime_get_sync() and
pm_runtime_put_noidle() are redundant, while they aren't.

Instead, I suggest we add a call to clk_disable_unprepare() in the
error path in ->probe(), rather than using devm_clk_get_enabled().

>         pm_runtime_put_noidle(&dev->dev);
>         pm_runtime_disable(&dev->dev);
>         platform_set_drvdata(dev, NULL);

Kind regards
Uffe
