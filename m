Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCCF6FBFCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjEIHAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjEIHA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:00:28 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F772114;
        Tue,  9 May 2023 00:00:26 -0700 (PDT)
Received: from SoMainline.org (unknown [89.205.226.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 9976A1FA7E;
        Tue,  9 May 2023 09:00:05 +0200 (CEST)
Date:   Tue, 9 May 2023 08:59:58 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/msm/dpu: Add DPU_INTF_DATA_COMPRESS feature
 flag
Message-ID: <chw4jhkwbtml3w3ha6beubvvil4jsr7wuzahfif2mzkcmsqhwj@wgm7axq2o6wk>
References: <20230405-add-dsc-support-v2-0-1072c70e9786@quicinc.com>
 <20230405-add-dsc-support-v2-3-1072c70e9786@quicinc.com>
 <i6i2xj2tuy5mcxsj674d77kfdb3ne6immkmrzw5f6u4bfx2sth@ef7fzrhdyypx>
 <1d7ccb5f-55c2-3b3a-df97-2c17beffabfc@quicinc.com>
 <0aa4130d-bb37-4743-10e5-fd518276f4a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0aa4130d-bb37-4743-10e5-fd518276f4a2@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-09 02:08:52, Dmitry Baryshkov wrote:
> On 09/05/2023 00:46, Jessica Zhang wrote:
> > 
> > 
> > On 5/7/2023 9:00 AM, Marijn Suijten wrote:
> >> On 2023-05-05 14:23:50, Jessica Zhang wrote:
> >>> Add DATA_COMPRESS feature flag to DPU INTF block.
> >>>
> >>> In DPU 7.x and later, DSC/DCE enablement registers have been moved from
> >>> PINGPONG to INTF.
> >>>
> >>> As core_rev (and related macros) was removed from the dpu_kms struct, 
> >>> the
> >>> most straightforward way to indicate the presence of this register 
> >>> would be
> >>> to have a feature flag.
> >>
> >> Irrelevant.  Even though core_rev was still in mainline until recently,
> >> we always hardcoded the features in the catalog and only used core_rev
> >> to select a dpu_mdss_cfg catalog entry.  There is no "if version >= X
> >> then enable feature Y" logic, this manually-enabled feature flag is the
> >> only, correct way to do it.
> > 
> > Hi Marijn,
> > 
> > Understood. FWIW, if we do find more register bit-level differences 
> > between HW versions in the future, it might make more sense to keep the 
> > HW catalog small and bring core_rev back, rather than keep adding these 
> > kinds of small differences to caps.
> 
> Let's see how it goes. Abhinav suggested that there might be feature 
> differences inside the DPU generations (and even inside the single DPU 
> major/minor combo). So I'm not sure what core_rev will bring us.
> 
> Let's land the platforms which are ready (or if there is anything close 
> to be submitted).

You mean waiting for catalog changes on the list specifically, so the
DSC series as well as SM6350/SM6375?  I do intend to send SM6125 now
that the INTF TE series (required for it, as well as for SM63**) seems
to be generally accepted, but have been quite busy with the DSC series
on the list as we're now unblocking many Xperia's to finally have
display!

The catalog addition is "pretty much ready", let me know if you'd like
it to be sent in prior to your cleanup.

> I'll post the next proposal for the catalog cleanups 
> close to -rc4, when the dust settles then we can have one or two weaks 
> for the discussion and polishing.
> 
> I'd like to consider:
> - inlining foo_BLK macros, if that makes adding new features easier

Sounds like a good idea.

> - reformat of clk_ctrls
> - maybe reintroduction of per-generation feature masks instead of 
> keeping them named after the random SoC

Yes that would make things more clear.  Or we can inline them entirely
though that might accidentally diverge SoCs and revisions.

> - maybe a rework of mdss_irqs / INTFn_INTR. We already have this info in 
> hw catalog.

Sounds good as well, that should get rid of some "duplication".

- Marijn
