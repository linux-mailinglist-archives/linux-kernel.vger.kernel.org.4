Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D45BCD94
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiISNrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiISNrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:47:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6A330543;
        Mon, 19 Sep 2022 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663595211; x=1695131211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YKEKcFYIu6qm0K8+4BMwEimDqvC6SyGiwhDXIYY2JLQ=;
  b=Gdbi9dFNYCD5ubNxQbLpXkhBQ4pyXQla1RDOaZZRPubxtTkiwIK7j/uY
   r38sa9Lbyq587Af9GSMzxdUmWzkTz8O4DAmnHz2lTu7WHfdRgTvhvlH5k
   XsTrnSkCC/CSsxaFfLdoaxE8wMqJW4sCEy2p6kM+LAufO9SLEmULkQqFQ
   UXwxoeH7SbhvT/AcwT2DslMvvcNqFNejycbnTQyW2TYiUEzGDFy+AM9kj
   /B6wIyS1Z95jnpv8d2fyj9PSdaAlsf+2/1bNiIDJCcZI7IhrcGVF6Le6K
   Si8dzqGewEE4qS9HVCE+VC3xn5RugU/Xr0cT/BKHiCrUXvyjyVPRSpqTF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="286446956"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="286446956"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="569657380"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 19 Sep 2022 06:46:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oaH6b-004ZdE-0u;
        Mon, 19 Sep 2022 16:46:37 +0300
Date:   Mon, 19 Sep 2022 16:46:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lennert Buytenhek <buytenh@wantstofly.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
Message-ID: <YyhyvazTBBmMSnXk@smile.fi.intel.com>
References: <YyF/dogp/0C87zLb@wantstofly.org>
 <YyGoZLTFhYQvlf+P@smile.fi.intel.com>
 <YyG2tDdq9PWTlaBQ@wantstofly.org>
 <YyHR4o5bOnODZzZ9@smile.fi.intel.com>
 <7fd034a9-c1e1-2dca-693b-129c9d2649@linux.intel.com>
 <YyRiPMa26qDptj3L@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyRiPMa26qDptj3L@wantstofly.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 02:47:08PM +0300, Lennert Buytenhek wrote:
> On Thu, Sep 15, 2022 at 07:27:45PM +0300, Ilpo Järvinen wrote:

...

> Thanks for the fix!
> 
> > [...] I'm far from sure if it's the 
> > best fix though as I don't fully understand what causes the faults during 
> > the THRE tests because the port->irq is disabled by the THRE test block.
> 
> If the IRQ hasn't been set up yet, the UART will have zeroes in its MSI
> address/data registers.  Disabling the IRQ at the interrupt controller
> won't stop the UART from performing a DMA write to the address programmed
> in its MSI address register (zero) when it wants to signal an interrupt.
> 
> (These UARTs (in Ice Lake-D) implement PCI 2.1 style MSI without masking
> capability, so there is no way to mask the interrupt at the source PCI
> function level, except disabling the MSI capability entirely, but that
> would cause it to fall back to INTx# assertion, and the PCI specification
> prohibits disabling the MSI capability as a way to mask a function's
> interrupt service request.)

This sounds to me like a good part to be injected into commit message of
the proposed fix.

-- 
With Best Regards,
Andy Shevchenko


