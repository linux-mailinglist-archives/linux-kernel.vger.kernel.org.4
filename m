Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB92F6AC33A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCFO3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCFO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:29:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8946A23337;
        Mon,  6 Mar 2023 06:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678112937; x=1709648937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U3J1RII/pyIAAeKO5LkrYUzx+agFkzmu3CeVXBbAtzk=;
  b=Pvzb+wTEMKx+H2JgOp5I/Krx/9i+Px/bMa7HICe15dlzyRnp4+dv1aNF
   bnsuoZJ+jcRqGKNgK7tBd2x3/Vgh3W3YyBxjtbvuQiKxeQN9Y/fBFnG/t
   +fjEYCc9elIkGBx/tnR3tad5d4PlvN+rHDimtUmW5Mb9gcSmQTNS8TY17
   xO4g4WyQYKNSOTmsLsNwUV/iwKkmpq1Fj1HIJrSUa1hrrtqL2A8ZNFNEW
   4SbI4UNLR8i/tQN1ZmOBmqhdIuMk2yBwSaZlLe9yHve2UN9sSkomNivsB
   yGm2SsWCzcDJh6709TPQyKsxJU4oyufXn7hfsQ1zJZUgV/tFQyThyi2Cj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363182689"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="363182689"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 06:24:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="653629993"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="653629993"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 06 Mar 2023 06:24:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZBlO-00GTRi-3B;
        Mon, 06 Mar 2023 16:24:30 +0200
Date:   Mon, 6 Mar 2023 16:24:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, Arnaud de Turckheim <quarium@gmail.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: Re: [PATCH v4 2/3] gpio: pcie-idio-24: Migrate to the regmap API
Message-ID: <ZAX3ntGgO4PjIkxx@smile.fi.intel.com>
References: <cover.1678106722.git.william.gray@linaro.org>
 <b96429c66e7caca05d9fb93805e11650fdbad312.1678106722.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b96429c66e7caca05d9fb93805e11650fdbad312.1678106722.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 07:59:52AM -0500, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> For the PCIe-IDIO-24 series of devices, the following BARs are
> available:
> 
>     BAR[0]: memory mapped PEX8311
>     BAR[1]: I/O mapped PEX8311
>     BAR[2]: I/O mapped card registers
> 
> There are 24 FET Output lines, 24 Isolated Input lines, and 8 TTL/CMOS
> lines (which may be configured for either output or input). The GPIO
> lines are exposed by the following card registers:
> 
>     Base +0x0-0x2 (Read/Write): FET Outputs
>     Base +0xB (Read/Write): TTL/CMOS
>     Base +0x4-0x6 (Read): Isolated Inputs
>     Base +0x7 (Read): TTL/CMOS
> 
> In order for the device to support interrupts, the PLX PEX8311 internal
> PCI wire interrupt and local interrupt input must first be enabled.
> 
> The following card registers for Change-Of-State may be used:
> 
>     Base +0x8-0xA (Read): COS Status Inputs
>     Base +0x8-0xA (Write): COS Clear Inputs
>     Base +0xB (Read): COS Status TTL/CMOS
>     Base +0xB (Write): COS Clear TTL/CMOS
>     Base +0xE (Read/Write): COS Enable
> 
> The COS Enable register is used to enable/disable interrupts and
> configure the interrupt levels; each bit maps to a group of eight inputs
> as described below:
> 
>     Bit 0: IRQ EN Rising Edge IN0-7
>     Bit 1: IRQ EN Rising Edge IN8-15
>     Bit 2: IRQ EN Rising Edge IN16-23
>     Bit 3: IRQ EN Rising Edge TTL0-7
>     Bit 4: IRQ EN Falling Edge IN0-7
>     Bit 5: IRQ EN Falling Edge IN8-15
>     Bit 6: IRQ EN Falling Edge IN16-23
>     Bit 7: IRQ EN Falling Edge TTL0-7
> 
> An interrupt is asserted when a change-of-state matching the interrupt
> level configuration respective for a particular group of eight inputs
> with enabled COS is detected.
> 
> The COS Status registers may be read to determine which inputs have
> changed; if interrupts were enabled, an IRQ will be generated for the
> set bits in these registers. Writing the value read from the COS Status
> register back to the respective COS Clear register will clear just those
> interrupts.

...

>  - Add mutex to prevent clobbering the COS_ENABLE register when masking
>    IRQ and setting their type configuration

But this doesn't explain killing the raw spin lock.

I don't understand how is it suppose to work then.

What is this lock for and how IRQ related registers can be updated
with RT type of kernel?

If mutex is okay, doesn't mean we have to add 'can_sleep = true'?

-- 
With Best Regards,
Andy Shevchenko


