Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FE65F4C45
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJDW4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJDW4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:56:12 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740AA237EB;
        Tue,  4 Oct 2022 15:56:08 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 132B4200D2;
        Wed,  5 Oct 2022 00:56:06 +0200 (CEST)
Date:   Wed, 5 Oct 2022 00:56:04 +0200
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
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 3/5] drm/msm/dsi: Account for DSC's bits_per_pixel having
 4 fractional bits
Message-ID: <20221004225604.4ysjrc2zmnbqordk@SoMainline.org>
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
        Marek Vasut <marex@denx.de>
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <20221001190807.358691-4-marijn.suijten@somainline.org>
 <CAA8EJppYJ-PYCsaKn=sGDpnJJdW2QBx=MOqUr6qzY0bAZtpGxA@mail.gmail.com>
 <20221004223504.vlfmxerdv47tlkdu@SoMainline.org>
 <b47e3be7-7de1-0f0c-8aa6-054e99dcaab3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b47e3be7-7de1-0f0c-8aa6-054e99dcaab3@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-05 01:40:12, Dmitry Baryshkov wrote:
> On 05/10/2022 01:35, Marijn Suijten wrote:
> > On 2022-10-04 17:45:50, Dmitry Baryshkov wrote:
> >> On Sat, 1 Oct 2022 at 22:08, Marijn Suijten
> >> <marijn.suijten@somainline.org> wrote:
> >> [..]
> >>> -       bytes_in_slice = DIV_ROUND_UP(dsc->slice_width * dsc->bits_per_pixel, 8);
> >>> +       bytes_in_slice = DIV_ROUND_UP(dsc->slice_width * bpp, 8);
> >>
> >>
> >> bytes_in_slice = DIV_ROUND_UP(dsc->slice_width * dsc->bits_per_pixel, 8 * 16); ?
> > 
> > Not necessarily a fan of this, it "hides" the fact that we are dealing
> > with 4 fractional bits (1/16th precision, it is correct though); but
> > since this is the only use of `bpp` I can change it and document this
> > fact wiht a comment on top (including referencing the validation pointed
> > out in dsi_populate_dsc_params()).
> > 
> > Alternatively we can inline the `>> 4` here?
> 
> No, I don't think so. If we shift by 4 bits, we'd loose the fractional 
> part. DIV_ROUND_UP( .... , 8 * 16) ensures that we round it up rather 
> than just dropping it.

I'd still keep the `-EINVAL` on `if (dsc->bits_per_pixel & 0xf)` to
guarantee that there is no fractional part.
After all, as explained in the patch description, none of this code /
the DSI driver in general seems to be able to handle fractional bits per
pixel.

> >>> [..]
> >>> -       dsc->slice_chunk_size = dsc->slice_width * dsc->bits_per_pixel / 8;
> >>> -       if ((dsc->slice_width * dsc->bits_per_pixel) % 8)
> >>> +       dsc->slice_chunk_size = dsc->slice_width * bpp / 8;
> >>> +       if ((dsc->slice_width * bpp) % 8)
> >>
> >> One can use fixed point math here too:
> >>
> >> dsc->slice_chunk_size = (dsc->slice_width * dsc->bits_per_pixel  + 8 *
> >> 16 - 1)/ (8 * 16);
> > 
> > Good catch, this is effectively a DIV_ROUND_UP() that we happened to
> > call bytes_in_slice above...
> > 
> > Shall I tackle this in the same patch, or insert another cleanup patch?
> 
> It's up to you. I usually prefer separate patches, even if just to ease 
> bisecting between unrelated changes.

Same feeling here, and have already set it up that way; added two extra
patches to 1. replace this with DIV_ROUND_UP() and 2. remove the
recalculation of slice_chunk_size (disguised as bytes_in_slice) above.

- Marijn
