Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFC472CAA0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbjFLPtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjFLPsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:48:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C647CA;
        Mon, 12 Jun 2023 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686584934; x=1718120934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W2HNM/FeZheU8WV1c9liGFrJzpMAfIbGq2q6Q46HIms=;
  b=nIUGiu9fkdYw8jEnSTdxSRQpgyRhll5VgBlFR2G3LKeZDKkKC5gIYNG4
   tt6wpKb73QZpK1xr6oswMQJ/FZDBLMyHHuFo7t/7mEd/0CjQTdm0MANb9
   2lTkJ5CWWxBhM+jqhFZ/RLOGt9aeh0aUYKF4BOsgHevcA5bhofNm1v3xz
   kc3lLKK3++eN0+XkKhLth0xm8YbBRWDrg30YFZNzR9oZlxpKJY6041RoI
   72c0QPgbuK+q33Um7mOf4MN8e7i1vHl22hRKcBh1NvigoWu8PzzMAu5YZ
   gz0Ht05689vNzOjHQ77Tf3yfOO/jcXFUguubmza1BLEr9u+jbjDGXwNBr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="347735363"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="347735363"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:48:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="741076865"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="741076865"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2023 08:48:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8jmj-0039RP-1V;
        Mon, 12 Jun 2023 18:48:49 +0300
Date:   Mon, 12 Jun 2023 18:48:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] rtc: isl12022: implement RTC_VL_READ and RTC_VL_CLR
 ioctls
Message-ID: <ZIc+YdUPIAt6L4fi@smile.fi.intel.com>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-6-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612113059.247275-6-linux@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 01:30:55PM +0200, Rasmus Villemoes wrote:
> Hook up support for reading the values of the SR_LBAT85 and SR_LBAT75
> bits. Translate the former to "battery low", and the latter to
> "battery empty or not-present".

...

> +static int isl12022_read_sr(struct regmap *regmap)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read(regmap, ISL12022_REG_SR, &val);
> +	if (ret < 0)
> +		return ret;
> +	return val;

Wondering if the bit 31 is in use with this register (note, I haven't checked
the register width nor datasheet).

> +}

-- 
With Best Regards,
Andy Shevchenko


