Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F46E5F4B25
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJDVtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiJDVsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:48:45 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC4B167E7;
        Tue,  4 Oct 2022 14:48:22 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4FD4F200F6;
        Tue,  4 Oct 2022 23:48:18 +0200 (CEST)
Date:   Tue, 4 Oct 2022 23:48:16 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
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
Message-ID: <20221004214816.3azmktopwjgpodzt@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
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
 <20221001202313.fkdsv5ul4v6akhc3@SoMainline.org>
 <CAA8EJpricAKmrtqGJx_ngqyqCWjc2rbrOcsE5QaH5qKaHP7-2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpricAKmrtqGJx_ngqyqCWjc2rbrOcsE5QaH5qKaHP7-2g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-04 17:41:07, Dmitry Baryshkov wrote:
> On Sat, 1 Oct 2022 at 23:23, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> [..]
> > Pre-empting the reviews: I was contemplating whether to use FIELD_PREP
> > here, given that it's not yet used anywhere else in this file.  For that
> > I'd remove the existing _SHIFT definitions and replace them with:
> >
> >         #define DSC_PPS_RC_RANGE_MINQP_MASK             GENMASK(15, 11)
> >         #define DSC_PPS_RC_RANGE_MAXQP_MASK             GENMASK(10, 6)
> >         #define DSC_PPS_RC_RANGE_BPG_OFFSET_MASK        GENMASK(5, 0)
> >
> > And turn this section of code into:
> >
> >         cpu_to_be16(FIELD_PREP(DSC_PPS_RC_RANGE_MINQP_MASK,
> >                                dsc_cfg->rc_range_params[i].range_min_qp) |
> >                     FIELD_PREP(DSC_PPS_RC_RANGE_MAXQP_MASK,
> >                                dsc_cfg->rc_range_params[i].range_max_qp) |
> >                     FIELD_PREP(DSC_PPS_RC_RANGE_BPG_OFFSET_MASK,
> >                                dsc_cfg->rc_range_params[i].range_bpg_offset));
> >
> > Is that okay/recommended?
> 
> This is definitely easier to review. However if you do not want to use
> FIELD_PREP, it would be better to split this into a series of `data |=
> something` assignments terminated with the rc_range_parameters[i]
> assignment.

Anything is fine by me, I have no strong opinion on this and rather
leave it up to the maintainers.  However, FIELD_PREP gives us concise
`#define`s through a single `GENMASK()` carrying both the shift and
mask/field-width.
At the same time these genmask definitions map more clearly to the
layout comment right above:

	/*
	 * For DSC sink programming the RC Range parameter fields
	 * are as follows: Min_qp[15:11], max_qp[10:6], offset[5:0]
	 */

If switching to `data |=` however, I've been recommended to not use
FIELD_PREP but fulyl write out `data |= (value & MASK) << SHIFT`
instead.

Perhaps a more important question is how to apply this consistently
throughout the function?

- Marijn
