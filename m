Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A43370FC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjEXROn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjEXRON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:14:13 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DAA18E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:13:50 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7747f76946bso1178739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684948427; x=1687540427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdS+q/K7TdrybGLIQtx2Ez7oq5UvktWCfD/foZoBFes=;
        b=U7BIgnrXPTfSBZPqP2ftRmyQUkaADhylgdggEtlKNZj/NkdDpyIu1i84qN7WxOE8kx
         RJaMka57NYeTMxg9lUsiVUd78BF+qshvEoBKUL01tg5MJplsp1zPvh9F8XXA6rjuNswv
         ztpqedBDo5cUIaOMd1JECBIkU8k1uFR4QMkNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684948427; x=1687540427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdS+q/K7TdrybGLIQtx2Ez7oq5UvktWCfD/foZoBFes=;
        b=aooIbMF6XzZo+vSQB7zdhwV5TcyZhaxeim/dlaF2CpOlwxvBRSHIbsQzdCYUCvl20x
         gSWCkT3cLUSIuJzUMKximGU1k1vdcewdAsA8eyk6OngJqBdov71mXKV5Mch8JhT8jlAx
         3qSuOn22ZFgJavTjx9D8e7VkhrDQRZqEHBMhgrSKqHIIlAb6MqzqLFNBuSGd/cPMDan0
         ukNWXlDNpb6b2VuaJ65q8U7bkNbVnr4S4vTlueU37LM6eSs+4qSPQnrR/ms8+sQ4Crqh
         RqgDKV8og7fCTuvn2k7srmW70S2eJPunMLmHHsg1SKS7OCU8nVlKrxe/KKA6La5pQEBw
         BKPw==
X-Gm-Message-State: AC+VfDzGOPpf6yHVplFlKMBNDSHrT8Rt1/E//hsFQk/DQ+q/dtxmGwJZ
        BxX1iAqnLCp7EjEOCKKGI86LYVeV6cl1zRXgk4U=
X-Google-Smtp-Source: ACHHUZ4AVlqXGHDeTUQ3fV7lKrIi2MkPs9s46MNTUnajRMjMfL3+magusJP3fR20gCIialt0u3ENzA==
X-Received: by 2002:a05:6e02:e0e:b0:335:b2b2:6710 with SMTP id a14-20020a056e020e0e00b00335b2b26710mr8872ilk.15.1684948426906;
        Wed, 24 May 2023 10:13:46 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id e2-20020a056638020200b00411bf6b457bsm3370907jaq.101.2023.05.24.10.13.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 10:13:46 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-33a8f766b64so5925ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:13:45 -0700 (PDT)
X-Received: by 2002:a05:6e02:20c7:b0:32a:f2a9:d1b7 with SMTP id
 7-20020a056e0220c700b0032af2a9d1b7mr411499ilq.10.1684948425265; Wed, 24 May
 2023 10:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230427232848.5200-1-quic_abhinavk@quicinc.com>
 <053819bd-b3c4-a72c-9316-85d974082ad6@linaro.org> <ZGzalLjTvUfzEADU@hovoldconsulting.com>
 <f530691b-989d-b059-6b06-e66abb740bdb@quicinc.com> <ZG216qoxK9hQ-kQs@hovoldconsulting.com>
 <4f2556e2-52ab-eb1d-b388-52546044f460@linaro.org>
