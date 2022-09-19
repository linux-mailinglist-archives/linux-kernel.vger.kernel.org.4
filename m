Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BBD5BCD7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiISNp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiISNpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:45:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7718A17066
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663595151; x=1695131151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YM1dRxbPZHCQXuHcTFNhP5mVRzQg8TEYi3/O2RyVXbk=;
  b=mdDIeNVH1lUortLCdmIDyhs9OmG956eSIzei2lBSlzFCNcL7BD+6VcAK
   Ys4CcZCwnlVt4Uucx2CxF9XAdT0CD93h0a15ePHkZK1eyqgGfnGzKU24l
   45IKuN/H2GyceCYUD8x3Jfp8YunEvI78Q9jYNDSi0tnW4VEvIdosHwljG
   l0we+aw6PQp0nmuYd+QkAFGWr6aidAtboGgH95OHUQ2TGd6VHEEWEP2pB
   0Lqyut1N5wTdUtBrNj8KncsSB8MyBETFg7QfbfJLYibTxf4PpCp0GQsgZ
   AyVTU5GBdl2YqjUehHyJhqIgEYCGxfDzdNwHJVOThODUQg1IaMp1i2MtE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279131316"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="279131316"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="744120637"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 19 Sep 2022 06:45:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oaH5l-004Zc7-0N;
        Mon, 19 Sep 2022 16:45:45 +0300
Date:   Mon, 19 Sep 2022 16:45:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Valentin Schneider <vschneid@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 2/4] lib/find_bit: create find_first_zero_bit_le()
Message-ID: <YyhyiFsV0z21jI0b@smile.fi.intel.com>
References: <20220915020730.852234-1-yury.norov@gmail.com>
 <20220915020730.852234-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915020730.852234-3-yury.norov@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 07:07:28PM -0700, Yury Norov wrote:
> find_first_zero_bit_le() is an alias to find_next_zero_bit_le(),
> despite that 'next' is known to be slower than 'first' version.
> 
> Now that we have common FIND_FIRST_BIT() macro helper, it's trivial
> to implement find_first_zero_bit_le() as a real function.

...

> +#ifdef __BIG_ENDIAN

Probably you want to add a blank line here.

> +#ifndef find_first_zero_bit_le
> +/*
> + * Find the first cleared bit in an LE memory region.
> + */
> +unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
> +{
> +	return FIND_FIRST_BIT(~addr[idx], swab, size);
> +}
> +EXPORT_SYMBOL(_find_first_zero_bit_le);
> +#endif
> +
> +#endif /* __BIG_ENDIAN */

-- 
With Best Regards,
Andy Shevchenko


