Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BE05F4BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJDWMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJDWLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:11:44 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7915A6C10D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:11:37 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 5CD8A20088;
        Wed,  5 Oct 2022 00:11:35 +0200 (CEST)
Date:   Wed, 5 Oct 2022 00:11:34 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] drm/msm/dpu1: Account for DSC's bits_per_pixel
 having 4 fractional bits
Message-ID: <20221004221134.roino4u2waawgh6u@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <20221001190807.358691-5-marijn.suijten@somainline.org>
 <7f7a5d78-e50f-b6af-bb3e-bbfbc7fa5f75@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7a5d78-e50f-b6af-bb3e-bbfbc7fa5f75@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-04 10:03:07, Abhinav Kumar wrote:
> 
> 
> On 10/1/2022 12:08 PM, Marijn Suijten wrote:
> > According to the comment this DPU register contains the bits per pixel
> > as a 6.4 fractional value, conveniently matching the contents of
> > bits_per_pixel in struct drm_dsc_config which also uses 4 fractional
> > bits.  However, the downstream source this implementation was
> > copy-pasted from has its bpp field stored _without_ fractional part.
> > 
> > This makes the entire convoluted math obsolete as it is impossible to
> > pull those 4 fractional bits out of thin air, by somehow trying to reuse
> > the lowest 2 bits of a non-fractional bpp (lsb = bpp % 4??).
> > 
> > The rest of the code merely attempts to keep the integer part a multiple
> > of 4, which is rendered useless thanks to data |= dsc->bits_per_pixel <<
> > 12; already filling up those bits anyway (but not on downstream).
> > 
> > Fixes: c110cfd1753e ("drm/msm/disp/dpu1: Add support for DSC")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
> Many of this bugs are because the downstream code from which this 
> implementation was derived wasnt the latest perhaps?

Perhaps, this code is "identical" to what I'm looking at in some
downstream 4.14 / 4.19, where the upstream struct for DSC either wasn't
there or wasn't used.  We have to find and address these bugs one by one
to make our panels work, and this series gets one platform (sdm845) down
but has more work pending for others (sm8250 has my current focus).

Or are you suggesting to "redo" the DSC integration work based on a
(much) newer display techpack (SDE driver)?

> Earlier, downstream had its own DSC struct maybe leading to this 
> redundant math but now we have migrated over to use the upstream struct 
> drm_dsc_config.

Found the 3-year-old `disp: msm: use upstream dsc config data` commit
that makes this change.  It carries a similar comment:

    /* integer bpp support only */

The superfluous math was howerver removed earlier, in:

    disp: msm: fix dsc parameters related to 10 bpc 10 bpp

- Marijn

> That being said, this patch LGTM
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
