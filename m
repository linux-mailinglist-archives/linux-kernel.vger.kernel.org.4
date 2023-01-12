Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BFD667ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjALQ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjALQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:25:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F3B479C1;
        Thu, 12 Jan 2023 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673540551; x=1705076551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b1y0t5i31C9uBnIOZ8Em+IhwTn+G8oRmBT8YWgv/OBQ=;
  b=VGnlRUe/j6FpiGPeMUuIWarb0AF44BS9cdum+DL2xX9uWYE73Pe3bXr9
   YvogKh4yWKVyiWP1Hmb/HPCvLssTYviWyb65rNBK6QnQHLNjGWjS3dLLJ
   349xd30ApLWBvDAGnfUDCyFCSmSxvFVgOadmvP/kTpq7k4QfCG9WtorlE
   NZjuPPm9wWYcoVuoVLVuAl2Y9qDan1HbkBtqavc4tW3f1Z4oICiGZwc7e
   5n4hYnvQ4WJlnCx6njFNDbQB9+X+/LdCxKDL7gYyg8HqOGGB6D6vFEu5A
   vdFxWskMQIrEn8ZLn6T/T7LS+2J4v0/OIcH6dGN22lb8X3opr77By24vJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388239573"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="388239573"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="688381595"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="688381595"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2023 08:22:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pG0LS-0088hY-0Z;
        Thu, 12 Jan 2023 18:22:26 +0200
Date:   Thu, 12 Jan 2023 18:22:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: of: Move enum of_gpio_flags to its only
 user
Message-ID: <Y8AzwdCGr4VFjP5X@smile.fi.intel.com>
References: <20230112145140.67573-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112145140.67573-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 04:51:40PM +0200, Andy Shevchenko wrote:
> GPIO library for OF is the only user for enum of_gpio_flags.
> Move it there.

...

> +/*
> + * This is Linux-specific flags. By default controllers' and Linux' mapping
> + * match, but GPIO controllers are free to translate their own flags to
> + * Linux-specific in their .xlate callback. Though, 1:1 mapping is recommended.
> + */

Now that I re-read the comment, I think this can be postponed until we get a
consensus that no new driver is ever should do non 1:1 mapping.

If that consensus achieved, we may drop this enum altogether and replace it
with the generic flags..

-- 
With Best Regards,
Andy Shevchenko


