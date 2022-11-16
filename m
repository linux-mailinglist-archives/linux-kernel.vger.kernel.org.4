Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C8562BF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKPN3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiKPN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:29:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97F4450A7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668605375; x=1700141375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XUU7tDNgYGoWHHgbI4B+EDpkeBTZbCvGBKabd0d70uw=;
  b=OTNybwqBwSh72195APyCi4yYM5PwLwFqET6NQGjx7u0EpwAvgAscK4mL
   zfngwXuwWjmxeQTtRJTzgO5cT+iACnzALRiIclJGYuNmaf0pcv0E8yHgh
   edayo6XSr6n0mlpNp2Cexi1H5eLfEmWWjsJOw0IFw8+oZuGI5PVcSQihw
   VgHHKqPriPoltb9aP8WwovR6G3P0KS30+NCQjYVLghsacXC9uWdM8RTXw
   G5gzGYLjTVj79x9Z67atlpAE9HAXOSBM0QY8cH1ocvt8Dv3LxvZfMC0lP
   wd5b8w5wIC/zAXlGmHgRnQXfpY+2Uy4QpsAQfhreqDs77XzcfR68O0/cZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292248058"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292248058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 05:29:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="672391618"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="672391618"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 16 Nov 2022 05:29:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovITs-00D8sV-0I;
        Wed, 16 Nov 2022 15:29:32 +0200
Date:   Wed, 16 Nov 2022 15:29:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Fei Li <fei1.li@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <Y3Tlu0BjgMk3xNDQ@smile.fi.intel.com>
References: <20221116092254.66234-1-andriy.shevchenko@linux.intel.com>
 <Y3TMmDXEbGyDQrLF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3TMmDXEbGyDQrLF@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:42:16PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 16, 2022 at 11:22:54AM +0200, Andy Shevchenko wrote:
> > After the commits for userspace (see Link tags below) the uuid field is
> > not being used in the ACRN code. Update kernel to reflect these changes.
> > I.e. we do the following:
> > - adding a comment explaining that it's not used anymore
> > - replacing the specific type by a raw buffer
> > - updating the example code accordingly
> > 
> > The advertised field confused users and actually never been used. So
> > the wrong part here is that kernel puts something which userspace never
> > used and hence this may confuse a reader of this code.

> > - * @uuid:		UUID of the VM. Pass to hypervisor directly.
> > + * @uuid:		Reserved (used to be UUID of the VM)
> 
> If it's reserved, then don't you need to check for 0?

Reserved in a way that it may content something we just don't care about.

...

> > +	__u8	uuid[16];
> 
> You just changed the type here, so what is that going to break in
> userspace that depended on this being of a structure type and now it's
> an array?

It's the same. The previous was hidden behind additional type level.

> And no other kernel changes needed?  Shouldn't you warn if this field is
> set?

No, as pointed out in the commit message kernel never ever used this.

-- 
With Best Regards,
Andy Shevchenko


