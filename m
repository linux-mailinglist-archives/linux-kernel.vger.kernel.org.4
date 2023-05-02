Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2946F4A81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjEBTli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 15:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEBTlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 15:41:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1810511B;
        Tue,  2 May 2023 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683056496; x=1714592496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aUIYjVCQRHRlfXDMj7fFiF8cdLlvmxD/u1gXezinv5I=;
  b=kSM58eOD9AUOcATx6vejqkSsFI4dAZ6dMgRdzm4E56R/bS290XwT23dK
   dghvogwtMSe3Wzozdvdnhxk8kbEPspUxGKMj32GurAz0GZIeZOdRYl5gv
   1zehYi9yDyXVGQmRQ7pR8M5f6HiKR2Hm11Am7oSgb91Ovw1/jpb+oloOF
   uYo41atKFhYEU/Of8HX6F0aiEu7+nRTLDZ0FVVOrgqVzL6Aw6xTpRhQHf
   V458hsL0ejiTQbkHw1Uwq8BCqPSy6EwIpYIS8/Ati3QwvmMOK34i77fx4
   rUlmkF/RsXML4Sn2Y5w7CdZsYRsVEMQ/kqUCcnt/CICTaG6jzwamApjcV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="351468220"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="351468220"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 12:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="761238064"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="761238064"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 02 May 2023 12:41:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ptvsR-008CrM-1h;
        Tue, 02 May 2023 22:41:31 +0300
Date:   Tue, 2 May 2023 22:41:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>,
        Andi Shyti <andi.shyti@kernel.org>, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZFFna3MUzEtBkMxr@smile.fi.intel.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
 <20230425155734.ywdle4pv6y2wjk2s@intel.intel>
 <ZE0WopTBS8S08tjX@carbian>
 <20230430184910.48d6c1b4@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430184910.48d6c1b4@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2023 at 06:49:10PM +0100, Jonathan Cameron wrote:
> On Sat, 29 Apr 2023 15:07:46 +0200
> Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> > On Tue, Apr 25, 2023 at 05:57:34PM +0200, Andi Shyti wrote:
> > > On Tue, Apr 25, 2023 at 12:22:25AM +0200, Mehdi Djait wrote:  

...

> > > > +	chip_info = device_get_match_data(&spi->dev);
> > > > +	if (!chip_info) {
> > > > +		const struct spi_device_id *id = spi_get_device_id(spi);
> > > > +		chip_info = (const struct kx022a_chip_info *)id->driver_data;  
> > > 
> > > you don't need the cast here... if you don't find it messy, I
> > > wouldn't mind this form... some hate it, I find it easier to
> > > read:
> > > 
> > > 	chip_info = spi_get_device_id(spi)->driver_data;
> > > 
> > > your choice.  
> > 
> > I don't really have any strong opinion about this other than keeping the
> > same style used in iio drivers
> > 
> > Again thank you for the review
> 
> I'm fairly sure the cast is needed because driver_data is (via defines)
> an unsigned long, which you cannot implicitly cast to a pointer without
> various warnings being generated.

Instead we have a specific SPI provided helper for the above, please use it
instead of open coded stuff.

-- 
With Best Regards,
Andy Shevchenko


