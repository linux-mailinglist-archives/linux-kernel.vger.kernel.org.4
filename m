Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787FE63DA76
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiK3QXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiK3QXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:23:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831F43AE2;
        Wed, 30 Nov 2022 08:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669825392; x=1701361392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hf3CqjgbQVSqURsLVEcOjIfYwu6rzu6lTTAG6MwSyW8=;
  b=nIN6e4zvGwSPBEtnTMGqLlYVHC+GvQuesS1WZBqFIsX+c6+7MqFHZuMG
   FGWNsG586Y7Pz9ddn3FjU8gEBEHm4WcdXiIcOLVBmp5NmlGUohkYiLFuo
   GRlcaui1XE/Fk+WvVS52KfnNgDJpdJPiDUIqVw9+gG5xVq+7zl/yx9CKU
   l+CwRXyg9ekgfjuxzJUGX0L2j8oXHiPS9Ll1c1VE5yoPl3M/A3sAMXxBE
   qV64WeU07003wGqivK2s7h3DW3xCU3sMNzoMTeWD5s0ZoWo6QwbTbfbUk
   8jeLa+QF6tp7QFqziYHj78cR01rPygY8zXJcyCxjGcIo5ed3cUmRExa8H
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="401714824"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="401714824"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 08:22:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707705570"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="707705570"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2022 08:22:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0Pr8-002Lcb-2k;
        Wed, 30 Nov 2022 18:22:42 +0200
Date:   Wed, 30 Nov 2022 18:22:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/3] Documentation: gpio: Add a section on what to
 return in ->get() callback
Message-ID: <Y4eDUnMgYvOEy/nI@smile.fi.intel.com>
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
 <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
 <8a53e88b-1e74-bf34-62a1-780a1b29bcbc@redhat.com>
 <f54df574-2763-5b3e-84a3-debf13777996@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f54df574-2763-5b3e-84a3-debf13777996@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 05:14:38PM +0100, Hans de Goede wrote:
> On 11/30/22 17:12, Hans de Goede wrote:
> > On 11/30/22 16:55, Andy Shevchenko wrote:

...

> > IHMO the rules for get() should simply be:
> > 
> > 1. Device has an input buffer:
> >    Return input-buffer value for the pin.
> > 
> > 2. Devices does not have an input buffer:
> >    Return last set output-buffer value
> 
> Quick correction device should be pin here, because it
> if there is an input buffer or not can differ per pin.
> So IHMO the rules for get() should simply be:
> 
> 1. pin has an input buffer:
>    return input-buffer value for the pin.
> 
> 2. pin does not have an input buffer:
>    return the value last set for the pin's output-buffer

"pin" misleads here. The "pin" can be in native function which may have not be
even connected to GPIO buffers. There are different hardware topologies.

So, no, not a "pin".

-- 
With Best Regards,
Andy Shevchenko


