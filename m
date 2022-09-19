Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B9D5BCD93
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiISNrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiISNrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:47:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E34D31207;
        Mon, 19 Sep 2022 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663595210; x=1695131210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jBbg9Ly3UJMnDmMmkjxG2CXACR0TAhGMOhRzvVmCwvs=;
  b=Av6zqIxHRTP/UYais3cmU5tsxf6ncaNJc60BELuZkx36r/ZQYyNRmZNQ
   xfZqT1j/03vx+0aBTXM4BsdeIrDkt4ntyHCu87nVSUeN56U+7O6AfC6Hk
   ZVIBbFsq6V/MP7bRhzBVkC4O/aYnoumyaqpCo2TUPyWxGtN8BO3P+B3hN
   Olzk/vwd1l+kNnNaQBb4K4ysrtfr5tKMCo3TPuTO4QGDOGK15eXeT4Eht
   LO5mP9eYOGQd8CRFLiwnhtkswH2EEA+z1oVzMAjyzxoZVj/fbmSv1wJrL
   PZaDIRdK6pIP2IugCn/eroVOgs/XDpC0fKHTpHytt4HnipTML6/boo8pJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="296996552"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="296996552"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="651684842"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 19 Sep 2022 06:46:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oaH6k-004ZdO-2Q;
        Mon, 19 Sep 2022 16:46:46 +0300
Date:   Mon, 19 Sep 2022 16:46:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
Message-ID: <Yyhyxmt+rhxEI0VH@smile.fi.intel.com>
References: <YyF/dogp/0C87zLb@wantstofly.org>
 <YyGoZLTFhYQvlf+P@smile.fi.intel.com>
 <YyG2tDdq9PWTlaBQ@wantstofly.org>
 <YyHR4o5bOnODZzZ9@smile.fi.intel.com>
 <7fd034a9-c1e1-2dca-693b-129c9d2649@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fd034a9-c1e1-2dca-693b-129c9d2649@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 07:27:45PM +0300, Ilpo Järvinen wrote:
> On Wed, 14 Sep 2022, Andy Shevchenko wrote:
> > On Wed, Sep 14, 2022 at 02:10:44PM +0300, Lennert Buytenhek wrote:
> > > On Wed, Sep 14, 2022 at 01:09:40PM +0300, Andy Shevchenko wrote:

...

> -	/*
> -	 * The above check will only give an accurate result the first time
> -	 * the port is opened so this value needs to be preserved.
> -	 */

Side note: I haven't got why you removed this comment (it may be some staled
info, but shouldn't be done in the separate change then?).

-- 
With Best Regards,
Andy Shevchenko


