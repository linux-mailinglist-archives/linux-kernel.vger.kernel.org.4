Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB7474EEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGKMXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjGKMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940341717
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC4F614BA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EF4C433C7;
        Tue, 11 Jul 2023 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689078016;
        bh=ESrFukL6Avmq96Qu5Z0oVFoi45CucnlANyNQFqVS/EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0woitDjv2729w2lKE8MkSDWhI9pE3s5StDUzTavbZivo5Oyc5vZwwAUIfxPu3Juz
         0P7vfULY6rAu7A4YI/aCthk+ruMFZURj9z0a6HJQ/81tSA46wsiaiddONLZKKmaCR4
         9+2b84FyJcP3VMxTaU8qVaKGPyBX/Kn4GwLZBuRzMDuUXQGbO115qE1M/AYZLGmajz
         WcUPq7qEzXmtGmHPsm37f3u0KgU8MJQ8W7Xdsv1Q/bqdXHPxh1Cz9DhsIqhx6BDxtX
         4PdxfsZ8kqPQmS/eJo2eYK6I4wNmbVq3ai2TcCpauITpYOutNeAobWuJoB+VyS/nHJ
         hrjIJPdP7q2cg==
Date:   Tue, 11 Jul 2023 15:20:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <20230711122012.GR41919@unreal>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
 <20230711063348.GB41919@unreal>
 <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
 <ZK002l0AojjdJptC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK002l0AojjdJptC@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 01:54:18PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 12:21:12PM +0200, Paolo Abeni wrote:
> > On Tue, 2023-07-11 at 09:33 +0300, Leon Romanovsky wrote:
> > > On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:
> > > > The bit operations take boolean parameter and return also boolean
> > > > (in test_bit()-like cases). Don't threat booleans as integers when
> > > > it's not needed.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > >  net/netlink/af_netlink.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > > > index 383631873748..d81e7a43944c 100644
> > > > --- a/net/netlink/af_netlink.c
> > > > +++ b/net/netlink/af_netlink.c
> > > > @@ -1623,9 +1623,10 @@ EXPORT_SYMBOL(netlink_set_err);
> > > >  /* must be called with netlink table grabbed */
> > > >  static void netlink_update_socket_mc(struct netlink_sock *nlk,
> > > >  				     unsigned int group,
> > > > -				     int is_new)
> > > > +				     bool new)
> > > >  {
> > > > -	int old, new = !!is_new, subscriptions;
> > > > +	int subscriptions;
> > > > +	bool old;
> > > >  
> > > >  	old = test_bit(group - 1, nlk->groups);
> > > >  	subscriptions = nlk->subscriptions - old + new;
> > > 
> > > So what is the outcome of "int - bool + bool" in the line above?
> 
> The same as with int - int [0 .. 1] + int [0 .. 1].

No, it is not. bool is defined as _Bool C99 type, so strictly speaking
you are mixing types int - _Bool + _Bool.

Thanks

> 
> Note, the code _already_ uses boolean as integers.
> 
> > FTR, I agree with Leon, the old code is more readable to me/I don't see
> > a practical gain with this change.
> 
> This change does not change the status quo. The code uses booleans as integers
> already (in the callers).
> 
> As I mentioned earlier, the purity of the code (converting booleans to integers
> beforehand) adds unneeded churn and with this change code becomes cleaner at
> least for the (existing) callers.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
