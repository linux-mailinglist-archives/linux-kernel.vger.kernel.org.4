Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C6564B852
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiLMPYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbiLMPX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:23:58 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561AD38B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:23:57 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vv4so37347560ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNJl4dW3INoFLSur18KGvAEZEys7Zg7HXl7mE/l9WMc=;
        b=cAdyHfnfTDl6Q1NGQlVuUwFnzVmOszYJerLagpzhCTJsBpIZzvJpbcry6wj/DZ8C9b
         T9PXTL/orC/c9TALqWuJtqWUmDhBkUsA8tOl3F3l7VFJ0DdeeepXJiUhgllK03T8m01h
         Vkjo0Sj5XyI7TYIDUEcxxq+unpUGpbk9fqbwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNJl4dW3INoFLSur18KGvAEZEys7Zg7HXl7mE/l9WMc=;
        b=4nOlofDULt1awGW3gyqKr41Cw+/ruxnjtKE/+V3Eg3sYECZ2DzfJo5AHrZX5lmjOkx
         sphnrIuLiqbDS+cN7+9rUa764HGFYcnXyTU34QtKfoxwAHoEEXIBOPAppFa0pi8xqE0T
         8+tFNjJia1rjI7nMfNBnssVTtZhx71zhgJ/gDjOXL/kfl0G/WeRUYcEUKnRMDHr9ofg8
         dzQ5VVi0TEj9Mnnk+5QsL8FLAIo5xFC/Q1VuhJ1FF/wd5UVu1fxHeOPh125KALrs7mXD
         ioLej1xZcvAMS1lcAwsawzE3u3ldMr+ClrX61G92TwxWVeRpB6Ee2/gz+BPurFLz5omG
         bYxQ==
X-Gm-Message-State: ANoB5plEhMpk667C6nQjxtzCgp9bM/z4/gMe1b1nMmZwur6D0bP/gLoc
        rqJpUxCj1NHz+OcqerArbTD07W8545CYfA52FP8=
X-Google-Smtp-Source: AA0mqf6hy8+ALxTNds8VIJYsJhID///UuhATxral4WjsiIPwWUHspYlZCz8qKgLLz+raP1RuZ1I+uQ==
X-Received: by 2002:a17:906:704d:b0:7b9:62ab:dc3f with SMTP id r13-20020a170906704d00b007b962abdc3fmr23217443ejj.1.1670945035733;
        Tue, 13 Dec 2022 07:23:55 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id ku18-20020a170907789200b0079dbf06d558sm4596426ejc.184.2022.12.13.07.23.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 07:23:53 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id ja17so5726556wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:23:53 -0800 (PST)
X-Received: by 2002:a7b:ce10:0:b0:3cf:5731:53db with SMTP id
 m16-20020a7bce10000000b003cf573153dbmr220771wmc.85.1670945032985; Tue, 13 Dec
 2022 07:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20221213002423.259039-1-konrad.dybcio@linaro.org> <20221213002423.259039-5-konrad.dybcio@linaro.org>
In-Reply-To: <20221213002423.259039-5-konrad.dybcio@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 13 Dec 2022 07:23:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U+prbiaQfWRcqp17oRgxFV=JvmweNFoK0+xYcnfoJr=A@mail.gmail.com>
Message-ID: <CAD=FV=U+prbiaQfWRcqp17oRgxFV=JvmweNFoK0+xYcnfoJr=A@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/msm/a6xx: Add support for A650 speed binning
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 12, 2022 at 4:24 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Add support for matching QFPROM fuse values to get the correct speed bin
> on A650 (SM8250) GPUs.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 2c1630f0c04c..f139ec57c32d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1887,6 +1887,20 @@ static u32 a640_get_speed_bin(u32 fuse)
>         return UINT_MAX;
>  }
>
> +static u32 a650_get_speed_bin(u32 fuse)
> +{
> +       if (fuse == 0)
> +               return 0;
> +       else if (fuse == 1)
> +               return 1;
> +       else if (fuse == 2)
> +               return 2;
> +       else if (fuse == 3)
> +               return 3;
> +
> +       return UINT_MAX;

Unlike some of the other functions, you don't need any complexity. Just do:

if (fuse <= 3)
  return fuse;

return UINT_MAX;


I'd also suggest that perhaps "UINT_MAX" isn't exactly the right
return value for when we have an unrecognized fuse. The return type
for the function is "u32" which is a fixed size type. UINT_MAX,
however, is a type that is automatically sized by the compiler. Though
it's unlikely, theoretically a compiler could be configured such that
"unsigned int" was something other than 32 bits. Ideally either the
return type would be changed to "unsigned int" or you'd return
0xffffffff as the sentinel value.

-Doug
