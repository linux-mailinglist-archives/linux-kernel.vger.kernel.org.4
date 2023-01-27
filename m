Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A603A67DFB8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjA0JJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjA0JJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:09:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BD14C10;
        Fri, 27 Jan 2023 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674810591; x=1706346591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eQ/IZzkS2NRxWmaI8adOA3mfHkoHdtOg1+kSMHdnbcg=;
  b=c9LRvu5u5uyKb3kvO5pfm+BZt2RSUTbZJDAWH9ITH4x2lik+ZSYrhQ8R
   Cbw3RNNPIEOGS0ZbzDBZoBpkaqAMEJQJbblKLpoTBRoq35XahQrjxk+Rc
   6RaXWzUy6l2ek4OF3jjw7xVNawYM2950YR+1FdQ2m74LTJUlZ/mez0/8X
   2K0td5atJeRCZRmRtA+jMeTojhLb7HigYMQ6FgAWfA+5fU0jOFXXvx8X4
   gnwAOcl6OggJo5kWV7nbUlN+vEg+C/I+NK6CKgdPNt6IENTMD/JwO77SB
   fuBBuEL22YdB7ABBcTygijeECNUoWQuoFWpUP+Py57S4ig68QBu/o3IQv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="325721265"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="325721265"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 01:09:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="787156569"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="787156569"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2023 01:09:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLKjx-00Ft8c-1f;
        Fri, 27 Jan 2023 11:09:45 +0200
Date:   Fri, 27 Jan 2023 11:09:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: Add support for AMS TCS3490 light sensor
Message-ID: <Y9OU2e6YMIUTtto0@smile.fi.intel.com>
References: <20230123231028.26073-1-markuss.broks@gmail.com>
 <20230123231028.26073-3-markuss.broks@gmail.com>
 <Y8+xamtH/U4vK75e@smile.fi.intel.com>
 <a782a0d9-c47e-4328-774f-6bef78161d81@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a782a0d9-c47e-4328-774f-6bef78161d81@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 05:54:56PM +0200, Markuss Broks wrote:
> On 1/24/23 12:22, Andy Shevchenko wrote:
> > On Tue, Jan 24, 2023 at 01:10:25AM +0200, Markuss Broks wrote:

First of all, I assume you agree on the comments you left unanswered,
so we will expect them all being addressed in the next version. Is it
correct perception?

...

> > > +static const struct regmap_config tcs3490_regmap_config = {
> > > +	.reg_bits	= 8,
> > > +	.val_bits	= 8,
> > Seems you are using regmap internal serialization, but does it guarantee the
> > serialization on the transaction level? Or why is it not a problem?
> Well, other drivers seem to have it this way too.

They all may be buggy, unclear, or hardware there doesn't require transaction
level locks. It means we have to avoid cargo cult.

> I don't really understand
> why it should be a problem, could you please clarify?

Because one should distinguish IO with register vs. IO transaction.
Imaging two threads which do an IO:

	CPU0					CPU1
						read REG2
						update value
	read REG1
						write REG2
	update value
	write REG1

If in our hypothetical example the writing to REG2 has a side effect on
the values in REG1, we are doomed.

You have to check all possible scenarios and tell if it's a problem or not with
the certain hardware. According to the result, add a corresponding comment to
the code and, if required, change the locking scheme.

> > > +};

-- 
With Best Regards,
Andy Shevchenko


