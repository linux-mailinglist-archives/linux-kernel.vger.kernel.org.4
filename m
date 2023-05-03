Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1416F621F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjECXhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjECXhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:37:01 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8D8A7F
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 16:36:56 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8EFF320A1D;
        Thu,  4 May 2023 01:36:54 +0200 (CEST)
Date:   Thu, 4 May 2023 01:36:53 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] drm/msm/dpu: add PINGPONG_NONE to disconnect DSC
 from PINGPONG
Message-ID: <mbpdqthhi7ynb22l62pwuwuepqeh6t67ggdseltxlx25uh6a2x@sbbfuitssdv5>
References: <1683144639-26614-1-git-send-email-quic_khsieh@quicinc.com>
 <1683144639-26614-5-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683144639-26614-5-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-03 13:10:36, Kuogee Hsieh wrote:
> During DSC setup, the crossbar mux need to be programmed to engage
> DSC to specified PINGPONG. Hence during tear down, the crossbar mux
> need to be reset to disengage DSC from PINGPONG. 0X0F is written to
> reset crossbar mux. It is not relevant to hw_pp->idx.  This patch add
> PINGPONG_NONE to serve as disable to reset crossbar mux.
> 
> Changes in v4:
> -- more details to commit text

As requested in v3, this doesn't adequately explain that all you're
doing is **removing `bool enable`** so that this function becomes
simpler to call in the disable scenario without coming up with a random
dpu_pingpong value that's irrelevant when enable=false.  How about the
following wording:

    drm/msm/dpu: Introduce PINGPONG_NONE to disconnect DSC from PINGPONG

    Disabling the crossbar mux between DSC and PINGPONG currently
    requires a bogus enum dpu_pingpong value to be passed when calling
    dsc_bind_pingpong_blk() with enable=false, even though the register
    value written is independent of the current PINGPONG block.  Replace
    that `bool enable` parameter with a new PINGPONG_NONE dpu_pingpong
    flag that triggers the write of the "special" 0xF "crossbar
    disabled" value to the register instead.

And don't forget to fix the log statement below.

<snip>

>  	DRM_DEBUG_KMS("%s dsc:%d %s pp:%d\n",
> -			enable ? "Binding" : "Unbinding",
> +			pp ? "Binding" : "Unbinding",
>  			hw_dsc->idx - DSC_0,
> -			enable ? "to" : "from",
> +			pp ? "to" : "from",
>  			pp - PINGPONG_0);

This wasn't adjusted, see v3 review.

- Marijn