In-Reply-To: <4f2556e2-52ab-eb1d-b388-52546044f460@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 May 2023 10:13:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VYczHFHv_h1tt-O+AagE1-KzgYd2B=Cx6fK_s4jR8iTw@mail.gmail.com>
Message-ID: <CAD=FV=VYczHFHv_h1tt-O+AagE1-KzgYd2B=Cx6fK_s4jR8iTw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: add module parameter for PSR
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 24, 2023 at 1:06=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 24/05/2023 09:59, Johan Hovold wrote:
> > On Tue, May 23, 2023 at 12:23:04PM -0700, Abhinav Kumar wrote:
> >> On 5/23/2023 8:24 AM, Johan Hovold wrote:
> >>> On Fri, May 12, 2023 at 09:13:04PM +0300, Dmitry Baryshkov wrote:
> >>>> On 28/04/2023 02:28, Abhinav Kumar wrote:
> >>>>> On sc7280 where eDP is the primary display, PSR is causing
> >>>>> IGT breakage even for basic test cases like kms_atomic and
> >>>>> kms_atomic_transition. Most often the issue starts with below
> >>>>> stack so providing that as reference
> >>>>>
> >>>>> Call trace:
> >
> >>>>> ---[ end trace 0000000000000000 ]---
> >>>>> [drm-dp] dp_ctrl_push_idle: PUSH_IDLE pattern timedout
> >>>>>
> >>>>> Other basic use-cases still seem to work fine hence add a
> >>>>> a module parameter to allow toggling psr enable/disable till
> >>>>> PSR related issues are hashed out with IGT.
> >>>>
> >>>> For the reference: Bjorn reported that he has issues with VT on a
> >>>> PSR-enabled laptops. This patch fixes the issue for him
> >>>
> >>> Module parameters are almost never warranted, and it is definitely no=
t
> >>> the right way to handle a broken implementation.
> >>>
> >>> I've just sent a revert that unconditionally disables PSR support unt=
il
> >>> the implementation has been fixed:
> >>>
> >>>     https://lore.kernel.org/lkml/20230523151646.28366-1-johan+linaro@=
kernel.org/
> >>
> >> I dont completely agree with this. Even the virtual terminal case was
> >> reported to be fixed by one user but not the other. So it was probably
> >> something missed out either in validation or reproduction steps of the
> >> user who reported it to be fixed OR the user who reported it not fixed=
.
> >> That needs to be investigated now.
> >
> > Yes, there may still be some time left to fix it, but it's pretty damn
> > annoying to find that an issue reported two months ago still is not
> > fixed at 6.4-rc3. (I even waited to make the switch to 6.4 so that I
> > would not have to spend time on this.)
> >
> > I didn't see any mail from Bjorn saying that the series that claimed to
> > fix the VT issue actually did fix the VT issue. There's only the commen=
t
> > above from Dmitry suggesting that disabling this feature is the only wa=
y
> > to get a working terminal back.
>
> Originally this issue was reported by Doug, and at [1] he reported that
> an issue is fixed for him. So, for me it looks like we have hardware
> where VT works and hardware where it doesn't.

As I understand it, the problem was originally reported by Bjorn over
IRC. When he reported the problem on VT2, Stephen Boyd confirmed that
he could see the same problem on our hardware when using VT2. I
confirmed I could reproduce and also tested the fix. I don't remember
if Bjorn ever tested the fix. I think many of us assumed that it was
the same issue so a fix for one person would also fix the other.


> Doug, can you please confirm whether you can reproduce the PSR+VT issue
> on 6.4-rc (without extra patches) or if the issue is fixed for you?
>
> [1]
> https://lore.kernel.org/dri-devel/CAD=3DFV=3DVSHmQPtsQfWjviEZeErms-VEOTmf=
ozejASUC9zsMjAbA@mail.gmail.com/

Ugh. Unfortunately, it's not easy for me to test this particular
feature directly on upstream Linux. :( I typically run with a ChromeOS
root filesystem, which works pretty well with mainline. One place
where it doesn't work with mainline is VT2. The VT2 feature for
Chromebooks is implemented with "frecon" and takes advantage of a
downstream patch that we've carried in the ChromeOS kernel trees for
years allowing handoff of who the DRM "master" is.

For testing the fix previously, I confirmed that I could reproduce the
problem on our downstream kernel (which had the PSR patches picked)
and that the fixes worked for me in that context.

Ah, but it shouldn't be too hard to pick that one patch. Let's see if
that works. I'll pick ("CHROMIUM: drm: Add drm_master_relax debugfs
file (non-root set/drop master ioctls)"). Indeed, it works!

OK, so with the top of Linus's tree (v6.4-rc3-17-g9d646009f65d) plus
the CHROMIUM patch to enable my VT2, I can confirm that I don't see
the issue. I can switch to VT2 and typing works fine. I will say that
on herobrine the backlight is all messed up, but I assume that's an
unrelated issue.

-Doug



> > Regressions happen and sometimes there are corner cases that are harder
> > to find, but this is a breakage of a fundamental feature that was
> > reported before the code was even merged into mainline.
> >
> >> We should have ideally gone with the modparam with the feature patches
> >> itself knowing that it gets enabled for all sinks if PSR is supported.
> >
> > Modparams are things of the past should not be used to enable broken
> > features so that some vendor can tick of their internal lists of
> > features that have been "mainlined".
>
> We have had a history of using modparam with i915 and IIRC amdgpu /
> radeon drivers to allow users to easily check whether new feature works
> for their hardware. My current understanding is that PSR+VT works for on
> some laptops and doesn't on some other laptops, which makes it a valid ca=
se.
>
> >
> > You can carry that single patch out-of-tree to enable this if you need
> > it for some particular use case where you don't care about VTs.
> >
> > But hopefully you can just get this sorted quickly. If not, the revert =
I
> > posted is the way to go rather than adding random module parameters.
> >
> > Johan
>
> --
> With best wishes
> Dmitry
>
