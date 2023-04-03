Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494626D42A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjDCKym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjDCKyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:54:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33BE12055;
        Mon,  3 Apr 2023 03:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CFAAB8184D;
        Mon,  3 Apr 2023 10:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C11AC433EF;
        Mon,  3 Apr 2023 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680519236;
        bh=VWMo1YJspHOfBC+lus10zI4L7eNsXSOhn8XQ8widspU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=InCZo1EfGW3TaJCuifsyUJAn7xv98k6uy+ckeaSMPOM9USkCQ78Bk9HmjDVRVtnMs
         HQckvKA/7bBzmsfegNZb+Ca6HOg4VlUrUNIc3YYEVlwkj0rlv4a9zineEn2+Pae+hN
         Vg3SWBxzRm/v90l1cdtEQOfTmoNjHVViobtEsiQu5S0mPhLk7Vjhl7jafHNCcjniEI
         67Ra+2S15o80jw+8sRqRhxG9FLTSHJRY4sjmVIvoY29dXW6j6PCCO5BB1XMMBgUt0Z
         SnLRgYDGi1SIoljEnQUSFjlxFqSt7YIxDQB9LedVfnOEp0U2KcycqglD5lfIAwRbf6
         PKwj9zIV1sYMg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pjHpL-0003Ag-3Y; Mon, 03 Apr 2023 12:54:19 +0200
Date:   Mon, 3 Apr 2023 12:54:19 +0200
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
Message-ID: <ZCqwWwdhhJdOK+5Y@hovoldconsulting.com>
References: <20230327122948.4323-1-johan+linaro@kernel.org>
 <48f71f9a-0d00-16df-fff8-5aa455918378@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f71f9a-0d00-16df-fff8-5aa455918378@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:18:07AM +0200, Krzysztof Kozlowski wrote:
> On 27/03/2023 14:29, Johan Hovold wrote:
> > The pmk8280 PMIC PON peripheral is gen3 and uses two sets of registers;
> > hlos and pbs.
> > 
> > This specifically fixes the following error message during boot when the
> > pbs registers are not defined:
> > 
> > 	PON_PBS address missing, can't read HW debounce time
> > 
> > Note that this also enables the spurious interrupt workaround introduced
> > by commit 0b65118e6ba3 ("Input: pm8941-pwrkey - add software key press
> > debouncing support") (which may or may not be needed).
> > 
> > Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > index c35e7f6bd657..a0ba535bb6c9 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > @@ -59,8 +59,9 @@ pmk8280: pmic@0 {
> >  		#size-cells = <0>;
> >  
> >  		pmk8280_pon: pon@1300 {
> > -			compatible = "qcom,pm8998-pon";
> > -			reg = <0x1300>;
> > +			compatible = "qcom,pmk8350-pon";
> 
> Same comment as Dmitry's. There is no compatible "qcom,pmk8350-pon"
> ccd3517faf18, therefore indicated backport (through AUTOSEL) will lead
> to invalid stable kernel.
>
> You must drop the Fixes tag, because this cannot be backported.

That's bullshit. Do you see a stable tag? Is 5.19-stable still active?

The problem is that the driver was updated before the binding was so the
above mentioned probe error has been there since this file was merged.

AUTOSEL is crazy and people apparently just ignore it instead of NAKing
when it is suggesting backporting devicetree cleanups (which to be fair
should generally not have Fixes tags in the first place).

If 5.19-stable was still active and someone suggested backporting this
one, they would have to change the compatible string to match the
inconsistent 5.19 kernel. Note that that would need to happen regardless
of whether this patch has a Fixes tag or not.

Johan
