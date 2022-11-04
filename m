Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC0661958D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiKDLod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiKDLob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:44:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9212CC88;
        Fri,  4 Nov 2022 04:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A0996216C;
        Fri,  4 Nov 2022 11:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA801C433D6;
        Fri,  4 Nov 2022 11:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667562268;
        bh=Fm4RmkkjBKi2J3sh9v6S2aRSdhr880Xg3fJGdAcANDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZqwDZQyk1Q1KEHu25MzHSyi663H6WkbJvSC0fUc1SkBj6V/V9RxG0hj7CoIZN334
         wlDV0LzbOXYuVsKx5kgTnP68F8U+TThWMjOga1xUJ/QnuwTqA+7hHV+6KeJVfHViWZ
         ah8KggQkb7OcmFOObkBckGjKgGLRgPOxm+J+U7FJOftUVYAUS9YeJwPpaXxWqlord9
         u/6Jz28LL96zcldHJRqN/vJmvAEesiVW/ZHUQ7NjXrN2D+HpFCQPmrKnGgEolYI/Sk
         NUYdgAqfalUcSREn4DxpyiwwZKRcdyczYUt2nw4Gt+W1f/lwucP9IOfn0sx7BMMciK
         qfB8IxVRm1v+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oqv7K-0003KN-U9; Fri, 04 Nov 2022 12:44:11 +0100
Date:   Fri, 4 Nov 2022 12:44:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, patches@lists.linux.dev,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v3] clk: qcom: gdsc: Remove direct runtime PM calls
Message-ID: <Y2T7Cp2HMChRbS/f@hovoldconsulting.com>
References: <20221103183030.3594899-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103183030.3594899-1-swboyd@chromium.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:30:30AM -0700, Stephen Boyd wrote:
> We shouldn't be calling runtime PM APIs from within the genpd
> enable/disable path for a couple reasons.
> 
> First, this causes an AA lockdep splat[1] because genpd can call into
> genpd code again while holding the genpd lock.

> Second, this confuses runtime PM on CoachZ for the camera devices by
> causing the camera clock controller's runtime PM usage_count to go
> negative after resuming from suspend. This is because runtime PM is
> being used on the clock controller while runtime PM is disabled for the
> device.
> 
> The reason for the negative count is because a GDSC is represented as a
> genpd and each genpd that is attached to a device is resumed during the
> noirq phase of system wide suspend/resume (see the noirq suspend ops
> assignment in pm_genpd_init() for more details). The camera GDSCs are
> attached to camera devices with the 'power-domains' property in DT.
> Every device has runtime PM disabled in the late system suspend phase
> via __device_suspend_late(). Runtime PM is not usable until runtime PM
> is enabled in device_resume_early(). The noirq phases run after the
> 'late' and before the 'early' phase of suspend/resume. When the genpds
> are resumed in genpd_resume_noirq(), we call down into gdsc_enable()
> that calls pm_runtime_resume_and_get() and that returns -EACCES to
> indicate failure to resume because runtime PM is disabled for all
> devices.
> 
> Upon closer inspection, calling runtime PM APIs like this in the GDSC
> driver doesn't make sense. It was intended to make sure the GDSC for the
> clock controller providing other GDSCs was enabled, specifically the
> MMCX GDSC for the display clk controller on SM8250 (sm8250-dispcc), so
> that GDSC register accesses succeeded. That will already happen because
> we make the 'dev->pm_domain' a parent domain of each GDSC we register in
> gdsc_register() via pm_genpd_add_subdomain(). When any of these GDSCs
> are accessed, we'll enable the parent domain (in this specific case
> MMCX).
> 
> We also remove any getting of runtime PM during registration, because
> when a genpd is registered it increments the count on the parent if the
> genpd itself is already enabled.
> 
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Link: https://lore.kernel.org/r/CAE-0n52xbZeJ66RaKwggeRB57fUAwjvxGxfFMKOKJMKVyFTe+w@mail.gmail.com [1]
> Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v2 (https://lore.kernel.org/r/20221102170717.1262547-1-swboyd@chromium.org):
>  * Drop dev assignment and remove struct member
>  * Update commit text, add link to report
> 
> Changes from v1 (https://lore.kernel.org/r/20221101233421.997149-1-swboyd@chromium.org):
>  * Fix ret thinko
>  * Update kerneldoc on 'dev' member

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
