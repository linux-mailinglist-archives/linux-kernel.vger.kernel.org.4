Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541C76E4583
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDQKqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDQKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:46:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFED49DD;
        Mon, 17 Apr 2023 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681728309; x=1713264309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q0LVjKHHmuRFdXP0gH1A8hWP0FnpGL5CdzUawYKr0oI=;
  b=Lj9NEl1/XaADKEMIENvl+tUwF2XAJKszIlIsMZHyZ/VtsfR7HvQewVjx
   gWMcK7CrgK1vdjMUyZIlco0Hcv+P2VoPcK/L1ZPKT7iDKPGrR+uNS+bow
   WSaUNLIxkJIFi3iS9IukI0pCHkSqiQVBjcChfJdQrXE0alR3T23MbWsVv
   sfBW7T2Wf3J/Ee/a+Srx+6QpZy16ImE/9CTk74/AnNXjmpF613lNpT4fj
   jBGdrRfkmFwnd7W99pJgqGhEXKF8tswwBDcxkx3nOEhQcYezcJT0J7YV4
   C5amkMeLNV14DRYV+dVmpigkZAHppNMG9LruzGav6o7uDvhl5bxgVbdjR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="342352606"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="342352606"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 03:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="759909509"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="759909509"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 Apr 2023 03:43:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1poMKQ-0012vq-0a;
        Mon, 17 Apr 2023 13:43:22 +0300
Date:   Mon, 17 Apr 2023 13:43:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v6 2/5] spi: dw: Move "dw_spi_can_dma" function
Message-ID: <ZD0iycNg4i6sYO48@smile.fi.intel.com>
References: <20230414120520.360291-1-joychakr@google.com>
 <20230414120520.360291-3-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414120520.360291-3-joychakr@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 12:05:17PM +0000, Joy Chakraborty wrote:
> Move "dw_spi_can_dma" function implementation below
> "dw_spi_dma_convert_width" function for handing compile dependency in
> future patches.

We refer to the functions like func().

...

> +static bool dw_spi_can_dma(struct spi_controller *master,
> +			   struct spi_device *spi, struct spi_transfer *xfer)
> +{
> +	struct dw_spi *dws = spi_controller_get_devdata(master);
> +
> +	return xfer->len > dws->fifo_len;
> +}

> +
> +

Single blank line is enough.

-- 
With Best Regards,
Andy Shevchenko


