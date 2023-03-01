Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20296A6F0A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCAPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCAPKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:10:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5100946A5;
        Wed,  1 Mar 2023 07:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677683406; x=1709219406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GZKkYyw/+6en+ZNdpH/LDyrmPrTHoHwB5M8HldeClUY=;
  b=c0wm525nhju3XRwr7bYrkt5xWzoOG/3UrsjXWHiHTMJcrSc9HOtKegHD
   CfR4vcove7CDyAbWa4Ur4qJXbLZ0ou1/XP7jeFz2zKUU1CZ1zEiKBPWZo
   JI7zX7j99bIhpTPbKenIi2igdkPSJGIvr6VCGEyargJlwrp2kChcYjxZx
   Ctd66fTsTuc7qjSw2wo85mSmGfzxhJ/7G/EhIuu7MWJ/MrV0hDQeU2GNp
   owPPce6wh89RKalZ+bxln2Fi5SrLiozDSnPuZRnp/+gaQ8ktNlsBzL6Ma
   h3UwJryDgUSXw31uFt1RIsLDkdQ6MY/dH3OSYDTCixyWiMO1t/LScYhYD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="322693413"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="322693413"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 07:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="707009096"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="707009096"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2023 07:09:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXO5N-00DnwK-23;
        Wed, 01 Mar 2023 17:09:41 +0200
Date:   Wed, 1 Mar 2023 17:09:41 +0200
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
Message-ID: <Y/9qtT0vckSikOKJ@smile.fi.intel.com>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
 <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
 <20230227234411.jqmwshzkeyx6iqyo@skbuf>
 <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
 <20230301143625.7kdnzujlv4psbhla@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301143625.7kdnzujlv4psbhla@skbuf>
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

On Wed, Mar 01, 2023 at 04:36:25PM +0200, Vladimir Oltean wrote:
> On Wed, Mar 01, 2023 at 04:33:16PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 28, 2023 at 01:44:11AM +0200, Vladimir Oltean wrote:
> > > On Tue, Feb 28, 2023 at 12:26:19AM +0200, Andy Shevchenko wrote:
> > > > I believe that there are few reasons for that:
> > > > 1) (besides that what Heikki mentioned);
> > > > 2) the software nodes only for quirks, seems you are trying to implement
> > > > something that should have to be implemented as proper DT / ACPI device node.
> > > > 
> > > > Can you elaborate why do you need that (as you see no other board file requires
> > > > this)?
> > > 
> > > Trying to keep the answer short while still answering the question.
> > 
> > Thank you, this is helpful to understand what you want.
> > 
> > Random idea #N+1 based on what you told is: how about DT / ACPI overlays?
> > Random idea #N+2 is: have you considered FPGA approach?
> > 
> > So, as far as I got it right the device _can_ be considered as hotpluggable
> > blackbox with a lot of hardware onboard. This is very much reminds me FPGA
> > sitting behind PCIe hotplug capable interface.
> > 
> > What do we have now there? Can we spread the same approach for your case?
> > 
> > Because to me board files here looks like a hack.
> > 
> > P.S.
> > Yeah, I know that SPI is not hotpluggable bus per se. It may be that
> > we actually need to reboot machine after plugging in/out the device.
> 
> Can you please give me some clearer references for #N+1 and #N+2?

> I haven't considered either of those options and I'm not sure what that
> would entail.

With overlays you can create the proper DT description stanza and end user's
job is to just put it somewhere and upload via precoded script or so [1].


For the second one I'm not really the expert. But either FPGA framework (if
they have anything working for this), or you also may look at Thunderbolt /
USB4 which uses similar approach while being PCIe devices. Okay, the latter
(USB4) is the PCIe topology, while FPGA is whatever behind the PCI switch.
Meaning that FPGA case from HW p.o.v. is closer to your case.

[1]:https://docs.kernel.org/devicetree/overlay-notes.html

-- 
With Best Regards,
Andy Shevchenko


