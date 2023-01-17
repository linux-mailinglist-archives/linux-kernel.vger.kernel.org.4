Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F166D778
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjAQIE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjAQIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:04:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC51D265B6;
        Tue, 17 Jan 2023 00:04:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42F19611E0;
        Tue, 17 Jan 2023 08:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1306C433EF;
        Tue, 17 Jan 2023 08:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673942658;
        bh=vB1tUi0ipCUEpsBghYAjXEtXUjagIZFsMiRJPsWnUaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T5yZSdMjUiRzxdy3m2UG+4oH3ZQlLPbzR+AnF52SIEImKtlyPrUvMcmkG25HjpZ79
         joYjF+7Uei7L3bhxUxQZMNSVVlgUr/35WwcarMU6e6lG0r/yCrGtOXCG6FEi6O/UXk
         XRBjZpUT0bW7LTEZUP9lUyEbl2BTAhsSVdaKfuTp+IVSX9wBl1GkmWZ4y82M6xrzJ7
         Xwj6WP0H8jfHRn5Sx0d+D9ouSZNV3EEK/Kaq5687HVuEph0UwiUTqfd++pFIJ8QcAR
         eV+n82ogzK1BDQ+E3+t0Ne+2N0d/uM9RDKD726Ea4girgTXOHtwIB7M1FSWjovvohH
         XwbixnAO3tX+w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pHgxT-00074C-F0; Tue, 17 Jan 2023 09:04:39 +0100
Date:   Tue, 17 Jan 2023 09:04:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Initialize mode_config earlier
Message-ID: <Y8ZWl85gSpOaLgO4@hovoldconsulting.com>
References: <20230113041051.4189063-1-quic_bjorande@quicinc.com>
 <eea1c5dc-6bc5-4246-f0e1-0c790de9f078@linaro.org>
 <9a64c685-9ff0-bc1d-e604-e3773ff9edd7@linaro.org>
 <20230117025122.jt3wrjkqfnogu4ci@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117025122.jt3wrjkqfnogu4ci@builder.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 08:51:22PM -0600, Bjorn Andersson wrote:
> On Fri, Jan 13, 2023 at 10:57:18AM +0200, Dmitry Baryshkov wrote:
> > On 13/01/2023 06:23, Dmitry Baryshkov wrote:
> > > On 13/01/2023 06:10, Bjorn Andersson wrote:
> > > > Invoking drm_bridge_hpd_notify() on a drm_bridge with a HPD-enabled
> > > > bridge_connector ends up in drm_bridge_connector_hpd_cb() calling
> > > > drm_kms_helper_hotplug_event(), which assumes that the associated
> > > > drm_device's mode_config.funcs is a valid pointer.
> > > > 
> > > > But in the MSM DisplayPort driver the HPD enablement happens at bind
> > > > time and mode_config.funcs is initialized late in msm_drm_init(). This
> > > > means that there's a window for hot plug events to dereference a NULL
> > > > mode_config.funcs.
> > > > 
> > > > Move the assignment of mode_config.funcs before the bind, to avoid this
> > > > scenario.
> > > 
> > > Cam we make DP driver not to report HPD events until the enable_hpd()
> > > was called? I think this is what was fixed by your internal_hpd
> > > patchset.
> > 
> > Or to express this in another words: I thought that internal_hpd already
> > deferred enabling hpd event reporting till the time when we need it, didn't
> > it?
> > 
> 
> I added a WARN_ON(1) in drm_bridge_hpd_enable() to get a sense of when
> this window of "opportunity" opens up, and here's the callstack:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 6 PID: 99 at drivers/gpu/drm/drm_bridge.c:1260 drm_bridge_hpd_enable+0x48/0x94 [drm]
> ...
> Call trace:
>  drm_bridge_hpd_enable+0x48/0x94 [drm]
>  drm_bridge_connector_enable_hpd+0x30/0x3c [drm_kms_helper]
>  drm_kms_helper_poll_enable+0xa4/0x114 [drm_kms_helper]
>  drm_kms_helper_poll_init+0x6c/0x7c [drm_kms_helper]
>  msm_drm_bind+0x370/0x628 [msm]
>  try_to_bring_up_aggregate_device+0x170/0x1bc
>  __component_add+0xb0/0x168
>  component_add+0x20/0x2c
>  dp_display_probe+0x40c/0x468 [msm]
>  platform_probe+0xb4/0xdc
>  really_probe+0x13c/0x300
>  __driver_probe_device+0xc0/0xec
>  driver_probe_device+0x48/0x204
>  __device_attach_driver+0x124/0x14c
>  bus_for_each_drv+0x90/0xdc
>  __device_attach+0xdc/0x1a8
>  device_initial_probe+0x20/0x2c
>  bus_probe_device+0x40/0xa4
>  deferred_probe_work_func+0x94/0xd0
>  process_one_work+0x1a8/0x3c0
>  worker_thread+0x254/0x47c
>  kthread+0xf8/0x1b8
>  ret_from_fork+0x10/0x20
> ---[ end trace 0000000000000000 ]---
> 
> As drm_kms_helper_poll_init() is the last thing being called in
> msm_drm_init() shifting around the mode_config.func assignment would not
> have any impact.
> 
> Perhaps we have shuffled other things around to avoid this bug?  Either
> way, let's this on hold  until further proof that it's still
> reproducible.

As I've mentioned off list, I haven't hit the apparent race I reported
here:

	https://lore.kernel.org/all/Y1efJh11B5UQZ0Tz@hovoldconsulting.com/

since moving to 6.2. I did hit it with both 6.0 and 6.1-rc2, but it
could very well be that something has changes that fixes (or hides) the
issue since.

Johan
