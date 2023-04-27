Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F776F0384
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbjD0Jj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243064AbjD0Jj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:39:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672624497
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:39:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-95227e5164dso235505566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1682588394; x=1685180394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ijOvNVXHQPQ7K3a8mfotlj3EqkLbm2iNVAzawaQHZIw=;
        b=kFa3Dgvsdqo+BXHl6yahcNl1383pNFvNtKjCwWMfHTj+Bit3JIwCGJEQDI6N/QU00j
         7X00IV28cyVTxMhXOHSSaNOtJlIO/f240AjyaV+PfAb4s7UETaAAtwNr4ZxvB9KF2UtB
         pZGfcxrFXB1KoRo0EnWbU8+HE3g7nM63d1OjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682588394; x=1685180394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijOvNVXHQPQ7K3a8mfotlj3EqkLbm2iNVAzawaQHZIw=;
        b=JinA70+Nd+sx0CdGUKkjQy0wo/2REWyF7baWHqq3YClebNFnxH/tx/QdheDC2XhJ4G
         WOkSgQ7y1E60lmIiY3SlFe+DA3DMvEL02A/nquy26o0ApMnca20zjxIDy5F6Bzpuq68o
         1m8Jz7LYxuyENSrtliyxXDXHx0EAMgaAuO8Pjn6As3aHaCKiKpmNcnWZC4tbeLF+Wr9Q
         rotEZlNUJWa4LDyzXL5RjEjsRtyQKnrEWOhnEh6X4+7vzxFTjkRO5ZzGyz/ODfFeyn9l
         4kTKIu299gm6u+m+KiVHjxPCTxuXD/nJ+hf0JKGxHD+hvjnQtLoNj1aeMviBym6dYjOB
         aFAw==
X-Gm-Message-State: AC+VfDzdgSJV683RS2zA6PJF5r6HTkpwDwszB82aUcm7mOuau06iM26K
        aolgYs31fXxfrcoPvMEB81RaHA==
X-Google-Smtp-Source: ACHHUZ7VSLJU2Bi7Vlppn+yZkQubTXq/4j3BnKk8IoW139u/a/w2x464xtiUeWCmvDcGrbJw+QXvuw==
X-Received: by 2002:a17:906:7491:b0:95f:db5f:73b7 with SMTP id e17-20020a170906749100b0095fdb5f73b7mr888891ejl.0.1682588393848;
        Thu, 27 Apr 2023 02:39:53 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id jt11-20020a170906ca0b00b00958434d4ecesm6820771ejb.13.2023.04.27.02.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 02:39:53 -0700 (PDT)
Date:   Thu, 27 Apr 2023 11:39:51 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>, Sean Paul <sean@poorly.run>
Subject: Re: [RFC 2/3] drm/msm: Rework get_comm_cmdline() helper
Message-ID: <ZEpC5xEZ4cueb881@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>
References: <20230417201215.448099-1-robdclark@gmail.com>
 <20230417201215.448099-3-robdclark@gmail.com>
 <58977051-197b-f1f0-c795-9037e70d7a91@linux.intel.com>
 <ZD5WLMRNibbRkGQO@phenom.ffwll.local>
 <CAF6AEGugcuV08G_pxjUGvhTbp8DFFG4ws3=oiP5PpbRf=SJdhQ@mail.gmail.com>
 <CACvgo52gByHzwtm4gxqUxZ5yJGTQ5NucBmMHSO7nLPsba3rTfw@mail.gmail.com>
 <CAF6AEGtijkCt2uUx98auFcK0GQHY=5GV7CxbOejGz22no6J0GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGtijkCt2uUx98auFcK0GQHY=5GV7CxbOejGz22no6J0GQ@mail.gmail.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 07:47:26AM -0700, Rob Clark wrote:
