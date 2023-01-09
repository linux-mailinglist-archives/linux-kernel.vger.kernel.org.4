Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF7D662129
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjAIJOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbjAIJND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:13:03 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18BE12ACD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:09:29 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id e76so7879329ybh.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ksUju8ytzlEweTpFQYqcZ9BkrnYInhKOiXTltSA/eNo=;
        b=KE2dHBcJ85l1aPKOz2mZustc8ycE905TTmv0LmYCR3+SU7Fcb9oIDIC3gA/LE+NGoc
         UWuGEtIYHR2PZtNw87jyhYqZcB699Gp39dylMUUATXUF8/v82qsSarg+eQ4ccoPUevmy
         0WuDy3drpNywj9k7GRGHPML4fZcofOtx5nyYYHGwHawzvputQJ6OshoE9dmMgxlCNd65
         fmpBm+j1sWd9tFiuwKEQG9iKHFF+/kMAkC9HWC4/5w4geGsONLkpUMHVeMhABiBfmXzC
         oNh6Che20j7CWPrm2Qbo9ImKj6xn8w8oH6SJcXoqUrp0iQAmOi2VZ+ZOIwwreGavcCeu
         hRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksUju8ytzlEweTpFQYqcZ9BkrnYInhKOiXTltSA/eNo=;
        b=R90l1GOrqrYAFr1Q1PMUlbX1kkzDTA0MkUMLFx9V8yAttEdMp9cLeBEGjePZGP7FD5
         FHF/Daqa+dW3iXwnYAOhECtSkhTBTXjWLPn/c5sBBEMroy+ZcH7EfRNDNYuWeXym1R+5
         QpQcotDT8LqJ9jXizyhtQTbmg4VQh+9DbURgt8fjQO/BiHy/pJ9+UO+xbeHI/VpZ1ra9
         bns4YuMLM9SilFDIZ23jw1WoPWIYM3THbi6AHMkIfQ5oqY11Y/eD0k2DL4ugWtdfvE7k
         sVKqYH2c7I3J/suF7z65SAtT67x3OBIQwsOVA2gCsszhG6rnl/E/2DlI+8hRdIa5icKk
         qw8w==
X-Gm-Message-State: AFqh2koBxyDfcKhRJA3IAvGxDEAvq83VXdx9FHqIV3TDbcJvrQpKxcYW
        AH5EiqHniUDX0DBcQ7jJxUw8bpptktqAyMD6nqxvmg==
X-Google-Smtp-Source: AMrXdXvgY4bPiSF3cDb82Kc6j/QVAY8FdBTgl+GCmX5CEP6zIModo62yxzJQ6CmBGYfoIPPv5/HCpyD+a7FlHgIMbfY=
X-Received: by 2002:a25:81c7:0:b0:726:7335:50af with SMTP id
 n7-20020a2581c7000000b00726733550afmr7898518ybm.516.1673255368894; Mon, 09
 Jan 2023 01:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20230109025044.27766-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230109025044.27766-1-jiasheng@iscas.ac.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 9 Jan 2023 11:09:18 +0200
Message-ID: <CAA8EJpr=1E6JvE+8NBa7fW5jKe23NhDeAXGBp90XLCphnYc12A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dsi: Add missing check for alloc_ordered_workqueue
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, marijn.suijten@somainline.org,
        vkoul@kernel.org, dianders@chromium.org, marex@denx.de,
        vladimir.lypak@gmail.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 04:51, Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> Add check for the return value of alloc_ordered_workqueue as it may return
> NULL pointer and cause NULL pointer dereference.
> Moreover, change the "goto fail" into "return ret" and drop the "fail"
> label since they are the same.
>
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
>
> v1 -> v2:
>
> 1. Change the "goto fail" into "return ret" and drop the "fail" label.

These are separate changes and should come as separate patches.

> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 89aadd3b3202..819f5be5fd77 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1884,7 +1884,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>         msm_host = devm_kzalloc(&pdev->dev, sizeof(*msm_host), GFP_KERNEL);
>         if (!msm_host) {
>                 ret = -ENOMEM;
> -               goto fail;
> +               return ret;
>         }
>
>         msm_host->pdev = pdev;
> @@ -1893,14 +1893,14 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>         ret = dsi_host_parse_dt(msm_host);
>         if (ret) {
>                 pr_err("%s: failed to parse dt\n", __func__);
> -               goto fail;
> +               return ret;
>         }
>
>         msm_host->ctrl_base = msm_ioremap_size(pdev, "dsi_ctrl", &msm_host->ctrl_size);
>         if (IS_ERR(msm_host->ctrl_base)) {
>                 pr_err("%s: unable to map Dsi ctrl base\n", __func__);
>                 ret = PTR_ERR(msm_host->ctrl_base);
> -               goto fail;
> +               return ret;
>         }
>
>         pm_runtime_enable(&pdev->dev);
> @@ -1909,7 +1909,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>         if (!msm_host->cfg_hnd) {
>                 ret = -EINVAL;
>                 pr_err("%s: get config failed\n", __func__);
> -               goto fail;
> +               return ret;
>         }
>         cfg = msm_host->cfg_hnd->cfg;
>
> @@ -1917,7 +1917,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>         if (msm_host->id < 0) {
>                 ret = msm_host->id;
>                 pr_err("%s: unable to identify DSI host index\n", __func__);
> -               goto fail;
> +               return ret;
>         }
>
>         /* fixup base address by io offset */
> @@ -1927,19 +1927,19 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>                                             cfg->regulator_data,
>                                             &msm_host->supplies);
>         if (ret)
> -               goto fail;
> +               return ret;
>
>         ret = dsi_clk_init(msm_host);
>         if (ret) {
>                 pr_err("%s: unable to initialize dsi clks\n", __func__);
> -               goto fail;
> +               return ret;
>         }
>
>         msm_host->rx_buf = devm_kzalloc(&pdev->dev, SZ_4K, GFP_KERNEL);
>         if (!msm_host->rx_buf) {
>                 ret = -ENOMEM;
>                 pr_err("%s: alloc rx temp buf failed\n", __func__);
> -               goto fail;
> +               return ret;
>         }
>
>         ret = devm_pm_opp_set_clkname(&pdev->dev, "byte");
> @@ -1977,15 +1977,17 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>
>         /* setup workqueue */
>         msm_host->workqueue = alloc_ordered_workqueue("dsi_drm_work", 0);
> +       if (!msm_host->workqueue) {
> +               ret = -ENOMEM;
> +               return ret;
> +       }
> +
>         INIT_WORK(&msm_host->err_work, dsi_err_worker);
>
>         msm_dsi->id = msm_host->id;
>
>         DBG("Dsi Host %d initialized", msm_host->id);
>         return 0;
> -
> -fail:
> -       return ret;
>  }
>
>  void msm_dsi_host_destroy(struct mipi_dsi_host *host)
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
