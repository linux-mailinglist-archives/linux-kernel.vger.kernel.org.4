Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3740F6DECB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDLHir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDLHi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:38:29 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C56761AE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:38:14 -0700 (PDT)
Received: from SoMainline.org (unknown [89.205.226.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 281932030B;
        Wed, 12 Apr 2023 09:38:10 +0200 (CEST)
Date:   Wed, 12 Apr 2023 09:38:08 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        freedreno@lists.freedesktop.org, quic_sbillaka@quicinc.com,
        airlied@gmail.com, andersson@kernel.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, dianders@chromium.org,
        vkoul@kernel.org, agross@kernel.org, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        sean@poorly.run, linux-kernel@vger.kernel.org
Subject: Re: [Freedreno] [PATCH] drm/msm/dpu: add DSC range checking during
 resource reservation
Message-ID: <tczt5alqbadkodgorqm4pljpqkn5bc4efpxiy3em7bgu7gqaka@3cdszu4k6rhk>
References: <1681247380-1607-1-git-send-email-quic_khsieh@quicinc.com>
 <qvgbm3wimai3jytnikbcixipvwqn2uywqpg4mn6mjh5atergfx@wa4edsrp7y22>
 <96416911-bca3-b007-b036-1c4463e83aaa@quicinc.com>
 <24c5aa23-9b3c-787c-10aa-e9d5ad91512b@linaro.org>
 <49479b93-b364-d882-7a77-08223a94ed36@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49479b93-b364-d882-7a77-08223a94ed36@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-11 18:50:24, Abhinav Kumar wrote:
> 
> 
> On 4/11/2023 6:06 PM, Dmitry Baryshkov wrote:
> > On 12/04/2023 01:32, Abhinav Kumar wrote:
> >> Hi Marijn
> >>
> >> On 4/11/2023 3:24 PM, Marijn Suijten wrote:
> >>> Again, don't forget to include previous reviewers in cc, please :)
> >>>
> >>> On 2023-04-11 14:09:40, Kuogee Hsieh wrote:
> >>>> Perform DSC range checking to make sure correct DSC is requested before
> >>>> reserve resource for it.
> > 
> > nit: reserving
> > 
> >>>
> >>> This isn't performing any range checking for resource reservations /
> >>> requests: this is only validating the constants written in our catalog
> >>> and seems rather useless.  It isn't fixing any real bug either, so the
> >>> Fixes: tag below seems extraneous.
> >>>
> >>> Given prior comments from Abhinav that "the kernel should be trusted",
> >>> we should remove this validation for all the other blocks instead.
> >>>
> >>
> >> The purpose of this check is that today all our blocks in RM use the 
> >> DSC_* enum as the size.
> >>
> >> struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
> >>
> >> If the device tree ends up with more DSC blocks than the DSC_* enum, 
> >> how can we avoid this issue today? Not because its a bug in device 
> >> tree but how many static number of DSCs are hard-coded in RM.
> > 
> > We don't have these blocks in device tree. And dpu_hw_catalog shouldn't 
> > use indices outside of enum dpu_dsc.
> > 
> 
> ah, my bad, i should have said catalog here. Okay so the expectation is 
> that dpu_hw_catalog.c will program the indices to match the RM limits.
> 
> I still stand by the fact that the hardware capabilities coming from 
> catalog should be trusted but this is just the SW index.

These come from the catalog.  Here's how it looks for sdm845:

	static struct dpu_dsc_cfg sdm845_dsc[] = {
		DSC_BLK("dsc_0", DSC_0, 0x80000, 0),
		DSC_BLK("dsc_1", DSC_1, 0x80400, 0),
		DSC_BLK("dsc_2", DSC_2, 0x80800, 0),
		DSC_BLK("dsc_3", DSC_3, 0x80c00, 0),
	};

The only way to trigger this newly introduced range check is by omitting
the DSC_x constants and manually writing e.g. an out-of-range value 10
here, or setting DSC_NONE.  This is only allowed for interfaces.

As we trust the kernel, hence this config, the if introduced here (and
already present for other blocks) has pretty much no effect.

> > Marijn proposed to pass struct dpu_foo_cfg directly to 
> > dpu_hw_foo_init(). This will allow us to drop these checks completely.
> > 
> 
> Ah okay, sure, would like to see that then uniformly get rid of these 
> checks.

This suggested change won't make a difference to the range check
introduced here.  The range-check validates that the catalog sets `id`
to a sensible value (since we do not use array indices for this, we
could even decide to do so via `[DSC_0] = (struct dpu_dsc_cfg){ ... }`
if we so desire in the future).

It'll only get rid of the `_xxx_offset` functions looping through the
arrays in the catalog again, to find a catalog pointer with matching
`id` while we aleady have exactly that pointer here via &cat->dsc[i].

The only semantic difference incurred by the change is when the same
`id` value is (erroneously) used multiple times in an array: the current
implementation will always find and return the first block while the
suggestion will make sure all blocks are used.
But again, reusing an `id` is an error and shouldn't happen.

> > For the time being, I think it might be better to add these checks for 
> > DSC for the sake of uniformity.
> > 
> 
> Yes, i think so too.

I'd rather see a separate patch removing them then, as my suggestion
won't affect the legality of the range check.

- Marijn
