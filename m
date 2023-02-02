Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D0E687EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjBBNax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBBNaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:30:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF6211B;
        Thu,  2 Feb 2023 05:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675344651; x=1706880651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ko6eIKDR7GQnGfkJ9453bCB4FUln9M60/sS1sBmialE=;
  b=dnFZu2pWKbPJm147HmVVAoGTWUf+IdvFRH8rWHK1yPcvSmx50cWtt0Dp
   4ioyr+dFV/yK/HPm81rMamPvvddRwjlBMGvSnRWg+IDsRYc/6ZoSHy3n+
   6Qjoq3OWQnOiwWCV3hGDchGeHntIht6KipCqbBajhV3oVRsoy5P/LcUyX
   5D8ZnpSIiIVUSb38JkW2Se804JVScGMkPk9mMYjiTYSck/LDBZHsNLfs+
   j+h1zjEu2FzzfYdnLVCPbFR8LcgNf4d7EjJ1ZuDoEWpru/0yc+dYxjJhX
   jG9xIWVcgL0+q2qU97noSE6M3pyZ2gT+REqkiM8r0bkZvSZNzZWVuXz4l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308094351"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="308094351"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 05:30:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665282268"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="665282268"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2023 05:30:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pNZfo-001Bo3-03;
        Thu, 02 Feb 2023 15:30:44 +0200
Date:   Thu, 2 Feb 2023 15:30:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Message-ID: <Y9u7A096Tbe1Cj9d@smile.fi.intel.com>
References: <20230201103534.108136-1-okan.sahin@analog.com>
 <20230201103534.108136-3-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201103534.108136-3-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:35:15PM +0300, Okan Sahin wrote:
> Regulator driver for both MAX77541 and MAX77540.
> The MAX77541 is a high-efficiency step-down converter
> with two 3A switching phases for single-cell Li+ battery
> and 5VDC systems.
> 
> The MAX77540 is a high-efficiency step-down converter
> with two 3A switching phases.

...

With

> +	struct device *dev = &pdev->dev;

to be here the following can be shortened

> +	struct max77541 *max77541 = dev_get_drvdata(pdev->dev.parent);

	struct max77541 *max77541 = dev_get_drvdata(dev->parent);

> +	struct regulator_config config = {};
> +	const struct regulator_desc *desc;
> +	struct device *dev = &pdev->dev;
> +	struct regulator_dev *rdev;
> +	int i;

> +	config.dev = pdev->dev.parent;

	config.dev = dev->parent;

...

> +static const struct platform_device_id max77541_regulator_platform_id[] = {
> +	{ "max77540-regulator", },
> +	{ "max77541-regulator", },

Inner commas are not required.

> +	{  /* sentinel */  }
> +};

-- 
With Best Regards,
Andy Shevchenko


