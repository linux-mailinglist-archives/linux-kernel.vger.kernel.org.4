Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDCB694AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjBMPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjBMPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:14:44 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E908A1CF4B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:14:16 -0800 (PST)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 69B611F684;
        Mon, 13 Feb 2023 16:14:14 +0100 (CET)
Date:   Mon, 13 Feb 2023 16:14:13 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Foss <rfoss@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Liu Shixin <liushixin2@huawei.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] drm/msm/dpu: Add SM6350 support
Message-ID: <20230213151413.qhpzzcz4c6m6rynk@SoMainline.org>
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-7-konrad.dybcio@linaro.org>
 <a18cf663-115d-edc8-5e4b-3d19fcd9a02c@linaro.org>
 <cc364658-478a-f239-5d17-5ca2b7f7df8b@linaro.org>
 <20230213113008.ih7ii5m3cz4w3lmz@SoMainline.org>
 <8560b69f-8d42-995d-2f4d-11d6a64afef0@linaro.org>
 <20230213142831.hbzfp2chekshsqyy@SoMainline.org>
 <28c9ea04-fedb-16cf-f874-f4c965fbc445@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28c9ea04-fedb-16cf-f874-f4c965fbc445@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-13 16:58:00, Dmitry Baryshkov wrote:
> On 13/02/2023 16:28, Marijn Suijten wrote:
> > On 2023-02-13 13:35:01, Dmitry Baryshkov wrote:
> >> On 13/02/2023 13:30, Marijn Suijten wrote:
> >>> On 2023-02-13 12:15:19, Konrad Dybcio wrote:
> >>> [...]
> >>>>>> @@ -1674,6 +1765,15 @@ static struct dpu_pingpong_cfg sc8280xp_pp[] = {
> >>>>>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31), -1),
> >>>>>>     };
> >>>>>>     +static struct dpu_pingpong_cfg sm6350_pp[] = {
> >>>>>> +    PP_BLK("pingpong_0", PINGPONG_0, 0x70000, 0, sdm845_pp_sblk,
> >>>>>
> >>>>> No TE support?
> >>>> It's.. complicated.. With just this patch, display refreshes, albeit
> >>>> not at 60fps. Marijn is working on getting it going, though
> >>>>
> >>>> https://github.com/SoMainline/linux/commits/marijn/longbois-next/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >>>
> >>> This branch hasn't been updated for the longest time.  I'm preparing v2
> >>> of the INTF TE series at:
> >>>
> >>> https://github.com/SoMainline/linux/commits/marijn/dpu/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >>>
> >>> and it has about ±40% of Dmitry's review applied.  More to come now that
> >>> hiatus is over.
> >>
> >> We should agree on landing order for my rework vs your changes. Can I
> >> try persuading you to review that 50-patches beast? With the hope that
> >> you'd agree to land your changes on top of it?
> > 
> > SM6115 unexpectedly landing in advance of SM8[345]0 was already an
> > unnecessary headache to deal with, and now we're "changing direction" on
> > landing SM6350/75 in advance of INTF TE too...  not to forget about
> > SM6125 which I also keep rebasing locally but planned on landing _after_
> > INTF TE.  Regardless of the extra effort it will take from me I'd be
> > happy to land my patches after everyone else's to have final say over
> > which setup gets what bitflags and interrupts, as these typically got
> > botched in our trees after rebases leading to broken INTF TE.
> > Perhaps I should resubmit the individual Fixes: commits though?
> 
> What is the current status of your INTF TE patchset? If it's mostly 
> ready, I can rebase my patch-bomb on top of it.

The catalog part is ready [1] and was rebased on -next a "week" ago, and
does not depend on any of the SM6125/6350/75 series.  All that remains
is addressing review comments regarding restructuring function and
function pointer layout.

[1]: https://github.com/SoMainline/linux/commits/marijn/dpu/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c

> I definitely do not want to merge new platforms before sorting out INTF 
> TE and the catalog. Handling sc8280xp, sm8350, sm8450 and sm6115 was a 
> nightmare. The restructure targets making addition of new platforms simpler.

Ack, totally agree here, massive rebase conflict nightmare not to
mention fixups/followups.

> > Feel free to propose a merge order listing all the aforementioned SoCs,
> > your rework, my INTF TE patches and whatever else is in the pipeline.
> > As I've been away for a while, and only have limited hobby time (_and_
> > have to split that on various projects), I'm behind on what's currently
> > in swing for DPU (need additional time to catch back up) nor will be
> > able to rebase/resubmit my patches often (a set-in-stone merge order
> > will really help prioritise/plan ahead here).
> 
> We have several patchsets in the pipeline (PSR, color-transformation 
> rework, wide planes) which do not touch the catalog, so the amount of 
> conflicts should be pretty minimal.

Sounds good.

> We are still waiting for DSC 1.2 v2, 
> but it definitely will take time to mature even if v2 is posted today.

That'll hit the catalog to a minimal extent (I guess, to describe new
blocks / with a feature flag) but should be easy to delay / rebase.

> So, *possible* the merge order is the following:
> - fixes from https://patchwork.freedesktop.org/series/113910/ go to 
> msm-fixes
> - fixes from your intf-te go to msm-fixes
> - https://patchwork.freedesktop.org/series/111751/
> - the rest of intf-te and catalog (*see below)
> - DPU features
> - new DPU platforms (might go together with DPU features)
> 
> * That really depends on the availability of the patchsets. Most 
> probably, as your patchset also contains several fixups, it would be 
> easier to land it before catalog split/rework.
> 
> So, if you have the available timeslot, could you please finish & send 
> intf te on top of msm-next.

Ack, I'll get to that immediately.  You might even pull in the
intermediate patches linked above (that touch the catalog) to see how it
integrates, if I remember correctly (it has been a while) the catalog
changes should now be independent of driver changes...?

> > Sure, I will at least start looking at your 50-patch as part of catching
> > back up.  Do you want to process that on the mailing list or via
> > https://gitlab.freedesktop.org/drm/msm/-/merge_requests/44?
> 
> I'd prefer to use email. The MR was open to doublecheck that nothing got 
> broken on sc7180.

Ack; will try providing feedback on the 50-patch series via email in
parallel to getting INTF TE v2 out ASAP.  As discussed before I should
probably add myself as reviewer to the drm/msm subsystem to have these
patches in my inbox from the get-go though...

- Marijn
