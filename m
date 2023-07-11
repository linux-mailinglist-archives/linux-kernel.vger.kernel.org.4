Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E10074EC06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjGKKyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjGKKyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:54:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C48E49;
        Tue, 11 Jul 2023 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689072863; x=1720608863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SMECa8VtUDTj8uAlHo+/eSzCIakPudLNZyp4Qu5FCqM=;
  b=R/Q3vfJ5N/9MVcwq7FOzyLBAWmOcQLoONdsenGBVY55ztx4A3oMyuVoO
   UT8hc/8LxKrSuQehCxQhW0+IrV9ZmBeSUrM0/5AxYLrp4kqeC36CBUs2L
   rlhkIxu/qaO/KqKVcAvrK2RVXUFA47aHD5hCFAstY2HfN3snP3UZNZxVd
   1t/sYClzUFtO2WZB81HteCE2O2e9ORW7xg1WuRHfDHdFYA8o1/iraeHCp
   yaEP9sitsIXK9OCo89pbc9qXHnnFN6ilr1Jvp3VLsZMnA78oyZ/UXJFi/
   eTLURFb67dVTb2aSDRt9RIGrks1fkC9kCaRjTBN49WgJmmVzJeZ5cNl/z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="368086543"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="368086543"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 03:54:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="715142598"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="715142598"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2023 03:54:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJB0c-001p18-33;
        Tue, 11 Jul 2023 13:54:18 +0300
Date:   Tue, 11 Jul 2023 13:54:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <ZK002l0AojjdJptC@smile.fi.intel.com>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
 <20230711063348.GB41919@unreal>
 <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:21:12PM +0200, Paolo Abeni wrote:
> On Tue, 2023-07-11 at 09:33 +0300, Leon Romanovsky wrote:
> > On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:
> > > The bit operations take boolean parameter and return also boolean
> > > (in test_bit()-like cases). Don't threat booleans as integers when
> > > it's not needed.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  net/netlink/af_netlink.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > > index 383631873748..d81e7a43944c 100644
> > > --- a/net/netlink/af_netlink.c
> > > +++ b/net/netlink/af_netlink.c
> > > @@ -1623,9 +1623,10 @@ EXPORT_SYMBOL(netlink_set_err);
> > >  /* must be called with netlink table grabbed */
> > >  static void netlink_update_socket_mc(struct netlink_sock *nlk,
> > >  				     unsigned int group,
> > > -				     int is_new)
> > > +				     bool new)
> > >  {
> > > -	int old, new = !!is_new, subscriptions;
> > > +	int subscriptions;
> > > +	bool old;
> > >  
> > >  	old = test_bit(group - 1, nlk->groups);
> > >  	subscriptions = nlk->subscriptions - old + new;
> > 
> > So what is the outcome of "int - bool + bool" in the line above?

The same as with int - int [0 .. 1] + int [0 .. 1].

Note, the code _already_ uses boolean as integers.

> FTR, I agree with Leon, the old code is more readable to me/I don't see
> a practical gain with this change.

This change does not change the status quo. The code uses booleans as integers
already (in the callers).

As I mentioned earlier, the purity of the code (converting booleans to integers
beforehand) adds unneeded churn and with this change code becomes cleaner at
least for the (existing) callers.

-- 
With Best Regards,
Andy Shevchenko


