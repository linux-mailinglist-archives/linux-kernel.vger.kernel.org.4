Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0956D4532
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjDCNDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjDCNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:03:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A620C27;
        Mon,  3 Apr 2023 06:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F095BB8198B;
        Mon,  3 Apr 2023 13:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E51C4339B;
        Mon,  3 Apr 2023 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680526988;
        bh=v1Pszh5fW8WyXmnfcFzSWf8zEpFGb5aRngCORZusvag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3ArRHOyteVcFRd/xdt0WMXDJEPg9g+QwOtYaV47vHGdMWCMITjMb8H1zlhgjnTKh
         GZGzgxI+uw/UsjJTYS9Qv8ewz8Iz/3Bafsw7t8rG1a2afWg+aqbPpnJLS4vacPjxB9
         ZldDcAWyHtdwf42Qyy0lZZ5b/Jvfj+iPPZ0Dq8wRLY1znajqL6wRn471YfO7cxsEgF
         FAGE9A61odAekWrpouMTguzpWX0K68bhDscqKjF1UnEibudIfJYK+8Rc6MpZ6flBQi
         a96DECHz49gt2wut/Ssg4y8n69O6gQT0neOJr57Gkp7lnil+b1cnxy/1n/IUNWULCc
         yHQJywfaLNJFA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pjJqP-0004IS-0m; Mon, 03 Apr 2023 15:03:33 +0200
Date:   Mon, 3 Apr 2023 15:03:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: fix pon compatible and
 registers
Message-ID: <ZCrOpWowEjUmltVA@hovoldconsulting.com>
References: <20230327122948.4323-1-johan+linaro@kernel.org>
 <48f71f9a-0d00-16df-fff8-5aa455918378@linaro.org>
 <ZCqwWwdhhJdOK+5Y@hovoldconsulting.com>
 <5dfb81df-8ae2-eb62-01a2-b26c6b8d2597@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dfb81df-8ae2-eb62-01a2-b26c6b8d2597@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 02:33:01PM +0200, Krzysztof Kozlowski wrote:
> On 03/04/2023 12:54, Johan Hovold wrote:
> > On Mon, Apr 03, 2023 at 11:18:07AM +0200, Krzysztof Kozlowski wrote:
> >> On 27/03/2023 14:29, Johan Hovold wrote:
> >>> The pmk8280 PMIC PON peripheral is gen3 and uses two sets of registers;
> >>> hlos and pbs.
> >>>
> >>> This specifically fixes the following error message during boot when the
> >>> pbs registers are not defined:
> >>>
> >>> 	PON_PBS address missing, can't read HW debounce time
> >>>
> >>> Note that this also enables the spurious interrupt workaround introduced
> >>> by commit 0b65118e6ba3 ("Input: pm8941-pwrkey - add software key press
> >>> debouncing support") (which may or may not be needed).
> >>>
> >>> Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> >>> index c35e7f6bd657..a0ba535bb6c9 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> >>> @@ -59,8 +59,9 @@ pmk8280: pmic@0 {
> >>>  		#size-cells = <0>;
> >>>  
> >>>  		pmk8280_pon: pon@1300 {
> >>> -			compatible = "qcom,pm8998-pon";
> >>> -			reg = <0x1300>;
> >>> +			compatible = "qcom,pmk8350-pon";
> >>
> >> Same comment as Dmitry's. There is no compatible "qcom,pmk8350-pon"
> >> ccd3517faf18, therefore indicated backport (through AUTOSEL) will lead
> >> to invalid stable kernel.
> >>
> >> You must drop the Fixes tag, because this cannot be backported.
> > 
> > That's bullshit. Do you see a stable tag? Is 5.19-stable still active?
> 
> Why do you refer to activeness of v5.19? This will go also to v6.0 and v6.1.

6.0 stable is also EOL, and 6.1 has "qcom,pmk8350-pon".

> > The problem is that the driver was updated before the binding was so the
> > above mentioned probe error has been there since this file was merged.
> 
> I grepped and that commit did not have such compatible. Are you saying
> that the kernel which was released with this commit already had that
> compatible in driver (through different merge/tree)?

The pwrkey started printing an error when the PON register was not
defined in 5.18 so the problem was already there when support for
sc8280xp was merged. Hence the Fixes tag.

	0b65118e6ba3 ("Input: pm8941-pwrkey - add software key press debouncing support")

> > AUTOSEL is crazy and people apparently just ignore it instead of NAKing
> > when it is suggesting backporting devicetree cleanups (which to be fair
> > should generally not have Fixes tags in the first place).
> 
> Sorry, no clue what do you want to say here... if you are unhappy with
> AUTOSEL, I am not the one to receive such feedback. Anyway, regardless
> of AUTOSEL, my concern was that the release containing that commit was
> not ready to work with that compatible. Isn't this the case here?

You were the one who brought up AUTOSEL, but it's shortcomings should
not be relevant here and that was my point.

No one is suggesting to backport this patch, but if someone were then
they need to do just that and *port* it to 5.19 or whatever imaginary
stable tree you care about which do not have "qcom,pmk8350-pon" (as I
mentioned below).

> > If 5.19-stable was still active and someone suggested backporting this
> 
> Whether v5.19 is active or not, it does not matter. Why would it matter?
> This will go longterm v6.1 as well!

That would be perfectly fine as, again, 6.1 has "qcom,pmk8350-pon".

> > one, they would have to change the compatible string to match the
> > inconsistent 5.19 kernel. Note that that would need to happen regardless
> > of whether this patch has a Fixes tag or not.
> 
> Any manual backporting of something which is not a fix for older kernel
> is already risky business and whoever is doing it, he is responsible for
> the outcome.

Exactly, and the same applies to fixes and arguable scripted backports
as well.

Johan
