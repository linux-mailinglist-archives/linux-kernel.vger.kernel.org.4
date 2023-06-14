Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C4D730331
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbjFNPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbjFNPOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:14:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCDF2107;
        Wed, 14 Jun 2023 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686755639; x=1718291639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MmppHhausc57QaDzWWA+gNGrwmT8VwlTPcsgP+wDNds=;
  b=EPB4Qf9H6YZ4tk+JgNNcrXqVDzjY7JF91kF67YLUKuF0CQfR8bse0e+d
   mJMPrvxkr6/nR6hjp8fNPbQSBtmhpiJ/JK2uOCrze/Jivkd1JCPvBoCey
   xqneGYZkyOptC+ggRmO+NiWPmuGPgLWwtmz4jKWyWUCxEK+Ax4gp66FIN
   2OyVBSvqGMW76+IBQ/riZp7hT8pF+MQDa6OngVmi6mge4vUtS3b4wB499
   Y2+9/WyHRc6qV32BjVeb56rwUy1TpdY7y3Ls1zJKOf7qMCuvGkPUa7kRe
   uQR/FdcE/b7Pq0NPALutYr/2hTp00NWHZSdS0CyZQu6YHRy73GbzUyT4M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="348301625"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="348301625"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 08:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="886272995"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="886272995"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2023 08:13:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9SC0-003j7Z-2q;
        Wed, 14 Jun 2023 18:13:52 +0300
Date:   Wed, 14 Jun 2023 18:13:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] rtc: isl12022: implement RTC_VL_READ ioctl
Message-ID: <ZInZMEZBZ8Dm2jem@smile.fi.intel.com>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-6-linux@rasmusvillemoes.dk>
 <ZIiJWKBFojAcNCkA@smile.fi.intel.com>
 <20230613212651c8770218@mail.local>
 <ZImvjj34YILrNJU5@smile.fi.intel.com>
 <20230614135036a3e049c4@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230614135036a3e049c4@mail.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 03:50:36PM +0200, Alexandre Belloni wrote:
> On 14/06/2023 15:16:14+0300, Andy Shevchenko wrote:
> > On Tue, Jun 13, 2023 at 11:26:51PM +0200, Alexandre Belloni wrote:
> > > On 13/06/2023 18:20:56+0300, Andy Shevchenko wrote:
> > > > On Tue, Jun 13, 2023 at 03:00:07PM +0200, Rasmus Villemoes wrote:

...

> > > > > +		ret = regmap_read(regmap, ISL12022_REG_SR, &val);
> > > > > +		if (ret < 0)
> > > > 
> > > > I always feel uneasy with ' < 0' — Does positive error makes sense?
> > > > Is it even possible? OTOH if the entire driver uses this idiom...
> > > > oh well, let's make it consistent.
> > > 
> > > /**
> > >  * regmap_read() - Read a value from a single register
> > >  *
> > >  * @map: Register map to read from
> > >  * @reg: Register to be read from
> > >  * @val: Pointer to store read value
> > >  *
> > >  * A value of zero will be returned on success, a negative errno will
> > >  * be returned in error cases.
> > >  */
> > 
> > I'm not sure what you meant by this. Yes, I know that there is no
> > possibility that regmap API returns positive value. Do you mean that
> > regmap API documentation is unclear?
> 
> No, I mean that you'd have to be clearer as to why you are uneasy with a
> test for a negative value when the function returns 0 for success and a
> negative value for an error. Else, this is pure bullying.

From the perspective of the code reader, a person, who might have not known all
the implementation details of the calls this kind of check will always puzzle
about positive value.

When reading such a code the following questions are arisen:
1) Can the positive return value be the case?
2) If so, what is the meaning of a such?
3) Why do we not care about it?

All this can simply gone if we use

	ret = foo(...);
	if (ret)
		return ret;

As it's clear that whatever is non-zero we accept as something to be promoted
to the upper layer. I hope this explains my position.

> > > > > +			return ret;

-- 
With Best Regards,
Andy Shevchenko


