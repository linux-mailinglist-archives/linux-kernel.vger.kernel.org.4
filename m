Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD767888E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjAWUoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjAWUoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:44:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D494330D8;
        Mon, 23 Jan 2023 12:44:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44BC261029;
        Mon, 23 Jan 2023 20:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69360C433D2;
        Mon, 23 Jan 2023 20:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674506661;
        bh=nsRBbpy3niV2zB0JxDiw6NxHMjalKZwL+jxcCxjKFKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qEGStwSlAwZla16k5WKaM58Gxev2Ji1uStrqOiyogyWRCZ7wdeyuiR0PsgJUDjOc2
         7n5mjn4X2gNYwBBR/NLr0pDbSf6qR+y631De8LcEuiwT92WFOxdqMjKk1AcFSR+GPl
         U4Shw7g+wU68Il+2HkZwTqx00cBT7AC3DVgcKkWCUM45Or7+Pq9+UE2j3lIbAPr1XO
         57WPhHhxbVICxcE0IJV/QizhFdN/Ctj2WO4srfoRrlgdir+ml6lHCz3DyU+2mGuOBe
         bDzgipsvh8k1mIKTu1SmfifbPTzqoYD1MW9IbKaRSioWrl5adaepzogdPJpHrT3nQc
         fNzqFV7/WHdkg==
Date:   Mon, 23 Jan 2023 14:44:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] printk: Document that CONFIG_BOOT_PRINTK_DELAY required
 for boot_delay=
Message-ID: <20230123204419.GA980727@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87Pcu0ZJKOiQQRY@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 06:18:26PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 23, 2023 at 12:04:40PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Document the fact that CONFIG_BOOT_PRINTK_DELAY must be enabled for the
> > "boot_delay" kernel parameter to work.  Also mention that "lpj=" may be
> > necessary.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 6cfa6e3996cf..b0b40b6a765c 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -480,8 +480,9 @@
> >  			See Documentation/block/cmdline-partition.rst
> >  
> >  	boot_delay=	Milliseconds to delay each printk during boot.
> > -			Values larger than 10 seconds (10000) are changed to
> > -			no delay (0).
> > +			Enable CONFIG_BOOT_PRINTK_DELAY and also specify
> > +			"lpj=".  Boot_delay values larger than 10 seconds
> > +			(10000) are changed to no delay (0).
> 
> That's counterintuitive.  I'd understand clamping it to 10 seconds,
> but not setting it to zero.

I'm not opposed to setting it to 10 sec instead of 0, but that came
from bfe8df3d314b ("slow down printk during boot"); added Randy in
case he wants to comment.

> Also, there are two ways of reading this.  One is that by specifying
> boot_delay=, lpj= is set to a sane value.  The other (intended?) is
> that in order to use this option, you must also specify lpj=.

Maybe this is better?

 	boot_delay=	Milliseconds to delay each printk during boot.
-			Values larger than 10 seconds (10000) are changed to
-			no delay (0).
+			Only works if CONFIG_BOOT_PRINTK_DELAY is enabled,
+			and you may also have to specify "lpj=".  Boot_delay
+			values larger than 10 seconds (10000) are changed
+			to no delay (0).
 			Format: integer
 
 	bootconfig	[KNL]
