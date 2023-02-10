Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C6A692300
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjBJQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjBJQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:10:26 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C9F7394B;
        Fri, 10 Feb 2023 08:10:24 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1442977d77dso7247690fac.6;
        Fri, 10 Feb 2023 08:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x8csjOo0ay/WiZRvu3Dg2jwRg3X/GeXQG6HE9v0Ckhg=;
        b=iL6M2cJ6J58klTFq2krCzR2yrvpnQewDDsJ+HQ0E3KbpVvn309aAywYr5JpSGaWTM4
         yUlZqdv0umrcR5h4jMZ51C7vUM3dcUakiLDZFYy+KmTF8yhKpysnP/2F087gI8NuJnsa
         GVFvk0p4Rx+v5t7sqsKsGZ9Wb8T/EkWgcCvuqtpmH9Xf+Qewdjqk9cdhva/Zd1+oY3zA
         Zfd2t9OlHVRskWSOgJREsc6XwUYWxrJuc5IBlfNVhwcLo1LDqIY3OxfjRB3m3N5vLbpF
         Bi26ItCvOBj89eq9Jl+zsbkzLAGPQcBgryKDKYjDkl607O7AibBaS9Ki7/5LLrObTm4T
         5+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8csjOo0ay/WiZRvu3Dg2jwRg3X/GeXQG6HE9v0Ckhg=;
        b=I3DZeszyHjESyFSLcJoHyoYRJUhj6IGUt865gip8o1nh5ywj8+YiKVPnnWojMdxHd3
         nRjzCjBa+UEyPDW1HgYnyU4TuDP2zDfal056/B+NQsEgw5mRNJ8ta4jexSBP96uQIWwB
         0ed6Rs4wBKzIvUq9U/DPAH7Bui2bhXSZLqqgMXa7RaWCTNPU3keCuO+FaxbSX1nX71Xe
         DQbSQcb3SIlYsFaOgTE4L/J58hHdniuHdux4ZFoHeb7fvUTfYxpYeboFtGPTMNTIVrvS
         Qq1ttCjbwZwyk9OYeoRbDXKeX2uePpAQHXEKRRUj1BNAOPvDRfrvRAgDsAlrIbVUXG6Y
         eHDg==
X-Gm-Message-State: AO0yUKXgqPMow4hVTPdwsdn/+8RED1qz2biw4Y/EuvP0S9QirXIaZKqN
        ANTDN67lzHK9tIltrtY9z4QunxYXJa8wXcUt5t8=
X-Google-Smtp-Source: AK7set/39G98hk5WRkbcUBbh2iCORLhHvcPbRo2Cwz0upBoFgp3MMSFVlKeQlhBknHB12xh0IrMQhYuSCVeKoO/swac=
X-Received: by 2002:a05:6870:1199:b0:163:999e:6460 with SMTP id
 25-20020a056870119900b00163999e6460mr857358oau.38.1676045423519; Fri, 10 Feb
 2023 08:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20230203181245.3523937-1-quic_bjorande@quicinc.com>
In-Reply-To: <20230203181245.3523937-1-quic_bjorande@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 10 Feb 2023 08:10:00 -0800
Message-ID: <CAF6AEGuJtiSrLqdZdEf=bz-R0jTg=ayR6OwutBgu5d1dBQUD_Q@mail.gmail.com>
Subject: Re: [RFC] drm/msm/adreno: Balance pm_runtime enable
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 10:12 AM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> When any of the components in the mdss hierarchy fails to bind,
> previously bound components are being unbound again.
>
> One such case happens when the DP controller fails to find its bridge or
> panel, where adreno_unbind() will be invoked without adreno_load_gpu()
> being called to invoke pm_runtime_enable().
>
> The result is that once everything is bound the pm_runtime_get_sync()
> call find the power-domain to have a positive disable_depth, fails
> with -EACCESS and prevents the GPU device to be powered up.
>
> Move the pm_runtime_enable() to adreno_bind(), in order to balance it
> with any calls to adreno_unbind().

I think instead we want to move where the pm_runtime_disable() is..
since pm_runtime_enable() was moved because we can't actually enable
runpm until we have GMU firmware

BR,
-R

> Fixes: 4b18299b3365 ("drm/msm/adreno: Defer enabling runpm until hw_init()")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 36f062c7582f..ca38b837dedb 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -432,15 +432,6 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
>         if (ret)
>                 return NULL;
>
> -       /*
> -        * Now that we have firmware loaded, and are ready to begin
> -        * booting the gpu, go ahead and enable runpm:
> -        */
> -       pm_runtime_enable(&pdev->dev);
> -
> -       /* Make sure pm runtime is active and reset any previous errors */
> -       pm_runtime_set_active(&pdev->dev);
> -
>         ret = pm_runtime_get_sync(&pdev->dev);
>         if (ret < 0) {
>                 pm_runtime_put_sync(&pdev->dev);
> @@ -548,6 +539,8 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>                 return PTR_ERR(gpu);
>         }
>
> +       pm_runtime_enable(dev);
> +
>         return 0;
>  }
>
> --
> 2.25.1
>
