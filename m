Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3477D67BB89
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjAYUBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjAYUBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:01:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F50C1727;
        Wed, 25 Jan 2023 12:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674676881; x=1706212881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qMIkX4c6b/zZjz0//EdYQvdotj4hd6Z/383EopROc2k=;
  b=eYZux95CRDYOnHN/xZxPjUQE8l2EO7F2by+IrRfVAblY51o23Lv7LMHo
   sZlE5SGnX8I29ndxmsyYHGJ2rFvauNP5KM7ZjwWliQxNLFz/RTv1eQ8wZ
   EZZnjgpdrdSuYYcclUy6inu80K4fqQ0ApjYRCqtYODgExOY+/OsMX7XBc
   fOqi2UXwLkxheGz8cLevywMsAu7+ZDiusI+nnK8f/HiPYVXSoVOmLX3/J
   Dps+ndc5jqrbmDO/IKE+Fr9WuzQ+p8NIff873Y0vTRefdLX/LWaSFOcuE
   zmRMsjR2Somtm00AuMka6jhhCewMq+Lw7avSUo4qLQa4VEeNSA4CIIQ+c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="314567718"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="314567718"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 12:01:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="751337105"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="751337105"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jan 2023 12:01:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKlxN-00F3jg-2e;
        Wed, 25 Jan 2023 22:01:17 +0200
Date:   Wed, 25 Jan 2023 22:01:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] usb: gadget: Use correct APIs and data types for
 UUID handling
Message-ID: <Y9GKje/7t79cxecC@smile.fi.intel.com>
References: <20230125143425.85268-1-andriy.shevchenko@linux.intel.com>
 <CAMUOyH2Kc6hL4564sYDZdGRjiJJYmDA5WXEsF92p_xN8iZGMsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMUOyH2Kc6hL4564sYDZdGRjiJJYmDA5WXEsF92p_xN8iZGMsg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 06:31:36PM +0100, Jó Ágila Bitsch wrote:
> On Wed, Jan 25, 2023 at 3:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > We have two types for UUIDs depending on the byte ordering.
> > Instead of explaining how bytes should go over the wire,
> > use dedicated APIs and data types. This removes a confusion
> > over the byte ordering.
> 
> Thanks for pointing this out. I was unaware of the exact UUID
> functions, as I'm still quite a newbie here.
> 
> I compiled and tested your patch in my test setup and it works perfectly.

Thanks for the testing. According to Submitting Patches documentation
you can provide a formal Tested-by tag.

-- 
With Best Regards,
Andy Shevchenko