> On Fri, Apr 21, 2023 at 2:33 AM Emil Velikov <emil.l.velikov@gmail.com> wrote:
> >
> > Greeting all,
> >
> > Sorry for the delay - Easter Holidays, food coma and all that :-)
> >
> > On Tue, 18 Apr 2023 at 15:31, Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > On Tue, Apr 18, 2023 at 1:34 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > >
> > > > On Tue, Apr 18, 2023 at 09:27:49AM +0100, Tvrtko Ursulin wrote:
> > > > >
> > > > > On 17/04/2023 21:12, Rob Clark wrote:
> > > > > > From: Rob Clark <robdclark@chromium.org>
> > > > > >
> > > > > > Make it work in terms of ctx so that it can be re-used for fdinfo.
> > > > > >
> > > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > > ---
> > > > > >   drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 ++--
> > > > > >   drivers/gpu/drm/msm/msm_drv.c           |  2 ++
> > > > > >   drivers/gpu/drm/msm/msm_gpu.c           | 13 ++++++-------
> > > > > >   drivers/gpu/drm/msm/msm_gpu.h           | 12 ++++++++++--
> > > > > >   drivers/gpu/drm/msm/msm_submitqueue.c   |  1 +
> > > > > >   5 files changed, 21 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > > > > index bb38e728864d..43c4e1fea83f 100644
> > > > > > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > > > > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > > > > @@ -412,7 +412,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
> > > > > >             /* Ensure string is null terminated: */
> > > > > >             str[len] = '\0';
> > > > > > -           mutex_lock(&gpu->lock);
> > > > > > +           mutex_lock(&ctx->lock);
> > > > > >             if (param == MSM_PARAM_COMM) {
> > > > > >                     paramp = &ctx->comm;
> > > > > > @@ -423,7 +423,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
> > > > > >             kfree(*paramp);
> > > > > >             *paramp = str;
> > > > > > -           mutex_unlock(&gpu->lock);
> > > > > > +           mutex_unlock(&ctx->lock);
> > > > > >             return 0;
> > > > > >     }
> > > > > > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > > > > > index 3d73b98d6a9c..ca0e89e46e13 100644
> > > > > > --- a/drivers/gpu/drm/msm/msm_drv.c
> > > > > > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > > > > > @@ -581,6 +581,8 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
> > > > > >     rwlock_init(&ctx->queuelock);
> > > > > >     kref_init(&ctx->ref);
> > > > > > +   ctx->pid = get_pid(task_pid(current));
> > > > >
> > > > > Would it simplify things for msm if DRM core had an up to date file->pid as
> > > > > proposed in
> > > > > https://patchwork.freedesktop.org/patch/526752/?series=109902&rev=4 ? It
> > > > > gets updated if ioctl issuer is different than fd opener and this being
> > > > > context_init here reminded me of it. Maybe you wouldn't have to track the
> > > > > pid in msm?
> > >
> > > The problem is that we also need this for gpu devcore dumps, which
> > > could happen after the drm_file is closed.  The ctx can outlive the
> > > file.
> > >
> > I think we all kept forgetting about that. MSM had support for ages,
> > while AMDGPU is the second driver to land support - just a release
> > ago.
> >
> > > But the ctx->pid has the same problem as the existing file->pid when
> > > it comes to Xorg.. hopefully over time that problem just goes away.
> >
> > Out of curiosity: what do you mean with "when it comes to Xorg" - the
> > "was_master" handling or something else?
> 
> The problem is that Xorg is the one to open the drm fd, and then
> passes the fd to the client.. so the pid of drm_file is the Xorg pid,
> not the client.  Making it not terribly informative.
> 
> Tvrtko's patch he linked above would address that for drm_file, but
> not for other driver internal usages.  Maybe it could be wired up as a
> helper so that drivers don't have to re-invent that dance.  Idk, I
> have to think about it.
> 
> Btw, with my WIP drm sched fence signalling patch lockdep is unhappy
> when gpu devcore dumps are triggered.  I'm still pondering how to
> decouple the locking so that anything coming from fs (ie.
> show_fdinfo()) is decoupled from anything that happens in the fence
> signaling path.  But will repost this series once I get that sorted
> out.

So the cleanest imo is that you push most of the capturing into a worker
that's entirely decoupled. If you have terminal context (i.e. on first
hang they stop all further cmd submission, which is anyway what
vk/arb_robustness want), then you don't have to capture at tdr time,
because there's no subsequent batch that will wreck the state.

But it only works if your gpu ctx don't have recoverable semantics.

If you can't do that it's a _lot_ of GFP_ATOMIC and trylock and bailing
out if any fails :-/
-Daniel

> 
> BR,
> -R
> 
> >
> > > guess I could do a similar dance to your patch to update the pid
> > > whenever (for ex) a submitqueue is created.
> > >
> > > > Can we go one step further and let the drm fdinfo stuff print these new
> > > > additions? Consistency across drivers and all that.
> > >
> > > Hmm, I guess I could _also_ store the overridden comm/cmdline in
> > > drm_file.  I still need to track it in ctx (msm_file_private) because
> > > I could need it after the file is closed.
> > >
> > > Maybe it could be useful to have a gl extension to let the app set a
> > > name on the context so that this is useful beyond native-ctx (ie.
> > > maybe it would be nice to see that "chrome: lwn.net" is using less gpu
> > > memory than "chrome: phoronix.com", etc)
> > >
> >
> > /me awaits for the series to hit the respective websites ;-)
> >
> > But seriously - the series from Tvrtko (thanks for the link, will
> > check in a moment) makes sense. Although given the livespan issue
> > mentioned above, I don't think it's applicable here.
> >
> > So if it were me, I would consider the two orthogonal for the
> > short/mid term. Fwiw this and patch 1/3 are:
> > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> >
> > HTH
> > -Emil

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
