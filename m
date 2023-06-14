Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667F3730099
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbjFNNvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245189AbjFNNvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:51:10 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B82109;
        Wed, 14 Jun 2023 06:50:39 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686750638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uH0PecxGM0xXTyJcDX7gP5FtdzAMT+wQnkEYwRRyRJg=;
        b=M5iMP4w9VsHNG/YdS8Tn2Sf4mbhF3tDXAFpknzwjGIB1MAQ+1h4fuiQJdFD01L+GDqQ7lk
        ysVo74591ywkghh3HGcmWq6dHk0Lrw1YdFLfWnANkK9jb+tlWLhovXI1ogfgfq/mZYE6p2
        m75jmn4MYMJYUNzXUcX/9GUQ+xjw69voZ58UaOyeCfIn/l9kJ7eL5YtYj+v6Q6weNXSlqf
        MQoLNifIyDezs4gT4Vf4cj7Yq9r217bFr3X+o27Vj9fk11aSOdTjhHO0uBwnqG6cOkUHDt
        y+PWywwNpTgul2FnSgCSISeILzOaL3pEocK14qDFWhmP8smqx35XDxFRSsxccA==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 582D8E0006;
        Wed, 14 Jun 2023 13:50:37 +0000 (UTC)
Date:   Wed, 14 Jun 2023 15:50:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] rtc: isl12022: implement RTC_VL_READ ioctl
Message-ID: <20230614135036a3e049c4@mail.local>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-6-linux@rasmusvillemoes.dk>
 <ZIiJWKBFojAcNCkA@smile.fi.intel.com>
 <20230613212651c8770218@mail.local>
 <ZImvjj34YILrNJU5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZImvjj34YILrNJU5@smile.fi.intel.com>
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

On 14/06/2023 15:16:14+0300, Andy Shevchenko wrote:
> On Tue, Jun 13, 2023 at 11:26:51PM +0200, Alexandre Belloni wrote:
> > On 13/06/2023 18:20:56+0300, Andy Shevchenko wrote:
> > > On Tue, Jun 13, 2023 at 03:00:07PM +0200, Rasmus Villemoes wrote:
> 
> ...
> 
> > > > +		ret = regmap_read(regmap, ISL12022_REG_SR, &val);
> > > > +		if (ret < 0)
> > > 
> > > I always feel uneasy with ' < 0' — Does positive error makes sense?
> > > Is it even possible? OTOH if the entire driver uses this idiom...
> > > oh well, let's make it consistent.
> > 
> > /**
> >  * regmap_read() - Read a value from a single register
> >  *
> >  * @map: Register map to read from
> >  * @reg: Register to be read from
> >  * @val: Pointer to store read value
> >  *
> >  * A value of zero will be returned on success, a negative errno will
> >  * be returned in error cases.
> >  */
> 
> I'm not sure what you meant by this. Yes, I know that there is no
> possibility that regmap API returns positive value. Do you mean that
> regmap API documentation is unclear?

No, I mean that you'd have to be clearer as to why you are uneasy with a
test for a negative value when the function returns 0 for success and a
negative value for an error. Else, this is pure bullying.

> 
> > > > +			return ret;
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
