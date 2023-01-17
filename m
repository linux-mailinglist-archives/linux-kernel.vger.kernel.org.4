Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB166D400
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 02:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjAQB5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 20:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjAQB5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 20:57:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEEA23133;
        Mon, 16 Jan 2023 17:57:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70F04B810A1;
        Tue, 17 Jan 2023 01:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420EBC433EF;
        Tue, 17 Jan 2023 01:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673920636;
        bh=j6kfoa3itOyva+gzVjTOyphyKodBRoESrjuevvVO07Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDwO5Vw9BNy4rX8MjdMycG73Mi0Oh5q+yVUqlFfqi3Rzm0dgkcpEOZ7JnEedCgsZy
         gs6RQcWQb/X3dRyA/M9sF+Si6vHSEZsltiuk7l4e6Doki5bXfTM4XynaDePirjaBOL
         s2sblKTvMVWqwZ6ax9CrIFnFCwRjWivK6Kt3yQZ3p8xglhdDla9AaBwJTQ56PmWKno
         3sHMMbROhPYgqnX8r0ACZ469PUKuK+oZ7ChILYgAIT9NezHW8Ak33+4tENR7cXroU1
         dx3Xcf04F0Pu0HVg+okO1jbffksuajZx0LXjdJmHKXEwUdNKBdVVjNBHPLeq43OtEf
         LPtzrQU9t4qQg==
Date:   Mon, 16 Jan 2023 19:57:13 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Define CMA region for CRD
 and X13s
Message-ID: <20230117015713.j62qymja6bdbgxiu@builder.lan>
References: <20230113041025.4188910-1-quic_bjorande@quicinc.com>
 <c37bdea2-2154-975b-4ef3-570922944088@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c37bdea2-2154-975b-4ef3-570922944088@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 03:17:05PM +0100, Konrad Dybcio wrote:
> 
> 
> On 13.01.2023 05:10, Bjorn Andersson wrote:
> > Booting the CRD needs roughly 64MB CMA, rather than relying on people
> > adding boot parameters etc define a region for this, to remove the
> > allocation errors from e.g. NVME.
> > 
> > While fixing the CRD define the same region for the X13s.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> So, to reiterate, the NVMe needs ~64M of contiguous RAM for
> $reasons and without this patch, it is not guaranteed that
> it can always find such a block which causes issues and
> adding a CMA region resolves that, is that correct?
> 

That's correct, $reasons being that NVMe complains about failures to
allocate CMA memory. I'll post a v2 with this in the commit message.

Thanks,
Bjorn

> Konrad
> >  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                | 9 +++++++++
> >  .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts      | 9 +++++++++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > index b29c02307839..e30a37c73b90 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > @@ -128,6 +128,15 @@ vreg_wwan: regulator-wwan {
> >  
> >  		regulator-boot-on;
> >  	};
> > +
> > +	reserved-memory {
> > +		linux,cma {
> > +			compatible = "shared-dma-pool";
> > +			size = <0x0 0x8000000>;
> > +			reusable;
> > +			linux,cma-default;
> > +		};
> > +	};
> >  };
> >  
> >  &apps_rsc {
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > index 78e61a8184c5..5bfd1f0b2a24 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > @@ -153,6 +153,15 @@ vreg_wwan: regulator-wwan {
> >  		regulator-boot-on;
> >  	};
> >  
> > +	reserved-memory {
> > +		linux,cma {
> > +			compatible = "shared-dma-pool";
> > +			size = <0x0 0x8000000>;
> > +			reusable;
> > +			linux,cma-default;
> > +		};
> > +	};
> > +
> >  	thermal-zones {
> >  		skin-temp-thermal {
> >  			polling-delay-passive = <250>;
