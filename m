Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A436E627A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiKNKYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbiKNKYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:24:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233AA1D0EE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668421461; x=1699957461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MvTTp8g0BzZqb9lW89EYw8zYqh0h4Ytuqndp2GiUR8Y=;
  b=N7vLPerwgvo7em74+YipsQe8xXEnvvwj7+Ntmw5lHNFBRKUqjU/eP+Jy
   aMWr1UIHcIog5yN/QD7LRkLe2ZuWMZGAnlkX1BOkIhUPlfxi9hGtZ6lWI
   dLRJBAypic41wpZiLW5fN/T8BXsspf8v1BQ0VzpOXR34XSeIIg/sRQAJ1
   buBchN/WSR1tNJM0YrN4yPBJWJblXUMSyH4akUqh+UuZKbOzU0iajsO0M
   E4y/5OTa6PAZrkOJQbkKjhH6XBR6Al2lNfr0aUWhJLwyaAvY+Ft38rsf/
   ArTaqxewHAJRBS9bGIWY0y9eABEcCjJT/V8xw8sSCMQ4d4/hvFm1trAuU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="309561475"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="309561475"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 02:24:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="883486152"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="883486152"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2022 02:24:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouWdU-00C7Tl-1X;
        Mon, 14 Nov 2022 12:24:16 +0200
Date:   Mon, 14 Nov 2022 12:24:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH RESEND 1/1] x86/of: Add support for boot time interrupt
 mode config
Message-ID: <Y3IXUN5ETBfrSXRW@smile.fi.intel.com>
References: <cover.1668403214.git.rtanwar@maxlinear.com>
 <37cc31242d0edda1bb0900cc62bba87954a7e892.1668403214.git.rtanwar@maxlinear.com>
 <Y3IOEFTZ1e/7uWJ4@smile.fi.intel.com>
 <00ce811f-2ec8-802d-d032-8ac2c65d06ff@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ce811f-2ec8-802d-d032-8ac2c65d06ff@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:00:02AM +0000, Rahul Tanwar wrote:
> On 14/11/2022 5:45 pm, Andy Shevchenko wrote:
> > On Mon, Nov 14, 2022 at 05:20:06PM +0800, Rahul Tanwar wrote:

...

> >> +     if (of_property_read_bool(dn, "intel,no-imcr")) {
> > 
> > I can't find this property in the Documentation/devicetree/bindings.
> > 
> > Moreover, I prefer to see positive one, something like:
> > 
> >          intel,virtual-wire-bla-bla-bla
> > 
> > Please consult with DT people on how properly name it.
> 
> 
> Yes, agree. Need to add it in bindings doc after finalizing the property 
> name. I chose "intel,no-imcr" to have a direct correlation with the MPS
> spec defined data field for the same purpose.

The problems with it are:
- it's negative
- it's too cryptic to one who doesn't know area well enough

> It reads below bit in 
> mpparse code to detect PIC mode or virtual wire mode.
> 
> Bit 7: IMCRP. When the IMCR presence bit is set, the IMCR is present and 
> PIC Mode is implemented; otherwise, Virtual Wire Mode is implemented.
> 
> Please refer [1]
> 
> [1] https://www.manualslib.com/manual/77733/Intel 
> Multiprocessor.html?page=40#manual

This is good reference for DT people to suggest you a better name.

-- 
With Best Regards,
Andy Shevchenko


