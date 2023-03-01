Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A776A6FD4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCAPex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjCAPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:34:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFA12B28D;
        Wed,  1 Mar 2023 07:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677684889; x=1709220889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I9PqVo+xN7TbKIQQKjJpJiyeMifXqTzwWAA4D4p0X9s=;
  b=XiQv32CcruN8tzHB/Hx16G21sT4nbgi75YDavZj+TaEe7nw9ihNqWa9P
   wOT/ho4G4LJI2YEpRzBd+mHIEhTck5hS+5DlzBHsHTu+C56EpVl4VFZC0
   c5e0n2Y86EK7Y0jwngZ1Jk8cpCeSWU2koik/KWOcDV6Z4dvFa2XyYAOS9
   w91YOZ6HONMR4e936NBsEOyKFOqCVAQ1YGrljO75iwIdIAl2BPHbgJ3No
   DQpMWfbwbNfUgKlEi2+i3pxT0PLNCXmDSZ174I3KV2rRYtwBpMuj/1PxF
   jCUjQW1Op2W6jetqFSf6W3aM8XrMrOMrc3l9EBjC6aB+EUWNabiRLAg3g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420699629"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420699629"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 07:34:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="798449312"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="798449312"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2023 07:34:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXOTc-00DoSW-2g;
        Wed, 01 Mar 2023 17:34:44 +0200
Date:   Wed, 1 Mar 2023 17:34:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Implementation of fwnode_operations :: device_get_match_data()
 for software nodes?
Message-ID: <Y/9wlDkuh39auAgF@smile.fi.intel.com>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
 <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
 <20230227234411.jqmwshzkeyx6iqyo@skbuf>
 <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
 <20230301143625.7kdnzujlv4psbhla@skbuf>
 <Y/9qtT0vckSikOKJ@smile.fi.intel.com>
 <20230301152527.khyzifds4w3rkebt@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301152527.khyzifds4w3rkebt@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 05:25:27PM +0200, Vladimir Oltean wrote:
> On Wed, Mar 01, 2023 at 05:09:41PM +0200, Andy Shevchenko wrote:
> > With overlays you can create the proper DT description stanza and end user's
> > job is to just put it somewhere and upload via precoded script or so [1].
> > 
> > [1]:https://docs.kernel.org/devicetree/overlay-notes.html
> 
> Ah, okay, no, that's already a no-go, since existing device tree blobs
> aren't compiled with the dtc "-@" flag which would generate the __symbols__
> node necessary for DT overlays to be applied over them.
> 
> That, and it's clunky and uncalled for in general, both from my
> perspective as a driver developer and that of a random user, if a driver
> would just start requiring device tree overlays for more functionality.
> Overlays address none of the complaints I had with large DT bindings
> being large in general. They are still equally large, but now, they are
> also spread into multiple files.

But isn't it what you would like to have working for your case?

Even taking into account the fixed HW layout, it would make sense to have more
flexible approach to describe it, no?

> > For the second one I'm not really the expert. But either FPGA framework (if
> > they have anything working for this), or you also may look at Thunderbolt /
> > USB4 which uses similar approach while being PCIe devices. Okay, the latter
> > (USB4) is the PCIe topology, while FPGA is whatever behind the PCI switch.
> > Meaning that FPGA case from HW p.o.v. is closer to your case.
> 
> A quick glance at Documentation/driver-api/fpga/ shows that it is a
> framework for dealing with reprogrammable hardware, and has infra to
> reprogram it. My hardware is fixed-function and doesn't need any of that.
> 
> Are you suggesting that I should look at reusing some common infra with
> the fpga subsystem instead? A quick grep for device_add in drivers/fpga/
> shows a bunch of open-coded device_add() and platform_device_add() calls.
> Is this what you wanted me to see or is there something else?

Ah, so they don't have a mechanism on how to describe the hardware inside
FPGA _after_ reconfiguration and apply it to the system? That's what I meant
when referred to it.

-- 
With Best Regards,
Andy Shevchenko


