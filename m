Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3363772DD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbjFMJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbjFMJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:00:24 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B691BA;
        Tue, 13 Jun 2023 02:00:22 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686646821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IfOv7/EV35Molg1/s6J6mIgsThkcvsrNOtCmAlFGMPY=;
        b=lD0FxXFsd1w8xrvQIJn5rtZHl3FQr7DkHE4vzxbtfWU/4zIx5EJL+t1kFH4Eqm4Evd9Nnr
        70gMt/T011gpdAhWldpLaYKyXczoAXcexULsD9laCCEqWbguGT/NvImQBPMvWvY2QbkG6h
        ovaigvzwBRF/MiIkSou1Br+cvXvSW1Om982GjIJ2S4iZxhxJ6O2hnYO64k4+npNLIJOSCm
        hKZKPJRxPdaA/GLZ4PhL9mjjefnBpgiBuOvQvN3KK4ph4+mYiUHaCLNFBkYVtchC6A4SQE
        ZWiNufyxpKP/nK8efLiXc5OXVHCuojuk9/vFeMTBwK6a3cAZ9Q47GOVjxwzVqg==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76026E0016;
        Tue, 13 Jun 2023 09:00:20 +0000 (UTC)
Date:   Tue, 13 Jun 2023 11:00:20 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] rtc: isl12022: implement RTC_VL_READ and RTC_VL_CLR
 ioctls
Message-ID: <20230613090020b5405b61@mail.local>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-6-linux@rasmusvillemoes.dk>
 <ZIc+YdUPIAt6L4fi@smile.fi.intel.com>
 <202306121610404abc8cbc@mail.local>
 <c7a2d554-5cb2-5b99-bb6d-855a320deb1b@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a2d554-5cb2-5b99-bb6d-855a320deb1b@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 09:53:03+0200, Rasmus Villemoes wrote:
> On 12/06/2023 18.10, Alexandre Belloni wrote:
> > On 12/06/2023 18:48:49+0300, Andy Shevchenko wrote:
> >> On Mon, Jun 12, 2023 at 01:30:55PM +0200, Rasmus Villemoes wrote:
> >>> Hook up support for reading the values of the SR_LBAT85 and SR_LBAT75
> >>> bits. Translate the former to "battery low", and the latter to
> >>> "battery empty or not-present".
> >>
> >> ...
> >>
> >>> +static int isl12022_read_sr(struct regmap *regmap)
> >>> +{
> >>> +	int ret;
> >>> +	u32 val;
> >>> +
> >>> +	ret = regmap_read(regmap, ISL12022_REG_SR, &val);
> >>> +	if (ret < 0)
> >>> +		return ret;
> >>> +	return val;
> >>
> >> Wondering if the bit 31 is in use with this register (note, I haven't checked
> >> the register width nor datasheet).
> >>
> > 
> > register width is in the driver:
> > 
> > static const struct regmap_config regmap_config = {
> > 	.reg_bits = 8,
> > 	.val_bits = 8,
> > 	.use_single_write = true,
> > };
> 
> Yeah.
> 
> But I only factored that out because I wanted to read the SR also in the
> isl12022_set_trip_levels() to emit the warning at boot time, but when
> that goes away, there's no longer any reason to not just fold this back
> into the ioctl() handler.

That would be to clear a not self clearable battery low (but not empty)
flag or a backup voltage switch flag.

> 
> Rasmus
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
