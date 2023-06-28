Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22409740AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjF1IJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:09:25 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:48386 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjF1IEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:04:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 382A1612B2;
        Wed, 28 Jun 2023 06:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985EAC433C8;
        Wed, 28 Jun 2023 06:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687934821;
        bh=d+baqAWGEBGvcOft2QO3hccMGeQCJsFLMtVCuuWroW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfXojygt+HeElbkAC6X55hXj4o+kaWr5OI73g21/V3AZ1MK3bHXL4mBcvOev/0w5c
         lLsJEn/9SIAkBhFg6uibNwKMQesouU17kPMgVW8QoCW9Eu/7JBUa+tePTidRrp/zRo
         5fzHv+EP39oquyYSja8zoUchED860xkdOAQ0FU3h+1lttHk+USF2TOKOnnFjPbK3qr
         sQbEmfKAgEu3wo2KwJRigDT18J+32dLLfxd/un6020jb4Oom5OaoITtzZwO1FUs/xQ
         PL7Vz6zsgJaS/hSVueevSqfYD8wP3o2U817m1cHkN5cWUDtUPvDnqm9j9TAQx0brbX
         SsYCgsE80cAbg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEOxA-0001LV-U7; Wed, 28 Jun 2023 08:47:00 +0200
Date:   Wed, 28 Jun 2023 08:47:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Patrick Wildt <patrick@blueri.se>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: add explicit rtc
 interrupt parent
Message-ID: <ZJvXZDBGBSQfeBdh@hovoldconsulting.com>
References: <20230627085306.6033-1-johan+linaro@kernel.org>
 <20230627132406.GA5490@thinkpad>
 <ZJr_5JIqWSGq-E-T@hovoldconsulting.com>
 <20230628052557.GB20477@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628052557.GB20477@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:55:57AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jun 27, 2023 at 05:27:32PM +0200, Johan Hovold wrote:
> > On Tue, Jun 27, 2023 at 06:54:06PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Jun 27, 2023 at 10:53:06AM +0200, Johan Hovold wrote:
> > > > Unless explicitly specified the interrupt-parent property is inherited
> > > > from the parent node on Linux even though this may not be in full
> > > > compliance with the devicetree specification.
> > > > 
> > > > Following commit 2d5cab9232ba ("arm64: dts: qcom: sc8280xp-pmics:
> > > > Specify interrupt parent explicitly"), add an explicit interrupt parent
> > > > also for the PMIC RTC node for the benefit of other operating systems
> > > > which may be confused by this omission.
> > > > 
> > > > Note that any such OS must still implement a fallback to the root
> > > > interrupt domain as most devicetrees are written under the assumption
> > > > that the interrupt parent is inherited.
> > > > 
> > > > Reported-by: Patrick Wildt <patrick@blueri.se>
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > 
> > > It is good to encode this in the binding and fix other such instances.
> > 
> > Not sure about that. Perhaps the spec should be updated to match reality
> > instead... We have many more instances like this, even for this very
> > SoC, but apparently OpenBSD or whatever OS needs this falls back to the
> > root domain then.
> > 
> 
> Just because linux is doing it in a different way doesn't warrant an amendment
> to the spec IMO.

My point is that it's apparently not just Linux as most devicetrees work
this way at least for the root domain. And then it may be time to update
the spec in some way.
 
> > Changing this for the rtc node for consistency after you changed the
> > others is a no-brainer, but not sure about trying to do this tree-wide.
> > We already have too many of these one-line DT cleanups...
> > 
> 
> I agree that this is going to be a one-line cleanup but someone has to do it.
> (not asking you to do since I also skipped it during 2d5cab9232ba). We can put
> it in the back burner.

So that may actually amount to a ten-thousand line diff or so... And
then it's probably better to just update the spec.

Johan
