Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDC16F0781
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243995AbjD0Oc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244139AbjD0OcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:32:17 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0B95BAB;
        Thu, 27 Apr 2023 07:31:54 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-38e3228d120so5126988b6e.3;
        Thu, 27 Apr 2023 07:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682605913; x=1685197913;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRZglDXB91+6f7S2dtMlSBFPaJiJ8/S98Gq1cNjaW8Q=;
        b=ZKUcLKH4jO6eUX11CsiFYAsZQboMzOTzukH+ORISmxFF2yQ6T96vWRnvS+xlwUtwBa
         0lqB7EnRVZbvDdY3i/V2xRzDCoFsKupg4xJATdLTpURRqY/9Vxst5iEaonxWZ5wxly9z
         LuYos6Wfwy4zeY0uKGYtwiUZmPFCX6HPuEvJBMTzrjYvbgjpbo0R/rfbi6OtH/y5fokF
         ox4hlGFE/1Cd5bnL7ekHeSYnvNMGcOGVME2PuLgyDk6ln934sI8x9H/Qh2O3jR1ppVIQ
         vIYOrx0EUjA2AOMXAj+u4tkcCLv9qcWv1gxGAe0LPtm0SALsFtgQBovdiAcxxEM8PDi6
         AnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682605913; x=1685197913;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRZglDXB91+6f7S2dtMlSBFPaJiJ8/S98Gq1cNjaW8Q=;
        b=Hr7r/8rbAufiknAClr4W7N8wOdcmM1X7w4eVYESMXzm7TOQk0YzdtaO/NcXT11n/VE
         V20afHxJVjAck46yENPcMfnOPMy1yesfWTaRv4c5OAAmsaUURFsN0q9q7K+TVxp8DCdI
         k/zPJ02e0SrvcQhX+JsGcvTAUYLycDY1c0szUpXIvMi32M/3USPejRZj12fpHFA6vs2K
         mem3Or6Rz4sc3g0BIK8mknxac512Am4lY9wR5fRbz55PrpFV0KEGai67yBz7qmOMt2Cp
         hViwmGn6FDePFX3PPwzpLh38soen8qjvTwtUQinmgRVdi3R9mAdyUFEo/Nhxk+0M/kv5
         ZJlQ==
X-Gm-Message-State: AC+VfDyO28OEYKEs6uayFchZt7+CpBQoNCAmNFWPo+5hgYSy5cZJfetC
        XIgKIbR9QHU2UlHHHnyj9WUG6vLQUeVkWesnqRMALEup
X-Google-Smtp-Source: ACHHUZ5vqvrwk+VgTL9ZXd2NM5nRRwBWWe3P4jFrzMD7s6MUMokZJiESSfjBOx9isBUa3M10jk9ZUbOD9YRpwoIy1vg=
X-Received: by 2002:a05:6808:914:b0:38c:1acd:e6ee with SMTP id
 w20-20020a056808091400b0038c1acde6eemr799313oih.9.1682605911323; Thu, 27 Apr
 2023 07:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230417201215.448099-1-robdclark@gmail.com> <20230417201215.448099-3-robdclark@gmail.com>
 <58977051-197b-f1f0-c795-9037e70d7a91@linux.intel.com> <ZD5WLMRNibbRkGQO@phenom.ffwll.local>
 <CAF6AEGugcuV08G_pxjUGvhTbp8DFFG4ws3=oiP5PpbRf=SJdhQ@mail.gmail.com>
 <CACvgo52gByHzwtm4gxqUxZ5yJGTQ5NucBmMHSO7nLPsba3rTfw@mail.gmail.com>
 <CAF6AEGtijkCt2uUx98auFcK0GQHY=5GV7CxbOejGz22no6J0GQ@mail.gmail.com> <ZEpC5xEZ4cueb881@phenom.ffwll.local>
