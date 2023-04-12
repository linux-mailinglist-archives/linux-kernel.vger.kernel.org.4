Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F8F6DEC84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjDLHYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDLHYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:24:19 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E08EB8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:24:17 -0700 (PDT)
Received: from SoMainline.org (unknown [89.205.226.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 9B2BD20301;
        Wed, 12 Apr 2023 09:24:13 +0200 (CEST)
Date:   Wed, 12 Apr 2023 09:24:10 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: always program dsc active bits
Message-ID: <feedv4isliterjtwyicqfarwuvzhtov3jkmvjcwqvt7itkyh7y@e2jq5t6r3lxc>
References: <1681247095-1201-1-git-send-email-quic_khsieh@quicinc.com>
 <z7wj2lcgcdxsqh7ylhec3ig6o4p6q37zqvpzoxp4bd4vid2z2n@ubsgt3ebqrwr>
 <83f9a438-52c5-83f3-1767-92d16518d8f0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f9a438-52c5-83f3-1767-92d16518d8f0@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-11 16:45:34, Abhinav Kumar wrote:
[..]
> > Does this flush all DSCs programmed in CTL_DSC_FLUSH as set above?  That
> > is currently still in `if (cfg->dsc)` and never overwritten if all DSCs
> > are disabled, should it be taken out of the `if` to make sure no DSCs
> > are inadvertently flushed, or otherwise cache the "previous mask" to
> > make sure we flush exactly the right DSC blocks?
> > 
> 
> Yes, DSC flush is hierarchical. This is the main DSC flush which will 
> enforce the flush of the DSC's we are trying to flush in the 
> CTL_DSC_FLUSH register.

That's what I was thinking, thanks for confirming.

> So if DSC was active, the CTL_FLUSH will only enforce the flush of the 
> DSC's programmed in CTL_DSC_FLUSH
> 
> If DSC is not active, we still need to flush that as well (that was the 
> missing bit).
> 
> No need to cache previous mask. That programming should be accurate in 
> cfg->dsc already.

This kind of implicit dependency warrants a comment at the very least.

What happens if a device boots without DSC panel connected?  Will
CTL_DSC_FLUSH be zero and not (unnecessarily, I assume) flush any of the
DSC blocks?  Or could this flush uninitialized state to the block?

- Marijn
