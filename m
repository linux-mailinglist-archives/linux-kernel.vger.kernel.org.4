Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64573681E21
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjA3WbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjA3WbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:31:18 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0292CC5F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:31:15 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BB55D1F68E;
        Mon, 30 Jan 2023 23:31:11 +0100 (CET)
Date:   Mon, 30 Jan 2023 23:31:10 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/14] drm/msm/disp/dpu: add supports of DSC encoder
 v1.2 engine
Message-ID: <20230130223110.abjh7k32fjs4kola@SoMainline.org>
References: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
 <1674498274-6010-11-git-send-email-quic_khsieh@quicinc.com>
 <20230123201133.zzt2zbyaw3pfkzi6@SoMainline.org>
 <926021c1-d9d1-4449-f01b-f405b48f326a@quicinc.com>
 <20230130201654.vlr7p7id3a7vxc2b@SoMainline.org>
 <0a0c3a12-51e9-b0d0-9307-847023dbe1f7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0c3a12-51e9-b0d0-9307-847023dbe1f7@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abhinav,

On 2023-01-30 13:22:03, Abhinav Kumar wrote:
> Hi Marijn
> 
> On 1/30/2023 12:16 PM, Marijn Suijten wrote:
> > On 2023-01-24 15:52:46, Kuogee Hsieh wrote:
> > 
> > <snip>
> > 
> > If only replying to a small chunk somewhere in the middle of a diff
> > and/or large review, please cut out unnecessary bits to make your reply
> > easier to find :)
> > 
> >>>> +	data = (dsc->flatness_min_qp & 0x1f);
> >>>> +	data |= (dsc->flatness_max_qp & 0x1f) << 5;
> >>>> +	data |= (dsc_info->det_thresh_flatness & 0xff) << 10;
> >>> dpu_hw_dsc.c computes this on the fly.  After removing that, and
> >>> using initial_lines from the function parameters, only
> >>> dsc_info->num_active_ss_per_enc remains.  Do you really need that
> >>> msm_display_dsc_info struct here, do you need it at all?
> >>
> >> I ported these code from our down stream code base.
> >>
> >> I make it work first, then clean it up will follow.
> >>
> >> I submit it for review since it looks like you guy like to have code sooner.
> > 
> > Correct, I was looking forward to these patches albeit complete with the
> > promised DSI support from Jessica, which still seems to be pending.
> > 
> 
> DSI support is still being worked upon.
> 
> I dont think we promised DSC 1.2 will come with DSI together in the same 
> series. It was always going to be DSC 1.2 + DP followed by another 
> series from Jessica for DSI.
> 
> Lets set the expectations right.

Not saying that these patches were promised as part of this series (as
said, "which still seem to be pending"), just making clear that this
series if of no use to me (no hurry to get the code in my hands sooner)
until the DSI patches are also shared which I would have started working
on myself if I didn't know QUIC was picking it up to distract from the
current v1.1 broken-ness on SM8150 and SM8250.

To set my (and at least Neil's) expectations straight as well: DSC 1.2
HW support should come in a separate series without DP support.  Smaller
series (not to mention appropriately split-up patches) lead to a
decrease in scope, less dependencies and hopefully more efficient v2 -
for all involved.

- Marijn
