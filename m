Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633E363C5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiK2Qx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiK2Qxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:53:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772E4748CA;
        Tue, 29 Nov 2022 08:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669740540; x=1701276540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ivbQv4Ys8jAWmrimJAmEXkGgasUDYcsZtmbNGEPMZeo=;
  b=NZklI9LdhW0vjIugue/w11mX1azN51DV8QDe4vTfAhwbO5eA/XioMUip
   ECOzRbMxLmg4CmB1+01lzWTSFp3L8pHRiZX9LKz89eDH5MSu6jpQBE2qF
   1/gcB1lsrL/aYNdnCZH0+o/JKsIEJA0OlF0rfNGD0NXxDfSOr0Le4KuL6
   XDKd7XQ8LrcIXog9eYO2J1DugSPaDIgZGGc+OJm0A+5nhbg24+BhhRlnf
   9vtQbZoAEsWRdqlPTPHTa8KRqkDbfq6PrnwbimrI3tRosZsl5e/JptQNj
   m4oBWkujTAdmYLZkxHjxnNuvDzVm/XVEIy0pNfnGXpNKZK4q3A1FaeXoc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="315194180"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="315194180"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="712439193"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="712439193"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2022 08:48:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p03mB-001n98-2j;
        Tue, 29 Nov 2022 18:48:07 +0200
Date:   Tue, 29 Nov 2022 18:48:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] gpiolib: Introduce gpio_device_get() and
 gpio_device_put()
Message-ID: <Y4Y3x/Fd098rRVbz@smile.fi.intel.com>
References: <20221125181158.67265-1-andriy.shevchenko@linux.intel.com>
 <20221125181158.67265-2-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mf14Q7_gMXaK+hZ8PdV2U5GiL97QRc3SGKLPqmEuSyDxA@mail.gmail.com>
 <Y4YbkUX+bTM5ZEGg@smile.fi.intel.com>
 <CAMRc=MfAJpcvCj+NZcg554XC07VYXAb2p9vb+fq6x_O4j+trjQ@mail.gmail.com>
 <Y4YxiHISfSs8crRa@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4YxiHISfSs8crRa@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:21:28PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 29, 2022 at 04:49:34PM +0100, Bartosz Golaszewski wrote:
> > On Tue, Nov 29, 2022 at 3:47 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Nov 29, 2022 at 02:54:10PM +0100, Bartosz Golaszewski wrote:

...

> > > That said, this can be submitted after v6.2-rc1 is out.

Btw, since you are trying to fix a user space race, I would like to
postpone this since it will conflict with that one anyway.

-- 
With Best Regards,
Andy Shevchenko


