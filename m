Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557C6679300
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjAXIZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjAXIZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:25:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54CDBB;
        Tue, 24 Jan 2023 00:25:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81A14B810E0;
        Tue, 24 Jan 2023 08:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C67C433EF;
        Tue, 24 Jan 2023 08:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674548699;
        bh=oQVf/VHVxuVU6pp8JxMCkVbd0XihALuaJGXSHkkghvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVZG9GpbpW3XSgAQF74nJedsmP5shTjLOEjHcUS5p3SfIhNBTTNQDx6kP2BR9apVE
         AMLu5XJKugX05Yt8nqoK5sb/L842bQ36DE0bhV7BePohrJij7RRQCNyZ/2yBy77RTp
         D2GP+fnsZ5MJUK9fgwEad+KHiUvjufMoA203qVk2zXHuBFr5ZP9ooTYhVB4wkJ/Usx
         W/Xv2Ws+eyGmiNPu57JW6l09hAyOToL8I6X/AZSgql3aORsmhxWsvH9YtV4pLr4jSZ
         h96/Y6xEI2mlX8Q1o6azAAk2IuBiFWbVx8RnEAQ2dU09nimq7Jp5uQzeRwG/6NnanA
         77vJ7Jt/HQhBQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pKEby-0005Hi-SQ; Tue, 24 Jan 2023 09:24:58 +0100
Date:   Tue, 24 Jan 2023 09:24:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Initialize mode_config earlier
Message-ID: <Y8+V2il5vyV7z/9B@hovoldconsulting.com>
References: <20230113041051.4189063-1-quic_bjorande@quicinc.com>
 <eea1c5dc-6bc5-4246-f0e1-0c790de9f078@linaro.org>
 <9a64c685-9ff0-bc1d-e604-e3773ff9edd7@linaro.org>
 <20230117025122.jt3wrjkqfnogu4ci@builder.lan>
 <Y8ZWl85gSpOaLgO4@hovoldconsulting.com>
 <Y86vaTQR7INWezyj@hovoldconsulting.com>
 <20230123171749.GA623918@hu-bjorande-lv.qualcomm.com>
 <Y8+SHQ/klPwusQRj@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8+SHQ/klPwusQRj@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:09:02AM +0100, Johan Hovold wrote:
> On Mon, Jan 23, 2023 at 09:17:49AM -0800, Bjorn Andersson wrote:
> > On Mon, Jan 23, 2023 at 05:01:45PM +0100, Johan Hovold wrote:
> > > On Tue, Jan 17, 2023 at 09:04:39AM +0100, Johan Hovold wrote:
> > > > On Mon, Jan 16, 2023 at 08:51:22PM -0600, Bjorn Andersson wrote:
> 
> > > > > Perhaps we have shuffled other things around to avoid this bug?  Either
> > > > > way, let's this on hold  until further proof that it's still
> > > > > reproducible.
> > > > 
> > > > As I've mentioned off list, I haven't hit the apparent race I reported
> > > > here:
> > > > 
> > > > 	https://lore.kernel.org/all/Y1efJh11B5UQZ0Tz@hovoldconsulting.com/
> > > > 
> > > > since moving to 6.2. I did hit it with both 6.0 and 6.1-rc2, but it
> > > > could very well be that something has changes that fixes (or hides) the
> > > > issue since.
> > > 
> > > For unrelated reasons, I tried enabling async probing, and apart from
> > > apparently causing the panel driver to probe defer indefinitely, I also
> > > again hit the WARN_ON() I had added to catch this:
> > > 
> > > [   13.593235] WARNING: CPU: 0 PID: 125 at drivers/gpu/drm/drm_probe_helper.c:664 drm_kms_helper_hotplug_event+0x48/0x7
> > > 0 [drm_kms_helper]
> 
> > > So the bug still appears to be there (and the MSM DRM driver is fragile
> > > and broken, but we knew that).
> > > 
> > 
> > But the ordering between mode_config.funcs = !NULL and
> > drm_kms_helper_poll_init() in msm_drm_init() seems pretty clear.
> > 
> > And my testing shows that drm_kms_helper_poll_init() is the cause for
> > getting bridge->hpd_cb != NULL.
> > 
> > So the ordering seems legit, unless there's something else causing the
> > assignment of bridge->hpd_cb to happen earlier in this scenario.
> 
> I'm not saying that this patch is correct (indeed it doesn't seem to
> be), but only that the bug I reported still appears to be present in
> 6.2.
> 
> Now that I actually looked at this again, I realise that the reason that
> haven't seen it with 6.2 is more likely due to the fact that I'm now
> making sure to load the panel driver before the drm driver to avoid that
> unnecessary probe deferral.
> 
> With async probing, I get the probe deferral again, and boom, I hit the
> same old NULL deref.
> 
> I see there's a call to drm_kms_helper_poll_fini() in msm_drm_uninit()
> which should stop the polling, but perhaps there's still some corner
> case due to the unexpected probe (or rather component bind) deferral
> which we're hitting.

I guess the drm_kms_helper_poll_fini() bit is irrelevant here as the
call comes from the pmic_glink_altmode_worker() and
drm_bridge_hpd_notify().

Perhaps the pmic_glink altmode driver simply isn't notified that the
drm device is gone again due to the late "probe" deferral or similar?

Johan
