Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BD967E97F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjA0PcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjA0PcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:32:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8AF1F91E;
        Fri, 27 Jan 2023 07:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81AD861CB1;
        Fri, 27 Jan 2023 15:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BF0C433D2;
        Fri, 27 Jan 2023 15:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674833529;
        bh=Z2iqEMIhEJct0i4hJR+FbRDHoDL2SDX5PExgGOdBZHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWdfQA8Trz6dfaYjQIE9SN1VapQVhi/7rcpMdmYajLyTwh+o3ZNxBiHQyFu0Epi7s
         o2kAKgLG09Bf1dTKxaEyQ9wNc/yu7qD84i7WOOjpn7ymox0y2WWv8LS1HX54z7kZci
         TzIjZF968TS5GNFn+GThsza46v8bGRJn5jehv6a6Vwx51e3MSugMEQnraC+YSbE7Rx
         ecJBPaXrp0rWRKiwSsxKEWx/I7qBeQ1A8SoRLOT5zvmDPsEFgcjgXlP9t7OzVA+Ef4
         qxkn236YJlRf5zg1mRP2PDo8Jra3p0zqq2elbibnE8H7O5otpaHxgvbC4wgOy1WzCT
         +sP3fK+n5fMfA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pLQiA-0001GM-EI; Fri, 27 Jan 2023 16:32:19 +0100
Date:   Fri, 27 Jan 2023 16:32:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/24] rtc: pm8xxx: add support for nvmem offset
Message-ID: <Y9PugpnzsqZpzSGE@hovoldconsulting.com>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-17-johan+linaro@kernel.org>
 <85481368-b32e-61aa-f83a-fb42d58c351a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85481368-b32e-61aa-f83a-fb42d58c351a@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 02:13:21PM +0000, Srinivas Kandagatla wrote:
> On 26/01/2023 14:20, Johan Hovold wrote:
> > On many Qualcomm platforms the PMIC RTC control and time registers are
> > read-only so that the RTC time can not be updated. Instead an offset
> > needs be stored in some machine-specific non-volatile memory, which the
> > driver can take into account.
> > 
> > Add support for storing a 32-bit offset from the Epoch in an nvmem cell
> > so that the RTC time can be set on such platforms.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/rtc/rtc-pm8xxx.c | 134 +++++++++++++++++++++++++++++++++++----
> >   1 file changed, 123 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> > index 922aef0f0241..09816b9f6282 100644
> > --- a/drivers/rtc/rtc-pm8xxx.c
> > +++ b/drivers/rtc/rtc-pm8xxx.c
> > @@ -3,6 +3,7 @@
> >    */
> > +static int pm8xxx_rtc_read_nvmem_offset(struct pm8xxx_rtc *rtc_dd)
> > +{
> > +	size_t len;
> > +	void *buf;
> > +	int rc;
> > +
> > +	buf = nvmem_cell_read(rtc_dd->nvmem_cell, &len);
> > +	if (IS_ERR(buf)) {
> > +		rc = PTR_ERR(buf);
> > +		dev_err(rtc_dd->dev, "failed to read nvmem offset: %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	if (len != sizeof(u32)) {
> > +		dev_err(rtc_dd->dev, "unexpected nvmem cell size %zu\n", len);
> > +		kfree(buf);
> > +		return -EINVAL;
> > +	}

> how about us nvmem_cell_read_u32()

I considered that, but did not like the asymmetry of the interface.

Specifically, nvmem_cell_read_u32() would go out and look up the nvmem
cell again even though I already have and need a reference for
nvmem_cell_write().

nvmem_cell_read_u32() seems to be a better fit as a convenience wrapper
for drivers that only need to do a single read at probe.

Johan
