Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180F5698F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBPJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBPJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:04:13 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF34821A19
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:04:11 -0800 (PST)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 7E2D220417;
        Thu, 16 Feb 2023 10:04:09 +0100 (CET)
Date:   Thu, 16 Feb 2023 10:04:08 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/msm/dpu: Initialize SSPP scaler version (from
 register read)
Message-ID: <20230216090408.caekj2t2x6asb2jk@SoMainline.org>
References: <20230215-sspp-scaler-version-v1-0-416b1500b85b@somainline.org>
 <CAA8EJpqL-Vsq7dbK7tfJAGgg2_nV463QYv5zgvRLx_8T2bsXxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqL-Vsq7dbK7tfJAGgg2_nV463QYv5zgvRLx_8T2bsXxA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-16 05:02:32, Dmitry Baryshkov wrote:
> On Thu, 16 Feb 2023 at 01:02, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > Random inspection of the SSPP code surfaced that the version field of
> > dpu_scaler_blk was never assigned in the catalog, resulting in wrong
> > codepaths to be taken within dpu_hw_setup_scaler3 based on a 0 version.
> > Rectify this by reading an accurate value from a register (that is not
> > equal to the values represented by DPU_SSPP_SCALER_QSEEDx enum
> > variants) and deleting dead code around QSEED versioning.
> >
> > Future changes should likely get rid of the distinction between QSEED3
> > and up, as these are now purely determined from the register value.
> > Furthermore implementations could look at the scaler subblk .id field
> > rather than the SSPP feature bits, which currently hold redundant
> > information.
> >
> > ---
> > Marijn Suijten (3):
> >       drm/msm/dpu: Read previously-uninitialized SSPP scaler version from hw
> >       drm/msm/dpu: Drop unused get_scaler_ver callback from SSPP
> >       drm/msm/dpu: Drop unused qseed_type from catalog dpu_caps
> 
> The cleanup looks good. However as you are on it, maybe you can also
> add patch 4, dropping DPU_SSPP_SCALER_QSEED3LITE and
> DPU_SSPP_SCALER_QSEED4 in favour of using QSEED3 for all these
> scalers?

I surely can!  Do you mind if I rename it to QSEED3_AND_UP for clarity?
How about the second question, dropping this redundant information from
the SSPP feature flags and only looking at the scaler_blk.id?

> As we are going to use scaler_version to distinguish between
> them, it would be logical not to duplicate that bit of information
> (not to mention all the possible troubles if scaler_version disagrees
> with the sblk->scaler_blk.id).

Note that we had a similar discussion for UBWC HW decoder version and it
was decided to go the opposite route [1].  That may have been for
technical reasons (unclocked register access), but it's an inconsistent
approach to say the least.

[1]: https://lore.kernel.org/linux-arm-msm/71f96910-e7b1-92f9-ae15-79bd1da40a0d@quicinc.com/

- Marijn
