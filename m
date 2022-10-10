Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036695F9820
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiJJGM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJJGMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:12:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4504598D;
        Sun,  9 Oct 2022 23:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665382374; x=1696918374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H643CzjwglCD2im/BP3mUFP7xikWejGDiUrJCN9KSGM=;
  b=UICwrgI9KMC7XsFLPs4rv4XatylgUPvcfJsIHpiEOYNaVdo+2V9BUodl
   yVDVPPJiAPXKUPwdb8S0csl4bc5Er+prujU1jBSN9D04VUVeAjBiMncrs
   JeacW6olu+40/yTZyr4a/YZAR0b0f5ruFt4a1fraLHqQLc8Zas73qAvQa
   H6cfQ34DhqPPBA5ifGIdadsHzUa3OOJurboeMjVgJA3Q4UebJhVZfAZ6N
   r2jOqR7orWzG01orb4TjF+Rhr5bEI7CSU6tYKHfRWUXWnyQ+yb/F2QW56
   6z0uY/A5I07dknwzm8s7UzS0K80BBst/mobxVMmdd2s3JLhDxAQF8CMrH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="301760176"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="301760176"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 23:12:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="800971680"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="800971680"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 09 Oct 2022 23:12:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ohm1x-004kBY-1y;
        Mon, 10 Oct 2022 09:12:49 +0300
Date:   Mon, 10 Oct 2022 09:12:49 +0300
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
Message-ID: <Y0O34dRPc0ri74b3@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <fa667d6870976a2cf2d60f06e262982872349d74.1665066397.git.mazziesaccount@gmail.com>
 <Yz7/o1q7p8NmGKMe@smile.fi.intel.com>
 <c25ce92b-ea93-1bd8-11ba-4812b040724d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25ce92b-ea93-1bd8-11ba-4812b040724d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 07:13:23AM +0300, Matti Vaittinen wrote:
> On 10/6/22 19:17, Andy Shevchenko wrote:
> > On Thu, Oct 06, 2022 at 05:36:52PM +0300, Matti Vaittinen wrote:
> > > A few regulator consumer drivers seem to be just getting a regulator,
> > > enabling it and registering a devm-action to disable the regulator at
> > > the driver detach and then forget about it.
> > > 
> > > We can simplify this a bit by adding a devm-helper for this pattern.
> > > Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()

...

> > > (cherry picked from commit b6058e052b842a19c8bb639798d8692cd0e7589f)
> > 
> > Not sure:
> >   - why this is in the commit message
> >   - what it points to, since
> > $ git show b6058e052b842a19c8bb639798d8692cd0e7589f
> >   fatal: bad object b6058e052b842a19c8bb639798d8692cd0e7589f
> > 
> > > Already in Mark's regulator tree. Not to be merged. Included just for
> > > the sake of the completeness. Will be dropped when series is rebased on
> > > top of the 6.1-rc1
> > 
> > Ah, I see, but does it mean the commit has been rebased or you used wrong SHA?
> 
> I did probably cherry-pick this from my local development branch and not
> from Mark's tree. Sorry for the confusion. I thought people would ignore
> these first two patches when reviewing as was requested in cover-letter.

The solution as pointed out by LKP and which will removes the need of the noise
in email and a lot of confusions is to use --base parameter to the patch(es).

-- 
With Best Regards,
Andy Shevchenko


