Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D114F60D1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJYQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiJYQsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:48:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361D6DEF0E;
        Tue, 25 Oct 2022 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666716500; x=1698252500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PTfZYzA7Md3yE1gNhg4Yx2147Cs8jhU+SIh1loNXQTk=;
  b=j/gOCbS6SjXqXJ3CSYFzX3uIQJUdUGgkYQzqVaznkzgmOskeftNpBpNN
   ig4MbINu/ehCggFYK/AmWIkdXRXBUwHJx2Slfi9fSWxYkZT8Ca4FjG7vg
   yoe/pbuuLiBvTKX4FGqtO0YyrBcy1DiQILju0IwRTFIB18TM4dwsH12Ud
   pBYG0o26QgE52rAQZJQotGiPkf/X1bqzMe+RcCa4jaXUQCwYw1nxgebS4
   AuxRUpkQxUzbeagQ+SKg3O8zb54FGDEAclxMtKzWxhcVR9T4IQ//U/c/N
   oDyP1cm05mevYlp1NAyA/oL0erxMcoQQLRgyRFxuR2PWZ5+nOaHK+6vbs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="308825589"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="308825589"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 09:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="700607829"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="700607829"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2022 09:47:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1onN5l-0026ut-2T;
        Tue, 25 Oct 2022 19:47:53 +0300
Date:   Tue, 25 Oct 2022 19:47:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Xiang Yang <xiangyang3@huawei.com>,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] gpiolib: acpi: Use METHOD_NAME__AEI macro for
 acpi_walk_resources
Message-ID: <Y1gTObc/opDBactf@smile.fi.intel.com>
References: <20221020014426.188667-1-xiangyang3@huawei.com>
 <CAMRc=Md6nseghBwfiRCL0KQ1BJ0WE7MH9QENf=HdJdnC1Xz1Fg@mail.gmail.com>
 <Y1FSRJC9s+7cvJI3@smile.fi.intel.com>
 <CAMRc=Mc-BvPRnORT+bm8LL5H3eG5-AOsN1fAaizXdhjZ=2E7xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mc-BvPRnORT+bm8LL5H3eG5-AOsN1fAaizXdhjZ=2E7xQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 04:30:27PM +0200, Bartosz Golaszewski wrote:
> On Thu, Oct 20, 2022 at 3:51 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 20, 2022 at 03:23:27PM +0200, Bartosz Golaszewski wrote:

...

> > I think I will take it. Care to provide your tag?
> 
> Just take it, I will back it out.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


