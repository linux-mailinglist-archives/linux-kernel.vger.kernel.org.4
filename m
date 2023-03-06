Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01F36ABF27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCFMJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCFMJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:09:27 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61B81DB86;
        Mon,  6 Mar 2023 04:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678104566; x=1709640566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ns401fX2ZWBO5rXMcW8dhFQJPEQGnvXWH7vAeYUPIWY=;
  b=LYRHFMmMspmCM7NCefaqYbiIK5vca6cw6UPDl61NTfSS1alCBHAeM50K
   cstN28qoUsmU5/Zk9sVXlsGGGj+G63PNA0Q6jWHveCYLfteiUHDLd6c1D
   bfMwLxSqf5gx73aoq+nHj2MfCkacSAZCSlujORuADQ2PQgvxk40dD/VEy
   1+JCC9O2NlVc5OKtVCp7/P9iPAf71+XTSZNA3oOQ2eQjZEwsF2wqnUN0k
   73KILLwPgn29naQynr9u7V4NiY3MUnzefir+QVBIBDV3gmYBVNjE7K/9p
   KFg+kgSqizKlagv4W2j5fuUsR4rgJE78RZNj8lo+YNlnEX+FZKeRKhXuQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="315197247"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="315197247"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 04:09:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="669414969"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="669414969"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 04:09:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZ9eZ-00GL5E-2z;
        Mon, 06 Mar 2023 14:09:19 +0200
Date:   Mon, 6 Mar 2023 14:09:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <ZAXX79Mix85gv0eA@smile.fi.intel.com>
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
 <20230228063151.17598-2-mike.looijmans@topic.nl>
 <Y/9vez/fzLD5dRVF@smile.fi.intel.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0685d97e-4a28-499e-a9e3-3bafec126832@emailsignatures365.codetwo.com>
 <a2ba706f-888b-0a72-03a5-cbf761dfaf19@topic.nl>
 <ZACxUpzCtlrMehrA@smile.fi.intel.com>
 <20230304172618.37f448d0@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230304172618.37f448d0@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 05:26:18PM +0000, Jonathan Cameron wrote:
> On Thu, 2 Mar 2023 16:23:14 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Mar 02, 2023 at 08:49:22AM +0100, Mike Looijmans wrote:
> > > On 01-03-2023 16:30, Andy Shevchenko wrote:  
> > > > On Tue, Feb 28, 2023 at 07:31:51AM +0100, Mike Looijmans wrote:  

...

> > > > > +	/* Shift result to compensate for bit resolution vs. sample rate */
> > > > > +	value <<= 16 - ads1100_data_bits(data);
> > > > > +	*val = sign_extend32(value, 15);  
> > > > Why not simply
> > > > 
> > > > 	*val = sign_extend32(value, ads1100_data_bits(data) - 1);
> > > > 
> > > > ?  
> > > 
> > > As discussed with  Jonathan Cameron, the register is right-justified and the
> > > number of bits depend on the data rate. Rather than having the "scale"
> > > change when the sample rate changes, we chose to adjust the sample result so
> > > it's always left-justified.  
> > 
> > Hmm... OK, but it adds unneeded code I think.
> 
> There isn't a way to do it in one go that I can think of.
> The first statement is multiplying the value by a power of 2, not just sign extending it.
> You could sign extend first then shift to do the multiply, but ends up same amount
> of code.
> 
> It does look a bit like a weird open coded sign extension though so I can see where
> the confusion came from!

I see, for the negative value both approaches will work, for the positive
the original one will provide a multiplied value.

Yeah, doesn't seem to be a subject to the (micro-)optimizations.

...

> > > > > +	for (i = 0; i < 4; i++) {
> > > > > +		if (BIT(i) == gain) {  
> > > > ffs()/__ffs() (look at the documentation for the difference and use proper one).  
> > > 
> > > Thought of it, but I'd rather have it return EINVAL for attempting to set
> > > the analog gain to "7" (0nly 1,2,4,8 allowed).  
> > 
> > I'm not sure what you are implying.
> > 
> > You have open coded something that has already to be a function which on some
> > architectures become a single assembly instruction.
> > 
> > That said, drop your for-loop if-cond and use one of the proposed directly.
> > Then you may compare the result to what ever you want to be a limit and return
> > whatever error code you want to
> 
> Agreed, could do it with appropriate ffs() followed by if (BIT(i) != gain) return -EINVAL;

I meant something different.

	i = ffs(gain); // or __ffs(gain)?
	if (i >= 4)
		return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


