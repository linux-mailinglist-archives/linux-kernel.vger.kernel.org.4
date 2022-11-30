Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA463D8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiK3PG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiK3PGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:06:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A03AC2D;
        Wed, 30 Nov 2022 07:06:22 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BBC351F37C;
        Wed, 30 Nov 2022 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669820780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4lUys73fH/9stzM7XaBk+5X7L109u+d+RX+rmB4MkMA=;
        b=ufeFNCzr1hWeuBgyuNpvEF3akbEmjj6ZlUB2MGQnaTW256u+AYaByt+jq/2PL7PXALCmnm
        P4YESlV7RtXDqRcCgfDYGP0Kx2C1G0GAXnp4klzKgmMuqnEZfls7p9Fy634pIQcfCGgtNy
        foEr5JrMLKluEXnpo4dc2b+FaYd8hso=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 50D1D2C14F;
        Wed, 30 Nov 2022 15:06:20 +0000 (UTC)
Date:   Wed, 30 Nov 2022 16:06:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 3/3] power: process: use explicit levels for printk
 continuations
Message-ID: <Y4dxa3YMsfhOZpPZ@alley>
References: <20221125190948.2062-1-linux@weissschuh.net>
 <20221125190948.2062-4-linux@weissschuh.net>
 <f4631f7bf0e1fe7b018ea24cb89aede7829581d2.camel@perches.com>
 <ad4e4785-c6f8-4ae1-a281-ff9dc5720db2@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad4e4785-c6f8-4ae1-a281-ff9dc5720db2@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-11-25 21:41:55, Thomas Weiﬂschuh wrote:
> On 2022-11-25 11:53-0800, Joe Perches wrote:
> > On Fri, 2022-11-25 at 20:09 +0100, Thomas Weiﬂschuh wrote:
> >> Many of the printk messages emitted during suspend and resume are
> >> emitted in fragments using pr_cont()/KERN_CONT.
> >> 
> >> As during suspend and resume a lot of operations are happing in the
> >> kernel the chances are high that the fragments are interspersed with
> >> unrelated messages.
> >> 
> >> In this case if no explicit level is specified for the fragments the
> >> standard level is applied, which by default is KERN_WARNING.
> >> 
> >> If the user is only observing KERN_WARNING and *not* KERN_INFO messages
> >> they will see incomplete message fragments.
> >> 
> >> By specifing the correct printk level also with the continuations this
> >> mismatch can be avoided.
> >> Also it reduces the amount of false-positive KERN_WARNING messages.
> >> 
> >> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> >> ---
> >>  kernel/power/process.c | 18 +++++++++---------
> >>  1 file changed, 9 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/kernel/power/process.c b/kernel/power/process.c
> > []
> >> @@ -82,7 +82,7 @@ static int try_to_freeze_tasks(bool user_only)
> >>  	elapsed_msecs = ktime_to_ms(elapsed);
> >>  
> >>  	if (todo) {
> >> -		pr_cont("\n");
> >> +		pr_info_cont("\n");
> > 
> > I think this isn't needed because of the immediately following pr_err.

Great catch.


> The pr_cont() itself or the conversion to pr_info_cont() is not needed?

The pr_cont() was needed before the commit 4bcc595ccd80decb42450
("printk: reinstate KERN_CONT for printing continuation lines").

Before this commit, lines were appended even without KERN_CONT
when the previous line did not end with "\n".

The above commit caused that only lines with KERN_CONT will be
appended.

We have the code:

		pr_cont("\n");
		pr_err("Freezing of tasks %s after %d.%03d seconds "

The pr_cont() is not needed here because pr_err() does not have
KERN_CONT. It will always start on a new line.

> Personally I would prefer to keep the patch as is.
> 
> If only the conversion is not needed for consistency with the rest of the file.
> If the pr_cont() in general is not needed it should be changed in a dedicated
> patch (by somebody who knows this code better).

I agree that it should be removed in a separate patch. The commit
message should mention the commit that modified the KERN_CONT
handling.

Best Regards,
Petr
