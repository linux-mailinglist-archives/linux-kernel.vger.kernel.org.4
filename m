Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86A4740C74
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbjF1JJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:09:14 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:34604 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjF1JEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:04:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F8C9612E7;
        Wed, 28 Jun 2023 05:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C1BC433C8;
        Wed, 28 Jun 2023 05:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687929970;
        bh=IH62veiH3zIYuVJb9DYDwfF8k41UKiAEys/EwODuy9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nD3x2WtyHP7OAhdwhay6wu4zjy9AnccHAXQ0D+HQEePHiWumleGtjGZ70t7F2vYZE
         sHCOMfeIw/pJatS+AHKUWHJ0caP9PBdYnRHnRNACIvGaYMOkQYWgYu9EjoExqda1y+
         IAy/vcrebVwg/xhAhqTTHog76PI59TPllZ5NISPTqCABM7g+nuIblMbRYF/8z+NbfE
         ESMbt1Dq4fWoy0VZma3zizVKAw/IdTVZt3zEbP/U+010MEUiP5h6RK/x1If6BQR4OC
         3HEZSc+0jgbK75LNX/xYUIY25MrYXiQ4C3LuZ91uN6QjgOp+qi3RcsVQmntwegAEt6
         qAoWxk6E2/LMA==
Date:   Wed, 28 Jun 2023 10:55:57 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan@kernel.org>
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
Message-ID: <20230628052557.GB20477@thinkpad>
References: <20230627085306.6033-1-johan+linaro@kernel.org>
 <20230627132406.GA5490@thinkpad>
 <ZJr_5JIqWSGq-E-T@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJr_5JIqWSGq-E-T@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 05:27:32PM +0200, Johan Hovold wrote:
> On Tue, Jun 27, 2023 at 06:54:06PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jun 27, 2023 at 10:53:06AM +0200, Johan Hovold wrote:
> > > Unless explicitly specified the interrupt-parent property is inherited
> > > from the parent node on Linux even though this may not be in full
> > > compliance with the devicetree specification.
> > > 
> > > Following commit 2d5cab9232ba ("arm64: dts: qcom: sc8280xp-pmics:
> > > Specify interrupt parent explicitly"), add an explicit interrupt parent
> > > also for the PMIC RTC node for the benefit of other operating systems
> > > which may be confused by this omission.
> > > 
> > > Note that any such OS must still implement a fallback to the root
> > > interrupt domain as most devicetrees are written under the assumption
> > > that the interrupt parent is inherited.
> > > 
> > > Reported-by: Patrick Wildt <patrick@blueri.se>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > It is good to encode this in the binding and fix other such instances.
> 
> Not sure about that. Perhaps the spec should be updated to match reality
> instead... We have many more instances like this, even for this very
> SoC, but apparently OpenBSD or whatever OS needs this falls back to the
> root domain then.
> 

Just because linux is doing it in a different way doesn't warrant an amendment
to the spec IMO.

> Changing this for the rtc node for consistency after you changed the
> others is a no-brainer, but not sure about trying to do this tree-wide.
> We already have too many of these one-line DT cleanups...
> 

I agree that this is going to be a one-line cleanup but someone has to do it.
(not asking you to do since I also skipped it during 2d5cab9232ba). We can put
it in the back burner.

- Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
