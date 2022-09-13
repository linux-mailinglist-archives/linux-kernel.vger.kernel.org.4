Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D075B680F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiIMGly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiIMGlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:41:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCA352E42
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:41:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w16so9800715eji.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gKNkp5TT0XjbSEmbU4M+B2B1cDxK13/0CThFH853tls=;
        b=oWWEF/08VQtpBTsplhTEQ87f9wS6PdIe0WOT+m9wrHcVpU1Gbf6/v9mUpGSDwch3nR
         A0Zib3++wgkeB2Ne5BzvDdzU+eifZFHaQGbgrGEK0/vux33BpwRSjkNkzUNwtnnOeeHH
         s0dkzYSP2obWbdCHPijdD2H/iA0Pku8Ki4LTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gKNkp5TT0XjbSEmbU4M+B2B1cDxK13/0CThFH853tls=;
        b=GYr0qxWQygcbWiGXdcYFNcPS7tcNLuS85tYW3DNjbzAtktW/RiqqWoZwvWpDdYqMqp
         iuTHy25kRPEEAlLx6zBqPTFWL+W1SA0U/1iSwZ7JoC4SjOKWiG3uAkouDWn5yharm+tD
         o9zzen1aRxAovcOSCIQUVOG/lDoZmpLBwc3mj0lUC10ghWaA5Ys3d6G5mAIGZ8AepPGS
         lvrLihF5Xwhh7QybubNNw6rC1R/zLhq1D57D0feQj66D3SpTxRVuKdqp1v2hT7j1qG/d
         WXKQiNlzNy6iY6gN6ea6xx/iE1jneRwM5tDdgEu8FU2bLMDc9WbtX+i0cvk7RZSvg2ce
         D2wQ==
X-Gm-Message-State: ACgBeo3ZqsfpWOiU5Kk6NVczpyhg3Wtu3s2SDSW7bY42GGm3exGAehDL
        PwBZeZ41Z1CbkOW3/j0huiLNWjUixk40IjTTxL0=
X-Google-Smtp-Source: AA6agR60HAmxYqp/MdR0WaUvDPiY9IgMNx772PSNP3/P+Yik3awtxP3NxAHcbHUMnNVj9V6BhRnXyQ==
X-Received: by 2002:a17:907:72d5:b0:77d:5d01:4f4f with SMTP id du21-20020a17090772d500b0077d5d014f4fmr6149828ejc.285.1663051309124;
        Mon, 12 Sep 2022 23:41:49 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id oz9-20020a1709077d8900b0077086ee4633sm5579764ejc.53.2022.09.12.23.41.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 23:41:48 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id v185-20020a1cacc2000000b003b42e4f278cso9682793wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:41:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8b:b0:3a5:f5bf:9c5a with SMTP id
 f11-20020a05600c4e8b00b003a5f5bf9c5amr1199949wmq.85.1663050927147; Mon, 12
 Sep 2022 23:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220912154046.12900-1-johan+linaro@kernel.org>
 <20220912154046.12900-5-johan+linaro@kernel.org> <e60f0053-3801-bf33-5841-69f16215fa00@linaro.org>
In-Reply-To: <e60f0053-3801-bf33-5841-69f16215fa00@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 13 Sep 2022 07:35:15 +0100
X-Gmail-Original-Message-ID: <CAD=FV=U8_bjPm3NEOWqzehrx0xFV4U771nTuhhOiM9gKDVCo5g@mail.gmail.com>
Message-ID: <CAD=FV=U8_bjPm3NEOWqzehrx0xFV4U771nTuhhOiM9gKDVCo5g@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/msm/dp: fix aux-bus EP lifetime
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 12, 2022 at 7:10 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 12/09/2022 18:40, Johan Hovold wrote:
> > Device-managed resources allocated post component bind must be tied to
> > the lifetime of the aggregate DRM device or they will not necessarily be
> > released when binding of the aggregate device is deferred.
> >
> > This can lead resource leaks or failure to bind the aggregate device
> > when binding is later retried and a second attempt to allocate the
> > resources is made.
> >
> > For the DP aux-bus, an attempt to populate the bus a second time will
> > simply fail ("DP AUX EP device already populated").
> >
> > Fix this by amending the DP aux interface and tying the lifetime of the
> > EP device to the DRM device rather than DP controller platform device.
>
> Doug, could you please take a look?
>
> For me this is another reminder/pressure point that we should populate
> the AUX BUS from the probe(), before binding the components together.

Aside from the kernel robot complaints, I'm not necessarily convinced.
I think we know that the AUX DP stuff in MSM-DP is fragile right now
and Qualcomm has promised to clean it up. This really feels like a
band-aid and is really a sign that we're populating the AUX DP bus in
the wrong place in Qualcomm's code. As you said, if we moved this to
probe(), which is the plan in the promised cleanup, then it wouldn't
be a problem.

As far as I know Qualcomm has queued this cleanup behind their current
PSR work (though it's never been clear why both can't be worked on at
the same time) and the PSR work was stalled because they couldn't
figure out what caused the glitching I reported. It's still on my nag
list that I bring up with them every week...

In any case, if a band-aid is urgent, maybe you could just call
of_dp_aux_populate_bus() directly in Qualcomm code and you could add
your own devm_add_action_or_reset() on the DRM device.
