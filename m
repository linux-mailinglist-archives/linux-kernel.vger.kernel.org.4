Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9725E8D3E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 16:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIXOSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 10:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiIXOSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 10:18:13 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1200EE9CEB
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 07:18:12 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 35655201362;
        Sat, 24 Sep 2022 14:18:10 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 8D8B08064C; Sat, 24 Sep 2022 16:06:15 +0200 (CEST)
Date:   Sat, 24 Sep 2022 16:06:15 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pcmcia: Removed unused variable control.
Message-ID: <Yy8O1+qKjEFuCZU0@owl.dominikbrodowski.net>
References: <20220725012955.4928-1-jrdr.linux@gmail.com>
 <YyxzrjA7hW6gdV5e@owl.dominikbrodowski.net>
 <ae8041cd-0f20-47e9-a4be-92159785e8a8@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae8041cd-0f20-47e9-a4be-92159785e8a8@www.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Sep 23, 2022 at 08:58:47AM +0200 schrieb Arnd Bergmann:
> On Thu, Sep 22, 2022, at 4:39 PM, Dominik Brodowski wrote:
> > Am Mon, Jul 25, 2022 at 06:59:55AM +0530 schrieb Souptick Joarder:
> >> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> >> 
> >> Kernel test robot throws below warning ->
> >> drivers/pcmcia/omap_cf.c:127:7: warning: variable 'control'
> >> set but not used [-Wunused-but-set-variable]
> >> 
> >> Removed unused variable control.
> >
> > From a code-generation standpoint, this is obiously correct, and probably
> > the compiler removes that omap_readw() already.
> 
> omap_readw() is an 'extern' function, so it does not get removed.
> 
> Even if it was inline, it's still "and volatile" read that gets
> left in because it may (and probably does) have side-effects.
> 
> > But, to be honest, I'm not
> > perfectly sure on what the device expects -- and whether it's required to
> > write back the control register (or parts of it). Does anyone still have the
> > hardware (or specs)? If not, I'm tempted to apply this patch on the basis
> > that the compiler might remove that omap_readw() anyway.
> 
> I think assigning to an unused variable was at some point needed to
> avoid a compiler warning because otherwise omap_readw() was just a
> pointer dereference. The safe way to transform the code should be to
> drop the variable but leave the function call.
> 
> Note that the driver is only used on the 'osk' reference board,
> not on any devices that were in mass-production.

Thanks for the evaluation, Arnd! So here's what I intend to push upstream:

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot throws below warning ->
drivers/pcmcia/omap_cf.c:127:7: warning: variable 'control'
set but not used [-Wunused-but-set-variable]

Removed unused variable control.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
[linux@dominikbrodowski.net: retain omap_readw() call, as it might be required]
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 1972a8f6fa8e..d3f827d4224a 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -124,8 +124,6 @@ static int omap_cf_get_status(struct pcmcia_socket *s, u_int *sp)
 static int
 omap_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
 {
-	u16		control;
-
 	/* REVISIT some non-OSK boards may support power switching */
 	switch (s->Vcc) {
 	case 0:
@@ -135,7 +133,7 @@ omap_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
 		return -EINVAL;
 	}
 
-	control = omap_readw(CF_CONTROL);
+	omap_readw(CF_CONTROL);
 	if (s->flags & SS_RESET)
 		omap_writew(CF_CONTROL_RESET, CF_CONTROL);
 	else
