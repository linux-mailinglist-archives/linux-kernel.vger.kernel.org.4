Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18273728FBF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbjFIGRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjFIGR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2808A3580;
        Thu,  8 Jun 2023 23:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F5F616C9;
        Fri,  9 Jun 2023 06:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2845CC433EF;
        Fri,  9 Jun 2023 06:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686291434;
        bh=B6+cEXU+VzPhKn+kA8svZbpcpafwICKvJPZUpHR+zho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEogXCkWo/1eteonPbvslPLmwh7f55SvhXOwmOCm9WKWcy5eTEFw/QaMD/0JXOn28
         KnP9y1lI9alflEFPTRb6CQ29Fr02ynwnlvXbpjezaFzuuRTYVHMl5+ZzzK4CUVp/4T
         Q0r8/70eaxtnmsWg8c9005jbDGbm3OolvxiDhbnFiADE/Vbvhup13EztHwvQlMQ/cP
         nSYC2SHYs9kDbuIN1dxi/0OynRW5QMtRiF+3fL+8SggYtruE+TKk5BLVr5zzCZusdr
         WG7taaUi2BmoD/wBoA5UmXtlDPHas6sRxHxjNAw7+NMupsJtrUPEJLFtF7RMITQNle
         qI4I3IEfPO6Mg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q7VRM-0005C5-SA; Fri, 09 Jun 2023 08:17:41 +0200
Date:   Fri, 9 Jun 2023 08:17:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: Adreno devfreq lockdep splat with 6.3-rc2
Message-ID: <ZILEBPQgqr1HomUQ@hovoldconsulting.com>
References: <ZBGNmXwQoW330Wr8@hovoldconsulting.com>
 <ZIHh95IeOPBTvB00@hovoldconsulting.com>
 <CAF6AEGv3y3C6nAq7nrkgbv5-9-tVgj+BtY1yU+fXXFFm_N7fcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGv3y3C6nAq7nrkgbv5-9-tVgj+BtY1yU+fXXFFm_N7fcQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 02:17:45PM -0700, Rob Clark wrote:
> On Thu, Jun 8, 2023 at 7:12 AM Johan Hovold <johan@kernel.org> wrote:

> > Have you had a chance to look at this regression yet? It prevents us
> > from using lockdep on the X13s as it is disabled as soon as we start
> > the GPU.
> 
> Hmm, curious what is different between x13s and sc7180/sc7280 things?

It seems like lockdep needs to hit the tear down path in order to
detect the circular lock dependency. Perhaps you don't hit that on your
sc7180/sc7280? 

It is due to the fact that the panel is looked up way too late so that
bind fails unless the panel driver is already loaded when the msm drm
driver probes.

Manually loading the panel driver before msm makes the splat go away.

> Or did lockdep recently get more clever (or more annotation)?

I think this is indeed a new problem related to some of the devfreq work
you did in 6.3-rc1 (e.g. fadcc3ab1302 ("drm/msm/gpu: Bypass PM QoS
constraint for idle clamp")).

> I did spend some time a while back trying to bring some sense to
> devfreq/pm-qos/icc locking:
> https://patchwork.freedesktop.org/series/115028/
> 
> but haven't had time to revisit that for a while

That's the series I link to below, but IIRC it did not look directly
applicable to the splat I see on X13s (e.g. does not involve
fs_reclaim).

> > On Wed, Mar 15, 2023 at 10:19:21AM +0100, Johan Hovold wrote:
> > >
> > > Since 6.3-rc2 (or possibly -rc1), I'm now seeing the below
> > > devfreq-related lockdep splat.
> > >
> > > I noticed that you posted a fix for something similar here:
> > >
> > >       https://lore.kernel.org/r/20230312204150.1353517-9-robdclark@gmail.com
> > >
> > > but that particular patch makes no difference.
> > >
> > > From skimming the calltraces below and qos/devfreq related changes in
> > > 6.3-rc1 it seems like this could be related to:
> > >
> > >       fadcc3ab1302 ("drm/msm/gpu: Bypass PM QoS constraint for idle clamp")

Johan
