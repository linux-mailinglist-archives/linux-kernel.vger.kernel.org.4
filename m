Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091106B1667
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCHXRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCHXRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:17:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5026C85346;
        Wed,  8 Mar 2023 15:17:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE48FB81E2E;
        Wed,  8 Mar 2023 23:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B66EC433EF;
        Wed,  8 Mar 2023 23:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678317429;
        bh=NmAkrHScLnTkuJqXt6bZ77v1FswLx79ftH2PnKG/MzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIGEjYo8FRg4ruvD0SpUwymB/BrCJyhUJC2i5rpF1yeKIdQWx2dmOJfUWtw9Ed3Id
         J7PJRAcoKC4+44Xcm4z0RZmZuOXo5nUynJY+tdBSOebBBUHgUjzJhKpHvxJhMfGBfd
         ERW/59pb9v6lzQ7iwl6Se1puzoQtyWHkrbuiuxvfTBu9rjyaJfgGoNDpQd3DVge69M
         pZrDdsvnivZEqk2YVjs1qL2RxLEvnOyjVpBvSQ0ymd1mF7Jooi0/E6Bhw1jv+X/B3W
         4Jj17CuWzNZqqHmkJ0BsVN2tWEIeidJ5fFgtjyJEzhmQpabHrmB2S+pZMfj6W98ful
         72+9jyUK4Xzag==
Date:   Wed, 8 Mar 2023 23:17:07 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
Message-ID: <ZAkXcyIlAhgdU3lF@gmail.com>
References: <20230214120253.1098426-1-abel.vesa@linaro.org>
 <20230214120253.1098426-2-abel.vesa@linaro.org>
 <Y+3ZyVRowJplzm9t@sol.localdomain>
 <ZAkEEXHbmxiJf7Fu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAkEEXHbmxiJf7Fu@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:54:25PM +0200, Abel Vesa wrote:
> > Also, in both cases, how will the ICE clock be controlled?  Currently the ICE
> > clock gets turned on and off by the UFS and eMMC drivers.  I don't see any logic
> > in your new driver that turns the clock on and off.
> 
> I added clock enablement in v2. We can decide later on if the clocks
> need to be disabled and when.

To reduce power usage, the ICE clock should be disabled when the UFS (or eMMC)
host controller clocks are disabled, as is currently the case.

> > > +struct qcom_ice {
> > > +	struct device *dev;
> > > +	struct device_node *np;
> > > +	void __iomem *base;
> > > +
> > > +	struct clk *core_clk;
> > > +
> > > +	bool supported;
> > > +};
> > 
> > Shouldn't struct qcom_ice be private to the driver?
> 
> Nope. If the QCOM_INLINE_CRYPTO_ENGINE is not set, the consumer still
> need to be able to call the ICE API (which in this case does really
> nothing). Again, this allows the consumer drivers to keep clean of
> unnecessary #ifdefs.

But isn't struct qcom_ice only dereferenced by drivers/soc/qcom/ice.c?  If other
.c files do not need it, the definition should be private to that file.

- Eric
