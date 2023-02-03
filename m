Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E8688F83
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBCGLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjBCGLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:11:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18248C435
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 22:10:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2DF661DA0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF83C433D2;
        Fri,  3 Feb 2023 06:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675404616;
        bh=DfM5R8PFBfidhrgBV7CLT4RjZOvtqTcBUrcNTslRTB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTVEqCt+GngMTlFjiHOoYVuppCDjPCOY6/O2lWk81G1hAapPYx2HEygIn+y2/FEXl
         HJOjgKKWKadOeDX+zAtPzkW3lm5grZoaiwQ/bxFPHGoxL0s1QxYmRIG5uzYPJ1x6w/
         ccC+ih37HJnxMsUKqxwDkKTf7NCjMzhG5BL3hO6o=
Date:   Fri, 3 Feb 2023 07:04:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernel/irq/irqdomain.c: fix memory leak with using
 debugfs_lookup()
Message-ID: <Y9yj9R1ZzD6GIhdf@kroah.com>
References: <20230202151554.2310273-1-gregkh@linuxfoundation.org>
 <868rhg109t.wl-maz@kernel.org>
 <Y9vqJhCj5w/+b6SV@kroah.com>
 <867cx00zvx.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867cx00zvx.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:56:50PM +0000, Marc Zyngier wrote:
> On Thu, 02 Feb 2023 16:51:50 +0000,
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Thu, Feb 02, 2023 at 04:48:30PM +0000, Marc Zyngier wrote:
> > > On Thu, 02 Feb 2023 15:15:54 +0000,
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > When calling debugfs_lookup() the result must have dput() called on it,
> > > > otherwise the memory will leak over time.  To make things simpler, just
> > > > call debugfs_lookup_and_remove() instead which handles all of the logic
> > > > at once.
> > > > 
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  kernel/irq/irqdomain.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> > > > index 8fe1da9614ee..e2096b51c004 100644
> > > > --- a/kernel/irq/irqdomain.c
> > > > +++ b/kernel/irq/irqdomain.c
> > > > @@ -1915,7 +1915,7 @@ static void debugfs_add_domain_dir(struct irq_domain *d)
> > > >  
> > > >  static void debugfs_remove_domain_dir(struct irq_domain *d)
> > > >  {
> > > > -	debugfs_remove(debugfs_lookup(d->name, domain_dir));
> > > > +	debugfs_lookup_and_remove(d->name, domain_dir);
> > > >  }
> > > >  
> > > >  void __init irq_domain_debugfs_init(struct dentry *root)
> > > 
> > > Reviewed-by: Marc Zyngier <maz@kernel.org>
> > > 
> > > Maybe add a Cc stable to get this in 6.1?
> > 
> > Sure, I can, but how often are irq domains removed from the system under
> > a normal operation?
> 
> As many time as you want if you're doing virtualisation and have the
> right sort of HW (anything GICv4.x, for example, which will create
> per-VM irqdomains).

Ok, I'll queue this up now and get it to Linus for 6.2-final.

thanks,

greg k-h
