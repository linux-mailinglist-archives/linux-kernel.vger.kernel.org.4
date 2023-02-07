Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCA368DED7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBGRZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjBGRYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:24:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC56810424;
        Tue,  7 Feb 2023 09:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675790692; x=1707326692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9xrRpquyUcNbyxXOKJwhHLAwKl6JNnIm4Wb4TxBKwhg=;
  b=NNa90n7GNnNOPC8Q7aEJsN/92O20DA9BJ08GBvEb4qvabYsdF2ihDmoI
   ABCnz5MTLVPoM1senFI/xVJHYfxfmsUg483urA/5QPH5gY+mQY6Y9nuhE
   cf8wo5ui6O+s77x7pmtLovPKM63mG4FN4SWRcnDFu9EQ93kTokLiR+s7X
   lOLm/2+NdS1vl5M8hReGgHuYI8QhMN1ng0Ej39hHlp0ejuzrMlkeoMRpL
   AzPAd1sPqQ6AfMzlyNaCPaV4aDgDfsQhlk6ORpLY3bqdH2/DvpcoL0f9Y
   PVyV66MHXuZxDLhucKgQt6cnJFgRvaknuy/5cCR1feG3GP8L24serP3Vn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="317536490"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="317536490"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 06:44:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="755642583"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="755642583"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Feb 2023 06:44:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B38A61C5; Tue,  7 Feb 2023 16:45:22 +0200 (EET)
Date:   Tue, 7 Feb 2023 16:45:22 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     mauro.lima@eclypsium.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: intel: Remove DANGEROUS tag from pci driver
Message-ID: <Y+JkArdW747OtMO9@black.fi.intel.com>
References: <20230206183143.75274-2-mauro.lima@eclypsium.com>
 <20230207135254.2465816-1-michael@walle.cc>
 <Y+JaKF4FZQKqeGs7@black.fi.intel.com>
 <8797addc6c063b867b94cce352191aab@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8797addc6c063b867b94cce352191aab@walle.cc>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 07, 2023 at 03:11:26PM +0100, Michael Walle wrote:
> Hi Mika,
> 
> Am 2023-02-07 15:03, schrieb Mika Westerberg:
> > On Tue, Feb 07, 2023 at 02:52:54PM +0100, Michael Walle wrote:
> > > > Modern CPUs exposes this controller as PCI device that only uses
> > > > hardware sequencing capabilities which is safer than software
> > > > sequencing.
> > > > Leave the platform driver as *DANGEROUS* and update help text since
> > > > most of these controllers are using software sequencing.
> > > 
> > > Out of curiosity, what is hardware sequencing? Maybe this should
> > > be explained a bit more in the Kconfig help text. Looks like the
> > > dangerous was there because you can update the bios and that
> > > could eventually lead to a bricked mainboard. So hardware
> > > sequencing helps there? how?
> > 
> > Hardware sequencing means the controller exposes just a bunch of "high
> > level" operations to the software.
> 
> Ok, I figured it would have been something to do with the SPI driver
> just supporting these high level ops. But even with that background
> it was hard to connect that to the "hardware sequencing". The help
> text should be somewhat understandable to the user/distro people/whoever,
> right? So I'd suggest to explain that a bit more in detail, or don't
> use the term hardware sequencing at all. I'm not sure.

I agree it should be made more understandable for the distro folks. At
least add some explanation why it is OK to select this.

Mauro, can you do that in the next version?

> > Such as read, write, erase and so on
> > but does not allow running the actual "low level" SPI-NOR opcodes.
> > Software sequencing on the other hand allows running pretty much any
> > opcode and this is what caused problems for certain Lenovo laptops few
> > years back that then resulted adding DANGEROUS to the Kconfig.
> 
> That information should go into the commit message.

+1
