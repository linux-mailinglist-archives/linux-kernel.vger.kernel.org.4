Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700AA6E9CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjDTTsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjDTTsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:48:32 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B2540F0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:48:23 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E936720540;
        Thu, 20 Apr 2023 21:48:20 +0200 (CEST)
Date:   Thu, 20 Apr 2023 21:48:18 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] DPU1 GC1.8 wiring-up
Message-ID: <enkpndd2yc5uke2zwjpu372my7ql4t6o2edvnkamaq7kqgcdlw@kumof55foww4>
References: <20230420-topic-dpu_gc-v1-0-d9d1a5e40917@linaro.org>
 <5b133c55-e4f5-bfd2-b542-a7d44313c038@linaro.org>
 <c0e0a55a-cc37-fe8a-8d8a-5fe257f99b9a@linaro.org>
 <3f3b3637-ed85-09a1-22b7-3ccd4bc929bb@quicinc.com>
 <2dff9d62-cffe-c66f-9e50-3ecd64e44d37@linaro.org>
 <6a335df7-ff0b-098a-feec-45714159df04@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a335df7-ff0b-098a-feec-45714159df04@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 21:01:04, Dmitry Baryshkov wrote:
> On 20/04/2023 04:36, Konrad Dybcio wrote:
> > 
> > 
> > On 20.04.2023 03:28, Abhinav Kumar wrote:
> >>
> >>
> >> On 4/19/2023 6:26 PM, Konrad Dybcio wrote:
> >>>
> >>>
> >>> On 20.04.2023 03:25, Dmitry Baryshkov wrote:
> >>>> On 20/04/2023 04:14, Konrad Dybcio wrote:
> >>>>> Almost all SoCs from SDM845 to SM8550 inclusive feature a GC1.8
> >>>>> dspp sub-block in addition to PCCv4. The other block differ a bit
> >>>>> more, but none of them are supported upstream.
> >>>>>
> >>>>> This series adds configures the GCv1.8 on all the relevant SoCs.
> >>>>
> >>>> Does this mean that we will see gamma_lut support soon?
> >>> No promises, my plate is not even full, it's beyond overflowing! :P
> >>>
> >>> Konrad
> >>
> >> So I think I wrote about this before during the catalog rework/fixes that the gc registers are not written to / programmed.
> >>
> >> If thats not done, is there any benefit to this series?
> > Completeness and preparation for the code itself, if nothing else?
> 
> The usual problem is that if something is not put to use, it quickly 
> rots or becomes misused for newer platforms. We have seen this with the 
> some of DPU features.
> 
> In case of GC (and the freshly defined DPU_DSPP_IGC, but not used) we 
> have three options:
> - drop the unused GC from msm8998_sblk.
> - keep things as is, single unused GC entry
> - fill all the sblk with the correct information in hope that it stays 
> correct
> 
> Each of these options has its own drawbacks. I have slight bias towards 
> the last option, to have the information in place (as long as it is 
> accurate).

Normally I'm all for rigorously and completely defining the hardware,
porting the entire downstream DT in one go while looking at it anyway.
(And it leaves less room for error when looking at DT properties while
 having no clue where they should end up in the catalog, or why they
 wouldn't be there)

In this case though, as you say, it's unused so there's no way to test
and validate anything, especially future changes we **might** make to
the looks and layout of the catalog.

What's worse, this series shows zero efforts towards at the very least
explaining that GC is the Gamma Correction block, what the benefits are
in defining/having it, and that it is currently not used by the DSPP
driver block at all.  That's my major reason for NAK'ing this.

- Marijn
