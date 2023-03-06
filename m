Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310C86ABDF4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCFLOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCFLOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:14:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40A91EBFC;
        Mon,  6 Mar 2023 03:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678101242; x=1709637242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K5/C63WfvQsU6EXGa195nktMwme91N/01fDqk0Ruij0=;
  b=eNJXPVuzBcOi5qBn3EMTHTbuf07FrVUcN/Anc6B1GiKwgL6PrAFua2Zo
   M+1t9I7niQra/w1pe3E1t5K4fM3Q62OyJYyNG+u/z+UIp65lzzFEH4t/n
   X5jB4IrMgDOWn94UYBaCoPWkaNCeqOZ26PZXe4vAybUGWpAi+MSOlAhnV
   Iq6R8UbPVLIMbutHXuw9wID0AS4bRd+tzSgNU/FoOFi3R6dPNwKVmKmBr
   25QDv7eYjzlFb67JzKe9aeRA7kPsmjc1ySRenkpgAp20L1GQINGuxg72U
   NxUUUuBSE10G6HEzpocQfPtUttLKzJBVO8lsMR1YPChl8WjwnM8y9xRzJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="315187455"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="315187455"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 03:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="708614242"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="708614242"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 06 Mar 2023 03:13:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZ8mz-00GJnm-0E;
        Mon, 06 Mar 2023 13:13:57 +0200
Date:   Mon, 6 Mar 2023 13:13:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZAXK9Hn2NuQPJ7eo@smile.fi.intel.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <9895826669118a1aa1db3f85c2610fa759426c33.1677750859.git.mazziesaccount@gmail.com>
 <ZAC7L8NQYgBcBTCF@smile.fi.intel.com>
 <7e537200-37ab-f6e6-c4e0-c3997128c01b@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e537200-37ab-f6e6-c4e0-c3997128c01b@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 07:54:22AM +0000, Vaittinen, Matti wrote:
> On 3/2/23 17:05, Andy Shevchenko wrote:
> > On Thu, Mar 02, 2023 at 12:57:54PM +0200, Matti Vaittinen wrote:

...

> >> +{
> >> +	int tmp = 1;
> >> +
> >> +	if (scale > max || !scale)
> >> +		return -EINVAL;
> >> +
> >> +	if (U64_MAX - max < scale) {
> >> +		/* Risk of overflow */
> >> +		if (max - scale < scale)
> >> +			return 1;
> > 
> >> +		while (max - scale > scale * (u64) tmp)
> > 
> > Space is not required after casting.
> > 
> >> +			tmp++;
> >> +
> >> +		return tmp + 1;
> > 
> > Wondering why you can't simplify this to
> > 
> > 		max -= scale;
> > 		tmp++;
> > 
> 
> Sorry, but I don't follow. Can you please show me the complete 
> suggestion? Exactly what should be replaced by the:

I don't understand. Do you see the blank lines I specifically added to show
the piece of the code I'm commenting on?

For your convenience, the while loop and return statement may be replaced with
two simple assignments.

>  > 		max -= scale;
>  > 		tmp++;

> >> +	}
> >> +
> >> +	while (max > scale * (u64) tmp)
> >> +		tmp++;
> >> +
> >> +	return tmp;
> >> +}

...

> >> +EXPORT_SYMBOL_GPL(iio_init_iio_gts);
> > 
> > I haven't noticed if you put these all exports into a proper namespace.
> > If no, please do.
> 
> I haven't. And in many cases I actually see very little to no value in 
> doing so as collisions are unlikely when symbols are appropriately prefixed.

This is a benefit of not polluting (global) namespace with something that is
rarely used. Please, try to utilize namespaces more in your nice kernel
contribution (there is *no* sarcasm).

> Anyways, it seems the IIO uses namespaces so let's play along. Any good 
> suggestions for a name?

IIO_GTS ?

...

