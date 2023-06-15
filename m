Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D478731602
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbjFOLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjFOLCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:02:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E7A26B0;
        Thu, 15 Jun 2023 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686826972; x=1718362972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MBLj8x0pRXz038lDkYp8kRv2ihJQQ6S7caV9Fgu/Y24=;
  b=dHJLoXHvKtIE8IgR5fW1ZQVt7aKwrkFpmSPFCqB1WJ/Quq+lCDSIbmdD
   UY00IMBTi5WMO4xo2SaaoaQoYYUKfYuL3ojI1vxajq1fNPH59Mkt0dVQ2
   96sdO9doJ5gzEnOW9jsiZJCIO6wWIsgPgI4yhXQp6CeQQnlNnMTXoZVar
   p3yNSNWQNr5a8nU/SMSanWVvy0SoI5EwUoyDSDWL19kZN9chvnmkYU4Ne
   Z+FHKIlxnZEeR1eHNftH9Ew+fRa7FKVRb12JoTgRz3zrgpU0ttebwvS5W
   cXqDI0iTVdPyHODfcqefC+9Tswbo0bzjq2MmjCpScacql7KpVAcbIK/6E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="422484953"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="422484953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 04:02:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="742194043"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="742194043"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2023 04:02:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9kkZ-003vKs-0O;
        Thu, 15 Jun 2023 14:02:47 +0300
Date:   Thu, 15 Jun 2023 14:02:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pinctrl: mcp23s08: check return value of
 devm_kasprintf()
Message-ID: <ZIrv1q3XJ32BxMCL@smile.fi.intel.com>
References: <20230615105333.585304-1-claudiu.beznea@microchip.com>
 <20230615105333.585304-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615105333.585304-2-claudiu.beznea@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:53:31PM +0300, Claudiu Beznea wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).

Not that this may happen, but okay.

...

> @@ -119,6 +119,9 @@ static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
>  		return -EINVAL;
>  	}
>  
> +	if (!name || !mcp->chip.label)
> +		return -ENOMEM;

I prefer to see 4 independent checks for each of the devm_kasprintf() calls.

-- 
With Best Regards,
Andy Shevchenko


