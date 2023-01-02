Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D065B3EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbjABPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjABPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:13:12 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749028FEA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:13:11 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n4so29804753plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=otygSCeqYmw+ATuRegxvbEPgY/sYQb9Ip6+W2rvVaQg=;
        b=a9G0rqbfwcOQy3clY+Qqml/pRfbYB3tTnEXqDNbOVsZW/oJt/kC1Xv5lyiLa4kBSGm
         3zoAcBlS5kMS0qrWlWmDeRRvjU/4kShoMy3tdgdkOca2QT5m3Yy4UFIqYmKYOfG1cCVD
         DspfzOTfaWX+1uQEbN+pxBIyru80S5a524q2+1d9UKlKhK3+IxBRP4BRIRcq8py39qJH
         lrx4pvoREYQh8usxT//rKsGVjLyJcrKovhip8OypTd+udn34vdUF5uXXcYPD5DvFmcmG
         T19ru4YhFZTvPcjU4VdACf1K0ozGQDY4gh7CZ/H++N9vbkRR+fQjGzyJ61hBbxoY9CJA
         z94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otygSCeqYmw+ATuRegxvbEPgY/sYQb9Ip6+W2rvVaQg=;
        b=lv//OzZu1S7g0Nkk7b15gOf1jlJNZFQHzw/Uyu60cqRnCZ2GJcVuKurm7VgAIiG5d0
         ZgOwf/4gZSa3RjlS+qCp7PbBGq+ZsJbM4oRTBNANtQbG4OSiPt0n0xEfYqBOFCjOyfqm
         qUHxkLizAuhNrBmwOEwYfJyenZ9Xr38i3wLFOXZNFELz9r/88EUHNdvhpC8ug66IlV4E
         x3RNDizYHXYyFYOVj4yr20mxZbteVz8BuR3drubM19GPcqh3x2wPEoMqLxhKVTYCVdJV
         806lXKAfINPh7VL+PjE9IuULWPzLS4AD8zBbxtYpaToFm/zIHOYvF/R8MGMiwdK6kMZm
         /4Mg==
X-Gm-Message-State: AFqh2kok9DghvE72sITY9S4yre3E+UPBJYuoKkdDa/MVYOQbw0psCdSr
        ErNur0AVSOz8rscQQTeFEKujydNOA8vNgZhY7EsknPVccQ9HrA==
X-Google-Smtp-Source: AMrXdXvBbRg+gwuK3zo3zJqn8sbYYAEgGNQd6plGlB7o9px13hy9RfXgRvDIwUhQ9Hr1LwldjrkE3KnikV8v2+McWew=
X-Received: by 2002:a17:902:e053:b0:192:8d55:4599 with SMTP id
 x19-20020a170902e05300b001928d554599mr1261766plx.165.1672672390946; Mon, 02
 Jan 2023 07:13:10 -0800 (PST)
MIME-Version: 1.0
References: <0f520597dbad89ab99c217c8986912fa53eaf5f9.1671293108.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <0f520597dbad89ab99c217c8986912fa53eaf5f9.1671293108.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:12:34 +0100
Message-ID: <CAPDyKFrhHnk21qKK0Losg02KCN18JdVZb1CgA=LYj4NwN33_Bw@mail.gmail.com>
Subject: Re: [PATCH] PM: AVS: qcom-cpr: Fix an error handling path in cpr_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Niklas Cassel <nks@flawful.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Dec 2022 at 17:05, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If an error occurs after a successful pm_genpd_init() call, it should be
> undone by a corresponding pm_genpd_remove().
>
> Add the missing call in the error handling path, as already done in the
> remove function.
>
> Fixes: bf6910abf548 ("power: avs: Add support for CPR (Core Power Reduction)")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/qcom/cpr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
> index e9b854ed1bdf..144ea68e0920 100644
> --- a/drivers/soc/qcom/cpr.c
> +++ b/drivers/soc/qcom/cpr.c
> @@ -1708,12 +1708,16 @@ static int cpr_probe(struct platform_device *pdev)
>
>         ret = of_genpd_add_provider_simple(dev->of_node, &drv->pd);
>         if (ret)
> -               return ret;
> +               goto err_remove_genpd;
>
>         platform_set_drvdata(pdev, drv);
>         cpr_debugfs_init(drv);
>
>         return 0;
> +
> +err_remove_genpd:
> +       pm_genpd_remove(&drv->pd);
> +       return ret;
>  }
>
>  static int cpr_remove(struct platform_device *pdev)
> --
> 2.34.1
>
