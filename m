Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFA1698EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBPIbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBPIbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:31:33 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B293CE3F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:31:27 -0800 (PST)
Received: from SoMainline.org (unknown [89.205.225.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 17EFD1F9AA;
        Thu, 16 Feb 2023 09:31:22 +0100 (CET)
Date:   Thu, 16 Feb 2023 09:31:19 +0100
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
Subject: Re: [PATCH 1/3] drm/msm/dpu: Read previously-uninitialized SSPP
 scaler version from hw
Message-ID: <20230216083119.6ispk2xhahhzn5sx@SoMainline.org>
References: <20230215-sspp-scaler-version-v1-0-416b1500b85b@somainline.org>
 <20230215-sspp-scaler-version-v1-1-416b1500b85b@somainline.org>
 <CAA8EJpq1L32VQ1eQEk2YQWqCwHgdFQfuWPhQx=PmhzXvazLgPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpq1L32VQ1eQEk2YQWqCwHgdFQfuWPhQx=PmhzXvazLgPA@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-16 04:22:13, Dmitry Baryshkov wrote:
> On Thu, 16 Feb 2023 at 01:02, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > DPU's catalog never assigned dpu_scaler_blk::version leading to
> > initialization code in dpu_hw_setup_scaler3 to wander the wrong
> > codepaths.  Instead of hardcoding the correct QSEED algorithm version,
> > read it back from a hardware register.
> >
> > Note that this register is only available starting with QSEED3, where
> > 0x1002 corresponds to QSEED3, 0x2004 to QSEED3LITE and 0x3000 to QSEED4.
> 
> This is not purely accurate. 0x1003 (sdm845) also corresponds to QSEED3.
> I'd say instead that there are several variations of QSEED3 scalers,
> where starting from 0x2004 it is called QSEED3LITE and starting from
> 0x3000 it is called QSEED4.

Good catch, I'll update that.

> > Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 --
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c    | 8 +++++++-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h    | 3 +++
> >  3 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > index ddab9caebb18..96ce1766f4a1 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > @@ -324,11 +324,9 @@ struct dpu_src_blk {
> >  /**
> >   * struct dpu_scaler_blk: Scaler information
> >   * @info:   HW register and features supported by this sub-blk
> > - * @version: qseed block revision
> >   */
> >  struct dpu_scaler_blk {
> >         DPU_HW_SUBBLK_INFO;
> > -       u32 version;
> 
> No. Please keep the version in the scaler subblk.  It is a version of
> the QSEED (scaler block), not the SSPP's version.

You are right that the new variable in the parent (SSPP) block is
nondescriptive and should have been named scaler_version.

However.

dpu_scaler_blk is only used as a const static struct in the catalog,
meaning we cannot (should not!) store a runtime-read register value
here.  Instead I followed your IRC suggestion to read the register in
dpu_hw_sspp_init, but my original implementation called
dpu_hw_get_scaler3_ver in _dpu_hw_sspp_setup_scaler3 where we already
have access to the subblk_offset, allowing us to delete
_dpu_hw_sspp_get_scaler3_ver.  Would you rather have that?  We don't
need the register value anywhere else.

> There is a block called DS (destination scaler), which can be used to
> scale the resulting image after the LM. This block also uses the
> QSEED3(,LITE,4) scaler block.

Is this already supported in mainline, and is it the reason for
previously having qseed_type globally available?  Is my understanding
correct that this scaler subblk in the SSPP is merely an interface to
it, allowing the same hardware to be used from the SSPP for intputs and
after the LM for outputs?

<snip>

- Marijn
