Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3CF6A6E7F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCAOdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCAOdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:33:22 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8FBEB4E;
        Wed,  1 Mar 2023 06:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677681201; x=1709217201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lUTOeRPA08xBu7g2RTi+QRPmI88RlYfPaGOyBpLRn98=;
  b=VxnKL29NAtHfhf4g6hrY/CvFsmVYZtL6PzgD+lbQa3w7OOteRzSI3mZZ
   kpgXrOQvr7uS/nnkPFlZ7ErMYDjeAHDXUEOaYO+O1gjEDAkXHY5bSv9Jo
   VI4yxKAFKT2ZMOx1QAkjj0oboQv+aW7Nwhf726BDi/rIjKHiFKC7Nzpxn
   eI932EnGGwzt0n9wZ9WCMl5d2Cx0TP5dvt79nSbriWEFii3snxMlhhN3z
   csV9No9Pj71HXcUWdzFKg2C1ZDRikrq7eHgYE+qmXVCBbveP1x/kGsSZQ
   H1/oAUc24+dGxQNy31sBP36jkXCzyiRqVvUhgYpP6oqP56falxuls03aa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="314842544"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="314842544"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 06:33:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="667882080"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="667882080"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 01 Mar 2023 06:33:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXNW8-00Dmwn-1v;
        Wed, 01 Mar 2023 16:33:16 +0200
Date:   Wed, 1 Mar 2023 16:33:16 +0200
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
Message-ID: <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
 <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
 <20230227234411.jqmwshzkeyx6iqyo@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227234411.jqmwshzkeyx6iqyo@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 01:44:11AM +0200, Vladimir Oltean wrote:
> On Tue, Feb 28, 2023 at 12:26:19AM +0200, Andy Shevchenko wrote:
> > I believe that there are few reasons for that:
> > 1) (besides that what Heikki mentioned);
> > 2) the software nodes only for quirks, seems you are trying to implement
> > something that should have to be implemented as proper DT / ACPI device node.
> > 
> > Can you elaborate why do you need that (as you see no other board file requires
> > this)?
> 
> Trying to keep the answer short while still answering the question.

Thank you, this is helpful to understand what you want.

Random idea #N+1 based on what you told is: how about DT / ACPI overlays?
Random idea #N+2 is: have you considered FPGA approach?

So, as far as I got it right the device _can_ be considered as hotpluggable
blackbox with a lot of hardware onboard. This is very much reminds me FPGA
sitting behind PCIe hotplug capable interface.

What do we have now there? Can we spread the same approach for your case?

Because to me board files here looks like a hack.

P.S.
Yeah, I know that SPI is not hotpluggable bus per se. It may be that
we actually need to reboot machine after plugging in/out the device.

> I'm working with some hardware which is rather complex (a full SoC with
> many peripherals inside) which is controlled by a larger SoC running
> Linux, over SPI.
> 
> As you point out, to describe the peripherals inside the SPI-controlled
> SoC would logically require writing a device tree with their register
> addresses within the small SoC address space, interrupt routing, clocks,
> yadda yadda.
> 
> However, this means several hundreds of lines of DT description, but
> this is a SPI device. So it's not like I could toss this description in
> some sort of SoC .dtsi which a board file would just include, because
> this dtsi might need to be instantiated twice or more in a single board
> DTS (depends on how many SPI devices there are, physically), and there
> isn't a really good way to parameterize what would be a huge macro
> (C preprocessor) essentially.
> 
> This, plus that 90% of that device tree description wouldn't tell the
> driver something it couldn't know already (nothing board-specific about
> this information). I'm not a fan of huge device tree descriptions where
> driver-level knowledge would do just fine. That SoC is currently
> supported by Linux using some bindings like this (simplifying, of course.
> There are some board-specific properties inside this node, which I've omitted):
> 
> &spi {
> 	ethernet-switch@0 {
> 		reg = <0>; // chip select
> 		compatible = "compatible";
> 	};
> 
> 	ethernet-switch@1 {
> 		reg = <1>; // chip select
> 		compatible = "compatible";
> 	};
> };
> 
> To get descriptions for all its peripherals, I'd have to describe it
> like this:
> 
> &spi {
> 	soc@0 {
> 		reg = <0>; // chip select
> 		compatible = "compatible";
> 		#address-cells = <1>; // address space of the SPI device's memory map
> 		#size-cells = <1>;
> 
> 		ethernet-switch@base-addr-1 {
> 			reg = <base-address-1>;
> 			compatible = "compatible";
> 		};
> 
> 		peripheral@base-addr-2 {
> 			reg = <base-address-2>;
> 			compatible = "compatible";
> 		};
> 
> 		some-other-peripheral@base-addr-3 {
> 			reg = <base-address-3>;
> 			compatible = "compatible";
> 		};
> 
> 		...
> 	};
> 
> 	soc@1 {
> 		// more of the same
> 	};
> };
> 
> So random idea #1 is: device trees where "ethernet-switch" is a child of
> "&spi" (first form) exist in the wild, and that's a fact. To change
> those device trees to the new format would break forward compatibility,
> since old kernels will not understand what to do with them (no driver
> for "soc@0").
> 
> Random idea #2: even if I had the option to start fresh, there is just
> too much boilerplate to put in the device tree, and I'd still go for the
> minimalist bindings. Otherwise it's a pain for the end user (board
> device tree author), first of all. Lots of ways to write it wrong and
> only a single way to get it right. And no reason to let him do it.
> 
> With the minimalist bindings, it becomes the responsibility of the
> "ethernet-switch" driver to have knowledge of the peripherals which are
> present in that SoC, and instantiate dedicated (not monolithic) drivers
> for them somehow, at their right base addresses. My current work in
> progress is to create software nodes + mfd (in the spi device driver),
> and platform device drivers for peripheral@base-addr-2,
> some-other-peripheral@base-addr-3 etc, which have no backing OF node.
> 
> There are some other variations on this theme which also made me focus
> on software nodes + mfd as a way to make sub-drivers of a larger
> OF-based driver more modular, without changing device tree bindings.

-- 
With Best Regards,
Andy Shevchenko


