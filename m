Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0F6A8634
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCBQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCBQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:21:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F205504C;
        Thu,  2 Mar 2023 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677774085; x=1709310085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=502TDYPD+P5WlMFQrS9KeOupKAiUNlCfEA+GuL2sdNU=;
  b=U4pxqokuSXDC3LypaumrPxAbTwoxYcZnQyb3sH/qcZaoPiVDIfHQwkEj
   LE+pmDqOgNlPz14b2OW1EoPqL8qX4Jd9+YxZ/srGbeqnoFu8LmgyXSUqO
   b02saAcY5CZe48g5iaK5YoqnlIK7fYBgIt2KJrBTxhAsDLkEYtNJoAG67
   KmQasGF/cWLTvixp5qBRK18j42SCUlIHpDVbNQc5/vNazj3xzU5GpfsFJ
   vLMQdFsUiF4a3eh1dNFDtUKst4XjWFbrUK3UcPla3vDsjdc8FGfWbfBiJ
   LX0ipw46YAtX1/JetvA6ipFEa770S6gejZc0YagfbHfdepFzrWbvTLfvC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="315184452"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="315184452"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 08:21:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="920759225"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="920759225"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2023 08:21:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXlgH-00EQQJ-0u;
        Thu, 02 Mar 2023 18:21:21 +0200
Date:   Thu, 2 Mar 2023 18:21:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 2/3] leds: simatic-ipc-leds-gpio: split up into
 multiple drivers
Message-ID: <ZADNAQbmxC3hdgl3@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
 <20230301170215.23382-3-henning.schild@siemens.com>
 <Y/+LLICwh3T25IGv@smile.fi.intel.com>
 <20230302094009.74b5d368@md1za8fc.ad001.siemens.net>
 <ZADE7kBB9HzTlpul@smile.fi.intel.com>
 <20230302165824.4868f6da@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230302165824.4868f6da@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 04:58:24PM +0100, Henning Schild wrote:
> Am Thu, 2 Mar 2023 17:46:54 +0200
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > On Thu, Mar 02, 2023 at 09:40:09AM +0100, Henning Schild wrote:
> > > Am Wed, 1 Mar 2023 19:28:12 +0200
> > > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:  
> > > > On Wed, Mar 01, 2023 at 06:02:14PM +0100, Henning Schild wrote:  

...

> > > > > +	.driver = {
> > > > > +		.name = KBUILD_MODNAME,    
> > > > 
> > > > Strictly speaking this is an ABI (as something may instantiate the
> > > > driver from the user space or elsewhere by this name. At the same
> > > > time this may change with the file name change.
> > > > 
> > > > Personally I prefer explicit string literal here.  
> > > 
> > > Switching from one module to three the names have to change. People
> > > who explicitly loaded the old module which supported multiple
> > > machines, will now how to load either both oŕ know which one to
> > > load.  
> > 
> > Wait, are you telling that now users load modules _manually_?!
> 
> No i am not, the modules all load automatically. I was trying to
> construct a hypothetical case where the name change could affect users
> doing unexpected things.
> 
> > > I personally think the ABI change is acceptable, the assumption
> > > would be that the drivers load automatically anyhow. And since
> > > there are no params i doubt users will have /etc/modprobe.d/ or
> > > /sys/module/ stuff around.
> > > 
> > > And with the split i guess an ABI change can not be fully avoided.
> > > Whether the names is explicit or implicit is another discussion and
> > > just a matter of style. I prefer to stay with the currently used
> > > pattern, it is not un-common in the kernel.  
> > 
> > The problem with that pattern is possible, while unlikely, renaming
> > of the file which triggers this to be updated.
> > 
> > Under sysfs the folder will change its name. If user has a script
> > relying on this, it will be broken. So, I prefer mine.
> 
> Yes, the name of the module will change ... and the location of module
> metadata and params in sysfs, both not a big deal here. Because there
> are no params, and there is not need to modprobe manually.

It's not only one folder AFAIU. Also folder in the drivers will change
its name. Parameters is one thing, the folder presence is another.

Yes, the case is quite unlikely to happen (to break anyone's setup)
that's why I started this with 'Strictly speaking...'. So, seems you
are staying on your side, I will leave this to maintainers. If they
are fine, I will have no objections.

> > > > > +	},    

-- 
With Best Regards,
Andy Shevchenko


