Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DD56C7F10
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCXNsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCXNsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:48:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B35DDBE0;
        Fri, 24 Mar 2023 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679665703; x=1711201703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vu8F1hy4gOIAuangf3/BoReRbQqwkKKOq4w7ZW6JVtE=;
  b=l0yHWvn6wPNx+ohFDf303HBVB9VN4BChhIBS/Z9dWrUrWe97YT0GJnHL
   fQu0Rjkkrg9K1nx6YIiVd2zjVdhzux5ahqujoZbkSGpmpGlWgVvi2xAjL
   4u8rHrctc1XMwzrZDAGSoIq5iZWtUf/bFpLB+TVYqRdA59zFt/q+ZKG4M
   Xc+yyqFMfHjlxk8wDihgYgveEpxSosHaF7qLNMUi/oe40YJEKiGeEheXp
   Yoe1Lz/4Wc3YhZTBiVCTy7CeuAc9iIT0tIRR3PPBAHApJJDujQ8tzBFsq
   wK2U1cPZuhUOp3ginwrwY5NJdpR2IPPDFkpuqfEHWr9q0qfjuj5snSL8J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="328198153"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="328198153"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 06:48:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="806671640"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="806671640"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2023 06:48:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pfhmF-007wcm-1N;
        Fri, 24 Mar 2023 15:48:19 +0200
Date:   Fri, 24 Mar 2023 15:48:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] counter: 104-quad-8: Refactor to buffer states
 for CMR, IOR, and IDR
Message-ID: <ZB2qI7k/Igws5khg@smile.fi.intel.com>
References: <cover.1679605919.git.william.gray@linaro.org>
 <c5adb13b4b0887beb1df40b34d2ef03d63a2860d.1679605919.git.william.gray@linaro.org>
 <ZB2OG4zZXsqqyN8v@smile.fi.intel.com>
 <ZB2Ob9VGe3GoEVko@smile.fi.intel.com>
 <ZB2k9m7rL7Hpy/zU@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB2k9m7rL7Hpy/zU@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:26:14AM -0400, William Breathitt Gray wrote:
> On Fri, Mar 24, 2023 at 01:50:07PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 24, 2023 at 01:48:43PM +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 23, 2023 at 05:25:28PM -0400, William Breathitt Gray wrote:

...

> > > > +static void quad8_control_register_update(struct quad8 *const priv, u8 *const buf,
> > > > +					  const size_t channel, const u8 val, const u8 field)
> > > > +{
> > > > +	u8p_replace_bits(&buf[channel], val, field);
> > > > +	iowrite8(buf[channel], &priv->reg->channel[channel].control);
> > > > +}
> > > 
> > > How did you compile this?
> > > Due to nature of *_replace_bits() this may only be a macro.
> > > 
> > > That's what LKP is telling about I think.
> > 
> > Ah, no, that's because the last parameter is not constant in the last patch in
> > the series.

> I'm having trouble cross-compiling for riscv, but I'm unable to recreate
> the build error when I compile for x86_64. However, I'd like to
> understand this error so I can fix it properly.
> 
> Is the problem here due to the "const u8 field" parameter? Instead of a
> constant variable, does this need to be a constant literal value for
> u8p_replace_bits()? I don't think that parameter changed in the last
> patch of the series, so why is the build error occurring for the last
> patch and not this penultimate patch here?

Good question. Perhaps my understanding is incorrect.

> Would qualifying the
> quad8_control_register_update() function with "__always_inline" resolve
> this issue?

Hmm... Don't know. You can always download a toolchain specifically build for
building kernels: https://mirrors.edge.kernel.org/pub/tools/crosstool/.

-- 
With Best Regards,
Andy Shevchenko


