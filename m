Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B280698DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBPHm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBPHm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:42:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A3D25285;
        Wed, 15 Feb 2023 23:42:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A41FBB825DF;
        Thu, 16 Feb 2023 07:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1F9C433D2;
        Thu, 16 Feb 2023 07:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676533372;
        bh=MOa0xJmnMkeXlEHM9s4CPRRpe1xjLgxBt3dpclKQX5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfDNRhIc0/qbZMXtg5hF6K/EjZv8HzC9qZoSEtDu3XXxsT8GGVTpjEVV4ADQGcI+b
         +n43X5NUq1AzksTktI+STfxuXuPIiemh0VecOBMvl/JfYVq71DggjY0tZHmA5WPFpT
         1Zm2+lBDJ2V6/UEwYKruoHBnto/IgvsXfYijug6usrz9pj5Mx02Zj8UfTuRfjIvpxg
         gvdazPcEsK+jPhaLhReN3AbQdjSAQ9lNH25MZF/3aeWFC0ecVPcc40ch02TqekF+6w
         FQ5mvkb/J7rCsKRUNsohbnS7zAFiciBkP0zzjrJWHNl1X9NsyeQsAdGyi8O0kLGLt/
         AxlK0dTuVt6+g==
Date:   Wed, 15 Feb 2023 23:42:50 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Message-ID: <Y+3eenOERCVGW+go@sol.localdomain>
References: <20230214120253.1098426-1-abel.vesa@linaro.org>
 <20230214120253.1098426-2-abel.vesa@linaro.org>
 <7442b4f8-0560-35ea-4b0e-1f249fc5c902@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7442b4f8-0560-35ea-4b0e-1f249fc5c902@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 02:34:47PM +0100, Konrad Dybcio wrote:
> > +#define QCOM_ICE_BIST_STATUS_MASK		0xF0000000
> GENMASK(31, 28)?

I personally think the plain number is much easier to read...

> btw, most of these defines seem unused?

Yes, the unused definitions can be dropped if people prefer.  I only included
them in the original version because this hardware has no public documentation,
so maybe it's helpful to see what registers and fields are available.

I suppose that downstream code could always be dug up if needed, though.  Or
maybe someday there will actually be documentation?

> > +static struct qcom_ice *engine;
> > +
> > +static bool qcom_ice_check_supported(struct qcom_ice *ice)
> > +{
> > +	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
> > +	struct device *dev = ice->dev;
> > +	int major = regval >> 24;
> > +	int minor = (regval >> 16) & 0xFF;
> > +	int step = regval & 0xFFFF;
> FIELD_GET?

Similarly, plain bit operations are much more universally understood...

> > +	regval = qcom_ice_readl(ice, QCOM_ICE_REG_ADVANCED_CONTROL);
> > +	/*
> > +	 * Enable low power mode sequence
> > +	 * [0]-0, [1]-0, [2]-0, [3]-E, [4]-0, [5]-0, [6]-0, [7]-0
> Pardon my ignorance, but I have no idea how this comment corresponds
> to the value OR'd..
> 
> > +	 */
> > +	regval |= 0x7000;
> > +	qcom_ice_writel(ice, regval, QCOM_ICE_REG_ADVANCED_CONTROL);

I'm not sure either!  I've never had access to any documentation for this
hardware, so the above logic is just taken from downstream code.  I kept that
comment because it was the only available explanation for the value OR'd.

Since it doesn't seem to be useful, I'm fine with just removing it.  (But please
keep the "Enable low power mode sequence" part, as that's useful.)

My guess is that it is actually just describing the bits backwards, so [3]-E
corresponds to the three bits that are set.

> > +static void qcom_ice_optimization_enable(struct qcom_ice *ice)
> > +{
> > +	u32 regval;
> > +
> > +	if (!ice)
> > +		return;
> > +
> > +	/* ICE Optimizations Enable Sequence */
> > +	regval = qcom_ice_readl(ice, QCOM_ICE_REG_ADVANCED_CONTROL);
> > +	regval |= 0xD807100;
> Please use lowercase hex, or de-magic-ify this if you have the means to.

I don't know what the 0xD807100 value means, sorry :-(  This is just the value
that works to enable the "optimizations", and which the downstream code was
using.  If anyone has access to the ICE hardware documentation (if there even
*is* documentation), they might be able to say.

- Eric
