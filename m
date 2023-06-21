Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405BA7388C4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFUPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjFUPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:20:49 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F0EC0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:17:34 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 43F9E200EA;
        Wed, 21 Jun 2023 17:17:31 +0200 (CEST)
Date:   Wed, 21 Jun 2023 17:17:29 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/msm/dpu: Set DATABUS_WIDEN on command mode
 encoders
Message-ID: <26tvhvqpxtxz5tqc6jbjixadpae34k7uc7fyec2u5o2ccj4tdq@tjvguzlolc3g>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-2-c7069f2efca1@quicinc.com>
 <c74c9e0e-d059-f0e3-4350-03089c37131a@linaro.org>
 <cce68370-3fd9-4c9a-258e-af0d5d057fda@quicinc.com>
 <n2c5qlujxhbbj2aqlgj7fetzoteood5h4hmbwt4mapi77xlvmt@bpourzaideti>
 <81a5e241-ec82-7414-8752-4ce3cb084959@linaro.org>
 <f14f2c31-38c2-0600-3a29-17e83afececf@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f14f2c31-38c2-0600-3a29-17e83afececf@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-20 14:38:34, Jessica Zhang wrote:
<snip>
> >>>>> +    if (phys_enc->hw_intf->ops.enable_widebus)
> >>>>> +        phys_enc->hw_intf->ops.enable_widebus(phys_enc->hw_intf);
> >>>>
> >>>> No. Please provide a single function which takes necessary
> >>>> configuration, including compression and wide_bus_enable.
> >>>>
> >>>
> >>> There are two ways to look at this. Your point is coming from the
> >>> perspective that its programming the same register but just a different
> >>> bit. But that will also make it a bit confusing.
> > 
> > My point is to have a high-level function that configures the INTF for 
> > the CMD mode. This way it can take a structure with necessary 
> > configuration bits.
> 
> Hi Dmitry,
> 
> After discussing this approach with Abhinav, we still have a few 
> questions about it:
> 
> Currently, only 3 of the 32 bits for INTF_CONFIG2 are being used (the 
> rest are reserved with no plans of being programmed in the future). Does 
> this still justify the use of a struct to pass in the necessary 
> configuration?

No.  The point Dmitry is making is **not** about this concidentally
using the same register, but about adding a common codepath to enable
compression on this hw_intf (regardless of the registers it needs to
touch).  Similar to how dpu_hw_intf_setup_timing_engine() programs the
hw_intf - including widebus! - for video-mode.

Or even more generically, have a struct similar to intf_timing_params
that says how the intf needs to be configured - without the caller
knowing about INTF_CONFIG2.

struct dpu_hw_intf_cfg is a very good example of how we can use a single
struct and a single callback to configure multiple registers at once
based on some input parameters.

> In addition, it seems that video mode does all its INTF_CONFIG2 
> configuration separately in dpu_hw_intf_setup_timing_engine(). If we 
> have a generic set_intf_config2() op, it might be good to have it as 
> part of a larger cleanup where we have both video and command mode use 
> the generic op. What are your thoughts on this?

Not in that way, but if there is a generic enable_compression() or
configure_compression() callback (or even more generic, similar to
setup_intf_cfg in dpu_hw_ctl) that would work for both video-mode and
command-mode, maybe that is beneficial.

- Marijn