In-Reply-To: <ZEpC5xEZ4cueb881@phenom.ffwll.local>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 27 Apr 2023 07:31:39 -0700
Message-ID: <CAF6AEGs5ROH0xqCwZKs2JaUvoOiEOmyqneLCW9eQDOJhPqNLFQ@mail.gmail.com>
Subject: Re: [RFC 2/3] drm/msm: Rework get_comm_cmdline() helper
To:     Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 2:39=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> On Fri, Apr 21, 2023 at 07:47:26AM -0700, Rob Clark wrote:
> > On Fri, Apr 21, 2023 at 2:33=E2=80=AFAM Emil Velikov <emil.l.velikov@gm=
ail.com> wrote:
> > >
> > > Greeting all,
> > >
> > > Sorry for the delay - Easter Holidays, food coma and all that :-)
> > >
> > > On Tue, 18 Apr 2023 at 15:31, Rob Clark <robdclark@gmail.com> wrote:
> > > >
> > > > On Tue, Apr 18, 2023 at 1:34=E2=80=AFAM Daniel Vetter <daniel@ffwll=
.ch> wrote:
> > > > >
> > > > > On Tue, Apr 18, 2023 at 09:27:49AM +0100, Tvrtko Ursulin wrote:
> > > > > >
> > > > > > On 17/04/2023 21:12, Rob Clark wrote:
> > > > > > > From: Rob Clark <robdclark@chromium.org>
> > > > > > >
> > > > > > > Make it work in terms of ctx so that it can be re-used for fd=
info.
> > > > > > >
> > > > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > > > ---
> > > > > > >   drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 ++--
> > > > > > >   drivers/gpu/drm/msm/msm_drv.c           |  2 ++
> > > > > > >   drivers/gpu/drm/msm/msm_gpu.c           | 13 ++++++-------
> > > > > > >   drivers/gpu/drm/msm/msm_gpu.h           | 12 ++++++++++--
> > > > > > >   drivers/gpu/drm/msm/msm_submitqueue.c   |  1 +
> > > > > > >   5 files changed, 21 insertions(+), 11 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/driver=
s/gpu/drm/msm/adreno/adreno_gpu.c
> > > > > > > index bb38e728864d..43c4e1fea83f 100644
> > > > > > > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > > > > > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > > > > > @@ -412,7 +412,7 @@ int adreno_set_param(struct msm_gpu *gpu,=
 struct msm_file_private *ctx,
> > > > > > >             /* Ensure string is null terminated: */
> > > > > > >             str[len] =3D '\0';
> > > > > > > -           mutex_lock(&gpu->lock);
> > > > > > > +           mutex_lock(&ctx->lock);
> > > > > > >             if (param =3D=3D MSM_PARAM_COMM) {
> > > > > > >                     paramp =3D &ctx->comm;
> > > > > > > @@ -423,7 +423,7 @@ int adreno_set_param(struct msm_gpu *gpu,=
 struct msm_file_private *ctx,
> > > > > > >             kfree(*paramp);
> > > > > > >             *paramp =3D str;
> > > > > > > -           mutex_unlock(&gpu->lock);
> > > > > > > +           mutex_unlock(&ctx->lock);
> > > > > > >             return 0;
> > > > > > >     }
> > > > > > > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/=
msm/msm_drv.c
> > > > > > > index 3d73b98d6a9c..ca0e89e46e13 100644
> > > > > > > --- a/drivers/gpu/drm/msm/msm_drv.c
> > > > > > > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > > > > > > @@ -581,6 +581,8 @@ static int context_init(struct drm_device=
 *dev, struct drm_file *file)
> > > > > > >     rwlock_init(&ctx->queuelock);
> > > > > > >     kref_init(&ctx->ref);
> > > > > > > +   ctx->pid =3D get_pid(task_pid(current));
> > > > > >
> > > > > > Would it simplify things for msm if DRM core had an up to date =
file->pid as
> > > > > > proposed in
> > > > > > https://patchwork.freedesktop.org/patch/526752/?series=3D109902=
&rev=3D4 ? It
> > > > > > gets updated if ioctl issuer is different than fd opener and th=
is being
> > > > > > context_init here reminded me of it. Maybe you wouldn't have to=
 track the
> > > > > > pid in msm?
> > > >
> > > > The problem is that we also need this for gpu devcore dumps, which
> > > > could happen after the drm_file is closed.  The ctx can outlive the
> > > > file.
> > > >
> > > I think we all kept forgetting about that. MSM had support for ages,
> > > while AMDGPU is the second driver to land support - just a release
> > > ago.
> > >
> > > > But the ctx->pid has the same problem as the existing file->pid whe=
n
> > > > it comes to Xorg.. hopefully over time that problem just goes away.
> > >
> > > Out of curiosity: what do you mean with "when it comes to Xorg" - the
> > > "was_master" handling or something else?
> >
> > The problem is that Xorg is the one to open the drm fd, and then
> > passes the fd to the client.. so the pid of drm_file is the Xorg pid,
> > not the client.  Making it not terribly informative.
> >
> > Tvrtko's patch he linked above would address that for drm_file, but
> > not for other driver internal usages.  Maybe it could be wired up as a
> > helper so that drivers don't have to re-invent that dance.  Idk, I
> > have to think about it.
> >
> > Btw, with my WIP drm sched fence signalling patch lockdep is unhappy
> > when gpu devcore dumps are triggered.  I'm still pondering how to
> > decouple the locking so that anything coming from fs (ie.
> > show_fdinfo()) is decoupled from anything that happens in the fence
> > signaling path.  But will repost this series once I get that sorted
> > out.
>
> So the cleanest imo is that you push most of the capturing into a worker
> that's entirely decoupled. If you have terminal context (i.e. on first
> hang they stop all further cmd submission, which is anyway what
> vk/arb_robustness want), then you don't have to capture at tdr time,
> because there's no subsequent batch that will wreck the state.

It is already in a worker, but we (a) need to block other contexts
from submitting while at the same time (b) using the GPU itself to
capture its state.. (yes, the way the hw works is overly complicated
in this regard)

> But it only works if your gpu ctx don't have recoverable semantics.

We do have recoverable semantics.. but that is pretty orthogonal.  We
just need a different lock.. I have a plan to move (a copy) of the
override strings to drm_file with it's own locking decoupled from what
we need in the recovery path.. and hopefully will finally have time to
type it up today and post it (just before disappearing off into the
woods to go backpacking ;-))

