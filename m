Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9272CC21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjFLRNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjFLRNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:13:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F54188;
        Mon, 12 Jun 2023 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686590016; x=1718126016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0IhzFlc0JSqsC8g90Ed8ErIHbGi6v7rirVUCLlYWgTI=;
  b=kd0p6GilJH70mqsdst+DgKhzTlwTO/vveuLVPVy+dYef0DGZAZtYU4wA
   LEFkDn/2D4xgcJAUGFt+53yqep1+DwBelEkVQaYmQjox4jFAuTVzeS1cp
   omG4WYaEbZX9c/N6/IMH+8INGeHAwyG1cOiFNtQ3QHP5clKGh3VlKVH2x
   9XIYPjTNVkfZyld6F3wpi1ViqohHC3EOF/ORja5bkfKsqi/TiKu7lUnpC
   wJtsixCf0WsouvlIgqEqrqdF4wXrEFlpWgbZFVfOsD0cEqTsS80aC9gnV
   NLH9UASy+H196T6C9RGGlw9+jsiPZ+BYKAjG8O8yffla4AtvRkcMMjI+f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="360590940"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="360590940"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 10:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="688714744"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="688714744"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 12 Jun 2023 10:13:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8l6h-003Ai5-0z;
        Mon, 12 Jun 2023 20:13:31 +0300
Date:   Mon, 12 Jun 2023 20:13:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZIdSO7MGk3K/R2u1@smile.fi.intel.com>
References: <cover.1686578553.git.mehdi.djait.k@gmail.com>
 <3a41a5ae9857cacdb062c398715a5938ccd47014.1686578554.git.mehdi.djait.k@gmail.com>
 <ZIc/uvB1zxNRnuRS@smile.fi.intel.com>
 <ZIdIev+evQUvX5Rg@carbian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIdIev+evQUvX5Rg@carbian>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 06:31:54PM +0200, Mehdi Djait wrote:
> On Mon, Jun 12, 2023 at 06:54:34PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 12, 2023 at 04:22:08PM +0200, Mehdi Djait wrote:

...

> > >  struct kx022a_data {
> > > +	const struct kx022a_chip_info *chip_info;
> > >  	struct regmap *regmap;
> > 
> > I would suggest to run bloat-o-meter with this version and if you place
> > chip_info after regmap. Does it gain us some memory?
> 
> I used the bloat-o-meter on the two .ko files (this version and the the
> one where chip_info after regamp) Is this what you asked for ?

Yes. I assume the old one is the current as in this patch?
If so, you know what to do in the next version :-)

> add/remove: 0/0 grow/shrink: 0/5 up/down: 0/-20 (-20)
> Function                                     old     new   delta
> kx132_get_fifo_bytes                         148     144      -4
> kx022a_trigger_set_state                     352     348      -4
> kx022a_read_raw                              380     376      -4
> kx022a_buffer_predisable                     248     244      -4
> kx022a_buffer_postenable                     296     292      -4
> Total: Before=11244, After=11224, chg -0.18%

-- 
With Best Regards,
Andy Shevchenko


