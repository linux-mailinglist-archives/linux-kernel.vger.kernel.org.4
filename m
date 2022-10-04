Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BD95F405C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJDJwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJDJwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:52:18 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C89CE7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:51:19 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 4972C3F2EB;
        Tue,  4 Oct 2022 11:51:16 +0200 (CEST)
Date:   Tue, 4 Oct 2022 11:51:14 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 0/5] drm: Fix math issues in MSM DSC implementation
Message-ID: <20221004095114.tr2gk76epbycflfa@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <Yzu50ly1AxZwmyvi@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzu50ly1AxZwmyvi@matsya>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-04 10:12:58, Vinod Koul wrote:
> On 01-10-22, 21:08, Marijn Suijten wrote:
> > Various removals of complex yet unnecessary math, fixing all uses of
> > drm_dsc_config::bits_per_pixel to deal with the fact that this field
> > includes four fractional bits, and finally an approach for dealing with
> > dsi_host setting negative values in range_bpg_offset, resulting in
> > overflow inside drm_dsc_pps_payload_pack().
> > 
> > Note that updating the static bpg_offset array to limit the size of
> > these negative values to 6 bits changes what would be written to the DPU
> > hardware at register(s) DSC_RANGE_BPG_OFFSET, hence the choice has been
> > made to cover up for this while packing the value into a smaller field
> > instead.
> 
> Thanks for fixing these. I dont have my pixel3 availble but changes lgtm
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

Thanks; any comment on the self-review I sent in for patch 3 and 5?

> > Altogether this series is responsible for solving _all_ Display Stream
> > Compression issues and artifacts on the Sony Tama (sdm845) Akatsuki
> > smartphone (2880x1440p).
> 
> Does it need two dsi lanes?

This panel has the default of four dsi data lanes enabled:

https://github.com/sonyxperiadev/kernel/blob/f956fbd9a234033bd18234d456a2c32c126b38f3/arch/arm64/boot/dts/qcom/dsi-panel-somc-akatsuki.dtsi#L74-L77

Unless you are referring to dual-dsi (ctrl/phy); this panel doesn't have
a dual connection, but I do have devices on sm8350/sm8450 with a
"4k"@120Hz display that have this, in case you want it to be tested?

However, for the time being I'm focussing on a similar panel (4 data
lanes, single DSI ctrl/phy) on sm8250 which keeps showing corrupted /
garbled data and resulting in ping-pong timeouts.  I haven't yet
confirmed if this is due to the "integration" of the pingpong block with
the intf (since relevant registers and interrupts still seem to be
accessible), a mismatching resource topology, or a misconfiguration
elswhere.  Relevant panel dts if you're interested:

https://github.com/sonyxperiadev/kernel/blob/e70161ec43b147b0b02578d05ab64552fd2df2cd/arch/arm64/boot/dts/somc/dsi-panel-sofef03_m-fhd_plus.dtsi

- Marijn
