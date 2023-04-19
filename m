Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5486C6E8078
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjDSRfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDSRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:35:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E268A6A6E;
        Wed, 19 Apr 2023 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681925711; x=1713461711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4qXm5eWpcBEMDu4cseUDl5qOFRKxr2ED5XonItnH7PA=;
  b=oCDaDlKTEN/8FUQjfUg1Zqw8UKbZkDprPZyrUiIWy8zE0Zuh4zKDIENL
   u84UdS5xmiiSC+WwH+68n/7XTM9R920gBLcPkdB2Ls3V3x2aBGsjI05uY
   sAM74zSvmNkkwf5WArV4VRZeWpiqFYqfQOE/bAxi62XND6RUsjUpy6PfJ
   A0ox9j8WVUDYViqUV3oFMqkFOG90z0YiWdXC54z3dqAMCDjRHNRmv0Rnb
   1Q3nSZLtMNUdci90IpmZTvd1ZDHUXivDBrzQ6kOVgowRYSyQUtRRmrZ0G
   2CIBrINQvt0DYsZsDMewFRnUDVoWBBrb8L2UVapD1cl33BTj9hfTYTRqK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="342993840"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="342993840"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 10:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="937755813"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="937755813"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 19 Apr 2023 10:35:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ppBhz-002KRH-2A;
        Wed, 19 Apr 2023 20:35:07 +0300
Date:   Wed, 19 Apr 2023 20:35:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v7 4/5] spi: dw: Add DMA address widths capability check
Message-ID: <ZEAmS3huMHla7Ifo@smile.fi.intel.com>
References: <20230418052902.1336866-1-joychakr@google.com>
 <20230418052902.1336866-5-joychakr@google.com>
 <ZD5JC7BdN1usn6Kd@smile.fi.intel.com>
 <CAOSNQF2sXHFCx9ZfrtfmxHfKrAE0XGP8SRvW6wyYco+FKSPmDw@mail.gmail.com>
 <ZD/VO1cuBYGCP4O2@smile.fi.intel.com>
 <CAOSNQF1wf3m+YTmh5qQWCM6+x3j2whvG6F=dW6Hd7zW0Y+E_1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSNQF1wf3m+YTmh5qQWCM6+x3j2whvG6F=dW6Hd7zW0Y+E_1g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 06:18:04PM +0530, Joy Chakraborty wrote:
> On Wed, Apr 19, 2023 at 5:19 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Apr 19, 2023 at 11:18:25AM +0530, Joy Chakraborty wrote:
> > > On Tue, Apr 18, 2023 at 1:08 PM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Tue, Apr 18, 2023 at 05:29:01AM +0000, Joy Chakraborty wrote:

...

> > > > > +     /*
> > > > > +      * Assuming both channels belong to the same DMA controller hence the
> > > > > +      * address width capabilities most likely would be the same.
> > > > > +      */
> > > >
> > > > I had a small comment on this In v6 thread.
> > >
> > > Sure,
> > >
> > > Your comment in V6 thread:
> > > "
> > > I would add something to explain the side of these address width, like
> > >
> > >          * Assuming both channels belong to the same DMA controller hence
> > >          * the peripheral side address width capabilities most likely would
> > >          * be the same.
> > > "
> > >
> > > I do not think the address width capabilities are dependent on the
> > > side of generation like memory or peripheral.
> >
> > Yes, they are independent. Memory could do with 4 bytes, while peripheral with
> > 1 byte and so on.
> >
> > > From what I understand,
> > > address width capabilities are solely dependent on the transaction
> > > generation capability of the DMA controller towards the system bus.
> >
> > What do you mean by a SB in the above? Memory? Peripheral?
> 
> By system bus I mean anything that is connecting the Memory, DMA and
> the peripheral.
> Something like :
> 
>           +-----------+          +-------------------+
>           |               |           |                        |
>           |   DMA    |           | PERIPHERAL |
>           |               |           |                         |
>           +----^-+---+          +-----+--^---------+
>         *** -->| |                         |    |
>                   | |                         |    |
> <------------+-v--------------------v---+------------->
>                     SYSTEM BUS
> <---------------------+--^----------------------------->
>                             |   |
>                             |   |
>                      +----v--+-----+
>                      |                   |
>                      |  MEMORY |
>                      |                   |
>                      +--------------+
> *** : Address width capabilities should be the capability of the DMA
> to generate transactions to the system bus on the marked interface
> irrespective of whether it is destined for Peripheral or memory is
> what I understand.

That's misunderstanding. You used only one possible HW design, there may be
more. For example we have Synopsys DesignWare DMA that has a lot of parameters
to configure bus mastering. One of such a case, where it makes a lot of sense,
is DesignWare SATA with the above mentioned DMA controller where it has two
masters and they are connected towards memory and towards peripheral "buses".
They have _different_ configurations.

So, generally speaking what you are saying is not true.

> > > What we intend to highlight here is the assumption that both tx and rx
> > > channel would belong to the same DMA controller hence the transaction
> > > generation capabilities would be the same both for read and write
> > > (e.g. if the DMA controller is able to generate 32 bit sized reads
> > > then it should also be able to generate 32 bit sized writes).
> > > With this assumption we are doing a bitwise and of both tx and rx capabilities.
> > >
> > > Please let me know if you think otherwise.

-- 
With Best Regards,
Andy Shevchenko


