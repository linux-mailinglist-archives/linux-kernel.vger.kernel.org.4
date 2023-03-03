Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27696A9589
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCCKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCCKqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:46:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1780E5D8A4;
        Fri,  3 Mar 2023 02:46:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 926F0CE20F7;
        Fri,  3 Mar 2023 10:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD994C433EF;
        Fri,  3 Mar 2023 10:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677840375;
        bh=BaXSPFUKDYDeayh9el1NehZiPOOebhV9G7uXQK7ivfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWfsbGkkr/6oryzvQL6+myKR6tU3L14rK4onQ8E6dk10KmE9IG+MJUFa8S3tSlYhU
         BZ044t15gzZwuiJ+oRi4Rlf94k9matUipNXjywBEnULT1apuxFqjSQHMvOxs/zagBb
         +KaywpOmicRN/mgTIjj02Mtit5HS23aqwfl2gq8/DsSrGNeR0afkzDXtLUJSh0VLiy
         0UQVgSQL9ifozO1za6vrPSGFmLf3Qtha/2jCTP6k/G5lgWuVXsXH81V3gCV+OEGPjY
         XZfjyQTfu2CX8VbcjsFxIBZMdi5QmUUjwclSJvVwVjl4roKDVk8bYZPVSVX0yErvzD
         tPEZFEFdOkAtA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pY2w2-0006CR-16; Fri, 03 Mar 2023 11:46:46 +0100
Date:   Fri, 3 Mar 2023 11:46:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] drm/msm/adreno: drop redundant pm_runtime_disable()
Message-ID: <ZAHQFn8CD9CNvz/0@hovoldconsulting.com>
References: <20230221101430.14546-1-johan+linaro@kernel.org>
 <20230221101430.14546-4-johan+linaro@kernel.org>
 <CAF6AEGsco+h0f5twHz9CRFyCUeiK1WOJWcURW3wPiZx5muio0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGsco+h0f5twHz9CRFyCUeiK1WOJWcURW3wPiZx5muio0g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Sorry about the late follow-up on this. Went down a bit of a DRM rabbit
hole this week.

On Wed, Feb 22, 2023 at 11:09:16AM -0800, Rob Clark wrote:
> On Tue, Feb 21, 2023 at 2:16 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Since commit 4b18299b3365 ("drm/msm/adreno: Defer enabling runpm until
> > hw_init()") runtime PM is no longer enabled at adreno_gpu_init(), which
> > means that there are no longer any bind() error paths for which
> > adreno_gpu_cleanup() is called with runtime PM enabled.
> >
> > As the runtime PM enable on first open() is balanced by the
> > pm_runtime_force_suspend() call at unbind(), adreno_gpu_cleanup() is now
> > always called with runtime PM disabled so that its pm_runtime_disable()
> > call can be removed.
> >
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index ce6b76c45b6f..1101b8234b49 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -1082,15 +1082,10 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
> >
> >  void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
> >  {
> > -       struct msm_gpu *gpu = &adreno_gpu->base;
> > -       struct msm_drm_private *priv = gpu->dev ? gpu->dev->dev_private : NULL;
> >         unsigned int i;
> >
> >         for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
> >                 release_firmware(adreno_gpu->fw[i]);
> >
> > -       if (priv && pm_runtime_enabled(&priv->gpu_pdev->dev))
> > -               pm_runtime_disable(&priv->gpu_pdev->dev);
> > -
> 
> Maybe WARN_ON(priv && pm_runtime_enabled(&priv->gpu_pdev->dev))?

I'd rather not add warnings for something that can not happen, but it
turns out there is indeed one corner case were this function could still
end up being called with runtime PM enabled, namely if suspending the
scheduler fails in adreno_system_suspend() during unbind:

            adreno_bind()
             info->init()                   // e.g. a6xx_gpu_init()
               adreno_gpu_init()
    
            msm_open()
              load_gpu()
                adreno_load_gpu()
                  pm_runtime_enable()
    
            adreno_unbind()
              adreno_system_suspend()
                err = suspend_scheduler(gpu)
                if (!err)
                  pm_runtime_force_suspend()
                    pm_runtime_disable()
              gpu->funcs->destroy()         // e.g. a6xx_destroy()
                adreno_gpu_cleanup()

I assume we'd be in bigger troubles than just having an unbalanced
disable count if that ever happens, but we should probably just keep the
conditional disable in adreno_gpu_cleanup() in place for now.

> >         msm_gpu_cleanup(&adreno_gpu->base);
> >  }
> > --
> > 2.39.2

I've found another related runtime PM issue so I'll send a v2 anyway.

Johan
