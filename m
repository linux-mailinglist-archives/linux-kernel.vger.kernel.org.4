Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEA45F982F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJJGPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiJJGPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:15:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7DF46216;
        Sun,  9 Oct 2022 23:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665382531; x=1696918531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hdadVB/NuyPjliUxW9jJSkSFml/0KgUKfluek+C+iNI=;
  b=T9Jf6iBKRHmN80Z8a4vfNVCU1j2aVuO7rKY/HggX3dC0Ja4qXHzgWquo
   gnB1NOtKTk+JUBnW8WkYqgUwmfRKTSNFSQAmpDMnO2qGhhSIehCe0W1xp
   zYKPZlI6791W9i4mCWEnYf5iC7no36ck6RwmsifQwWsI8J8M8yv4h8rWN
   7ckP57e+FtaH64vtZO1fHta3+CsCPMmv9HELQoaaKY2gM1zcVXt6oN6OZ
   Yd0ix1vyHavAqzNEaGvk0yirY//eIGjk+XaE7wOU2Jm2tiqqKOO6UXi2K
   wFXiA7IUuGkfcRJ/LdPuOAuqH8bhn6hLYCYvnfacytkgsC5faO+9OYMRa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="366115181"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="366115181"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 23:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="694513968"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="694513968"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2022 23:15:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ohm4U-004kEG-2G;
        Mon, 10 Oct 2022 09:15:26 +0300
Date:   Mon, 10 Oct 2022 09:15:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <Y0O4fiQQX0M317h/@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
 <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
 <20221009133351.6ff4894b@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009133351.6ff4894b@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 01:33:51PM +0100, Jonathan Cameron wrote:
> On Thu, 6 Oct 2022 21:32:11 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 06, 2022 at 05:38:14PM +0300, Matti Vaittinen wrote:

...

> > > +module_param(g_kx022a_use_buffer, bool, 0);
> > > +MODULE_PARM_DESC(g_kx022a_use_buffer,
> > > +		 "Buffer samples. Use at own risk. Fifo must not overflow");  
> > 
> > Why?! We usually do not allow module parameters in the new code.
> 
> Badly broken hardware - was my suggestion.  Alternatives if there are usecases
> that need to use the fifo, but it can wedge hard in a fashion that is impossible
> to prevent from the driver?  My gut feeling is still drop the support entirely
> with a strong comment in the code that the hardware is broken in a fashion we don't
> know how to work around.

I also would drop this from upstream and if anybody curious, provide some kind
of GitHub gist for that. Also it needs some communication with a vendor to
clarify the things.

-- 
With Best Regards,
Andy Shevchenko


