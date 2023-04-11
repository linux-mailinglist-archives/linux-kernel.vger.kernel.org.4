Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A4D6DDE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDKOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjDKOht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:37:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71452100;
        Tue, 11 Apr 2023 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681223855; x=1712759855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fPtmDzX4bkCD1h/FIx2OlULjDZBI3uztavNwtzp0d9s=;
  b=T+Jz3JApzXeckpYeA1WmpuokrJyOFkwev3mXd1FwzfFHdoi7V1ASD+Fq
   5un7ICFgsEoOGpJ5zHNbkAlrXI0AKxBl/SimhI7umRMDYLdYPc2LCJoRj
   5JokNGbsuT6lnvp3A/1EIT1RMOBggHMutCpY0owTxLrzU0hFjbTKMxyFF
   J3z3ge7M5tKoxd0CHEDoqSIdIFXSXH5NOymRJH7NbJWef+XoVD6wEWAOK
   11yw+cgi2NzVSWCpznIzFqc4KsSpYCUQX2hi09CBpGqlikhyy67cg3qKF
   O+OIW1O1QMIpGdZ9ASHsoSdTj8SiBCuUUGOI/ySVLxzKkgXkDfa1uby+x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343635961"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343635961"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 07:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="666000024"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="666000024"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2023 07:37:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmF7k-00FK4v-1Y;
        Tue, 11 Apr 2023 17:37:32 +0300
Date:   Tue, 11 Apr 2023 17:37:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: 104-quad-8: Migrate to the regmap API
Message-ID: <ZDVwrEZh1y88Hw8b@smile.fi.intel.com>
References: <20230410141252.143998-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410141252.143998-1-william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:12:52AM -0400, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.

Looking at the statistics it's a bit unfortunate that LoCs are risen,
perhaps you can add more points why regmap is better than direct IO
accessors.

...

> +	int state;

state...

> +	state = regmap_test_bits(priv->map, QUAD8_INDEX_INPUT_LEVELS, BIT(signal->id - 16));
> +	if (state < 0)
> +		return state;

...

> +	int ret;

ret...

> +	ret = regmap_write(priv->map, QUAD8_CONTROL(count->id),
> +			   SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL);
> +	if (ret)
> +		goto exit_unlock;

...

> +	int err;

err...

> +	err = regmap_write(priv->map, QUAD8_CONTROL(id), SELECT_RLD | RESET_BP);
> +	if (err)
> +		return err;

...

Maybe a bit of consistency?


...

> +	int err;
> +	unsigned int status;
>  	unsigned long irq_status;
>  	unsigned long channel;
>  	unsigned int flg_pins;
>  	u8 event;

Perhaps longer lines first? Hence

	int ret;

to be here.

-- 
With Best Regards,
Andy Shevchenko


