Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB7622E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiKIO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiKIO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:57:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D03E3895
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:57:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C2C0E1FAE5;
        Wed,  9 Nov 2022 14:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668005849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wEwcwLQjvB03L0PsEWQ50R/B4fE+de9uaYeUoWQhFII=;
        b=ZRJNv9tNtvncUyEsEgPEbvLUGvr+NA93hObyBVa5th+rPnY6NF4AHxK/923wEbQtVKKZDh
        CvigJnfOKdtZwc3X34hhxojjp7bWyAaV4xqhp0yb7vnmryBuZWooC4PXflI++OGo8Cr4YT
        rs10UhYcEjpBcDWK2+yPgQnX0xvwq5Q=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A71742C141;
        Wed,  9 Nov 2022 14:57:29 +0000 (UTC)
Date:   Wed, 9 Nov 2022 15:57:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH printk v3 09/40] um: kmsg_dump: use console_is_enabled()
Message-ID: <Y2u/2TGbaFlQrGIx@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-10-john.ogness@linutronix.de>
 <Y2u/i9EgSe5BYIA5@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2u/i9EgSe5BYIA5@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-09 15:56:11, Petr Mladek wrote:
> On Mon 2022-11-07 15:22:07, John Ogness wrote:
> > Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  arch/um/kernel/kmsg_dump.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> > index 40abf1e9ccb1..f0233e2f8de0 100644
> > --- a/arch/um/kernel/kmsg_dump.c
> > +++ b/arch/um/kernel/kmsg_dump.c
> > @@ -32,7 +32,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> >  		 * expected to output the crash information.
> >  		 */
> >  		if (strcmp(con->name, "ttynull") != 0 &&
> > -		    (con->flags & CON_ENABLED)) {
> > +		    console_is_enabled(con)) {
> 
> Same as with the 9th patch. I would merge this with the patch
> switching to the srcu console list iterator. It will explain
> why the racy check is needed here. This change does not make
> sense without the other.

Ah, this was supposed to be for the 10th patch.

I am sorry for confusion.

Best Regards,
Petr
