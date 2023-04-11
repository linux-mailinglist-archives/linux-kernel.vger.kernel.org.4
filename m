Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1C26DDCCF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjDKNuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjDKNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:50:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779D035B3;
        Tue, 11 Apr 2023 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681221020; x=1712757020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JFPGu+gyKqMOZ64dcu+rRARx61M4gkcolxvEsNoV1FM=;
  b=JyB7ksgP40Ym1rsgSvYqJO+sxmqOV2d+2CHw/MDuOfcludv9iTtyo8m0
   MU/DtpqgGsBep9a7EfZTy/0QBUR0gxbrDiiFbnwH9emu0j3RyZ4+vyHuY
   W8+iyAU0JDZYWjNauopCWgtkpWawKaJM3jjG0phkhyoHJecYpn8GbNGXA
   osaOfdc7UZUtVHQX0MU+k37gjUrYvOQWD61nqM7zyeiyBWZHIfFl9nhds
   0L3v15IFxYAgFomlvl7inPbTZ2KOczV4mmiEVFkqor7h97ax0yYU5bo5V
   8OOOWQJoh9tUQeaimNoS6ZD0blDMuLOG6k5ZgOOJ2FGsOEVsNzRgLVcSU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="345403987"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="345403987"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 06:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="721200052"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="721200052"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 11 Apr 2023 06:50:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmENn-00FHll-1U;
        Tue, 11 Apr 2023 16:50:03 +0300
Date:   Tue, 11 Apr 2023 16:50:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 3/3] counter: 104-quad-8: Utilize helper functions to
 handle PR, FLAG and PSC
Message-ID: <ZDVli05x7u/bg7Zc@smile.fi.intel.com>
References: <cover.1681134558.git.william.gray@linaro.org>
 <669c8f782f11fe27c4568e4fc3ba459c4f954874.1681134558.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <669c8f782f11fe27c4568e4fc3ba459c4f954874.1681134558.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:03:13AM -0400, William Breathitt Gray wrote:
> The Preset Register (PR), Flag Register (FLAG), and Filter Clock
> Prescaler (PSC) have common usage patterns. Wrap up such usage into
> dedicated functions to improve code clarity.

...

>  	*val = 0;

Is not needed now as always being initialized by below call.

>  	spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL, &chan->control);
> -
> -	for (i = 0; i < 3; i++)
> -		*val |= (unsigned long)ioread8(&chan->data) << (8 * i);
> +	ioread8_rep(&chan->data, val, 3);
>  
>  	spin_unlock_irqrestore(&priv->lock, irqflags);

...

> +	struct channel_reg __iomem *const chan = priv->reg->channel + id;

Not sure if array representation will look better here and elsewhere.

	struct channel_reg __iomem *const chan = &priv->reg->channel[id];

-- 
With Best Regards,
Andy Shevchenko


