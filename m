Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92A86E2B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 23:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDNVBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 17:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDNVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:01:52 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ECD46BC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:01:48 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v7so18781081ybi.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681506108; x=1684098108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bpfMXe/KqbWIelZJe4uoAyC5aNyWUPiACGVGh2qmwy4=;
        b=ESxeOXEPGqrm0OS/iNJo92P5dIcNLtF7YiRD/kjS8BUetUNEyGG7UaUQoJoAoqLqss
         jxVBbTO2w39KwZLpr9YYuLgInyUGx1ZkwhzNueqqlfVLpPqQOJd1b+77d0mR39cxYqQn
         2/lDQzTCSEMjoGhVcVsGyjnRl84ypMIACewEg12ToTddPHqAN99b4nJZIlcgoTRu2yLz
         JEOugPwNuXnJUehwVqNeK+NeAu3vIr2+6x9Dhpru0CxqMYKizlccomIHjSJCjfG9Is6e
         J5ZfnZ2NH/mk4S4tSwgeGm6t5RQeqChr6g+QMSRPjvgdD9QrWCIYfZuaPtWpYPzZkKB3
         RXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681506108; x=1684098108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpfMXe/KqbWIelZJe4uoAyC5aNyWUPiACGVGh2qmwy4=;
        b=daLZLm2GZYv/BMrAWnB0BHZCwey9jMdmuL1nFLKa7vvNMPA3/r7dgfWJFiv+xsPubk
         yZzDwqPSRrRNSHMPZJHeVrfTZeOZdrpPLgxLY7eg2P4jbQrrd9/G6W4Qkys1Ifcy/7I8
         kxiKpdievYS54HVqCH1ruD5J0rFpV9vCG/rV8iBNVy5ByRbdWeQx+ckAdAoT0PcwJsvq
         WmG6JOWr1IJ53UjyadDRsbva8HwqRD+w9c82JRrXmX+VhjebKFN1IJ3VkiNLbdkuI69o
         aq6/S+VeUXpuQEnJHmbRCBj8on4hZuMGh8g7DxZRY2AcURzXypDK6g5O6hAFiT87GF8d
         upqA==
X-Gm-Message-State: AAQBX9f7one0HpFFe/UqLnpjdbBtry8ZyOpY5SLWHQHE0O3inFh2r77H
        AVj07dngKCLL55xo79pn2nFuY/bYjzWDVLp4yLp/Kg==
X-Google-Smtp-Source: AKy350a6AQhCKOCqsuAPG4WgtTUaUp2Zmf+Z17MMZxfmVFeziyrPpCdMUQwN/3lykz1gOYCumpn4K1dyAr2SD+v3B60=
X-Received: by 2002:a25:748e:0:b0:b6c:2d28:b3e7 with SMTP id
 p136-20020a25748e000000b00b6c2d28b3e7mr4606248ybc.9.1681506108117; Fri, 14
 Apr 2023 14:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <1681490777-15351-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1681490777-15351-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 15 Apr 2023 00:01:37 +0300
Message-ID: <CAA8EJppy0bGKQsQFoDZtWgtKrZuU5NLVoteXMbqDR30Var92NA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dpu: always program DSC active bits
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch,
        airlied@gmail.com, agross@kernel.org, andersson@kernel.org,
        marijn.suijten@somainline.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 at 19:46, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> In current code, the dsc active bits are set only if the cfg->dsc is set.
> However, for displays which are hot-pluggable, there can be a use-case
> of disconnecting a DSC supported sink and connecting a non-DSC sink.
>
> For those cases we need to clear DSC active bits during teardown.
>
> As discuss at [1], clear DSC active bit will handled at reset_intf_cfg()

nit: discussed

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Fixes: 77f6da90487c ("drm/msm/disp/dpu1: Add DSC support in hw_ctl")
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>
> [1] https://lore.kernel.org/linux-arm-msm/ec045d6b-4ffd-0f8c-4011-8db45edc6978@quicinc.com/
> ---

Changelog? This is v3 already, but it has no changes described.

>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index bbdc95c..88e4efe 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -541,10 +541,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
>         if (cfg->merge_3d)
>                 DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
>                               BIT(cfg->merge_3d - MERGE_3D_0));
> -       if (cfg->dsc) {
> -               DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
> -               DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
> -       }
> +

And the comment got dropped. Please restore it in some form.

> +       DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
> +       DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
>  }
>
>  static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
