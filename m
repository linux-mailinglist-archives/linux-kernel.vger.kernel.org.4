Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E46D6E2955
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDNR2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDNR2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:28:12 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8573C13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:28:09 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 74EF23FA00;
        Fri, 14 Apr 2023 19:28:06 +0200 (CEST)
Date:   Fri, 14 Apr 2023 19:28:04 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: always program dsc active bits
Message-ID: <3oaangxh7gmie3cdd6rmujm7dd3hagsrnwiq3bascdtamvfn3a@bn6ou5hbsgxv>
References: <1681401401-15099-1-git-send-email-quic_khsieh@quicinc.com>
 <tgfbdk6q3uool365jqddibnbgq66clsmsm6tldxpm5toqghxpq@m2ic3oonv2s5>
 <aac210da-dec1-aab8-3f48-c33d9e7687d6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aac210da-dec1-aab8-3f48-c33d9e7687d6@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-14 08:41:37, Abhinav Kumar wrote:
> 
> On 4/14/2023 12:48 AM, Marijn Suijten wrote:
> > Capitalize DSC in the title, as discussed in v1.
> > 
> > On 2023-04-13 08:56:41, Kuogee Hsieh wrote:
> >> In current code, the DSC active bits are written only if cfg->dsc is set.
> >> However, for displays which are hot-pluggable, there can be a use-case
> >> of disconnecting a DSC supported sink and connecting a non-DSC sink.
> >>
> >> For those cases we need to clear DSC active bits during tear down.
> >>
> >> Changes in V2:
> >> 1) correct commit text as suggested
> >> 2) correct Fixes commit id
> >> 3) add FIXME comment
> >>
> >> Fixes: 77f6da90487c ("drm/msm/disp/dpu1: Add DSC support in hw_ctl")
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> > 
> > By default git send-email should pick this up in the CC line...  but I
> > had to download this patch from lore once again.
> > 
> 
> Yes, I think what happened here is, he didnt git am the prev rev and 
> make changes on top of that so git send-email didnt pick up. We should 
> fix that process.

The mail was sent so it must have gone through git send-email, unless a
different mail client was used to send the .patch file.  I think you are
confusing this with git am (which doesn't need to be used if editing a
commit on a local branch) and subsequently git format-patch, which takes
a commit from a git repository and turns it into a .patch file: neither
of these "converts" r-b's (and other tags) to cc, that's happening in
git send-email (see `--suppress-cc` documentation in `man
git-send-email`).

I can recommend b4: it has lots of useful features including
automatically picking up reviews and processing revisions.  It even
requires a changelog to be edited ;).  However, finding the right flags
and trusting it'll "do as ordered" is a bit daunting at first.

> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> >> index bbdc95c..1651cd7 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> >> @@ -541,10 +541,10 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
> >>   	if (cfg->merge_3d)
> >>   		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
> >>   			      BIT(cfg->merge_3d - MERGE_3D_0));
> >> -	if (cfg->dsc) {
> >> -		DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
> >> -		DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
> >> -	}
> >> +
> >> +	/* FIXME: fix reset_intf_cfg to handle teardown of dsc */
> > 
> > There's more wrong than just moving (not "fix"ing) this bit of code into
> > reset_intf_cfg.  And this will have to be re-wrapped in `if (cfg->dsc)`
> > again by reverting this patch.  Perhaps that can be explained, or link
> > to Abhinav's explanation to make it clear to readers what this FIXME
> > actually means?  Let's wait for Abhinav and Dmitry to confirm the
> > desired communication here.
> > 
> > https://lore.kernel.org/linux-arm-msm/ec045d6b-4ffd-0f8c-4011-8db45edc6978@quicinc.com/
> > 
> 
> Yes, I am fine with linking this explanation in the commit text and 
> mentioning that till thats fixed, we need to go with this solution. The 
> FIXME itself is fine, I will work on it and I remember this context well.

Looks like it was removed entirely in v3, in favour of only describing
it in the patch body.  The wording seems a bit off but that's fine by me
if you're picking this up soon anyway.

- Marijn
