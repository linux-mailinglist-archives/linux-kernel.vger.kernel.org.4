Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6572CB12
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjFLQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFLQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:10:47 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D48710C9;
        Mon, 12 Jun 2023 09:10:43 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686586242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rYcn3RNmCkhTMoTm2euN2KhPgjvs1X0oq7hvMFkzhzM=;
        b=Q0x12Hn0KgaIHzqIKKUftOfcxtwwKuV3aZW/89yjqTkPUOCBiDkmr9OW8lBFgi8kmWuDsW
        eOdLaEHc2z0LCN+txJpzfdk0KREfJQw5GPd5lmc6xqPE42zQOZ0TGHAKowz9T6WKZs2AXp
        W8oLVolX/1d81v5JTk7HBVt4YiAwcWKv4pEJBSQodQ1w5wgpbnNGXhSBkwnoTlemQu7pu3
        FM8vpmLGgrJ9WRs3zQIyl6HOPMxSt6Kj3MVkTZCcwvWyAzec0NhB9ugNt7EbYy6hK7V7Sv
        +WG8QZ9YzS/HaK+xIqIiNRhtaoSwocPpM2bxZY44mEVHMTPFRpdWDrqMjX1Pdg==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A02B60010;
        Mon, 12 Jun 2023 16:10:40 +0000 (UTC)
Date:   Mon, 12 Jun 2023 18:10:40 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] rtc: isl12022: implement RTC_VL_READ and RTC_VL_CLR
 ioctls
Message-ID: <202306121610404abc8cbc@mail.local>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-6-linux@rasmusvillemoes.dk>
 <ZIc+YdUPIAt6L4fi@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIc+YdUPIAt6L4fi@smile.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 18:48:49+0300, Andy Shevchenko wrote:
> On Mon, Jun 12, 2023 at 01:30:55PM +0200, Rasmus Villemoes wrote:
> > Hook up support for reading the values of the SR_LBAT85 and SR_LBAT75
> > bits. Translate the former to "battery low", and the latter to
> > "battery empty or not-present".
> 
> ...
> 
> > +static int isl12022_read_sr(struct regmap *regmap)
> > +{
> > +	int ret;
> > +	u32 val;
> > +
> > +	ret = regmap_read(regmap, ISL12022_REG_SR, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +	return val;
> 
> Wondering if the bit 31 is in use with this register (note, I haven't checked
> the register width nor datasheet).
> 

register width is in the driver:

static const struct regmap_config regmap_config = {
	.reg_bits = 8,
	.val_bits = 8,
	.use_single_write = true,
};


> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
