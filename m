Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F89D5F4590
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJDOgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJDOf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:35:59 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E9A6170C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:35:58 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 207so13739782ybn.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WM6PfXHHse3/yexDzL/5HR9PYYLOMXw7VQRCht6d5SU=;
        b=oBLmmmDLvD4KT4Ygj0QEZVj8j8wvotDFRb6yACIepSPEPq4m7ZyTAaIp56eT0s0Uiz
         VihDiSrOFKmz51MqD0s6lckh4+0mo2DtAAv1ieii5EyD3pIRW/fq8FQbpBs042IaTHVW
         QUkrOPiWtjqphFL5n5WTLv5yaDvabw9x3RSIeZjR/J2MkG2OcC3cJjvRdrvt7jKNPgSG
         viNv3Q+d0JMQWkGyA3vcBYDUnppyztYIioMsqJ2aKQvWSuc4aBIEf5R5n9s4q3LOeAOf
         G2yjwRoij9c+LQL7bgjtdbYSb5zxlj/HDf0PTA5GFgSBMk1ScQ3r7HwVq+2AbAf2Bo3b
         JOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WM6PfXHHse3/yexDzL/5HR9PYYLOMXw7VQRCht6d5SU=;
        b=au4hDk7DazJxNazMepvcRHw7g44O7jKyMEo+KNC2TDamMQ2jLi/ieUpbs0D0Lpsqk5
         85QqUodCmvAQkAsV/IjGN3motj8HA01gK/GAU5jg5xdkEJAa/hYe4NVqCxt08lHs+jLC
         WrsNgUIdfZKOu6M73BvHml7nU1zdoRgeV257H/k1i6pN6wNIpe4YLwPJ0YnydIp4Z1I8
         0+MB5rtKwBQiLkZXJ1s6zji3zyjsl9GGDDGyneE+sULKyl6mL7yZ1ZqlkadpHCkDdBdR
         4jEYUQSObrr4ziqKTU+n9UDXrEU37fjkTWE7MZKKj+EhbAO89HMnsy7Jp2AgjdN3zdNM
         QWJQ==
X-Gm-Message-State: ACrzQf01mIeaWc/LyeXK1y9AfsLjy7caqYsL/e1xEWPgiSb/BySBjaQ6
        0Z48JBn1Tdzs3WPYy1HlvBmg1zKUyVI3J9LrI3A0SA==
X-Google-Smtp-Source: AMsMyM5QPwacWT/plAClT9ufk5FfkV8GOwFid2Fa66k5LdXW5Xbi864YzwABxgdaZdmjDK3I1DPXXwRupYr/vj3MDMI=
X-Received: by 2002:a25:ba45:0:b0:67a:6298:7bac with SMTP id
 z5-20020a25ba45000000b0067a62987bacmr26917511ybj.194.1664894157723; Tue, 04
 Oct 2022 07:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221001190807.358691-1-marijn.suijten@somainline.org> <20221001190807.358691-5-marijn.suijten@somainline.org>
In-Reply-To: <20221001190807.358691-5-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 4 Oct 2022 17:35:46 +0300
Message-ID: <CAA8EJpoEUuJqj4hAa-qU1ovZuR0ivu3Jzeyx50JPw3k2mv2Lmg@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/msm/dpu1: Account for DSC's bits_per_pixel having
 4 fractional bits
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
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

On Sat, 1 Oct 2022 at 22:08, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> According to the comment this DPU register contains the bits per pixel
> as a 6.4 fractional value, conveniently matching the contents of
> bits_per_pixel in struct drm_dsc_config which also uses 4 fractional
> bits.  However, the downstream source this implementation was
> copy-pasted from has its bpp field stored _without_ fractional part.
>
> This makes the entire convoluted math obsolete as it is impossible to
> pull those 4 fractional bits out of thin air, by somehow trying to reuse
> the lowest 2 bits of a non-fractional bpp (lsb = bpp % 4??).
>
> The rest of the code merely attempts to keep the integer part a multiple
> of 4, which is rendered useless thanks to data |= dsc->bits_per_pixel <<
> 12; already filling up those bits anyway (but not on downstream).
>
> Fixes: c110cfd1753e ("drm/msm/disp/dpu1: Add support for DSC")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

-- 
With best wishes
Dmitry
