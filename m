Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AFA6A8584
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCBPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCBPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:47:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A053E61A;
        Thu,  2 Mar 2023 07:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677772021; x=1709308021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JAipvvtID4UIsHFYIMs4dTvpzhPgRpYEfN79S7XKdlo=;
  b=JF/Z+PcmyTkpkWhW9ADXA6qJ7638J9e8SaovHjk023fGlhW3dFe7r4aI
   7BoAjB+XdTLHQcHLys5uLpyJJWM5fkUAtFfjkIw71Cd0L/K/I3hwWJNOk
   ks/LhDUiPat5ryCevpxoI4YSu5YmHhxxaWexjvQP7bJvoDX5SamYnEZM2
   dNMHKhlDMa5VSRkSxNFdfSkxCwMoP4xsW7OLTmgwPz93f9pkILXX5Ns0j
   OmzAgK8325zGOSJiWirTQzXGXw9bEbbWAqj85/SNeIgNVQjBZGeEd/Zkr
   hz6fMVMSJQcSOvxeyDGk6/YHDbmELwAF/hhHiLVxtv14QklrdDZiDOrnd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="318571371"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="318571371"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 07:47:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="707452421"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="707452421"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 02 Mar 2023 07:46:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXl8w-00EPc3-14;
        Thu, 02 Mar 2023 17:46:54 +0200
Date:   Thu, 2 Mar 2023 17:46:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 2/3] leds: simatic-ipc-leds-gpio: split up into
 multiple drivers
Message-ID: <ZADE7kBB9HzTlpul@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
 <20230301170215.23382-3-henning.schild@siemens.com>
 <Y/+LLICwh3T25IGv@smile.fi.intel.com>
 <20230302094009.74b5d368@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230302094009.74b5d368@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 09:40:09AM +0100, Henning Schild wrote:
> Am Wed, 1 Mar 2023 19:28:12 +0200
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > On Wed, Mar 01, 2023 at 06:02:14PM +0100, Henning Schild wrote:

...

> > > +	.driver = {
> > > +		.name = KBUILD_MODNAME,  
> > 
> > Strictly speaking this is an ABI (as something may instantiate the
> > driver from the user space or elsewhere by this name. At the same
> > time this may change with the file name change.
> > 
> > Personally I prefer explicit string literal here.
> 
> Switching from one module to three the names have to change. People who
> explicitly loaded the old module which supported multiple machines,
> will now how to load either both oŕ know which one to load.

Wait, are you telling that now users load modules _manually_?!

> I personally think the ABI change is acceptable, the assumption would
> be that the drivers load automatically anyhow. And since there are no
> params i doubt users will have /etc/modprobe.d/ or /sys/module/ stuff
> around.
> 
> And with the split i guess an ABI change can not be fully avoided.
> Whether the names is explicit or implicit is another discussion and
> just a matter of style. I prefer to stay with the currently used
> pattern, it is not un-common in the kernel.

The problem with that pattern is possible, while unlikely, renaming of the file
which triggers this to be updated.

Under sysfs the folder will change its name. If user has a script relying on
this, it will be broken. So, I prefer mine.

> > > +	},  

-- 
With Best Regards,
Andy Shevchenko


