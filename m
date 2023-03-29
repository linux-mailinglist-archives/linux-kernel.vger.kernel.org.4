Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BF06CF391
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjC2TrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjC2TqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:46:23 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3476EAD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:46:04 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id m16so487072ybk.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680119164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw+Hse+KJzv0y2FSFqFqsApOoihx38C1GEdX++8T4mU=;
        b=Ls7zjQJXIsTIXK8xa12UAtG31viT2wzMU0YcliPrqQwfiS28W+VSdxEZCOHXi+RobD
         XJ9KXSPw5B0DaQod948Mcm4Qe5V/oKODzQN0VNyyLUo34I+uIejSXd7Yil7OLKaWM3Ic
         mDCDMu1lQm16AhfKyfawdB1xpJL3jxmlF2mcmnpp67Oe1PKzWojDN94zz1dBnpaD/F8n
         73x1wO5Vu7TyBgqnybHaJwRlqGhN+FyoVNHwCokw5NLLun+bYLCaC9NxH5xxs6OuvGfj
         eKXowAHQQsuzG8s8sypYOTlw9Ob3IXxmPcPDbdi07zqSSX5gApCeN57e0aEDnXq8mZNE
         yCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680119164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uw+Hse+KJzv0y2FSFqFqsApOoihx38C1GEdX++8T4mU=;
        b=lMy/98tpcURGwp7K6tpy14JNkRMKjJI7lU8RPX5FfiUwvlazNKHXvuhDI3ttf8DSrs
         vKOwjQiOw0y64reh+/vywSAmMlt7aqMpr5KREkEPiPjz3YNqkoNCjx6HfasUk5gKUDwo
         NLO7q+I8agyImwqvINFdXA/2TNG5WR1buHtMKMF3OwUCVp1e2piqOzK48iStOnJqyhKj
         dguVJxPRcgbmgEIBmRtv093QDmnAQ8Jw23mmtW2K3wkRJg4InaVp599zNcPH7N1SD4s3
         504d4jxhdDaLg2RukovNaQAwDFscAGw67TDPycZYXrHk4qbXmNzK8rfGWWZEqTiDQ8Wt
         QcGQ==
X-Gm-Message-State: AAQBX9egu/G2kLyD1M+T6jKOf8+OHCqgernvnPt/rq3IhvcRIYcJeayi
        90nJB70hf/NM7MeTg8i1pdfsxe1lyyulpCOYzQA8MQ==
X-Google-Smtp-Source: AKy350Ylj3nNZ+UsrhOAFg1PNOleWiB7Ukh6l+gs8gz1nByk+hbUAS4yZ4upJ6ElCZNHNv03bHuKs6bpr3HesgeAprk=
X-Received: by 2002:a05:6902:a8c:b0:b7b:fb15:8685 with SMTP id
 cd12-20020a0569020a8c00b00b7bfb158685mr7538197ybb.9.1680119163802; Wed, 29
 Mar 2023 12:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230329140445.2180662-1-konrad.dybcio@linaro.org>
 <ZCRNFitcrAeH27Pn@hovoldconsulting.com> <83986fa9-c9eb-ae5a-b239-584092f2cea5@linaro.org>
In-Reply-To: <83986fa9-c9eb-ae5a-b239-584092f2cea5@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 29 Mar 2023 22:45:52 +0300
Message-ID: <CAA8EJpohEo+kMw7fx5112m+z7JHSLDmsqOL4T7hmyvr2fPP8vQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: adreno_gpu: Use suspend() instead of
 idle() on load error
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, agross@kernel.org,
        marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 at 18:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 29.03.2023 16:37, Johan Hovold wrote:
> > On Wed, Mar 29, 2023 at 04:04:44PM +0200, Konrad Dybcio wrote:
> >> If we fail to initialize the GPU for whatever reason (say we don't
> >> embed the GPU firmware files in the initrd), the error path involves
> >> pm_runtime_put_sync() which then calls idle() instead of suspend().
> >>
> >> This is suboptimal, as it means that we're not going through the
> >> clean shutdown sequence. With at least A619_holi, this makes the GPU
> >> not wake up until it goes through at least one more start-fail-stop
> >> cycle. Fix that by using pm_runtime_put_sync_suspend to force a clean
> >> shutdown.
> >
> > This does not sound right. If pm_runtime_put_sync() fails to suspend the
> > device when the usage count drops to zero, then you have a bug somewhere
> > else.
> I was surprised to see that it was not called as well, but I wasn't able
> to track it down before..

Could you please check that it's autosuspend who kicks in? In other
words, if we disable autosuspend, the pm_runtime_put_sync is enough()?

That would probably mean that we lack some kind of reset in the hw_init path.

On the other hand, I do not know how the device will react to the
error-in-the-middle state. Modems for example, can enter the state
where you can not properly turn it off once it starts the boot
process.

And if we remember the efforts that Akhil has put into making sure
that the GPU is properly reset in case of an _error_, it might be
nearly impossible to shut it down in a proper way.

Thus said, I think that unless there is an obvious way to restart the
init process, Korad's pm_runtime_put_sync_suspend() looks like a
correct fix to me.

> > Also since commit 2c087a336676 ("drm/msm/adreno: Load the firmware
> > before bringing up the hardware") the firmware is loaded before even
> > hitting these paths so the above description does not sound right in
> > that respect either (or is missing some details).
> ..but I did some more digging and I found that the precise "firmware"
> that fails is the ZAP blob, which is not checked like SQE in the
> commit you mentioned!
>
> Now I don't think that we can easily check for it as-is since
> zap_shader_load_mdt() does the entire find-load-authenticate
> dance which is required with secure assets, but it's obviously
> possible to rip out the find-load part of that and go on from
> there.

Yes, I think we should load all firmware early. ZAP shader is a bit
unique since the DT can override the name, but it might be nice to
check for its presence earlier.

At the same time it probably should not stop us from fixing the idle()
vs suspend() bug.

>
> Do you think that would be a better solution?
>
> Konrad
>
> >
> >> Test cases:
> >> 1. firmware baked into kernel
> >> 2. error loading fw in initrd -> load from rootfs at DE start
> >>
> >> Both succeed on A619_holi (SM6375) and A630 (SDM845).
> >>
> >> Fixes: 0d997f95b70f ("drm/msm/adreno: fix runtime PM imbalance at gpu load")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> index f61896629be6..59f3302e8167 100644
> >> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> @@ -477,7 +477,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
> >>      return gpu;
> >>
> >>  err_put_rpm:
> >> -    pm_runtime_put_sync(&pdev->dev);
> >> +    pm_runtime_put_sync_suspend(&pdev->dev);
> >>  err_disable_rpm:
> >>      pm_runtime_disable(&pdev->dev);
> >
> > Johan



-- 
With best wishes
Dmitry
