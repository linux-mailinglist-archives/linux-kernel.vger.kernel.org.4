Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B2364E474
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLOXE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLOXEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:04:54 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DC44386D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:04:51 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3bfd998fa53so10952457b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jj+Yw0LnI+4S2TE6CziTLpc8F6+12sJM98glvhhKdCU=;
        b=l4pudfWMlR8d8XZK35gg+50oSmIqkABAOSzCWaJ66QqpQNIXemXlYs9C2A5BSd+a94
         xPA1bTrKeLHvKGJDeU41KRxL7wX8NLIjPqJAHkUFruV6iQjnuvTBy1mCcH7GXIVzvNdI
         cyq3wg82/dw/Jwg5SZjwaQgV7qvnOSpXCANEygJKWl+Tgeg1zoIRuIpEBNcQ0EAvil/3
         3Ex/SWZA1f37jPiWpQ3xx9ejVPVf/decSo1fZblMcwvd5LkzHRhEBlQCdcHxjSpw92Cl
         nhfYBFPzYlnyEX3At4DS+5w865dL/EU2RPDLedNGkUbT36Z0QezFGRikUzmHE82i1y42
         XggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jj+Yw0LnI+4S2TE6CziTLpc8F6+12sJM98glvhhKdCU=;
        b=S439wUFFvu1Gl+I611NuySIfrSHh0ewMnCg/7nqopFcVENzSSJ9uqkW3N0vOPWcXpC
         pK/48FDlBKiSCgkDohlYjxaWMvJXBpsTmCuS/8PN9s/xJ2rsY+vYFhwIxCwm3J64Mcnj
         BNnYg6rBoLnFCW/IWQkFrzPUCv8kJhcn59iLhPy5vQHF5UO43gI8JSMhusSxiweZz4cL
         Uzr2/Tx4sA+BE9uA/zbKavUKxR+Y30XZOa5OpUGZ4hm/c/2tVDNj5XZpaWZ8yZCo8XQi
         6L5fUNaGJhOEL8TYyqVXMTUfxO5GlYQ5AXizX8ACXh/eH+iG7Cv8tNwVrVSyjHO4WR78
         3Ryw==
X-Gm-Message-State: ANoB5pnZ4BPAAfz53yH8iEjkSYQw5ioU+1gQGxZXUp99iTfvhNL8CXVW
        sUgquB+QzE0D7GMUteeB3fqY0bdLsaqv3LYVZgl7xA==
X-Google-Smtp-Source: AA0mqf5aCvorXkICWtqWSDt6Cusf3MZN1wuC0dmniym8Rep7BtRxEq7rTvb0u6aXueNsjvbiI7Xrn/t9pqgnrH4ctJ0=
X-Received: by 2002:a81:53d4:0:b0:3c0:c065:7608 with SMTP id
 h203-20020a8153d4000000b003c0c0657608mr3117813ywb.378.1671145490997; Thu, 15
 Dec 2022 15:04:50 -0800 (PST)
MIME-Version: 1.0
References: <1671144775-19077-1-git-send-email-quic_khsieh@quicinc.com> <1671144775-19077-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1671144775-19077-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 16 Dec 2022 01:04:40 +0200
Message-ID: <CAA8EJprkXEH=g4XyH3JEAg3MNpbs7NHcKQ2OCBX6s9VcCikoLg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/msm/dp: do not complete dp_aux_cmd_fifo_tx()
 if irq is not for aux transfer
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
> There are 3 possible interrupt sources are handled by DP controller,
> HPDstatus, Controller state changes and Aux read/write transaction.
> At every irq, DP controller have to check isr status of every interrupt
> sources and service the interrupt if its isr status bits shows interrupts
> are pending. There is potential race condition may happen at current aux
> isr handler implementation since it is always complete dp_aux_cmd_fifo_tx()
> even irq is not for aux read or write transaction. This may cause aux read
> transaction return premature if host aux data read is in the middle of
> waiting for sink to complete transferring data to host while irq happen.
> This will cause host's receiving buffer contains unexpected data. This
> patch fixes this problem by checking aux isr and return immediately at
> aux isr handler if there are no any isr status bits set.
>
> Current there is a bug report regrading eDP edid corruption happen during
> system booting up. After lengthy debugging to found that that VIDEO_READY
> interrupt was continuously firing during system booting up which cause
> dp_aux_isr() to complete dp_aux_cmd_fifo_tx() prematurely to retrieve data
> from aux hardware buffer which is not yet contains complete data transfer
> from sink. This cause edid corruption.
>
> Follows are the signature at kernel logs when problem happen,
> EDID has corrupt header
> panel-simple-dp-aux aux-aea0000.edp: Couldn't identify panel via EDID
> panel-simple-dp-aux aux-aea0000.edp: error -EIO: Couldn't detect panel nor find a fallback
>
> Changes in v2:
> -- do complete if (ret == IRQ_HANDLED) ay dp-aux_isr()
> -- add more commit text
>
> Changes in v3:
> -- add Stephen suggested
> -- dp_aux_isr() return IRQ_XXX back to caller
> -- dp_ctrl_isr() return IRQ_XXX back to caller
>
> Changes in v4:
> -- split into two patches
>
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
>

The same feedback as the one I gave for v2 or v3:

There should be no empty lines between tags. And you still have one
empty line here.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index d030a93..cc3efed 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -423,6 +423,10 @@ void dp_aux_isr(struct drm_dp_aux *dp_aux)
>
>         isr = dp_catalog_aux_get_irq(aux->catalog);
>
> +       /* no interrupts pending, return immediately */
> +       if (!isr)
> +               return;
> +
>         if (!aux->cmd_busy)
>                 return;
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
