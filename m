Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54D6E9CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjDTT42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjDTT41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:56:27 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1230C55A8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:56:24 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 57249205AB;
        Thu, 20 Apr 2023 21:56:23 +0200 (CEST)
Date:   Thu, 20 Apr 2023 21:56:22 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] DPU1 GC1.8 wiring-up
Message-ID: <57pxyxwluu33z4lpij5gx7biwfo5pbhdalhhxflw7esi5n3vts@qhjb7ldnz3wb>
References: <20230420-topic-dpu_gc-v1-0-d9d1a5e40917@linaro.org>
 <5b133c55-e4f5-bfd2-b542-a7d44313c038@linaro.org>
 <c0e0a55a-cc37-fe8a-8d8a-5fe257f99b9a@linaro.org>
 <3f3b3637-ed85-09a1-22b7-3ccd4bc929bb@quicinc.com>
 <2dff9d62-cffe-c66f-9e50-3ecd64e44d37@linaro.org>
 <6a335df7-ff0b-098a-feec-45714159df04@linaro.org>
 <b134d09c-55fa-7879-80ff-900e39c20c3d@quicinc.com>
 <0f469b3c-5f0f-e027-8a9f-d1233169c04a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f469b3c-5f0f-e027-8a9f-d1233169c04a@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 22:51:22, Dmitry Baryshkov wrote:
> On 20/04/2023 22:47, Abhinav Kumar wrote:
> > 
> > 
> > On 4/20/2023 11:01 AM, Dmitry Baryshkov wrote:
> >> On 20/04/2023 04:36, Konrad Dybcio wrote:
> >>>
> >>>
> >>> On 20.04.2023 03:28, Abhinav Kumar wrote:
> >>>>
> >>>>
> >>>> On 4/19/2023 6:26 PM, Konrad Dybcio wrote:
> >>>>>
> >>>>>
> >>>>> On 20.04.2023 03:25, Dmitry Baryshkov wrote:
> >>>>>> On 20/04/2023 04:14, Konrad Dybcio wrote:
> >>>>>>> Almost all SoCs from SDM845 to SM8550 inclusive feature a GC1.8
> >>>>>>> dspp sub-block in addition to PCCv4. The other block differ a bit
> >>>>>>> more, but none of them are supported upstream.
> >>>>>>>
> >>>>>>> This series adds configures the GCv1.8 on all the relevant SoCs.
> >>>>>>
> >>>>>> Does this mean that we will see gamma_lut support soon?
> >>>>> No promises, my plate is not even full, it's beyond overflowing! :P
> >>>>>
> >>>>> Konrad
> >>>>
> >>>> So I think I wrote about this before during the catalog rework/fixes 
> >>>> that the gc registers are not written to / programmed.
> >>>>
> >>>> If thats not done, is there any benefit to this series?
> >>> Completeness and preparation for the code itself, if nothing else?
> >>
> >> The usual problem is that if something is not put to use, it quickly 
> >> rots or becomes misused for newer platforms. We have seen this with 
> >> the some of DPU features.
> >>
> >> In case of GC (and the freshly defined DPU_DSPP_IGC, but not used) we 
> >> have three options:
> >> - drop the unused GC from msm8998_sblk.
> >> - keep things as is, single unused GC entry
> >> - fill all the sblk with the correct information in hope that it stays 
> >> correct
> >>
> >> Each of these options has its own drawbacks. I have slight bias 
> >> towards the last option, to have the information in place (as long as 
> >> it is accurate).
> >>
> > 
> > My vote is for (1) . Today, GC is unused and from the discussion here, 
> > there is no concrete plan to add it. If we keep extending an unused 
> > bitmask for all the chipsets including the ones which will get added in 
> > the future in the hope that someday the feature comes, it doesnt sound 
> > like a good idea.
> > 
> > I would rather do (1), if someone has time.
> 
> Agree, this was the second item on my preference list. Could you please 
> send this oneliner?

Nit (to make sure we're on the same thought here): I think it's a
3-liner: remove it from DSPP_MSM8998_MASK as well as msm8998_dspp_sblk.

> > OR lets stay at (2) till 
> > someone does (1).

I'm personally okay leaving it in place too, with an eye on implementing
this, IGC, and other blocks at some point if there's a use for it via
standard DRM properties.

> > When someone implements GC, we can re-use this patch and that time keep 
> > konrad's author rights or co-developed by.

Good to at least know all these SoCs have the same offset and revision.

- Marijn
