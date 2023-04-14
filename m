Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34C56E2989
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjDNRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjDNRen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:34:43 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139126E8F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:34:32 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9C8AC3FA14;
        Fri, 14 Apr 2023 19:34:29 +0200 (CEST)
Date:   Fri, 14 Apr 2023 19:34:28 +0200
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
Message-ID: <6s42sutrd2c6tme46t6tchd6y6wonmpwokseqqz2frkrfext7v@vnv44tzwyva4>
References: <1681247095-1201-1-git-send-email-quic_khsieh@quicinc.com>
 <z7wj2lcgcdxsqh7ylhec3ig6o4p6q37zqvpzoxp4bd4vid2z2n@ubsgt3ebqrwr>
 <83f9a438-52c5-83f3-1767-92d16518d8f0@quicinc.com>
 <feedv4isliterjtwyicqfarwuvzhtov3jkmvjcwqvt7itkyh7y@e2jq5t6r3lxc>
 <e78e576a-2a04-e7ca-f6c4-701d508541ad@quicinc.com>
 <mfzi535qsjtcznwdvgb7qyzk25rcsrkwozah6ji4thqsj73n3m@asybxllomisg>
 <049697ba-d997-62c0-6e21-ffb287ac3100@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049697ba-d997-62c0-6e21-ffb287ac3100@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-14 08:48:43, Abhinav Kumar wrote:
> 
> On 4/14/2023 12:35 AM, Marijn Suijten wrote:
> > On 2023-04-12 10:33:15, Abhinav Kumar wrote:
> > [..]
> >>> What happens if a device boots without DSC panel connected?  Will
> >>> CTL_DSC_FLUSH be zero and not (unnecessarily, I assume) flush any of the
> >>> DSC blocks?  Or could this flush uninitialized state to the block?
> >>>
> >>
> >> If we bootup without DSC panel connected, the kernel's cfg->dsc will be
> >> 0 and default register value of CTL_DSC_FLUSH will be 0 so it wont flush
> >> any DSC blocks.
> > 
> > Ack, that makes sense.  However, if I connect a DSC panel, then
> > disconnect it (now the register should be non-zero, but cfg->dsc will be
> > zero), and then replug a non-DSC panel multiple times, it'll get flushed
> > every time because we never clear CTL_DSC_FLUSH after that?
> > 
> 
> If we remove it after kernel starts, that issue is there even today 
> without that change because DSI is not a hot-pluggable display so a 
> teardown wont happen when you plug out the panel. How will cfg->dsc be 0 
> then? In that case, its not a valid test as there was no indication to 
> DRM that display was disconnected so we cannot tear it down.

The patch description itself describes hot-pluggable displays, which I
believe is the upcoming DSC support for DP?  You ask how cfg->dsc can
become zero, but this is **exactly** what the patch description
describes, and what this patch is removing the `if` for.  If we are not
allowed to discuss that scenario because it is not currently supported,
neither should we allow to apply this patch.

With that in mind, can you re-answer the question?

- Marijn