> >> +	for (i = gts->num_itime - 2; i >= 0; i--)
> > 
> > Yeah, if you put this into temporary, like
> > 
> > 	i = gts->num_itime - 1;
> > 
> > this becomes
> > 
> > 	while (i--) {
> > 
> 
> I prefer for(). It looks clearer to me...

It has too many characters to parse. That's why I prefer while.
Are we going to have principle disagreement on this one?

>  > Note, you may re-use that i (maybe renamed to something better in the 
> memcpy()
>  > above as well).
> 
> ...but this makes sense so Ok.

...

> > Note, you missed {} for better reading.
> 
> Didn't miss it but left it out intentionally. {} does not help me as 
> indentiation makes it clear. Can add one for you though.

Not for me. For other people who would read 1+ screen long for-loop body (not
everybody has 120+ lines of terminal.

...

> >> +		for (i = 0; !ret && i < gts->num_avail_all_scales; i++)
> > 
> > Much easier to read if you move this...
> > 
> >> +			ret = iio_gts_total_gain_to_scale(gts, all_gains[i],
> >> +					&gts->avail_all_scales_table[i * 2],
> >> +					&gts->avail_all_scales_table[i * 2 + 1]);
> > 
> > ...here as
> > 
> > 		if (ret)
> > 			break;
> 
> I think the !ret in loop condition is obvious. Adding break and brackets 
> would not improve this.

It moves it to the regular pattern. Yours is not so distributed in the kernel.

...

> >> +	kfree(all_gains);
> >> +	if (ret && gts->avail_all_scales_table)
> >> +		kfree(gts->avail_all_scales_table);
> >> +
> >> +	return ret;
> > 
> > But Wouldn't be better to use goto labels?
> 
> I don't see benefit in this case. Handling return value and goto would 
> require brackets. The current one is much simpler for me. I am just 
> considering dropping that 'else' which is not needed.

At least it would be consistent with the very same file style in another
function. So, why there do you goto, and not here where it makes sense
to me?

...

> >> +	while (i) {
> > 
> > Instead of doing standard
> > 
> > 	while (i--) {
> > 
> >> +		/*
> >> +		 * It does not matter if i'th alloc was not succesfull as
> >> +		 * kfree(NULL) is safe.
> >> +		 */
> > 
> > You add this comment, ...
> > 
> >> +		kfree(per_time_gains[i]);
> >> +		kfree(per_time_scales[i]);
> > 
> > ...an additional loop, ...
> 
> The comment is there to explain what I think you missed. We have two 
> arrays there. We don't know whether the allocation of first one was 
> successful so we try freeing both.
> 
> > 
> >> +
> >> +		i--;
> > 
> > ...and a line of code.
> > 
> >> +	}
> > 
> > Why?
> 
> Because, as the comment says, it does not matter if allocation was 
> succesfull. kfree(NULL) is safe.

Wouldn't be better to avoid no-op kfree() by explicitly putting the call before
hands?

	kfree(...[i]);
	while (i--) {
		...
	}

?

Much better to understand than what you wrote. I have to read comment on top of
the code, with my proposal comment won't be needed.

...

> >> +	for (i = gts->num_itime - 1; i >= 0; i--) {
> > 
> > 	i = gts->num_itime;
> > 
> > 	while (i--) {
> 
> I prefer for() when initializing a variable is needed. Furthermore, 
> having var-- or --var in a condition is less clear.

	while (x--)

_is_ a pattern for cleaning up something. Your for-loop has a lot of additional
(unnecessary) code lines that makes it harder to understand (by the people who
are not familiar with the pattern).

> >> +	}

...

> >> +void iio_gts_purge_avail_time_table(struct iio_gts *gts)
> >> +{
> >> +	if (gts->num_avail_time_tables) {
> > 
> > 	if (!...)
> > 		return;
> 
> Does not improve this as we only have just one small conditional block 
> of code which we either execute or not. It is clear at a glance. Would 
> make sense if we had longer function.

I believe it makes sense to have like this even for this long function(s).

> >> +		kfree(gts->avail_time_tables);
> >> +		gts->avail_time_tables = NULL;
> >> +		gts->num_avail_time_tables = 0;
> >> +	}
> >> +}

...

> >> +			if (!diff) {
> > 
> > Why not positive conditional?
> 
> Because !diff is a special condition and we check explicitly for it.

And how my suggestion makes it different?

(Note, it's easy to miss the ! in the conditionals, that's why positive ones
 are preferable.)

> > 
> > 			if (diff) {
> > 				...
> > 			} else {
> > 				...
> > 			}
> > 

> >> +			} else {

> >> +			}

-- 
With Best Regards,
Andy Shevchenko


