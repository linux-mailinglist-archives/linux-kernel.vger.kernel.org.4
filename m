Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E19C6B78CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCMNZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCMNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:25:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D71CE050;
        Mon, 13 Mar 2023 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678713940; x=1710249940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nqCsKoZxx5kpwaIc/QepkMQXnWMFLY7WFFBUg5QjjDw=;
  b=eWHMwJQhUbL0vPxHzBAsnx+r3VD8OOIP90u5otS6mnlgOKSMB12unadY
   /Sjj3/2TWSE2vk9PRWUfvBlwfdAP3+nzPy5vwIeyYGnUeWbl2cIxozyPV
   9qV8DnYwv+VUqEyhuVJ7AjW6khi/lBKYS1Xvb+tjaIRHOZFKCy807fTSR
   vzS9HXqnsNd22PJLfBVTc205xTdiHX7vl9sKe4zq9mDIxfA/hMQ1O1z+O
   B7uBgewasZsM8Top9gedRTDaUCT44gHJwYBPXxAaoqb86ymnEdKHjWV5y
   7DjsN7XnVq0IstGex8mj9IEPDub+ci0WSUZnGwYAARU6px9FoSWocW5aV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316790703"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="316790703"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 06:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="747606585"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="747606585"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2023 06:25:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pbiBD-002e2V-10;
        Mon, 13 Mar 2023 15:25:35 +0200
Date:   Mon, 13 Mar 2023 15:25:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZA8kTx4exvGwUfNn@smile.fi.intel.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
 <e507c171-bebc-84f6-c326-ff129b42fb7f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e507c171-bebc-84f6-c326-ff129b42fb7f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 02:47:45PM +0200, Matti Vaittinen wrote:
> On 3/6/23 14:52, Andy Shevchenko wrote:
> > On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:

...

> > > +/*
> > 
> > If it's deliberately not a kernel doc, why to bother to have it looking as one?
> > It's really a provocative to some people who will come with a patches to "fix"
> > this...
> 
> I just liked the kernel-doc format. It's a standard way of explaining the
> parameters and returned value. Function however is intended to be internal
> and thus I don't see a need to make this "official kernel doc".

The problem as I pointed out with your approach it's unmaintainable. And
I even explained why I consider it this way.

> > > + * iio_gts_get_gain - Convert scale to total gain
> > > + *
> > > + * Internal helper for converting scale to total gain.
> > > + *
> > > + * @max:	Maximum linearized scale. As an example, when scale is created
> > > + *		in magnitude of NANOs and max scale is 64.1 - The linearized
> > > + *		scale is 64 100 000 000.
> > > + * @scale:	Linearized scale to compte the gain for.
> > > + *
> > > + * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
> > > + *		is invalid.
> > > + */

...

> > > +	if (scaler > NANO || !scaler)
> > > +		return -EINVAL;
> > 
> > Shouldn't be OVERFLOW for the first one?
> 
> -EOVERFLOW? I guess it could be. Thanks.

Yes.

...

> > > +		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
> > > +		     NULL);
> > 
> > One line reads better?
> 
> I try mostly to keep the good old 80 chars as I often have 3 terminal
> windows fitted on my laptop screen. It works best with the short lines.

With it on one line

		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp, NULL);

You have N at the last column which quite likely suggests that it's NULL.
So, I don't think it's a big issue to put on a single line.

...

> > > +	if (ret && gts->avail_all_scales_table)
> > 
> > In one case you commented that free(NULL) is okay, in the other, you add
> > a duplicative check. Why?
> 
> Sorry but what do you mean by dublicative check?
> 
> Usually I avoid the kfree(NULL). That's why I commented on it in that
> another case where it was not explicitly disallowed. I'll change that for v4
> to avoid kfree(NULL) as you suggested.

So, and with it you put now a double check for NULL, do you think it's okay?
I don't.

> > > +		kfree(gts->avail_all_scales_table);

...

> > > +	per_time_gains = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);
> > 
> > sizeof(type) is error prone in comparison to sizeof(*var).
> 
> Yes and no. In majority of cases where we see sizeof(*var) - the *var is no
> longer a pointer as having pointers to pointers is not _that_ common. When
> we see sizeof(type *) - we instantly know it is a size of a pointer and not
> a size of some other type.
> 
> So yes, while having sizeof(*var) makes us tolerant to errors caused by
> variable type changes - it makes us prone to human reader errors. Also, if
> someone changes type of *var from pointer to some other type - then he/she
> is likely to in any case need to revise the array alloactions too.
> 
> While I in general agree with you that the sizeof(variable) is better than
> sizeof(type) - I see that in cases like this the sizeof(type *) is clearer.

Still get a fundamental disagreement on this. I would insist, but I'm not
a maintainer, so you are lucky :-) if Jonathan will not force you to follow
my way.

...

> > > +	per_time_scales = kcalloc(gts->num_itime, sizeof(int *), GFP_KERNEL);

Ditto.

...

> > > +err_free_out:
> > > +	while (i) {
> > > +		/*
> > > +		 * It does not matter if i'th alloc was not succesfull as
> > > +		 * kfree(NULL) is safe.
> > > +		 */
> > 
> > Instead, can be just a free of the known allocated i:th member first followed
> > by traditional pattern. In that case comment will become redundant.
> > 
> 
> I replied to this in your comments regarding the v2. Sorry for splitting the
> discussion by sending v3 so soon.

You can have repeated it here :-)

Yes, two labels and one kfree() makes the comment go away. To me that comment
is more confusing than helping.

> > > +		kfree(per_time_scales[i]);
> > > +		kfree(per_time_gains[i]);
> > > +
> > > +		i--;
> > > +	}

...

> > > +	for (i = gts->num_itime - 1; i >= 0; i--) {
> > 
> > 	while (i--) {
> > 
> > makes it easier to parse.
> 
> This is also something I replied for v2. I think we have a fundamental
> disagreement on this one :/

Yes, and I will continue insisting on while (foo--).
That why I won't give you my tags :-)

...

> > > +		if (!min)
> > > +			min = gts->hwgain_table[i].gain;
> > > +		else
> > > +			min = min(min, gts->hwgain_table[i].gain);
> > 
> > I was staring at this and have got no clue why it's not a dead code.
> 
> Nor can I. It seems obvious to me that the one who wrote this had no idea
> what he was doing XD
> 
> Well, I must have had some initial idea of using the minimum value to
> something - but I can't remember what would've been the use. Maybe I was
> initially thinking that I'll return the smallest value in-range if the gain
> given as a parameter was smaller than any of the supported ones.
> 
> Thank you for reading this carefully and pointing it out! Well spotted!

Hint: run always `make W=1` when building kernel.

It will show defined but not used cases and combined with nowadays
default -Werror won't be compilable.

-- 
With Best Regards,
Andy Shevchenko


