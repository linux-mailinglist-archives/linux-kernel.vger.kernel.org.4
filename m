Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45566884D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjBBQwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjBBQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:51:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3386D5FA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:51:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15754B82743
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 16:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DEFC433D2;
        Thu,  2 Feb 2023 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675356714;
        bh=hNSX/lsqCDMw4Bnn3aKyZIqTpOhcoT+nJhz6gwpWLAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQBkBgIFaQv3APFcrNPyWy309SN+R7X6w6EcjKIhotTNyKsnIg06EdpKpAQmhmNtD
         HfzfBN/u2GxPO86nzH/oGn/ATYpZYYcrk5Av+1zljMWXn5Ly8KgXpk4XPvzFc1RRqT
         BenYOBfEFKFZLtTNKe3fqSaEo4Fg04OSKB5Ccmyc=
Date:   Thu, 2 Feb 2023 17:51:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernel/irq/irqdomain.c: fix memory leak with using
 debugfs_lookup()
Message-ID: <Y9vqJhCj5w/+b6SV@kroah.com>
References: <20230202151554.2310273-1-gregkh@linuxfoundation.org>
 <868rhg109t.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868rhg109t.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:48:30PM +0000, Marc Zyngier wrote:
> On Thu, 02 Feb 2023 15:15:54 +0000,
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > When calling debugfs_lookup() the result must have dput() called on it,
> > otherwise the memory will leak over time.  To make things simpler, just
> > call debugfs_lookup_and_remove() instead which handles all of the logic
> > at once.
> > 
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  kernel/irq/irqdomain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> > index 8fe1da9614ee..e2096b51c004 100644
> > --- a/kernel/irq/irqdomain.c
> > +++ b/kernel/irq/irqdomain.c
> > @@ -1915,7 +1915,7 @@ static void debugfs_add_domain_dir(struct irq_domain *d)
> >  
> >  static void debugfs_remove_domain_dir(struct irq_domain *d)
> >  {
> > -	debugfs_remove(debugfs_lookup(d->name, domain_dir));
> > +	debugfs_lookup_and_remove(d->name, domain_dir);
> >  }
> >  
> >  void __init irq_domain_debugfs_init(struct dentry *root)
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> 
> Maybe add a Cc stable to get this in 6.1?

Sure, I can, but how often are irq domains removed from the system under
a normal operation?

Or you can take it through your tree and add that?  I too can take it
through mine, which ever is easier for you.

thanks,

greg k-h
