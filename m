Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7591F64E489
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLOXLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiLOXLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:11:37 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31CD5FB95
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:11:34 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 192so583956ybt.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Szzl/alf+UR8Vwg7EPAO+cB8Tlpry3/LxWbMwieNXB8=;
        b=YyA6xgDsOKtdJqw5/VT8jKceCzCyN/tMM7v0IBz0fv4Avivo1341iZ+z02yn6f9qAN
         VzA9UiWPbIvdy99S9k5B35Jd1Urrab5naqEW7CJLGkm7DH6DQ81KI8QnpzSgYdMDzfS9
         FEpQRpZRTO4Dl64DNzT9b/ffBNJeTxwli8rvk++P8RKmqf+ig88VZ8eEV2SK45XkwrkH
         4viEtQBUHxRZWFdP03eeKvLckOkOopTeSGlzgZ4j4L02MlbYuzlDFqDIMif16YJES0Iz
         Pt/LP/PGSR0LwnB17ygp6iQXuVsehBAufEPT4gFc01K+wrcVohNiRProchCJb35C6dk0
         xpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Szzl/alf+UR8Vwg7EPAO+cB8Tlpry3/LxWbMwieNXB8=;
        b=whjktni0KZe6zglK2ApT+HptPzFauxKJiID+thC+5CMKTdY6EUsrqnJE9N7tkkzM4v
         SCkiOjKTgr3fEnBiGG5kJ+/4wKl6nUIMogKfQo8r48uE0YMJHaE/yV6hOFzRU7rO5v7q
         Nilc8UbWtGNBGvq0O5D++WSA9KkXWGlBDLmf/aTgQj5LXu8PmnZSsp2h+CoKmQKDnDHA
         owhpn6/KqfON7E0/vtcUd3+UqsFmgmMyn1T1hMPbr9vWVS7SBhP0d1RHrAxxIk3egZs8
         x6BIBJB4aacRPhXjVUuQ4t1HYdFFNL0K2YFuShZhc+Vs/KAh9Jxp2nEtmaV2qK0e+osg
         kVQA==
X-Gm-Message-State: ANoB5pmSQQX7b+UXsqyuU7lHvYaaoXCGbQR/yqZ1NDWLGO546r0HRKHB
        YJQBamdB1DWdLA2gRqN4BmZQJ5zy1/E/T5ZkPpVGXg==
X-Google-Smtp-Source: AA0mqf4T4+tFhPKcT71HbXhjadonYTlRa+tuHPeWOSn63wwK0Qxfh/bCCjSw1MiXkZzbVQbYfqTKnabPMXzomTn/oUY=
X-Received: by 2002:a25:8544:0:b0:723:5b57:cde9 with SMTP id
 f4-20020a258544000000b007235b57cde9mr2851707ybn.194.1671145893878; Thu, 15
 Dec 2022 15:11:33 -0800 (PST)
