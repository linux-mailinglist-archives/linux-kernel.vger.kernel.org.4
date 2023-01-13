Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6BD66A229
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjAMSfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjAMSeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:34:44 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D55C7C3AE;
        Fri, 13 Jan 2023 10:31:04 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="410304784"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="410304784"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 10:31:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="800677927"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="800677927"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2023 10:30:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1pGOpN-008l2m-33;
        Fri, 13 Jan 2023 20:30:57 +0200
Date:   Fri, 13 Jan 2023 20:30:57 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Sergey Nazarov <Sergey.Nazarov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Fix wrong FIFO level setting for long xfers
Message-ID: <Y8GjYUWKSbfXFNEK@smile.fi.intel.com>
References: <20230113165724.27199-1-Sergey.Semin@baikalelectronics.ru>
 <CAHp75Vc3+_SiVFzmJPM2dtPqUGErGY6Qc6_deS1yaDkjtT35rQ@mail.gmail.com>
 <20230113181854.ob7lgbwixnxdrcys@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113181854.ob7lgbwixnxdrcys@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 09:18:54PM +0300, Serge Semin wrote:
> On Fri, Jan 13, 2023 at 07:33:16PM +0200, Andy Shevchenko wrote:
> > On Fri, Jan 13, 2023 at 6:57 PM Serge Semin
> > <Sergey.Semin@baikalelectronics.ru> wrote:
> > >
> > > Due to using the u16 type in the min_t() macros the SPI transfer length
> > > will be cast to word before participating in the conditional statement
> > > implied by the macro. Thus if the transfer length is greater than 64KB the
> > > Tx/Rx FIFO threshold level value will be determined by the leftover of the
> > > truncated after the type-case length. In the worst case it will cause
> > > having the "Tx FIFO Empty" or "Rx FIFO Full" interrupts triggered on each
> > > word sent/received to/from the bus. In its turn it will cause the
> > > dramatical performance drop.
> > >
> > > The problem can be easily fixed by using the min() macros instead of
> > > min_t() which doesn't imply any type casting thus preventing the possible
> > > data loss.
> 
> > But this would be problematic if the types of the parameters are different.
> > Currently they are u32 vs. unsigned int.
> 
> Yes, it would but only in case if somebody changes their types. As you
> said they are currently of u32 and unsigned int types which are the
> same on all the currently supported platforms. So even if somebody
> changes the type of any of them then the compiler will warn about it
> anyway.
> 
> > I would rather assume that
> > FIFO length is always less than or equal to 64K and just change the
> > type in min_t to follow what dws->tx_len is.
> 
> There is no need in assuming in this case. FIFO depth doesn't exceed
> 256 xfer words by the DW SSI IP-core design (judging by the constraints
> applied to the SSI_RX_FIFO_DEPTH and SSI_TX_FIFO_DEPTH synthesize
> parameters). So the dws->fifo_len can be easily converted to u16 type.
> The problem is in the tx_len field casting to u16. It's a rare case,
> but the SPI xfers length can be greater than 64K. The
> spi_transfer.len field is of the unsigned int type and the SPI-core
> doesn't have any constraints to that (except the one defined by the
> controller drivers).
> 
> So to make sure I correctly understand what you meant. Do you suggest
> to do something like this (it was my first version of the fix):
> -	level = min_t(u16, dws->fifo_len / 2, dws->tx_len);
> +	level = min_t(u32, dws->fifo_len / 2, dws->tx_len);
> or even like this
> -	level = min_t(u16, dws->fifo_len / 2, dws->tx_len);
> +	level = min_t(typeof(dws->tx_len), dws->fifo_len / 2, dws->tx_len);
> ?

No, I suggest

	level = min_t(unsigned int, dws->fifo_len / 2, dws->tx_len);

So, we do not care about changing of the fifo_len type, and we won't issue
a compiler warning if it becomes, let's say, u8. While your solution will
still produce it.

> Personally I would prefer either my solution with just min() macros
> usage (which in case of the types change will give the compile-time
> warning about the types mismatch) or using the min_t(u32, ...) version
> (using typeof() seems overkill). I don't see much different (do you?).

Yes, hence personally I prefer my proposal.

> Both versions have their pros and cons.

Right.

-- 
With Best Regards,
Andy Shevchenko


