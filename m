Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54145F5A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiJESqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiJESqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:46:02 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC4E55B9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:46:01 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 13ECA3EEBA;
        Wed,  5 Oct 2022 20:45:59 +0200 (CEST)
Date:   Wed, 5 Oct 2022 20:45:57 +0200
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
Message-ID: <20221005184557.pq5w33uo4sgwfnpy@SoMainline.org>
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
 <20221004221134.roino4u2waawgh6u@SoMainline.org>
 <3bf05883-e8dc-5e11-ed83-7f8f7b801737@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf05883-e8dc-5e11-ed83-7f8f7b801737@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-05 07:19:11, Abhinav Kumar wrote:
> > [..]
> > 
> > Or are you suggesting to "redo" the DSC integration work based on a
> > (much) newer display techpack (SDE driver)?
> 
> There is no need to redo the DSC integration now.
> 
> The code I am referring to is here :
> 
> https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/-/blob/DISPLAY.LA.2.0.r1-08000-WAIPIO.0/msm/sde_dsc_helper.c#L240
> 
> So with respect to the redundant math in patches 1/3/4/5 of this series, 
> I dont see all the redundant math anymore in this calculation.
> 
> This is what i meant by my comment.

It all seems to have had a nice clean-up.  What I meant is that it might
have been more efficient to copy-paste the cleaned-up, improved
downstream implementation instead of individually trying to find and
address all issues; either by running into these bugs on upstream (the
way this patch series came to be), or by comparing the new/improved
downstream with upstream.

> When DSC changes were pushed, they were indeed validated on sdm845 
> devices by Vinod so there was a certain level of confidence on those 
> changes.

Some branches seemed to have a display driver without the DCS PPS
command, or with the command commented out (relying on the panel being
configured for DSC by the bootloader).  The "4 fractional bits" issue
might have gone unnoticed since the panel driver was writing, and both
the DSI and DPU1 drivers were reading this field without those
fractional bits.

It's only a small bug (but with disastrous results on panel drivers with
proper DCS PPS command), the rest is cruft that was copied from
downstream but not filtered out in development nor review.

> At this point, we should just consider these as bug-fixes for upstream 
> and keep going. A full redo is not required.

Ack, at least that doesn't make this series/work obsolete :)

> At some point in the next couple of months, we plan to add DSC 1.2 
> support to MSM.

That's appreciated as all devices I have here (on newer SoCs with DSC
1.2) also have high-resolution, high-fps panels that need DSC to
function correctly.
We'll see who gets to it first though :)

> We will check for any missing changes (if any after this series of 
> yours) and push those as part of that.

There are a few, but it's hard to say until the panel is fully working.
Current focus is on sm8250.
We can discuss this at a more informal pace in #linux-msm if you're
interested.

- Marijn
