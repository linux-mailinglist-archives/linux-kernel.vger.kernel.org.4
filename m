Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC70F6166C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiKBQAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiKBP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:59:52 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F409B2C108;
        Wed,  2 Nov 2022 08:59:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i9so9241564qki.10;
        Wed, 02 Nov 2022 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/1grPaD+xMIby1Txd3zoCjkj1cuL2trjeEvsrdeQYk=;
        b=pE+d2BMuxQjQYzxQqj4PXTA8MdpkV/KJe2dAN8yPM0xASyxTbxq9if/GzGXIwkEnkm
         Zhq28XdD6jQ/2Ix6oTGL+2kJW+/C9S8DXs0WmmtbOwWoF4Fc/9Q2VlLDHMjAYS0aBhOI
         8QrjLRVd9u5A9F0OF6DkrHbdoqLDQQzShm7+B0hYX/wvOUoGswqKQt4l7RXX+gEwCpu9
         h9Mtj97CQnB26geCAwTJr+LTcXYOQCqOISPZNaTmK3RCJKbGO2QgW9zjwgAQFBxAA2WW
         Urz83q4xaNSKPMWBsS15Pju/tNWJnjU7O7ktboSF+MB3PDFm7tZw69e7zYLw8VeOiXJD
         CT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/1grPaD+xMIby1Txd3zoCjkj1cuL2trjeEvsrdeQYk=;
        b=UaKApcZZVVap+j7XxDR9L/nBkwQNpv2v4G4EbBMiHR7DSe41mZ1tMvGAJ/GzzLtltV
         /lPRyIemdHJkSzN/WPNiGWpDgicaAJIcRhs26PON8E+yrGHhIMQmjIXjvBC4xw6u0tou
         VXVB7bpDzD8Vs3wOMGn0K60RZNsSY7W/f/7ycPTPBoiLwWPOpSmNyoQuy9UKkI7JzLU8
         AEYZtz1i3voJafMWUYRDYZJSMj6c0BN13lvLWKD4UBLGVAqSvlReJgtXOrNk2vWGwGHu
         Tya+eB8abh22RmwdiKnBVAQkK5hDDJULluxKHHLu5Hg8cYxjNUG6r+jfgQQASI4pjh/0
         aAHg==
X-Gm-Message-State: ACrzQf3XUs46P9nj9akgDT4lKC8ijL4LNHai/uw8ZWIu3rw/iXYf5vU1
        /JpDEBjSAw1T/DNR3fhKBaC3EtFmtTec+mVh6zc=
X-Google-Smtp-Source: AMsMyM4hLVYbFgPOuL0CR9Bpu/6eSDfsMz83d21/2tJDZhIHfJzJSngYiCH/QQcArG+V4Qg/WyZljtSopOCAqV2gAII=
X-Received: by 2002:a05:620a:254e:b0:6c7:855c:6eb with SMTP id
 s14-20020a05620a254e00b006c7855c06ebmr18731720qko.39.1667404790104; Wed, 02
 Nov 2022 08:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221101214051.159988-1-robdclark@gmail.com> <044540cc-1d8b-45da-ac8b-ecc133b45dc1@amd.com>
In-Reply-To: <044540cc-1d8b-45da-ac8b-ecc133b45dc1@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 2 Nov 2022 09:00:06 -0700
Message-ID: <CAF6AEGvFxU10Uu+eBRm0ChyVDPg3DMNoeHd4zCWHWwRzRBvP3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Remove exclusive-fence hack
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 3:46 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 01.11.22 um 22:40 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The workaround was initially necessary due to dma_resv having only a
> > single exclusive fence slot, yet whe don't necessarily know what order
> > the gpu scheduler will schedule jobs.  Unfortunately this workaround
> > also has the result of forcing implicit sync, even when userspace does
> > not want it.
> >
> > However, since commit 047a1b877ed4 ("dma-buf & drm/amdgpu: remove
> > dma_resv workaround") the workaround is no longer needed.  So remove
> > it.  This effectively reverts commit f1b3f696a084 ("drm/msm: Don't
> > break exclusive fence ordering")
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Oh, yes please. I had that on my todo list for after the initial patch
> had landed, but couldn't find the time to look into it once more.
>
> There was another case with one of the other ARM drivers which could be
> cleaned up now, but I can't find it any more of hand.
>
> Anyway this patch here is Acked-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>.

Thanks.. I had a quick look for the other driver but couldn't spot
anything, so perhaps it has already been fixed?

BR,
-R

>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/msm/msm_gem_submit.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm=
/msm_gem_submit.c
> > index 5599d93ec0d2..cc48f73adadf 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> > @@ -334,8 +334,7 @@ static int submit_fence_sync(struct msm_gem_submit =
*submit, bool no_implicit)
> >               if (ret)
> >                       return ret;
> >
> > -             /* exclusive fences must be ordered */
> > -             if (no_implicit && !write)
> > +             if (no_implicit)
> >                       continue;
> >
> >               ret =3D drm_sched_job_add_implicit_dependencies(&submit->=
base,
>
