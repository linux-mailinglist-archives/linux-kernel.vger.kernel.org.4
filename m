Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A040694EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjBMSMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjBMSME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:12:04 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5040FC655
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:11:34 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id g8so13960428vso.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YhyueGm0rbJoXfAMuP4ME9y20a+9vEsRucr9LaCFZhw=;
        b=SVjPeLrC97MbzGve1F6WSqRht948tpI14Bwxv9/AJydgcsAhw641XoEX6j3j67NsS1
         IqGHj2wxZY9CTt0ZEHwT/6H31umeLxUHTwMStANUidaIIJWsfVUYlK1ANPNyXd78J+2/
         3mTe11CYF/HJ2JZj2tLKeCcpP4i6yRbjk1wMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhyueGm0rbJoXfAMuP4ME9y20a+9vEsRucr9LaCFZhw=;
        b=XpuwvZLoK3AUlL99KNoNVkubJePMsas3zMj7reoYaIVDX9dpOww+Ld9Y4Qx9Q50Qfz
         pf6/+FuwEx0095mVX4vvynnsa08JK5A9aiIfDkFz4/MS0GmdiGnrMA4ySw7IoXSHSkDZ
         Fzr4F6EZTv08EFf7Z48YZfQQWrhEeZJA9HpHKRg/IC+3wQg9sS8CT5GEQXSuzqg7lvHF
         M4nbNjLx4pxI3ol/XzBiQMQkbG3l3Dc5A6AR/omB52z+QbaHCwTmt0qWfePryJqzLI+Q
         LBqgrbp3Huf/RbAIG9LJE6UXe2+ffkQwC3f4spUAjpJ0ONrxTvj6dcnYAPwnzTjgXbrW
         ugpw==
X-Gm-Message-State: AO0yUKVCbDWv/6OqwsMtY6ropm6pShCa/Du2leAuvWEv6rCi+Is6vjWT
        Ajq3YGMMzd8192fO4cdPMKqw1YeHWZ4i2DVm
X-Google-Smtp-Source: AK7set9wwRVZ2aOiKnrkex5pAschJvmYIWpVmQsHZlwe3aWklxqULLly2pxsvtTI6MWxMfoaSrxcfQ==
X-Received: by 2002:a05:6102:948:b0:412:a93:ec50 with SMTP id a8-20020a056102094800b004120a93ec50mr4024287vsi.29.1676311891055;
        Mon, 13 Feb 2023 10:11:31 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id p18-20020a67f312000000b003d3f819a19fsm342073vsf.19.2023.02.13.10.11.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 10:11:29 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id i4so2032978vkn.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:11:28 -0800 (PST)
X-Received: by 2002:a05:6122:243:b0:401:4f4b:22c2 with SMTP id
 t3-20020a056122024300b004014f4b22c2mr967178vko.28.1676311888469; Mon, 13 Feb
 2023 10:11:28 -0800 (PST)
MIME-Version: 1.0
References: <1674814487-2112-1-git-send-email-quic_kalyant@quicinc.com>
In-Reply-To: <1674814487-2112-1-git-send-email-quic_kalyant@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Feb 2023 10:11:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XKOm1zLH+grTMD33QX_uX67AQ1ZUoyCYoAfUpqktCshg@mail.gmail.com>
Message-ID: <CAD=FV=XKOm1zLH+grTMD33QX_uX67AQ1ZUoyCYoAfUpqktCshg@mail.gmail.com>
Subject: Re: [v12] drm/msm/disp/dpu1: add support for dspp sub block flush in sc7280
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        swboyd@chromium.org, quic_vpolimer@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
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

On Fri, Jan 27, 2023 at 2:15 AM Kalyan Thota <quic_kalyant@quicinc.com> wrote:
>
> Flush mechanism for DSPP blocks has changed in sc7280 family, it
> allows individual sub blocks to be flushed in coordination with
> master flush control.
>
> Representation: master_flush && (PCC_flush | IGC_flush .. etc )
>
> This change adds necessary support for the above design.
>
> Changes in v1:
> - Few nits (Doug, Dmitry)
> - Restrict sub-block flush programming to dpu_hw_ctl file (Dmitry)
>
> Changes in v2:
> - Move the address offset to flush macro (Dmitry)
> - Separate ops for the sub block flush (Dmitry)
>
> Changes in v3:
> - Reuse the DPU_DSPP_xx enum instead of a new one (Dmitry)
>
> Changes in v4:
> - Use shorter version for unsigned int (Stephen)
>
> Changes in v5:
> - Spurious patch please ignore.
>
> Changes in v6:
> - Add SOB tag (Doug, Dmitry)
>
> Changes in v7:
> - Cache flush mask per dspp (Dmitry)
> - Few nits (Marijn)
>
> Changes in v8:
> - Few nits (Marijn)
>
> Changes in v9:
> - Use DSPP enum while accessing flush mask to make it readable (Dmitry)
> - Few nits (Dmitry)
>
> Changes in v10:
> - Fix white spaces in a separate patch (Dmitry)
>
> Changes in v11:
> - Define a macro for dspp flush selection (Marijn)
> - Few nits (Marijn)
>
> Changes in v12:
> - Minor comments (reorder macros and a condition) (Marijn)
>
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  5 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  4 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c     | 49 +++++++++++++++++++++++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h     |  5 ++-
>  5 files changed, 58 insertions(+), 7 deletions(-)

There's a (trivial to resolve) merge conflict when applying this patch
against msm-next. I dunno if that means you should send a v13?

In any case, when using this patch together with the DSPP series [1]
the internal night light works on sc7280-herobrine based boards. Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>


[1] https://lore.kernel.org/r/1676286704-818-1-git-send-email-quic_kalyant@quicinc.com/