MIME-Version: 1.0
References: <1671144775-19077-1-git-send-email-quic_khsieh@quicinc.com> <1671144775-19077-3-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1671144775-19077-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 16 Dec 2022 01:11:22 +0200
Message-ID: <CAA8EJpp0j8LF5YRVR_x+JBPxp1-Cfd_z_G3Z9TBHJNg-GeE99A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/msm/dp: enhance dp controller isr
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 at 00:53, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> dp_display_irq_handler() is the main isr handler with the helps
> of two sub isr, dp_aux_isr and dp_ctrl_isr, to service all DP
> interrupts on every irq triggered. Current all three isr does
> not return IRQ_HANDLED if there are any interrupts it had
> serviced. This patch fix this ambiguity by having all isr
> return IRQ_HANDLED if there are interrupts had been serviced
> or IRQ_NONE otherwise.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c     | 96 ++++++++++++++++++++++++-------------
>  drivers/gpu/drm/msm/dp/dp_aux.h     |  2 +-
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 13 +++--
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 16 +++++--
>  5 files changed, 86 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index cc3efed..2b85b61 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -162,45 +162,78 @@ static ssize_t dp_aux_cmd_fifo_rx(struct dp_aux_private *aux,
>         return i;
>  }
>
> -static void dp_aux_native_handler(struct dp_aux_private *aux, u32 isr)
> +static irqreturn_t dp_aux_native_handler(struct dp_aux_private *aux, u32 isr)
>  {
> -       if (isr & DP_INTR_AUX_I2C_DONE)
> +       irqreturn_t ret = IRQ_NONE;
> +
> +       if (isr & DP_INTR_AUX_I2C_DONE) {
>                 aux->aux_error_num = DP_AUX_ERR_NONE;
> -       else if (isr & DP_INTR_WRONG_ADDR)
> +               ret = IRQ_HANDLED;
> +       } else if (isr & DP_INTR_WRONG_ADDR) {
>                 aux->aux_error_num = DP_AUX_ERR_ADDR;
> -       else if (isr & DP_INTR_TIMEOUT)
> +               ret = IRQ_HANDLED;
> +       } else if (isr & DP_INTR_TIMEOUT) {
>                 aux->aux_error_num = DP_AUX_ERR_TOUT;
> -       if (isr & DP_INTR_NACK_DEFER)
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       if (isr & DP_INTR_NACK_DEFER) {
>                 aux->aux_error_num = DP_AUX_ERR_NACK;
> +               ret = IRQ_HANDLED;
> +       }
> +
>         if (isr & DP_INTR_AUX_ERROR) {
>                 aux->aux_error_num = DP_AUX_ERR_PHY;
>                 dp_catalog_aux_clear_hw_interrupts(aux->catalog);
> +               ret = IRQ_HANDLED;
>         }
> +
> +       return ret;
>  }
>
> -static void dp_aux_i2c_handler(struct dp_aux_private *aux, u32 isr)
> +static irqreturn_t dp_aux_i2c_handler(struct dp_aux_private *aux, u32 isr)
>  {
> +       irqreturn_t ret = IRQ_NONE;
> +
>         if (isr & DP_INTR_AUX_I2C_DONE) {
>                 if (isr & (DP_INTR_I2C_NACK | DP_INTR_I2C_DEFER))
>                         aux->aux_error_num = DP_AUX_ERR_NACK;
>                 else
>                         aux->aux_error_num = DP_AUX_ERR_NONE;
> -       } else {
> -               if (isr & DP_INTR_WRONG_ADDR)
> -                       aux->aux_error_num = DP_AUX_ERR_ADDR;
> -               else if (isr & DP_INTR_TIMEOUT)
> -                       aux->aux_error_num = DP_AUX_ERR_TOUT;
> -               if (isr & DP_INTR_NACK_DEFER)
> -                       aux->aux_error_num = DP_AUX_ERR_NACK_DEFER;
> -               if (isr & DP_INTR_I2C_NACK)
> -                       aux->aux_error_num = DP_AUX_ERR_NACK;
> -               if (isr & DP_INTR_I2C_DEFER)
> -                       aux->aux_error_num = DP_AUX_ERR_DEFER;
> -               if (isr & DP_INTR_AUX_ERROR) {
> -                       aux->aux_error_num = DP_AUX_ERR_PHY;
> -                       dp_catalog_aux_clear_hw_interrupts(aux->catalog);
> -               }
> +
> +               return IRQ_HANDLED;
> +       }
> +
> +       if (isr & DP_INTR_WRONG_ADDR) {
> +               aux->aux_error_num = DP_AUX_ERR_ADDR;
> +               ret = IRQ_HANDLED;
> +       } else if (isr & DP_INTR_TIMEOUT) {
> +               aux->aux_error_num = DP_AUX_ERR_TOUT;
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       if (isr & DP_INTR_NACK_DEFER) {
> +               aux->aux_error_num = DP_AUX_ERR_NACK_DEFER;
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       if (isr & DP_INTR_I2C_NACK) {
> +               aux->aux_error_num = DP_AUX_ERR_NACK;
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       if (isr & DP_INTR_I2C_DEFER) {
> +               aux->aux_error_num = DP_AUX_ERR_DEFER;
> +               ret = IRQ_HANDLED;
>         }
> +
> +       if (isr & DP_INTR_AUX_ERROR) {
> +               aux->aux_error_num = DP_AUX_ERR_PHY;
> +               dp_catalog_aux_clear_hw_interrupts(aux->catalog);
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       return ret;
>  }
>
>  static void dp_aux_update_offset_and_segment(struct dp_aux_private *aux,
> @@ -409,15 +442,11 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>         return ret;
>  }
>
> -void dp_aux_isr(struct drm_dp_aux *dp_aux)
> +irqreturn_t dp_aux_isr(struct drm_dp_aux *dp_aux)
>  {
>         u32 isr;
>         struct dp_aux_private *aux;
> -
> -       if (!dp_aux) {
> -               DRM_ERROR("invalid input\n");
> -               return;
> -       }

Any reason to remove this? It doesn't belong to the IRQ patch.

> +       irqreturn_t ret = IRQ_NONE;

Just irqreturn_t ret;

>
>         aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
>
> @@ -425,17 +454,20 @@ void dp_aux_isr(struct drm_dp_aux *dp_aux)
>
>         /* no interrupts pending, return immediately */
>         if (!isr)
> -               return;
> +               return ret;

return IRQ_NONE;

>
>         if (!aux->cmd_busy)
> -               return;
> +               return ret;

return IRQ_NONE;

>
>         if (aux->native)
> -               dp_aux_native_handler(aux, isr);
> +               ret = dp_aux_native_handler(aux, isr);
>         else
> -               dp_aux_i2c_handler(aux, isr);
> +               ret = dp_aux_i2c_handler(aux, isr);
>
> -       complete(&aux->comp);
> +       if (ret == IRQ_HANDLED)
> +               complete(&aux->comp);

I still think that it would be better to move complete() to the i2c
and native handlers.
Then you can write something as simple as:

if (aux->native)
    return dp_aux_native_handler(...);

return dp_aux_i2c_handler(....);

> +
> +       return ret;
>  }
>
>  void dp_aux_reconfig(struct drm_dp_aux *dp_aux)
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.h b/drivers/gpu/drm/msm/dp/dp_aux.h
> index e930974..511305d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.h
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.h
> @@ -11,7 +11,7 @@
>
>  int dp_aux_register(struct drm_dp_aux *dp_aux);
>  void dp_aux_unregister(struct drm_dp_aux *dp_aux);
> -void dp_aux_isr(struct drm_dp_aux *dp_aux);
> +irqreturn_t dp_aux_isr(struct drm_dp_aux *dp_aux);
>  void dp_aux_init(struct drm_dp_aux *dp_aux);
>  void dp_aux_deinit(struct drm_dp_aux *dp_aux);
>  void dp_aux_reconfig(struct drm_dp_aux *dp_aux);
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 3854c9f..5968ab1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1982,27 +1982,32 @@ int dp_ctrl_off(struct dp_ctrl *dp_ctrl)
>         return ret;
>  }
>
> -void dp_ctrl_isr(struct dp_ctrl *dp_ctrl)
> +irqreturn_t dp_ctrl_isr(struct dp_ctrl *dp_ctrl)
>  {
>         struct dp_ctrl_private *ctrl;
>         u32 isr;
> -
> -       if (!dp_ctrl)
> -               return;

Again, why?

> +       irqreturn_t ret = IRQ_NONE;
>
>         ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
>
>         isr = dp_catalog_ctrl_get_interrupt(ctrl->catalog);
> +       /* no interrupts pending, return immediately */
> +       if (!isr)
> +               return ret;

Please apply the same pattern here. If you know that you are returning
IRQ_NONE, return it directly.

>
>         if (isr & DP_CTRL_INTR_READY_FOR_VIDEO) {
>                 drm_dbg_dp(ctrl->drm_dev, "dp_video_ready\n");
>                 complete(&ctrl->video_comp);
> +               ret = IRQ_HANDLED;
>         }
>
>         if (isr & DP_CTRL_INTR_IDLE_PATTERN_SENT) {
>                 drm_dbg_dp(ctrl->drm_dev, "idle_patterns_sent\n");
>                 complete(&ctrl->idle_comp);
> +               ret = IRQ_HANDLED;
>         }
> +
> +       return ret;
>  }
>
>  struct dp_ctrl *dp_ctrl_get(struct device *dev, struct dp_link *link,
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index 9f29734..c3af06d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -25,7 +25,7 @@ int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_off_link(struct dp_ctrl *dp_ctrl);
>  int dp_ctrl_off(struct dp_ctrl *dp_ctrl);
>  void dp_ctrl_push_idle(struct dp_ctrl *dp_ctrl);
> -void dp_ctrl_isr(struct dp_ctrl *dp_ctrl);
> +irqreturn_t dp_ctrl_isr(struct dp_ctrl *dp_ctrl);
>  void dp_ctrl_handle_sink_request(struct dp_ctrl *dp_ctrl);
>  struct dp_ctrl *dp_ctrl_get(struct device *dev, struct dp_link *link,
>                         struct dp_panel *panel, struct drm_dp_aux *aux,
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bfd0aef..d40bfbd 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1192,7 +1192,7 @@ static int dp_hpd_event_thread_start(struct dp_display_private *dp_priv)
>  static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
>  {
>         struct dp_display_private *dp = dev_id;
> -       irqreturn_t ret = IRQ_HANDLED;
> +       irqreturn_t ret = IRQ_NONE;
>         u32 hpd_isr_status;
>
>         if (!dp) {
> @@ -1206,27 +1206,33 @@ static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
>                 drm_dbg_dp(dp->drm_dev, "type=%d isr=0x%x\n",
>                         dp->dp_display.connector_type, hpd_isr_status);
>                 /* hpd related interrupts */
> -               if (hpd_isr_status & DP_DP_HPD_PLUG_INT_MASK)
> +               if (hpd_isr_status & DP_DP_HPD_PLUG_INT_MASK) {
>                         dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
> +                       ret = IRQ_HANDLED;
> +               }
>
>                 if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
>                         dp_add_event(dp, EV_IRQ_HPD_INT, 0, 0);
> +                       ret = IRQ_HANDLED;
>                 }
>
>                 if (hpd_isr_status & DP_DP_HPD_REPLUG_INT_MASK) {
>                         dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
>                         dp_add_event(dp, EV_HPD_PLUG_INT, 0, 3);
> +                       ret = IRQ_HANDLED;
>                 }
>
> -               if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
> +               if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK) {
>                         dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> +                       ret = IRQ_HANDLED;
> +               }
>         }
>
>         /* DP controller isr */
> -       dp_ctrl_isr(dp->ctrl);
> +       ret |= dp_ctrl_isr(dp->ctrl);
>
>         /* DP aux isr */
> -       dp_aux_isr(dp->aux);
> +       ret |= dp_aux_isr(dp->aux);
>
>         return ret;
>  }
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
