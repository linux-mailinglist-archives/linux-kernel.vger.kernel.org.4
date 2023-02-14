Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68611697034
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjBNV4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjBNV43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:56:29 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CFD1B575;
        Tue, 14 Feb 2023 13:56:24 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-15ff0a1f735so20844947fac.5;
        Tue, 14 Feb 2023 13:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KSatBS/MK7pWYdNv/VGlbNMDCcLZ1O3J6AhpFAuuvQc=;
        b=KOHGs9dCx/MV5ZSbYtdWT5FCwSTrVkX2xYV6S0HrXEr4H00koyiEhV1NXFgvu61Fne
         kxPQi+ZqgnPIpsXOq11R3ZCV9GkMCuAdxzdfFt0w99rPOPFvW6jg5qo3cUBbBxWCUGn5
         y6cyxVh/MBz6dVPj3nyEwUc7wZTw1Od0lYgqeQxrqwwFUCw9wf2CnvJxd38tY57sONk7
         9+p1YPMPH9hPUSbe5cXZMKYY/CGcFsfuXB5DjKjg1V1jx8GyfhLlq+6e2DpGN0HnphK3
         fVMqkGR6fQfswCa930JZoYgmd+Xh60/FFbRI2U2dqRX1jsuil4sgXdeFbOkW7SeU6VIE
         CO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSatBS/MK7pWYdNv/VGlbNMDCcLZ1O3J6AhpFAuuvQc=;
        b=09U9aTRNsBehmQj2tYcXhQjb7LyaZRbUhCkTb5Vte9XIxDoodxzM4P5/xFkVHC6ksW
         6NhjVJXwRCnNVH8JTeOTnLOG/ddhQ8OzmGrfZwuD5aRnQ/5Ar+80FLOAhEYnrLwA99K3
         kJqgbh+3nKB85YjmpyCegA2abeSyCKWFgwkhunWSnbTE6XLwlDzlq7tqbund5COfjwMj
         gYZLLLSn1siUw5zsI7DCCdamrjb5txdxS5YBridtFQE6/nGvIFPY3fhXjhidtgH6cCjS
         EiDRc9GqssQzVNp3LR2CaPoD62RGspqqMm3LdoQBOY5AZ0c0QyXuVF+O6+GjTZXBjEeu
         WWOQ==
X-Gm-Message-State: AO0yUKXr2qZuiAoGlM/nnH0RaR7Pt1nf2cN4zzvz0lLdN4NdQXL/JQNF
        6U08OnEVkwMQ5WBBTfQcTTzfrNvI9t/Nuk/MO6g=
X-Google-Smtp-Source: AK7set/1yYVnUjCEQyoiqfPka498lLP+fGlZ/ugd5TRwuKES936/s9KcP5OJ6pv2MK1r++0COFnb908+NObCmlnu0C4=
X-Received: by 2002:a05:6871:259b:b0:16e:2bc5:1601 with SMTP id
 yy27-20020a056871259b00b0016e2bc51601mr32544oab.38.1676411783384; Tue, 14 Feb
 2023 13:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org> <20230214173145.2482651-11-konrad.dybcio@linaro.org>
In-Reply-To: <20230214173145.2482651-11-konrad.dybcio@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 14 Feb 2023 13:56:12 -0800
Message-ID: <CAF6AEGva3ecxTOx3Yb+Wh-1K=jYA3tDo_aXg09jS9pzJupYExQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] drm/msm/a6xx: Fix up A6XX protected registers
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Tue, Feb 14, 2023 at 9:32 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> One of the protected ranges was too small (compared to the data we
> have downstream). Fix it.
>
> Fixes: 408434036958 ("drm/msm/a6xx: update/fix CP_PROTECT initialization")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 503c750216e6..d6b38bfdb3b4 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -690,7 +690,7 @@ static const u32 a6xx_protect[] = {
>         A6XX_PROTECT_NORDWR(0x00800, 0x0082),
>         A6XX_PROTECT_NORDWR(0x008a0, 0x0008),
>         A6XX_PROTECT_NORDWR(0x008ab, 0x0024),
> -       A6XX_PROTECT_RDONLY(0x008de, 0x00ae),
> +       A6XX_PROTECT_RDONLY(0x008d0, 0x00bc),

Nak, this is intentional, we need userspace to be able to configure
the CP counters.  Otherwise this would break fdperf, perfetto, etc

(although maybe we should comment where we diverge from downstream)

BR,
-R

>         A6XX_PROTECT_NORDWR(0x00900, 0x004d),
>         A6XX_PROTECT_NORDWR(0x0098d, 0x0272),
>         A6XX_PROTECT_NORDWR(0x00e00, 0x0001),
> --
> 2.39.1
>
