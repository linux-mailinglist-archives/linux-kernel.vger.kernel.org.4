Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00F372CAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbjFLP64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbjFLP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:58:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C58DB;
        Mon, 12 Jun 2023 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585529; x=1718121529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I+xvNGPtJIDx2cMGugui7TU2yLN8SR4xN9XtnWHCLXc=;
  b=UwKg7TDs1kckc5bOUdbJkstrVK+urF7A3idCsNYtkL7Pxi9Zb4DCs2n5
   1Fr7Ge5IXRAvbXcMDiktePWGGgx5WFpC3qiUiry8s9XFo3TEOzTxpALV+
   R63hVcgNkgDDMnJmnzJIPDkYb5WaT9POaJGLj85AicuYufiqZ5VXaW9DZ
   y93cuzh5JQo07etLvX/06P3szJ/Udt0CUUgY3/6z3W4UPcQYVsCTQ3lDH
   OSOliSUswbaaZ2wSfWCCn0bKETkTbzx4zj+lHs2JJoeSrDa4gjo4HQQZR
   QET1U79u3SwDCLI5usvtspYBydsgFZ0xRlNAElB92XCPKT967ET8XsZK8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="423965613"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="423965613"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="705454504"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="705454504"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2023 08:58:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8jwK-0039Y2-0D;
        Mon, 12 Jun 2023 18:58:44 +0300
Date:   Mon, 12 Jun 2023 18:58:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 7/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <ZIdAs75zaw765wWC@smile.fi.intel.com>
References: <cover.1686578553.git.mehdi.djait.k@gmail.com>
 <893fc0470dd9ffa1476af2b7ae1219d51a95c223.1686578554.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <893fc0470dd9ffa1476af2b7ae1219d51a95c223.1686578554.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:22:10PM +0200, Mehdi Djait wrote:
> Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
> ranges from ±2G to ±16G, digital output through I²C/SPI.
> Add support for basic accelerometer features such as reading acceleration
> via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.

...

>  	help
> -	  Enable support for the Kionix KX022A digital tri-axis
> -	  accelerometer connected to I2C interface.
> +	  Enable support for the Kionix KX022A, KX132-1211 digital tri-axis
> +	  accelerometers connected to SPI interface.

Usually for sake of the smalle churn in the future this can be redone as

	  Enable support for the following digital tri-axis
	  accelerometers connected to SPI interface:
	    - Kionix KX022A
	    - Kionix KX132-1211

...

>  	help
> -	  Enable support for the Kionix KX022A digital tri-axis
> -	  accelerometer connected to I2C interface.
> +	  Enable support for the Kionix KX022A, KX132-1211 digital tri-axis
> +	  accelerometers connected to I2C interface.

Ditto.

-- 
With Best Regards,
Andy Shevchenko


