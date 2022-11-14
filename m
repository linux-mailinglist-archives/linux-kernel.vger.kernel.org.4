Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8A7628AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiKNUt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbiKNUt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:49:26 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F3D1583C;
        Mon, 14 Nov 2022 12:49:26 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so13918952fac.1;
        Mon, 14 Nov 2022 12:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/zs5GFS4zX5I6/Faq+e+SUg4iVEYXlwxarNYXij8AkM=;
        b=ImPaTYpH20pxonMgoWCi8i5Qs38yYeoMefN7Ur6gCETa7/kYYYRJoRy4jpTu1Vpzn3
         hWLLOgAeDNUPVTO+5huo0TYVcwfWujK0Aw1JE/wJwtx//tDBo9QX57HtwqowqYi+65MH
         3v3CO/F0ngn4sRyzWvOXMehFGzagpS0FBLRlphqddJCIOtVf0miMSb3Qsx6VfbltPPPz
         rwAVxmLlrArcsS97jBiWyztSuCfBFEehxgy0Ck+9LbqJHYbe//kCtwbRZsJQNO6veN/7
         J3DXqrlpMQxiGuUN9aDF4KMoC6Ld18+V4aHI/oXi83S5KpWO/sq5NJt+6H9JILlgOhOk
         3a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zs5GFS4zX5I6/Faq+e+SUg4iVEYXlwxarNYXij8AkM=;
        b=UrcSgWLc7UQBi2DM6ormDDgYFtFxg6V8WZMSXGXQehwxcEg42cLkZsR7AbsTqizDwz
         HZWopCOffr72dYrTh202HYdS+WFtzPtaoRTmTPLWd0j40u++ZRbRpnLx7wqLs3sWCTa/
         NGUJ1GrHDwUhHv+kcOHJlCI9uyYRvbEbOsrIW0ew6WuA62m1DDIKDlq3EN04XnxHiC+w
         vYT6oah4cclVpninIAWPSE6AD0iYVemYp6VKHfFRmABLWKedDacdnNzoUzA0W1Ftliun
         37co6w7oKtAJd7CB7hw77Qye0oePUD6IkazFKOM8nt8h631Wuc3iBjiqg0pceyFIF79v
         4Sng==
X-Gm-Message-State: ANoB5pmTx+dVi3CUCfv2EU2amXJW8l1dj1EC/VQQqo8ChUtJFD2L0j79
        wYYa41Lol2y1hSVhvj6Q8ek8/8CuF1GEIk0eSuk=
X-Google-Smtp-Source: AA0mqf5Oo2AzjTceHKiJk2Mi+Kzjn7EOsa7GoBX8c8TdPP3ULdrZxu7oElvFZNnKbpBB817J/M/OWPoG7FxpTmV9EYw=
X-Received: by 2002:a05:6870:b87:b0:13d:51fe:3404 with SMTP id
 lg7-20020a0568700b8700b0013d51fe3404mr7667561oab.183.1668458965345; Mon, 14
 Nov 2022 12:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20221114194133.1535178-1-robdclark@gmail.com> <97429a67-e763-4226-828c-8381a2abe9f9@quicinc.com>
In-Reply-To: <97429a67-e763-4226-828c-8381a2abe9f9@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 14 Nov 2022 12:49:45 -0800
Message-ID: <CAF6AEGu2soY3Xm_obivcLKqgJ0HVj0H90C7zN5YOTFK0RmRbdA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: Fix speed-bin detection vs probe-defer
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Nov 14, 2022 at 11:59 AM Akhil P Oommen
<quic_akhilpo@quicinc.com> wrote:
>
> On 11/15/2022 1:11 AM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > If we get an error (other than -ENOENT) we need to propagate that up the
> > stack.  Otherwise if the nvmem driver hasn't probed yet, we'll end up with
> > whatever OPP(s) are represented by bit zero.
> >
> > Fixed: fe7952c629da ("drm/msm: Add speed-bin support to a618 gpu")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > index 7fe60c65a1eb..96de2202c86c 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -1956,7 +1956,7 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
> >               DRM_DEV_ERROR(dev,
> >                             "failed to read speed-bin (%d). Some OPPs may not be supported by hardware",
> I just noticed and was going to send a similar fix. We should remove ".
> Some OPPs may not be supported by hardware" here.
>
> Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>
> Btw, on msm-next-external-fixes + this fix,  I still see boot up issue
> in herobrine due to drm_dev_alloc() failure with -ENOSPC error.

Could you track it down one level deeper? I wonder if there is some
missing cleanup in the probe-defer path and we end up failing in
drm_minor_alloc() or something along those lines

BR,
-R

> -Akhil.
> >                             ret);
> > -             goto done;
> > +             return ret;
> >       }
> >
> >       supp_hw = fuse_to_supp_hw(dev, rev, speedbin);
>
