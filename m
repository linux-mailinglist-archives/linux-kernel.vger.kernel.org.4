Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66639707A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjERHFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjERHFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:05:46 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1E52686
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:05:43 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4257F20481;
        Thu, 18 May 2023 09:05:41 +0200 (CEST)
Date:   Thu, 18 May 2023 09:05:40 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        freedreno@lists.freedesktop.org, quic_sbillaka@quicinc.com,
        andersson@kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, vkoul@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        quic_jesszhan@quicinc.com, swboyd@chromium.org, sean@poorly.run,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 7/8] drm/msm/dpu: add DSC 1.2 hw blocks for relevant
 chipsets
Message-ID: <xvcl5ojsrifi26trso6nvvfsimtijygp3iizhl4djdrerc5lej@xrwsawvb3k4t>
References: <1684360919-28458-1-git-send-email-quic_khsieh@quicinc.com>
 <1684360919-28458-8-git-send-email-quic_khsieh@quicinc.com>
 <w7xre5jdot3fpe3ldj6vcnvribpbalfvova5hhmbgvgvkrcm34@xqvsc5ga2knb>
 <51f0439c-a5e8-b47a-21af-7bbbc944ca53@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51f0439c-a5e8-b47a-21af-7bbbc944ca53@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-17 16:22:37, Abhinav Kumar wrote:
<snip>
> >> @@ -529,6 +539,19 @@ static const struct dpu_pingpong_sub_blks sc7280_pp_sblk = {
> >>   	.features = _features, \
> >>   	}
> >>   
> >> +/*
> >> + * NOTE: Each display compression engine (DCE) contains dual hard
> >> + * slice DSC encoders so both share same base address but with
> >> + * its own different sub block address.
> >> + */
> > 
> > I still think this comment is superfluous (and doesn't even apply
> > generically, see i.e. sc7280) and should best be kept exclusively in the
> > SoC-specific catalog files.
> > 
> > - Marijn
> > 
> 
> sc7280 is the only exception as it has only one encoder. But, by and 
> large, for all other chipsets this is true and hence kept here.
> 
> The main reason for this comment is people should not get confused that 
> how come two DSC encoders have the same base address.

And that's why the comment is already placed in the SoC-specific catalog
files where a duplicate base address is visible.  It is not visible
here.

- Marijn

> >> +#define DSC_BLK_1_2(_name, _id, _base, _len, _features, _sblk) \
> >> +	{\
> >> +	.name = _name, .id = _id, \
> >> +	.base = _base, .len = _len, \
> >> +	.features = BIT(DPU_DSC_HW_REV_1_2) | _features, \
> >> +	.sblk = &_sblk, \
> >> +	}
> >> +
> >>   /*************************************************************
> >>    * INTF sub blocks config
> >>    *************************************************************/
> >> -- 
> >> 2.7.4
> >>
