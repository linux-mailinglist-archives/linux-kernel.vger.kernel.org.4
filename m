Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E53698A76
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBPCW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBPCW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:22:26 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA382A6CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:22:25 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id i137so607416ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CM7+nbuu2JRbsspQMF7cJUrYUSFpszj5JfnwXasrm4A=;
        b=gigIXAI3bPveEUhfHtx570QVDRLxYX8xjSWbAgaaNJr8OHn4vARDGJsyhfgvBLcMDu
         L5wohJVj2YE+B1UmeMMEN6eX9hUlJGWCeWF7OnleAViT0ZiH0tFgvT5A3+q9q/yyljTw
         ak7eMAvbDlFACfYoveoHaq4Py9kkWFfouQrsr47NUWXPzKtEDokaedfZGbJwddAIDhrW
         Eq3AqzDzSq5H1b23lX6l7HL83+naDjPPRpreyReiWB+51yIxAmZAqD5QTlck2h48tnc9
         8p+PYJU9rmsSSUfVjun4M1wT54J5PfT0Xv86UY5+V0xApa7rXLzqYb1KL5FzmUKMWxw0
         FNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CM7+nbuu2JRbsspQMF7cJUrYUSFpszj5JfnwXasrm4A=;
        b=bxJsUkNwTvwCJ9EtQJX+EqJI0CvZ7a+Fc3y7xCE4OJgH9s7kxEqbp9BLV4scdhVI46
         deGyqGbKqBxVUykddbw+mAHVkq6VLV20pjkhzOPZeCXB9fD+ICQZIuFiotn4SKzegG2P
         lUxUhsVLBl5eO5djkin08gBZhPi/Rdx9bDKbALu7FRY5QuGQnL3EXVKWMYhPVJSsis/i
         XoGM7PFYtOKBAssCUz9xK3Sef2qiq5UIrQNU7tBYMkG4kY2qxJeQOGHLqLUV6ikb7qIM
         AX2iu7s6zt8+tc4VQsRnFI75yDpTJ23SAjAtcWFxrTEWob0hNn6CkkTrDhIJFlGOqZBD
         ciVw==
X-Gm-Message-State: AO0yUKVwGjZSTdDoenGHHxGEqI/kdbus9wYmxrKqINoaMO2m13Ntb+Et
        oigdp1OXRhMrsVB73VLJIbuoIbyRRetqXzpieGqDQQ==
X-Google-Smtp-Source: AK7set/dOBv0noQbP2fgaIWTgCF1NkJvZ1c87YBke3v3Br/DUuhltjLJlt/oBAfG1FZOUEQf5yA2VgwloLnLwaQtJ/E=
X-Received: by 2002:a25:9c07:0:b0:905:d0a5:3ff6 with SMTP id
 c7-20020a259c07000000b00905d0a53ff6mr547394ybo.322.1676514144276; Wed, 15 Feb
 2023 18:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20230215-sspp-scaler-version-v1-0-416b1500b85b@somainline.org> <20230215-sspp-scaler-version-v1-1-416b1500b85b@somainline.org>
In-Reply-To: <20230215-sspp-scaler-version-v1-1-416b1500b85b@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Feb 2023 04:22:13 +0200
Message-ID: <CAA8EJpq1L32VQ1eQEk2YQWqCwHgdFQfuWPhQx=PmhzXvazLgPA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/msm/dpu: Read previously-uninitialized SSPP
 scaler version from hw
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 at 01:02, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> DPU's catalog never assigned dpu_scaler_blk::version leading to
> initialization code in dpu_hw_setup_scaler3 to wander the wrong
> codepaths.  Instead of hardcoding the correct QSEED algorithm version,
> read it back from a hardware register.
>
> Note that this register is only available starting with QSEED3, where
> 0x1002 corresponds to QSEED3, 0x2004 to QSEED3LITE and 0x3000 to QSEED4.

This is not purely accurate. 0x1003 (sdm845) also corresponds to QSEED3.
I'd say instead that there are several variations of QSEED3 scalers,
where starting from 0x2004 it is called QSEED3LITE and starting from
0x3000 it is called QSEED4.

>
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 --
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c    | 8 +++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h    | 3 +++
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index ddab9caebb18..96ce1766f4a1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -324,11 +324,9 @@ struct dpu_src_blk {
>  /**
>   * struct dpu_scaler_blk: Scaler information
>   * @info:   HW register and features supported by this sub-blk
> - * @version: qseed block revision
>   */
>  struct dpu_scaler_blk {
>         DPU_HW_SUBBLK_INFO;
> -       u32 version;

No. Please keep the version in the scaler subblk.  It is a version of
the QSEED (scaler block), not the SSPP's version.

There is a block called DS (destination scaler), which can be used to
scale the resulting image after the LM. This block also uses the
QSEED3(,LITE,4) scaler block.

>  };
>
>  struct dpu_csc_blk {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> index 4246ab0b3bee..d4e181e1378c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
> @@ -430,7 +430,7 @@ static void _dpu_hw_sspp_setup_scaler3(struct dpu_hw_pipe *ctx,
>                 return;
>
>         dpu_hw_setup_scaler3(&ctx->hw, scaler3_cfg, idx,
> -                       ctx->cap->sblk->scaler_blk.version,
> +                       ctx->version,
>                         sspp->layout.format);
>  }
>
> @@ -807,6 +807,12 @@ struct dpu_hw_pipe *dpu_hw_sspp_init(enum dpu_sspp idx,
>         hw_pipe->mdp = &catalog->mdp[0];
>         hw_pipe->idx = idx;
>         hw_pipe->cap = cfg;
> +
> +       if (test_bit(DPU_SSPP_SCALER_QSEED3, &cfg->features) ||
> +                       test_bit(DPU_SSPP_SCALER_QSEED3LITE, &cfg->features) ||
> +                       test_bit(DPU_SSPP_SCALER_QSEED4, &cfg->features))
> +               hw_pipe->version = _dpu_hw_sspp_get_scaler3_ver(hw_pipe);
> +
>         _setup_layer_ops(hw_pipe, hw_pipe->cap->features);
>
>         return hw_pipe;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> index 0c95b7e64f6c..eeaf16c6af15 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
> @@ -352,6 +352,7 @@ struct dpu_hw_sspp_ops {
>   * @hw: block hardware details
>   * @catalog: back pointer to catalog
>   * @mdp: pointer to associated mdp portion of the catalog
> + * @version: qseed block revision
>   * @idx: pipe index
>   * @cap: pointer to layer_cfg
>   * @ops: pointer to operations possible for this pipe
> @@ -362,6 +363,8 @@ struct dpu_hw_pipe {
>         const struct dpu_mdss_cfg *catalog;
>         const struct dpu_mdp_cfg *mdp;
>
> +       u32 version;
> +
>         /* Pipe */
>         enum dpu_sspp idx;
>         const struct dpu_sspp_cfg *cap;
>
> --
> 2.39.2
>


-- 
With best wishes
Dmitry
