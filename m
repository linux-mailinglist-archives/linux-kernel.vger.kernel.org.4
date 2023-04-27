Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BF6F0D31
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344264AbjD0Uc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbjD0Ucy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:32:54 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF0E2D65;
        Thu, 27 Apr 2023 13:32:52 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 13472200D5;
        Thu, 27 Apr 2023 22:32:51 +0200 (CEST)
Date:   Thu, 27 Apr 2023 22:32:49 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, quic_sbillaka@quicinc.com,
        dianders@chromium.org, airlied@gmail.com, andersson@kernel.org,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        swboyd@chromium.org, vkoul@kernel.org, agross@kernel.org,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, sean@poorly.run,
        linux-kernel@vger.kernel.org
Subject: Re: [Freedreno] [PATCH] drm/msm/dpu: always program dsc active bits
Message-ID: <plyxdgxbiqxmlbs5d53ps6vl4zts6zlzbctrpvshnbvuontqot@uaspqab4kmjt>
References: <z7wj2lcgcdxsqh7ylhec3ig6o4p6q37zqvpzoxp4bd4vid2z2n@ubsgt3ebqrwr>
 <83f9a438-52c5-83f3-1767-92d16518d8f0@quicinc.com>
 <feedv4isliterjtwyicqfarwuvzhtov3jkmvjcwqvt7itkyh7y@e2jq5t6r3lxc>
 <e78e576a-2a04-e7ca-f6c4-701d508541ad@quicinc.com>
 <mfzi535qsjtcznwdvgb7qyzk25rcsrkwozah6ji4thqsj73n3m@asybxllomisg>
 <049697ba-d997-62c0-6e21-ffb287ac3100@quicinc.com>
 <6s42sutrd2c6tme46t6tchd6y6wonmpwokseqqz2frkrfext7v@vnv44tzwyva4>
 <82bf6167-d621-1a4e-86f0-7a8567347722@quicinc.com>
 <2e6dwt74oyy7rroxyus6ebfbylbbtinsi7bccpqazjm64owiv4@gfs52kkq47c3>
 <8c3a210a-200b-eb1d-e39a-8aad15d790f4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3a210a-200b-eb1d-e39a-8aad15d790f4@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-14 16:51:52, Abhinav Kumar wrote:
> On 4/14/2023 4:11 PM, Marijn Suijten wrote:
> > On 2023-04-14 10:57:45, Abhinav Kumar wrote:
> >> On 4/14/2023 10:34 AM, Marijn Suijten wrote:
> >>> On 2023-04-14 08:48:43, Abhinav Kumar wrote:
> >>>> On 4/14/2023 12:35 AM, Marijn Suijten wrote:
> >>>>> On 2023-04-12 10:33:15, Abhinav Kumar wrote:
> >>>>> [..]
> >>>>>>> What happens if a device boots without DSC panel connected?  Will
> >>>>>>> CTL_DSC_FLUSH be zero and not (unnecessarily, I assume) flush any of the
> >>>>>>> DSC blocks?  Or could this flush uninitialized state to the block?
> >>>>>>
> >>>>>> If we bootup without DSC panel connected, the kernel's cfg->dsc will be
> >>>>>> 0 and default register value of CTL_DSC_FLUSH will be 0 so it wont flush
> >>>>>> any DSC blocks.
> >>>>>
> >>>>> Ack, that makes sense.  However, if I connect a DSC panel, then
> >>>>> disconnect it (now the register should be non-zero, but cfg->dsc will be
> >>>>> zero), and then replug a non-DSC panel multiple times, it'll get flushed
> >>>>> every time because we never clear CTL_DSC_FLUSH after that?
> >>>>
> >>>> If we remove it after kernel starts, that issue is there even today
> >>>> without that change because DSI is not a hot-pluggable display so a
> >>>> teardown wont happen when you plug out the panel. How will cfg->dsc be 0
> >>>> then? In that case, its not a valid test as there was no indication to
> >>>> DRM that display was disconnected so we cannot tear it down.
> >>>
> >>> The patch description itself describes hot-pluggable displays, which I
> >>> believe is the upcoming DSC support for DP?  You ask how cfg->dsc can
> >>> become zero, but this is **exactly** what the patch description
> >>> describes, and what this patch is removing the `if` for.  If we are not
> >>> allowed to discuss that scenario because it is not currently supported,
> >>> neither should we allow to apply this patch.
> >>>
> >>> With that in mind, can you re-answer the question?
> >>
> >> I didnt follow what needs to be re-answered.
> >>
> >> This patch is being sent in preparation of the DSC over DP support. This
> >> does not handle non-hotpluggable displays.
> > 
> > Good, because my question is specifically about *hotpluggable*
> > displays/panels like the upcoming DSC support for DP.  After all there
> > would be no point in me suggesting to connect and disconnect
> > non-hotpluggable displays and expect something sensible to happen,
> > wouldn't it?  Allow me to copy-paste the question again for convenience,
> > with some minor wording changes:
> > 
> > 	However, if I connect a DSC DP display, then disconnect it (now the
> > 	register should be non-zero, but cfg->dsc will be zero), and then
> > 	connect and reconnect a non-DSC DP display multiple times, it'll get
> > 	flushed every time because we never clear CTL_DSC_FLUSH after that?
> > 
> > And the missing part is: would multiple flushes be harmful in this case?
> 
> Well, you kept asking about "DSC panel" , that made me think you were 
> asking about a non-hotpluggable MIPI DSI DSC panel and not DP DSC 
> monitor. On many boards, panels can be removed/connected back to their 
> daughter card. The term "panel" confused me a bit.
> 
> Now answering your question.
> 
> Yes, it will get flushed once every hotplug thats not too bad but 
> importantly DSC wont be active as CTL_DSC_ACTIVE will be set to 0 so it 
> wont cause any issue.
> 
> 
> >> I do not think dynamic switch
> >> between DSC and non-DSC of non-hotpluggable displays needs to be
> >> discussed here as its not handled at all with or without this patch.
> >>
> >> We wanted to get early reviews on the patch. If you want this patch to
> >> be absorbed when rest of DSC over DP lands, I have no concerns with
> >> that. I wont pick this up for fixes and we will land this together with
> >> the rest of DP over DSC.
> > 
> > I don't mind when and where this lands, just want to have the semantics
> > clear around persisting the value of CTL_DSC_FLUSh in the register.
> > 
> > Regardless, this patch doesn't sound like a fix but a workaround until
> > reset_intf_cfg() is fixed to be called at the right point, and extended
> > to clear CTL_DSC_ACTIVE and flush the DSCs.  Perhaps it shouldn't have a
> > Fixes: tag for that reason, as you intend to reinstate this
> > if (cfg->dsc) condition when that is done?
> > 
> 
> Its certainly fixing the use-case of DSC to non-DSC switching. So it is 
> a fix.
> 
> But yes not the best fix possible. We have to improve it by moving this 
> to reset_intf_cfg() as I already committed to.

Ack, thanks for confirming this all and working on that, sounds good!

- Marijn
