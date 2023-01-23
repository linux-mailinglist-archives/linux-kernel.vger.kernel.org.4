Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9C678529
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjAWSmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjAWSmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:42:09 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD077305EA;
        Mon, 23 Jan 2023 10:41:54 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e16so14149016ljn.3;
        Mon, 23 Jan 2023 10:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhlPIoKqpJ/PJ8PY23eDY/CCn5R9q7KJI1L+l6DFSV4=;
        b=dx/jDEhG1hiE/kFI8RGzHGw8T1hT9ioGH7WVqBCb9VJk8FVh2viZX8pidjRvU8y3Uv
         xoV2icFJ2XA8JaYSKAynmgGjaOJl88dzLXxDeg8DPCwETzgWYdtVYmpyeL42vbbNPOnN
         0eX+9qD3TZYbMtW+FDJCactkMRPGll2PFssRNRxruGIglqPE+XARZxDlQRTcMaOvPUsx
         19ahd/qnqXb0ON8TTRXUr4rBVw/EeJfvjoYmGR6Vf5MiPGqgFsxDop/l/f5SJHpyZu9J
         f5M9xzlf5B/stfb8aNegBc8jcGVct+tLhwldwH0eztB0CshHb6G1MkgMdg+mnUiJ/0rk
         6hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhlPIoKqpJ/PJ8PY23eDY/CCn5R9q7KJI1L+l6DFSV4=;
        b=UKFpYVr6FcVp0LPSrD3OTjQBqhXk//KGnYYzi3KgheQgI0s/n+YjBxf5DuoYkqdqBr
         iz1UxZEpRZs5QDpw6LSXCM0fMlXyfWsgLIpjZDKnsvxyD+ilIaspjELFXO2qv8n1JzOd
         SNXB2tLSsG11hRrQ6TKF7CsoB46bFxxIWlhw+UPTnUKB9XxFWY24Jag/otHvhmKObG0w
         D5MmwGeXemsSkwP3vDB+ipiqzF76SlVAnN9muVmPgVhhqFhzUmjZb/ZVpKQmnyQ2qBgX
         TTmoplVKpCjw4zHZzd++eq7T3n5hrJppM5y9olN4aBWhc+pJxbfBqeB/Ff5bkGivoAjm
         T4Ow==
X-Gm-Message-State: AFqh2kp5CeVOz4e8JEuQqXbSEEBZVld93mfUWqRAns4Ur9RoaZIPVQY7
        tw5WOmYtvSn3Nr/oSdBqVwfA/zPlQAT4u5Oh/nJbfWaMQoI=
X-Google-Smtp-Source: AMrXdXt7MEbx0j2R3h/DzLsERwYupIS9S9DC3haWahjZuLCsAAsHH1Mgqvu5EM1rKDw/W3IB0C5I993x2Tx/6JctY/I=
X-Received: by 2002:a2e:880a:0:b0:28b:6e8c:1ffb with SMTP id
 x10-20020a2e880a000000b0028b6e8c1ffbmr1144679ljh.65.1674499313074; Mon, 23
 Jan 2023 10:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20230116132152.405535-1-konrad.dybcio@linaro.org> <20230116132152.405535-10-konrad.dybcio@linaro.org>
In-Reply-To: <20230116132152.405535-10-konrad.dybcio@linaro.org>
From:   Arnaud Vrac <rawoul@gmail.com>
Date:   Mon, 23 Jan 2023 19:41:41 +0100
Message-ID: <CAN5H-g54j7kA0+7fmoyj+gOKENycOxJjpHiqbgfM_bYZXj2ofA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] interconnect: qcom: rpm: Don't use
 clk_get_optional for bus clocks anymore
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

With this series on a db820c, I get an error on boot when probing
a0noc because no "bus" clock is defined. If I revert this patch it
works again.

-Arnaud

Le lun. 16 janv. 2023 =C3=A0 14:31, Konrad Dybcio
<konrad.dybcio@linaro.org> a =C3=A9crit :
>
> Commit dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for pro=
vider clocks")
> relaxed the requirements around probing bus clocks. This was a decent
> solution for making sure MSM8996 would still boot with old DTs, but
> now that there's a proper fix in place that both old and new DTs
> will be happy about, revert back to the safer variant of the
> function.
>
> Fixes: dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for pro=
vider clocks")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/q=
com/icc-rpm.c
> index 343e6021a93a..8cff724661f2 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -522,7 +522,7 @@ int qnoc_probe(struct platform_device *pdev)
>         }
>
>  regmap_done:
> -       ret =3D devm_clk_bulk_get_optional(dev, qp->num_bus_clks, qp->bus=
_clks);
> +       ret =3D devm_clk_bulk_get(dev, qp->num_bus_clks, qp->bus_clks);
>         if (ret)
>                 return ret;
>
> --
> 2.39.0
>
