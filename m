Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4240F64482E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiLFPkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiLFPkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:40:51 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B1ABE3B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:40:50 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kw15so3720457ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 07:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VQDzBqsBTE8WLwYAzMMGHQmUn+CuZZVkF9Y36XFfYec=;
        b=kLrPEpykbsLXwkED/QlJ1FLFFvX9oUCpMJKPH4x0GiU8byIpo6HmWG9Xl4xlk8maqA
         aKCRmP7kd8Dz9IRbEOKS5YbYuuxkhhJl9Q5sjHr0iuB9l2Et/XZi1FDpz4I54nt6Dtg4
         Xp+7QF9vE9mokQorQF9Rn7+Mt/gaqnt96+GEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQDzBqsBTE8WLwYAzMMGHQmUn+CuZZVkF9Y36XFfYec=;
        b=wbriEzdbcD0yOSzO0mvzZt4LYvTs2wclFLSasGvXpDzjVo2c2QiWsmAnbjqiywvLiJ
         1h0KpQfcZbRTVus8xfpGjP7UmOCLE9tFs53CDXBw416BszPXa7ExshFl0ke6/Kd+mopK
         nCWGHmUeds5ZD5h8bJ1lRLzz3+Gm4+Ze49CtiUyccG+PDbm5RC/ef08uItfQ+gq0IMG2
         jMNb5jDSf4b10QQGKcTHI38rfE9piKpAGmlznDSbEj7Gqd8DwL4Z1Lu38ocOixZ811FZ
         j9sYnz11aiokrIxGOiISxId8b77Yh7nE9ynxvBL9cV2JikljvM07nlbzz12HLrFeSAr5
         EyMw==
X-Gm-Message-State: ANoB5pmBfAn3C8EEc4jppsW+1izXBUwjvjGW6sSso1PFockIiX7uU8mO
        MY7sYqR1jxCmEdoMRLfLE952PrdHFe4Ody+SMeI=
X-Google-Smtp-Source: AA0mqf6j8LRiDlrPXVKY1wBWsZTxKjq9pNkYA88YrSKny0SoiiW4atHBDuW8dx0Eq6wstfss6aYI2g==
X-Received: by 2002:a17:907:8a22:b0:7af:16b5:9af8 with SMTP id sc34-20020a1709078a2200b007af16b59af8mr372701ejc.33.1670341248690;
        Tue, 06 Dec 2022 07:40:48 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id va11-20020a17090711cb00b007c0f45ad6bcsm2571500ejb.109.2022.12.06.07.40.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 07:40:46 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id r65-20020a1c4444000000b003d1e906ca23so513100wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 07:40:46 -0800 (PST)
X-Received: by 2002:a05:600c:3c8e:b0:3d0:69f4:d3d0 with SMTP id
 bg14-20020a05600c3c8e00b003d069f4d3d0mr23096034wmb.93.1670341245678; Tue, 06
 Dec 2022 07:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20221206075512.812389-1-linmq006@gmail.com>
In-Reply-To: <20221206075512.812389-1-linmq006@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Dec 2022 07:40:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XXoue_vkuM7TmxnECfT3-p9d-OH=H_dyeoOk_Kp4kK2w@mail.gmail.com>
Message-ID: <CAD=FV=XXoue_vkuM7TmxnECfT3-p9d-OH=H_dyeoOk_Kp4kK2w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Fix memory leak in msm_mdss_parse_data_bus_icc_path
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 5, 2022 at 11:55 PM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_icc_get() alloc resources for path1, we should release it when not
> need anymore. Early return when IS_ERR_OR_NULL(path0) may leak path1.
> Add icc_put(path1) in the error path to fix this.
>
> Fixes: b9364eed9232 ("drm/msm/dpu: Move min BW request and full BW disable back to mdss")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index e13c5c12b775..a38fa9a9a3d6 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -49,8 +49,10 @@ static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
>         struct icc_path *path0 = of_icc_get(dev, "mdp0-mem");
>         struct icc_path *path1 = of_icc_get(dev, "mdp1-mem");
>
> -       if (IS_ERR_OR_NULL(path0))
> +       if (IS_ERR_OR_NULL(path0)) {
> +               icc_put(path1);
>                 return PTR_ERR_OR_ZERO(path0);
> +       }
>
>         msm_mdss->path[0] = path0;
>         msm_mdss->num_paths = 1;

Hmmm. I guess the original author of the code (which wasn't me--I just
restored the code that was deleted by a previous change) was assuming
that if mdp0-mem had a problem that mdp1-mem would also have a
problem. That would mean that you wouldn't need to call icc_put() on
it.

...and, in fact, your patch doesn't handle that case, does it? If
_both_ of the two are error or NULL then you'll be calling icc_put()
on something invalid. I guess icc_put() handles those cases without
crashing but it will give a WARN_ON() splat if it happens to be an
error...

Really, there's a better solution anyway. Instead, you should do:

path0 = of_icc_get(dev, "mdp0-mem");
if (IS_ERR_OR_NULL(path0))
  return PTR_ERR_OR_ZERO(path0);

msm_mdss->path[0] = path0;
msm_mdss->num_paths = 1;

path1 = of_icc_get(dev, "mdp1-mem");
if (!IS_ERR_OR_NULL(path1)) {
 ...
}

In other words just defer getting path1 until after you've checked
path0 for an error.

-Doug
