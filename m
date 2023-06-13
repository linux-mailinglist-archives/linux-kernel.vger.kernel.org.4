Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F6172E6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbjFMPVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjFMPVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:21:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A794199A;
        Tue, 13 Jun 2023 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686669662; x=1718205662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=plNmqEkqncOE/3uGn703aXGX7ZUQBL5FWEgWSiyApfI=;
  b=O0dpH6xIz/XCyfM3PxwfCzMhuFzKOIPErkS8ijCMMZeCHP1O5ZoQAnYN
   Lyy+bjVUo/mrhFKqtIcZGLeXYZxvBzbcSDbPx2MC11HdFcjiYrZZjNIg4
   RNvQzcmPqdqvAUSIHCmjZjy6UAQaBro5ngPqFHeE/CpwUmwgIN937Clb+
   IdVwnC6JjE+x/LrBLU2ZVMTJVCV+CL0Su0z4ZgNqbqdXQ30JdNJvS8Xe+
   CGGVpn9jZoHAnGVMdU+vDP0951MOHLxenzXmOqEwkN8byyU3fsx0Hw3ZY
   9f6niiNWiq8fajeJwVYj5kIxrB5z5qkZa57rnJXfwepAbF8uXoRbOk+/F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348021136"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="348021136"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 08:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711699337"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="711699337"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 08:20:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q95pI-003UAE-1G;
        Tue, 13 Jun 2023 18:20:56 +0300
Date:   Tue, 13 Jun 2023 18:20:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] rtc: isl12022: implement RTC_VL_READ ioctl
Message-ID: <ZIiJWKBFojAcNCkA@smile.fi.intel.com>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-6-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230613130011.305589-6-linux@rasmusvillemoes.dk>
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

On Tue, Jun 13, 2023 at 03:00:07PM +0200, Rasmus Villemoes wrote:
> Hook up support for reading the values of the SR_LBAT85 and SR_LBAT75
> bits. Translate the former to "battery low", and the latter to
> "battery empty or not-present".

A couple of nit-picks below.

...

> +static int isl12022_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> +{
> +	struct regmap *regmap = dev_get_drvdata(dev);
> +	u32 user = 0, val;

This assignment can be done in the actual case below.

> +	int ret;
> +
> +	switch (cmd) {
> +	case RTC_VL_READ:
> +		ret = regmap_read(regmap, ISL12022_REG_SR, &val);
> +		if (ret < 0)

I always feel uneasy with ' < 0' — Does positive error makes sense?
Is it even possible? OTOH if the entire driver uses this idiom...
oh well, let's make it consistent.

> +			return ret;

		user = 0;

The rationale to avoid potential mistakes in the future in case this function
will be expanded and user will be re-used.

> +		if (val & ISL12022_SR_LBAT85)
> +			user |= RTC_VL_BACKUP_LOW;
> +
> +		if (val & ISL12022_SR_LBAT75)
> +			user |= RTC_VL_BACKUP_EMPTY;
> +
> +		return put_user(user, (u32 __user *)arg);
> +
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