BR,
-R

> If you can't do that it's a _lot_ of GFP_ATOMIC and trylock and bailing
> out if any fails :-/
> -Daniel
>
> >
> > BR,
> > -R
> >
> > >
> > > > guess I could do a similar dance to your patch to update the pid
> > > > whenever (for ex) a submitqueue is created.
> > > >
> > > > > Can we go one step further and let the drm fdinfo stuff print the=
se new
> > > > > additions? Consistency across drivers and all that.
> > > >
> > > > Hmm, I guess I could _also_ store the overridden comm/cmdline in
> > > > drm_file.  I still need to track it in ctx (msm_file_private) becau=
se
> > > > I could need it after the file is closed.
> > > >
> > > > Maybe it could be useful to have a gl extension to let the app set =
a
> > > > name on the context so that this is useful beyond native-ctx (ie.
> > > > maybe it would be nice to see that "chrome: lwn.net" is using less =
gpu
> > > > memory than "chrome: phoronix.com", etc)
> > > >
> > >
> > > /me awaits for the series to hit the respective websites ;-)
> > >
> > > But seriously - the series from Tvrtko (thanks for the link, will
> > > check in a moment) makes sense. Although given the livespan issue
> > > mentioned above, I don't think it's applicable here.
> > >
> > > So if it were me, I would consider the two orthogonal for the
> > > short/mid term. Fwiw this and patch 1/3 are:
> > > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> > >
> > > HTH
> > > -Emil
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
