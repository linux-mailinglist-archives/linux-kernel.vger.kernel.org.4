Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5B15F6B58
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiJFQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiJFQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:18:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB24E88A09;
        Thu,  6 Oct 2022 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665073102; x=1696609102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IS9/8GZEIZjGTZSUozDDT7Qbp2bCtL4B2ZSEaLpZNYA=;
  b=Gnc+f/P7Wf3CK9GcO9dlvPNZmDYj+p6M5oK1IJL3n/l5M2BZ+KsGa1Aw
   ZsZloP6fxCg5C2PiyrAQ9vb7DQm4G5HuOA/9Cb1hxm3xbu/+VGF1v/E3b
   BHZpMGpe5u4U3edJxyiresKjgdNakpY2lR8VzrvSIAbv7fRkSsEeVDXou
   wXmA1CoWQaQSV2ZqyjoyNG55tP21Fy5rsHbHeShbUyqNWXE7C140tX8ri
   iRAktbQc0S0XDqEr2jAxfzAT+H2aJ0ilfwUlQhCAZIfXs7vOzzMHqoHwG
   xU66VYuSI4v/wq0PWo7DOGcIfYH8E6t6j8QEItHtFP9ywh0RK/rNOWDlY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="290752703"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="290752703"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 09:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="953684392"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="953684392"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2022 09:17:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ogTZ5-003Ehi-1q;
        Thu, 06 Oct 2022 19:17:39 +0300
Date:   Thu, 6 Oct 2022 19:17:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/5] regulator: Add devm helpers for get and enable
Message-ID: <Yz7/o1q7p8NmGKMe@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <fa667d6870976a2cf2d60f06e262982872349d74.1665066397.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa667d6870976a2cf2d60f06e262982872349d74.1665066397.git.mazziesaccount@gmail.com>
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

On Thu, Oct 06, 2022 at 05:36:52PM +0300, Matti Vaittinen wrote:
> A few regulator consumer drivers seem to be just getting a regulator,
> enabling it and registering a devm-action to disable the regulator at
> the driver detach and then forget about it.
> 
> We can simplify this a bit by adding a devm-helper for this pattern.
> Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()

...

> (cherry picked from commit b6058e052b842a19c8bb639798d8692cd0e7589f)

Not sure:
 - why this is in the commit message
 - what it points to, since
$ git show b6058e052b842a19c8bb639798d8692cd0e7589f
 fatal: bad object b6058e052b842a19c8bb639798d8692cd0e7589f

> Already in Mark's regulator tree. Not to be merged. Included just for
> the sake of the completeness. Will be dropped when series is rebased on
> top of the 6.1-rc1

Ah, I see, but does it mean the commit has been rebased or you used wrong SHA?

...

> +static void regulator_action_disable(void *d)
> +{
> +	struct regulator *r = (struct regulator *)d;

Cast is not needed.

> +	regulator_disable(r);
> +}

-- 
With Best Regards,
Andy Shevchenko


