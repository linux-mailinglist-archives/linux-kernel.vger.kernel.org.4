Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C56B7A12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCMOPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjCMOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:14:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A13E303CE;
        Mon, 13 Mar 2023 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678716865; x=1710252865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eowD8jaWUY++CZ3PEvc8pljfPucTh1HLbxPsran3B84=;
  b=Dm8NEjWa/fSGXjKr5Dca3b8FODARxNIb7X7MTClWdWpKOplugRWWw0cY
   WyPNDFC4RnnhyMM/urdkDCjem9dBdfgRgJTtH9T8La6LRkkMzhGFrRmyE
   3iUoSBnDX4DIIPxnBAMy57FQ2XmjZQ9WyYdWtBwVZIIjiQUUT/Fzm/8Ku
   36E5Z6qvi0BrB58ELBla0RPMzl7jrZetEf4Oo4tg9AyWfwuNJa9fra4G1
   YFEjOYVLvgNu+RjMSOlSo560mTgIahnvks/1A4lvpwPkvK2i+36MRQY64
   x9IuYvnCEmmzu0EreUf70rECERqGomtwlhhXsR3P1QM9+xz+PtyZ3TSEQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317541141"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="317541141"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 07:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="852792752"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="852792752"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2023 07:11:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pbito-002fJG-2K;
        Mon, 13 Mar 2023 16:11:40 +0200
Date:   Mon, 13 Mar 2023 16:11:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Leonard, Niall" <Niall.Leonard@ncr.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] gpio: mmio: Use new flag BGPIOF_NO_INPUT.
Message-ID: <ZA8vHLozhRrYRrER@smile.fi.intel.com>
References: <20230126-gpio-mmio-fix-v2-0-38397aace340@ncr.com>
 <20230126-gpio-mmio-fix-v2-2-38397aace340@ncr.com>
 <Y+jds9U1PgYpXBHT@smile.fi.intel.com>
 <ace51cc4-aa77-7ac0-b83f-12057a9bbae6@ncr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace51cc4-aa77-7ac0-b83f-12057a9bbae6@ncr.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 01:56:24PM +0000, Leonard, Niall wrote:
> On 12/02/2023 12:38, Andy Shevchenko wrote:
> > On Tue, Jan 31, 2023 at 01:49:38PM +0000, Niall Leonard wrote:
> >> Add new flag BGPIOF_NO_INPUT to header file.
> >> Use the existing shadow data register 'bgpio_data' to allow
> >> the last written value to be returned by the read operation
> >> when BGPIOF_NO_INPUT flag is set.
> >> Ensure this change only applies to the specific binding "wd,mbl-gpio".
> > 
> > I'm wondering why do we need that.
> > 
> > I mean the reading back the (possible cached) output value is the right thing
> > to do by default for GPIO (in output mode) or GPO. So, instead you can simply
> > check the current direction of the pin and return (cached) value.
> > 
> > Or did I miss something?
> > 
> My thinking here was that I don't want to break any existing code which 
> relies on the read always reading the physical port.
> I'm going to rethink my approach here as I'm starting to think the 
> better approach would be to modify the gpio-74xx-mmio.c driver to cater 
> for this hardware.

That's why we need a greatest denominator here, right?

Currently we have a full inconsistency on how drivers are implementing
all this. What I'm suggesting is to always have the following:
1) if pin is input or OS/OD/OE/OC -- read input buffer;
2) if pin is output, always read (cached) value.

Yes, there is an opinion to find a short circuit by reading input in
the output mode, but I consider that impractical complication.

Note, that above will also satisfy all (common) hardware limitations.

-- 
With Best Regards,
Andy Shevchenko


