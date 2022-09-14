Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBEC5B8353
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiINIxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiINIxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD566113E;
        Wed, 14 Sep 2022 01:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8E0061957;
        Wed, 14 Sep 2022 08:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED961C433D7;
        Wed, 14 Sep 2022 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663145596;
        bh=19OWbRY2d9LI079TVZxY+HNHoWLw1R8/3d3LhfyBcUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtBsTDHUc3FHh9/D3OzUcRRQn9gQK2LmQYpmeuc5GaZLWf8SBjut49Ee3RAxqwB6V
         JzzM2FuiPruPQqZX5diAKpbji4NVeVQQ59tmAMxv+ILQvbGVdGvZlGS9xA23t5Ta4S
         qnVlvwHyAoE0RAIZl2SCqfeKtbXqRsYHW282xSdcMEUOoXlmcxIi2HQq04T/luZs44
         uMycqjKpesZoSF784B3clGbAi2bVn6CVPr5m6CuDiJZejei/ygosu2bRxTapLB3y5q
         Bi2FItNBYhM2o89nvF9akVjgR+dwkD003Uru73SV0nxMcpo3HMlpD9C/1B/N1prbyE
         whc815b/oqe6g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oYO8y-00015O-0L; Wed, 14 Sep 2022 10:53:16 +0200
Date:   Wed, 14 Sep 2022 10:53:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, mka@chromium.org,
        johan+linaro@kernel.org, dianders@chromium.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: qcom: gcc-sc7280: Update the .pwrsts for usb
 gdsc
Message-ID: <YyGWfMKTII8NEHLk@hovoldconsulting.com>
References: <20220901101756.28164-1-quic_rjendra@quicinc.com>
 <20220901101756.28164-3-quic_rjendra@quicinc.com>
 <YyF+IuoDjBZzEQxO@hovoldconsulting.com>
 <33af27a0-85b9-4301-62d9-24132989e26e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33af27a0-85b9-4301-62d9-24132989e26e@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 02:07:06PM +0530, Krishna Kurapati PSSNV wrote:
> On 9/14/2022 12:39 PM, Johan Hovold wrote:
> > On Thu, Sep 01, 2022 at 03:47:56PM +0530, Rajendra Nayak wrote:
> >> USB on sc7280 cannot support wakeups from low power states
> >> if the GDSC is turned OFF. Update the .pwrsts for usb GDSC so it
> >> only transitions to RET in low power.
> > 
> > It seems this isn't just needed for wakeup to work. On both sc7280 and
> > sc8280xp the controller doesn't resume properly if the domain has been
> > powered off (i.e. regardless of whether wakeup is enabled or not).

>    I believe you are referring to the reinit that happens in xhci resume 
> path after wakeup happens:
> 
> [   48.675839] xhci-hcd xhci-hcd.14.auto: xHC error in resume, USBSTS 
> 0x411, Reinit

Right, and on sc8280xp the controller doesn't survive resume at all.
 
> I see that when USB GDSC is not in retention, we don't retain controller 
> state and go for reinit and re-enum of connected devices. We are seeing 
> an additional delay of around ~0.7 sec (in chromebooks running on 
> SC7280) in the wakeup path for re-enumeration of connected USB devices. 
> To avoid this, we wanted to put GDSC in retention during PM suspend.

Thanks for confirming. This needs to be described in the commit message
of this patches, which currently only says that this change is needed
for wakeup.

> > Are you sure there's no state that needs to be retained regardless of
> > the wakeup setting?
> > 
> >> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> >> ---
> >>   drivers/clk/qcom/gcc-sc7280.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> >> index 7ff64d4d5920..de29a034e725 100644
> >> --- a/drivers/clk/qcom/gcc-sc7280.c
> >> +++ b/drivers/clk/qcom/gcc-sc7280.c
> >> @@ -3126,7 +3126,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
> >>   	.pd = {
> >>   		.name = "gcc_usb30_prim_gdsc",
> >>   	},
> >> -	.pwrsts = PWRSTS_OFF_ON,
> >> +	.pwrsts = PWRSTS_RET_ON,
> >>   	.flags = VOTABLE,
> >>   };
> > 
> > And what about gcc_usb30_sec_gdsc?
> 
> Currently wakeup is not enabled on secondary controller as its not 
> required for end product platform (herobrine variant). So leaving the 
> usb30_sec_gdsc as it is for now.

This is generic code that can be used in different products and if this
is needed for the first controller it is also needed for the second
(i.e. even if wakeup isn't wired up or used on the products you are
working on).

Johan
