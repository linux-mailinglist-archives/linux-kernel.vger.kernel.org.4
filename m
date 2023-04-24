Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B786ECE92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjDXNdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjDXNdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:33:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C883C5;
        Mon, 24 Apr 2023 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682343180; x=1713879180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wc9Cm7TyT7ueaYYlMnAYMYWhzj+Qq3M8FGuFj9g27Nc=;
  b=miBVIvWjLflJzF1WL54sB/iGy3CbFAAZGjVXqxwtEmEyoGrVOA9AkHhh
   DYfmLf0ua/a4eh9qgezPI6YcAmkPCITzpWnf8Ws+5H/p/FdHi4LhZfspw
   I+DdG+QQr5Bf0CbU/cQuOQ8e1dsuURtgWo/VjIAv4OfxCduqkswEVwQ4V
   9mfb1e1JnEK6WCDk19qgKUfC/sUDIa8t0QPl54eoPdoOqhgO2zchT933j
   GZX6ZtThPi4J7fx+miPnm0DUbZr01VkyAXaGHrADQo8+lwvTzAsWsgt56
   FpKfXYhvxakEummxcZQ9ICMqrcy4TWbYrF+JdjYsIeEVW1pafJBCZD8rh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="326060756"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="326060756"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 06:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="725696135"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="725696135"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2023 06:31:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pqwI7-004XBP-2P;
        Mon, 24 Apr 2023 16:31:39 +0300
Date:   Mon, 24 Apr 2023 16:31:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yan Wang <rk.code@outlook.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] gpio: mmio: restroe get multiple gpio mask
Message-ID: <ZEaEu7Yxd+E53sth@smile.fi.intel.com>
References: <KL1PR01MB544800D7E51C9209A9BD998BE6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1PR01MB544800D7E51C9209A9BD998BE6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 05:06:48PM +0800, Yan Wang wrote:
> Simplify the code,should not modify its logic.

> Fixes: 761b5c30c206 ("gpio: mmio: replace open-coded for_each_set_bit()")

What does it fix?

...

>  	for_each_set_bit(i, mask, gc->bgpio_bits) {
> -		if (test_bit(i, bits))
> -			*set_mask |= bgpio_line2mask(gc, i);
> -		else
> -			*clear_mask |= bgpio_line2mask(gc, i);
> +		if (*mask == 0)
> +			break;

Huh?!

We never enter here if mask is 0. So, do not add a dead code, please.

Moreover, in principle mask can be longer than 1 long, this code simply wrong.

NAK

> +		if (__test_and_clear_bit(i, mask)) {
> +			if (test_bit(i, bits))
> +				*set_mask |= bgpio_line2mask(gc, i);
> +			else
> +				*clear_mask |= bgpio_line2mask(gc, i);
> +		}
>  	}

-- 
With Best Regards,
Andy Shevchenko


