Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6895FD726
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJMJgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJMJgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:36:52 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0412E9F8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:36:50 -0700 (PDT)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id CE7933F757;
        Thu, 13 Oct 2022 11:36:47 +0200 (CEST)
Date:   Thu, 13 Oct 2022 11:36:46 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     phone-devel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org
Subject: Re: [Freedreno] [PATCH v3 06/10] drm/msm/dsi: Migrate to
 drm_dsc_compute_rc_parameters()
Message-ID: <20221013093646.c65mbjc6oekd7gha@SoMainline.org>
References: <20221009184824.457416-1-marijn.suijten@somainline.org>
 <20221009185058.460688-1-marijn.suijten@somainline.org>
 <5c178d7e-5022-f5e5-791d-d3800114b42b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c178d7e-5022-f5e5-791d-d3800114b42b@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-12 16:03:06, Abhinav Kumar wrote:
> 
> 
> On 10/9/2022 11:50 AM, Marijn Suijten wrote:
> > As per the FIXME this code is entirely duplicate with what is already
> > provided inside drm_dsc_compute_rc_parameters(), and it is yet unknown
> > why this comment was put in place instead of resolved from the get-go.
> > Not only does it save on duplication, it would have also spared certain
> > issues.
> > 
> > For example, this code from downstream assumed dsc->bits_per_pixel to
> > contain an integer value, whereas the upstream drm_dsc_config struct has
> > it with 4 fractional bits.  drm_dsc_compute_rc_parameters() already
> > accounts for this feat, and the sole remaining use of
> > dsc->bits_per_pixel inside dsi_populate_dsc_params() will be addressed
> > in a separate patch.
> > 
> 
> This is a nice cleanup! Thanks for doing this. I would actually like to 
> move towards the drm_dsc_compute_rc_parameters() API.
> 
> But I would like to hold back this change till Vinod clarifies because 
> Vinod had mentioned that with drm_dsc_compute_rc_parameters() he was 
> seeing a mismatch in the computation of two values.
> 
> slice_bpg_offset and the final_offset.

Unsurprisingly so because final_offset, and slice_bpg_offset through
initial_offset depend directly on bits_per_pixel.  The main takeaway of
this series is that Vinod was interpreting this field as integer instead
of containing 4 fractional bits.  If he updates his the panel driver [1]
to set bits_per_pixel = 8 << 4 instead of just 8 to account for this,
the values should check out once again.

[1]: https://git.linaro.org/people/vinod.koul/kernel.git/commit/?h=topic/pixel3_5.18-rc1&id=1d7d98ad564f1ec69e7525e07418918d90f247a1

Once Vinod (or someone else in the posession of a Pixel 3) confirms
this, I can respin this series and more explicitly explain why the FIXME
was put in place, instead of being resolved outright?

- Marijn

> 
> The difference between the upstream drm_dsc_compute_rc_parameters() and 
> dsi_populate_dsc_params() causing this was not clear to me from his 
> explanation earlier.
> 
> So this was left as a to-do item.
> 
> I would like this to be re-tested on pixel3 and check if this works for 
> vinod. If not, i think its the right time to debug why and not delay 
> this more.
> 
> Thanks
> 
> Abhinav
