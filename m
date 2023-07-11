Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CFF74F08B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjGKNoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjGKNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:44:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6820E10C7;
        Tue, 11 Jul 2023 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689083062; x=1720619062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9whZIVbPFswM7Gv172Nf0MtfoDbbo099QAczhdHkuAs=;
  b=DKj7955h4etJM1ghaGmg0Up/EioSo2H37b8dms18W00s4kHL6Hky4eFf
   LxT7TvRZhJJkJUIWajIyyend457mofbEouqThlAHVNkm7Dt8Sc0PdGYSq
   8Ruj3NxRIpecaUzUmbt3UnVd+2aJSvfwYx1t0Tfe8FC00YBtL3k9hiEXK
   unIerEO3lEkNHTw/CSz75oNuQH9O247+bcmgJgJICpTrUz3qysl8xe5nD
   tU2Emjf2Oqbbj7MHQv7j+AaZhVtK1foAhXrDTssThpArUqv6qvB4gSuA7
   EL6GWa428wY2cLF1w2JViX27kdgm7AcgnzTa/qx4D7jxQPOtSgpKhkIBe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="354483878"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="354483878"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:44:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="750766091"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="750766091"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2023 06:44:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJDf8-001ra6-14;
        Tue, 11 Jul 2023 16:44:18 +0300
Date:   Tue, 11 Jul 2023 16:44:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <ZK1csjLgGM+ezG/J@smile.fi.intel.com>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
 <20230711063348.GB41919@unreal>
 <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
 <ZK002l0AojjdJptC@smile.fi.intel.com>
 <20230711122012.GR41919@unreal>
 <ZK1O7lBF1vH7/7UM@smile.fi.intel.com>
 <20230711133259.GS41919@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711133259.GS41919@unreal>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 04:32:59PM +0300, Leon Romanovsky wrote:
> On Tue, Jul 11, 2023 at 03:45:34PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 11, 2023 at 03:20:12PM +0300, Leon Romanovsky wrote:
> > > On Tue, Jul 11, 2023 at 01:54:18PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Jul 11, 2023 at 12:21:12PM +0200, Paolo Abeni wrote:
> > > > > On Tue, 2023-07-11 at 09:33 +0300, Leon Romanovsky wrote:
> > > > > > On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:

...

> > > > > > So what is the outcome of "int - bool + bool" in the line above?
> > > > 
> > > > The same as with int - int [0 .. 1] + int [0 .. 1].
> > > 
> > > No, it is not. bool is defined as _Bool C99 type, so strictly speaking
> > > you are mixing types int - _Bool + _Bool.
> > 
> > 1. The original code already does that. You still haven't reacted on that.
> 
> The original code was int - int + int.

No. You missed the callers part. They are using boolean.

> > 2. Is what you are telling a problema?
> 
> No, I'm saying that you took perfectly correct code which had all types
> aligned and changed it to have mixed type arithmetic.

And after this change it's perfectly correct code with less letters and hidden
promotions (as a parameter to the function) and hence requires less cognitive
energy to parse.

So, the bottom line is the commit message you don't like, is it so?

-- 
With Best Regards,
Andy Shevchenko


