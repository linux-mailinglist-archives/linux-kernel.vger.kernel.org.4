Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C2661F259
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiKGMDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiKGMDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:03:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229F5AE49;
        Mon,  7 Nov 2022 04:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667822616; x=1699358616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Z1kJ88PxVSnKX0ubwde7m8W4wYIIR6Ene1mnU2DV/8c=;
  b=MCcP5KWLULmGwShwZSmvg2XYy/njSelSzi4F6W1Nasqj/RiiGL/1TdYT
   vO+5t6hiy1oeHsv7+pLDFtYgxTFZd7DDrG24V8YA/CjY5mkw33wTDJQzS
   EItYLANt/+/bI5ijruKyaiVMNzFDDh87q2inV7BrFsRelPYDJjrC5USiK
   0r7yyOYPkleBGddgNMqK5G12VRx34C2VbKBH3FzbMLRoqgJvkngBR0gIO
   takTxyoMPWNBqn+vo129wY7iW/mVAsheADY4NzCKCHnLYhC9GCdB7g+D4
   81zV7U3NMMQpaZFEtkHVTAgfy0Lc9zOTMlx73XlAOmVPB7l+OpaK/I32t
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="312158411"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="312158411"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 04:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="881047014"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="881047014"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 07 Nov 2022 04:03:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os0qg-008cPz-1R;
        Mon, 07 Nov 2022 14:03:30 +0200
Date:   Mon, 7 Nov 2022 14:03:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?utf-8?Q?J=EF=BF=BDrvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] 8250: DMA Fixes
Message-ID: <Y2j0EmqkH8f57q9N@smile.fi.intel.com>
References: <20221107110708.58223-1-ilpo.jarvinen@linux.intel.com>
 <Y2js3Xsq1Fmz1mTq@smile.fi.intel.com>
 <b66aa1-50ab-ecc-1633-d6e83f5cd925@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b66aa1-50ab-ecc-1633-d6e83f5cd925@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 01:50:38PM +0200, Ilpo Jï¿½rvinen wrote:
> On Mon, 7 Nov 2022, Andy Shevchenko wrote:
> 
> > On Mon, Nov 07, 2022 at 01:07:04PM +0200, Ilpo Järvinen wrote:
> > > Here are a number of 8250 DMA related fixes. The last one seems the
> > > most serious problem able to corrupt the payload ordering.
> > > 
> > > Ilpo Järvinen (4):
> > >   serial: 8250: Fall back to non-DMA Rx if IIR_RDI occurs
> > 
> > 8250_port?
> > 
> > >   serial: 8250_lpss: Configure DMA also w/o DMA filter
> > >   serial: 8250_lpss: Use 16B DMA burst with Elkhart Lake
> > >   serial: 8250: Flush DMA Rx on RLSI
> > 
> > 8250_port?
> 
> Why?

> To me this 8250_core/port split is still integral part of the same 
> 8250 even if they're in the end technically loaded into different modules
> or the code is in a different file. There's even some trickery to access 
> internals of the other part to workaround the circular module dependency 
> logic that would otherwise prevent the split (like we learned not so long 
> time ago with that setup_irq change).

> I can start to use 8250_port if you insist but it seems pointless 5 extra 
> characters out from a resource that is scarse to begin with, IMHO (the 
> summary line is not that long).

No strong opinion here, I just follow (in my patches) the following logic:
- if it touches a single file, I use full prefix,
- otherwise I use 8250

-- 
With Best Regards,
Andy Shevchenko


