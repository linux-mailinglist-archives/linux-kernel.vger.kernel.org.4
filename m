Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBB560EDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiJ0B64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiJ0B6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:58:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB689C696C;
        Wed, 26 Oct 2022 18:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B63CB8248E;
        Thu, 27 Oct 2022 01:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D448C433D6;
        Thu, 27 Oct 2022 01:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666835930;
        bh=7XhdauFWmszF7qH8F0omcebe1A7UMyRAwOUOW2AS3dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CED3jK+ZPtWwB7wTRjdVm/OSrbwnVVIOeWLJ+vD+0MMV2wyvLtq8gRgHeE+CA0QB0
         bNsdyqlGcLYyL6lbqdwC8YWx6yvjrFNzxpofNIM9t7PuMg7IKiGa6OFkqdfEG0AMFm
         oSZ98AQjfIjO+nijtAi2DQHwAWXkAR41NQrZnGer0s5l3256WvxzGeXj1EhsqhZK9X
         uqfkxxLNWm7C22fN0m926Tol7qdGDrS4D7dGkYzBK+OEml/7g6Ta+/swo9Dch/1U2M
         Yk0O+0w7mnIU8fnXNy6k2oYIrZXpBbwK50/srC5yzL7fC5uD6d85t39RfDOdUsmKiu
         BYun4RlHCjPxA==
Date:   Wed, 26 Oct 2022 20:58:46 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/12] drm/msm/dp: HPD handling relates to next_bridge
Message-ID: <20221027015846.5gsmlinx4iwyjvui@builder.lan>
References: <20221026032624.30871-1-quic_bjorande@quicinc.com>
 <20221026032624.30871-10-quic_bjorande@quicinc.com>
 <5974CB5A-699F-4768-9DAA-FAE507CFAD53@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5974CB5A-699F-4768-9DAA-FAE507CFAD53@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:08:49AM +0300, Dmitry Baryshkov wrote:
> 
> 
> On 26 October 2022 06:26:21 EEST, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> >From: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> >The DisplayPort controller's internal HPD interrupt handling is used for
> >cases where the HPD signal is connected to a GPIO which is pinmuxed into
> >the DisplayPort controller.
> >
> >Most of the logic for enabling and disabling the HPD-related interrupts
> >is conditioned on the presence of an EDP panel, but more generically
> >designs that has a downstream drm_bridge (next_bridge) could use this to
> >handle the HPD interrupts, instead of the internal mechanism.
> >
> >So replace the current is_edp-based guards with a check for the presence
> >of next_bridge.
> 
> This does not sound correct. The next bridge might be a dummy bridge,
> not supporting the hpd.

I only considered checking for the Chrome case, where the output isn't
modelled and we have to rely on the internal HPD logic. Checking that
next_bridge is present and will deliver us hpd events sounds somewhat
reasonable.

But if I understand the code correctly, panel-edp isn't handing us hpd
events - and we still don't want the internal HPD logic to trigger. So I
presume I would need to check that this isn't a EDP controller and that
we're going to get external HPD events?

If so, clean you please give me some pointer on how to check if
next_bridge will provide us with hpd signaling or not?


PS. Which dummy bridge do you have in mind?

> Please change this to use the enable_hpd()/disable_hpd() callbacks.
> This way the drm_bridge_connector framework will make sure to enable
> hpd handling for the bridge that is actually supposed to generate hpd
> events.
> 

The drm_bridge_connector_init() call in dp_drm_connector_init() does
this for us already.

Regards,
Bjorn

> 
> >
> >Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> >---
> >
> >Changes since v2:
> >- None
> 
> 
> -- 
> With best wishes
> Dmitry
