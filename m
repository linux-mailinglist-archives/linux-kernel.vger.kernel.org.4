Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CDE5BCE5D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiISOTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiISOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:19:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD632BD8;
        Mon, 19 Sep 2022 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663597181; x=1695133181;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+1jJkKo3oDnZITK1ZKuYSzyR0/mdILKfueu7BEmDvLI=;
  b=bLTCKVOqxIa7bgTn+erQiB2zVwQq0Q/5liC7Z7YFJAAvw+QdVz2RzxPB
   /TnOlCaWDEJzZXiby8+N0lR2SLR6wNcYsNZk60YDXoWNyQSWXv71WE4yR
   Db8K+LUiENhMcOAmm6tZrQKVUkNl7TznUdgfCorhiBCdGbUd5oqPgLO7A
   9I2JTkK4/wpLaeZF5woxgLSt2JPU62WbnNYYHYeCW+rXDW0RDxT/N7wsq
   Io4vbISQevzwxK5H6KZ0SKJSiyYgVhpEbtCa8wU4VAAFixU0pKkdPnI/p
   CMRsJxwOzHs3Lp+jc2U2xO4hcWpCGtmpW42WvgA0UB2eAbGYQwq23WjIS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="300230010"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="300230010"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 07:19:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="707582398"
Received: from iswiersz-mobl1.ger.corp.intel.com ([10.252.33.172])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 07:19:37 -0700
Date:   Mon, 19 Sep 2022 17:19:35 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
In-Reply-To: <YyhyvazTBBmMSnXk@smile.fi.intel.com>
Message-ID: <d5bc5b97-25db-d70-17dc-aab49f8fbc77@linux.intel.com>
References: <YyF/dogp/0C87zLb@wantstofly.org> <YyGoZLTFhYQvlf+P@smile.fi.intel.com> <YyG2tDdq9PWTlaBQ@wantstofly.org> <YyHR4o5bOnODZzZ9@smile.fi.intel.com> <7fd034a9-c1e1-2dca-693b-129c9d2649@linux.intel.com> <YyRiPMa26qDptj3L@wantstofly.org>
 <YyhyvazTBBmMSnXk@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1542528522-1663597179=:1603"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1542528522-1663597179=:1603
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 19 Sep 2022, Andy Shevchenko wrote:

> On Fri, Sep 16, 2022 at 02:47:08PM +0300, Lennert Buytenhek wrote:
> > On Thu, Sep 15, 2022 at 07:27:45PM +0300, Ilpo Järvinen wrote:
> 
> ...
> 
> > Thanks for the fix!
> > 
> > > [...] I'm far from sure if it's the 
> > > best fix though as I don't fully understand what causes the faults during 
> > > the THRE tests because the port->irq is disabled by the THRE test block.
> > 
> > If the IRQ hasn't been set up yet, the UART will have zeroes in its MSI
> > address/data registers.  Disabling the IRQ at the interrupt controller
> > won't stop the UART from performing a DMA write to the address programmed
> > in its MSI address register (zero) when it wants to signal an interrupt.
> > 
> > (These UARTs (in Ice Lake-D) implement PCI 2.1 style MSI without masking
> > capability, so there is no way to mask the interrupt at the source PCI
> > function level, except disabling the MSI capability entirely, but that
> > would cause it to fall back to INTx# assertion, and the PCI specification
> > prohibits disabling the MSI capability as a way to mask a function's
> > interrupt service request.)
> 
> This sounds to me like a good part to be injected into commit message of
> the proposed fix.

I added my own wording already but I could adds of Lennert's far superior 
descriptions verbatim if he is OK with that?


-- 
 i.

--8323329-1542528522-1663597179=:1603--
