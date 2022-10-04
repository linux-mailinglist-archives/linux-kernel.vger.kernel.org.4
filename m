Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1465F4B39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJDV5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJDV5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:57:50 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E389B31340
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:57:48 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 3A869200F1;
        Tue,  4 Oct 2022 23:57:46 +0200 (CEST)
Date:   Tue, 4 Oct 2022 23:57:45 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH 5/5] drm/dsc: Prevent negative BPG offsets from shadowing
 adjacent bitfields
Message-ID: <20221004215745.zdfvulqx4exlujgk@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Lyude Paul <lyude@redhat.com>
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <20221001190807.358691-6-marijn.suijten@somainline.org>
 <55d7e20b-79cd-ece6-b643-8b542beb7474@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d7e20b-79cd-ece6-b643-8b542beb7474@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-04 13:22:25, Abhinav Kumar wrote:
> 
> On 10/1/2022 12:08 PM, Marijn Suijten wrote:
> > msm's dsi_host specifies negative BPG offsets which fill the full 8 bits
> > of a char thanks to two's complement: this however results in those bits
> > bleeding into the next parameter when the field is only expected to
> > contain 6-bit wide values.
> > As a consequence random slices appear corrupted on-screen (tested on a
> > Sony Tama Akatsuki device with sdm845).
> > 
> > Use AND operators to limit all values that constitute the RC Range
> > parameter fields to their expected size.
> > 
> > Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >   drivers/gpu/drm/display/drm_dsc_helper.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_dsc_helper.c b/drivers/gpu/drm/display/drm_dsc_helper.c
> > index c869c6e51e2b..2e7ef242685d 100644
> > --- a/drivers/gpu/drm/display/drm_dsc_helper.c
> > +++ b/drivers/gpu/drm/display/drm_dsc_helper.c
> > @@ -243,11 +243,11 @@ void drm_dsc_pps_payload_pack(struct drm_dsc_picture_parameter_set *pps_payload,
> >   	 */
> >   	for (i = 0; i < DSC_NUM_BUF_RANGES; i++) {
> >   		pps_payload->rc_range_parameters[i] =
> > -			cpu_to_be16((dsc_cfg->rc_range_params[i].range_min_qp <<
> > +			cpu_to_be16(((dsc_cfg->rc_range_params[i].range_min_qp & 0x1f) <<
> >   				     DSC_PPS_RC_RANGE_MINQP_SHIFT) |
> > -				    (dsc_cfg->rc_range_params[i].range_max_qp <<
> > +				    ((dsc_cfg->rc_range_params[i].range_max_qp & 0x1f) <<
> >   				     DSC_PPS_RC_RANGE_MAXQP_SHIFT) |
> > -				    (dsc_cfg->rc_range_params[i].range_bpg_offset));
> > +				    (dsc_cfg->rc_range_params[i].range_bpg_offset & 0x3f));
> >   	}
> >   
> 
> Looking at some examples of this for other vendors, they have managed to 
> limit the value to 6 bits in their drivers:
> 
> https://gitlab.freedesktop.org/drm/msm/-/blob/msm-next/drivers/gpu/drm/i915/display/intel_vdsc.c#L532
> 
> https://gitlab.freedesktop.org/drm/msm/-/blob/msm-next/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c#L87
> 
> Perhaps, msm should do the same thing instead of the helper change.

Thanks, I should have done my due-diligence and look up how other
drivers dealt with this, but wasn't immediately expecting negative
values elsewhere.

Alas, as explained in the cover letter I opted to perform the masking in
the PPS packing code as the DSC block code also reads these values, and
would suddenly write 6-bit intead of 8-bit values to the
DSC_RANGE_BPG_OFFSET registers.  Quick testing on the mentioned sdm845
platform shows no regressions, but I'm not sure if that's safe to rely
on?

> If you want to move to helper, other drivers need to be changed too to 
> remove duplicate & 0x3f.

Sure, we only have to confirm whether those drivers also read back the
value(s) in rc_range_params, and expect / allow this to be 8 instead of
6 bits.

> FWIW, this too has already been fixed in the latest downstream driver too.

What is this supposed to mean?  Is there a downstream DPU project that
has pending patches needing to be upstreamed?  Or is the downstream SDE,
techpack/display, or whatever it is called nowadays, slowly using more
DRM structs like drm_dsc_config and this drm_dsc_pps_payload_pack()
helper function as pointed out in an earlier mail?

Offtopic: are SDE and DPU growing closer together, hopefully achieving
feature parity allowing the SDE project to be dropped in favour of a
fully upstreamed DPU driver for day-one out-of-the-box mainline support
for new SoCs (as long as work is published and on its way upstream)?

- Marijn
