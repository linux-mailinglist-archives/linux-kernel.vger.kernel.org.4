Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493586A7221
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCARdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCARdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:33:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD8B22782;
        Wed,  1 Mar 2023 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677692014; x=1709228014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5qeKohc7NtvHPnm/kxWP0+JfrFL0Yyv5fIjX8vlHQvw=;
  b=TkHjvpuTP5wShNz/L4d9ZyM4PyA/31JSFHqgVogT04ptjyseK6jYfDGM
   NR+Ate2LdpJ96F4D8liuc1EV7rRtRIyU3G2Dq9hBp1V8+60mNCtVDGQyx
   VhScnrwmJbqyYMzK2dR8JUaPFKPnU5wAV3+6xkOzMU8W7jv34+8gEvgIN
   +vFR039E2RNcjm7r5oDLBSHQMvU5WwfU9pJ47Qb+bDrfvckIwO20ev4/t
   XEe8eoGQZ/yeSWgJh1AdkD6apFs36F8o23hdZLdAAtmYnkxpBDzAqut6A
   HT9ZIVaTArg+VDRU8Bspb4JHZV6TZ74fN1vPo7QrhWZwgOAl8cPC8yunb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="335966922"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="335966922"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 09:33:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="763674803"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="763674803"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Mar 2023 09:33:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXQKX-00DrEU-2j;
        Wed, 01 Mar 2023 19:33:29 +0200
Date:   Wed, 1 Mar 2023 19:33:29 +0200
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
Message-ID: <Y/+MaRO4vrCRFXE8@smile.fi.intel.com>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
 <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
 <20230227234411.jqmwshzkeyx6iqyo@skbuf>
 <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
 <20230301143625.7kdnzujlv4psbhla@skbuf>
 <Y/9qtT0vckSikOKJ@smile.fi.intel.com>
 <20230301152527.khyzifds4w3rkebt@skbuf>
 <Y/9wlDkuh39auAgF@smile.fi.intel.com>
 <20230301171845.oliqbso7v2vmyqr3@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301171845.oliqbso7v2vmyqr3@skbuf>
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

On Wed, Mar 01, 2023 at 07:18:45PM +0200, Vladimir Oltean wrote:
> On Wed, Mar 01, 2023 at 05:34:44PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 01, 2023 at 05:25:27PM +0200, Vladimir Oltean wrote:
> > > On Wed, Mar 01, 2023 at 05:09:41PM +0200, Andy Shevchenko wrote:
> > > > With overlays you can create the proper DT description stanza and end user's
> > > > job is to just put it somewhere and upload via precoded script or so [1].
> > > > 
> > > > [1]:https://docs.kernel.org/devicetree/overlay-notes.html
> > > 
> > > Ah, okay, no, that's already a no-go, since existing device tree blobs
> > > aren't compiled with the dtc "-@" flag which would generate the __symbols__
> > > node necessary for DT overlays to be applied over them.
> > > 
> > > That, and it's clunky and uncalled for in general, both from my
> > > perspective as a driver developer and that of a random user, if a driver
> > > would just start requiring device tree overlays for more functionality.
> > > Overlays address none of the complaints I had with large DT bindings
> > > being large in general. They are still equally large, but now, they are
> > > also spread into multiple files.
> > 
> > But isn't it what you would like to have working for your case?
> > 
> > Even taking into account the fixed HW layout, it would make sense to have more
> > flexible approach to describe it, no?
> 
> Not really, no...
> What I would like to have is a (partially) auto- (and dynamically-) generated
> firmware description.
> 
> I'd need that in order to have a cleaner separation between the device
> drivers for the various peripherals on that Ethernet switch SoC.
> Currently, there's a lot of monolithic code to drive those peripherals
> that lives in drivers/net/dsa/ but would belong to drivers/net/mdio,
> drivers/irqchip/, drivers/gpio/, things like that.
> 
> What I want is the logic that gets me there, with none of the complications
> for things I don't need.
> 
> > > > For the second one I'm not really the expert. But either FPGA framework (if
> > > > they have anything working for this), or you also may look at Thunderbolt /
> > > > USB4 which uses similar approach while being PCIe devices. Okay, the latter
> > > > (USB4) is the PCIe topology, while FPGA is whatever behind the PCI switch.
> > > > Meaning that FPGA case from HW p.o.v. is closer to your case.
> > > 
> > > A quick glance at Documentation/driver-api/fpga/ shows that it is a
> > > framework for dealing with reprogrammable hardware, and has infra to
> > > reprogram it. My hardware is fixed-function and doesn't need any of that.
> > > 
> > > Are you suggesting that I should look at reusing some common infra with
> > > the fpga subsystem instead? A quick grep for device_add in drivers/fpga/
> > > shows a bunch of open-coded device_add() and platform_device_add() calls.
> > > Is this what you wanted me to see or is there something else?
> > 
> > Ah, so they don't have a mechanism on how to describe the hardware inside
> > FPGA _after_ reconfiguration and apply it to the system? That's what I meant
> > when referred to it.
> 
> Reading Documentation/devicetree/bindings/fpga/fpga-region.txt (with my
> limited and ultra-superficial understanding), I guess that they still
> use overlays to describe what should be probed on the reprogrammed regions.

Yes, that's why I remember overlays approach and FPGA case.

I guess you have very similar requirements to get this done: your case is a
particular one for FPGA, i.e. (re-)loading the same HW layout over and over.

I believe it should be discussed with them being involved. We don't want to
have two approaches of similar things in the kernel.

-- 
With Best Regards,
Andy Shevchenko


