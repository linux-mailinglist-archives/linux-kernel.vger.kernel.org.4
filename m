Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4045A5B77F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiIMR2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiIMR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:28:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5058D53D26;
        Tue, 13 Sep 2022 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663085788; x=1694621788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=261mO1KgSTtW14tdM99gOkkUmGI9TLXyDOhAtu26Vp8=;
  b=FEFKV1RR1qmmNB+2TOtgT7Dz60+8CN19ZBpYsKzUJGYDa+dOYJ5mYg11
   bS0k1Ggj2wa5hg9LzXGng1pifpH9WflKIRVA4AsPcGzxwqrYtkXs1ZMus
   H82RSpMbMHrZ057heOfRxzZW8gt/w4+y1VrqaCio05r8k8uO0kM6CeTqk
   TiJ+uXExGgTzry7mCZL1GT3vho2LrFZYY8karAC6yr2XbURlWqD3Hh+5u
   eV4CsuGErIkGToWA006XS3gDDDYq//Ul+HzY2WnCHWw7FCDoItrvOy9/z
   MSTA1ptpDKPr/NIjhCaNRJ0OOdd72y6XGPHfL8ETjvKJIZKI+VH0On7JF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="298186600"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="298186600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:16:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="758852127"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:16:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oY8aG-001psQ-0H;
        Tue, 13 Sep 2022 19:16:24 +0300
Date:   Tue, 13 Sep 2022 19:16:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     brgl@bgdev.pl, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/3] gpio: idio-16: Introduce the ACCES IDIO-16 GPIO
 library module
Message-ID: <YyCs1/HgOG31MX1N@smile.fi.intel.com>
References: <cover.1662927941.git.william.gray@linaro.org>
 <6b28fb497c35def57c1920362c82402bed4bd23f.1662927941.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b28fb497c35def57c1920362c82402bed4bd23f.1662927941.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 04:34:38PM -0400, William Breathitt Gray wrote:
> Exposes consumer library functions to facilitate communication with
> devices within the ACCES IDIO-16 family such as the 104-IDIO-16 and
> the PCI-IDIO-16.
> 
> A CONFIG_GPIO_IDIO_16 Kconfig option is introduced by this patch.
> Modules wanting access to these idio-16 library functions should select
> this Kconfig option and import the IDIO_16 symbol namespace.

...

> +int idio_16_get(struct idio_16 __iomem *const reg, const unsigned long offset)
> +{
> +	const unsigned long mask = BIT(offset);
> +
> +	if (offset < 8)
> +		return !!(ioread8(&reg->out0_7) & mask);
> +
> +	if (offset < 16)
> +		return !!(ioread8(&reg->out8_15) & (mask >> 8));
> +
> +	if (offset < 24)
> +		return !!(ioread8(&reg->in0_7) & (mask >> 16));
> +
> +	return !!(ioread8(&reg->in8_15) & (mask >> 24));

For the sake of robustness, since it's a library, I would do

	if (offset < 32)
		...

	return -EINVAL;

> +}
> +EXPORT_SYMBOL_NS_GPL(idio_16_get, IDIO_16);

If there is not expected to be more than a single namespace, you may define it
just once for all via

#define DEFAULT_SYMBOL_NAMESPACE IDIO_16

And honestly, I would add also GPIO prefix to it, GPIO_IDIO_16.

...

> +	if (*mask & GENMASK(7, 0))
> +		bitmap_set_value8(bits, ioread8(&reg->out0_7), 0);
> +	if (*mask & GENMASK(15, 8))
> +		bitmap_set_value8(bits, ioread8(&reg->out8_15), 8);
> +	if (*mask & GENMASK(23, 16))
> +		bitmap_set_value8(bits, ioread8(&reg->in0_7), 16);
> +	if (*mask & GENMASK(31, 24))
> +		bitmap_set_value8(bits, ioread8(&reg->in8_15), 24);

So, the addresses of the ports are not expected to be continuous?

...

> +void idio_16_set(struct idio_16 __iomem *const reg,
> +		 struct idio_16_state *const state, const unsigned long offset,
> +		 const unsigned long value)
> +{
> +	unsigned long flags;
> +
> +	/* offsets greater than 15 are input-only signals */
> +	if (offset > 15)

For the sake of consistency:

	if (offset >= 16)

> +		return;
> +
> +	spin_lock_irqsave(&state->lock, flags);

> +	if (value)
> +		set_bit(offset, state->out_state);
> +	else
> +		clear_bit(offset, state->out_state);

assign_bit()

But I'm wondering why do you need the atomic bitops under the lock?

> +	if (offset < 8)
> +		iowrite8(bitmap_get_value8(state->out_state, 0), &reg->out0_7);
> +	else
> +		iowrite8(bitmap_get_value8(state->out_state, 8), &reg->out8_15);
> +
> +	spin_unlock_irqrestore(&state->lock, flags);
> +}

...

> +	for_each_set_clump8(offset, port_mask, mask, IDIO_16_NOUT) {
> +		value = bitmap_get_value8(bits, offset);
> +		out_state = bitmap_get_value8(state->out_state, offset);
> +
> +		out_state = (out_state & ~port_mask) | (value & port_mask);
> +		bitmap_set_value8(state->out_state, out_state, offset);

This looks like bitmap_replace(). It might require to redesign the flow a bit.

> +		if (offset < 8)
> +			iowrite8(out_state, &reg->out0_7);
> +		else
> +			iowrite8(out_state, &reg->out8_15);
> +	}

...

> +static inline int idio_16_get_direction(const unsigned long offset)
> +{
> +	return (offset < IDIO_16_NOUT) ? 0 : 1;

	return (offset >= IDIO_16_NOUT) ? 1 : 0;

?

> +}

-- 
With Best Regards,
Andy Shevchenko


