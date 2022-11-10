Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8563624686
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiKJQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKJQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:03:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EAF303EA;
        Thu, 10 Nov 2022 08:03:14 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668096193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2ekXh2GYs190EffPperJZ/U7GEy4Ue5lLOHn3cnsTY=;
        b=D1AzsMAdXVSDzz5kJrt9f713AtZ5rwnGbtn8uOef0JjHAAhBhyzEyiDq1I4hJFtlHwHh7m
        GX7kiyvgZ3PjN+ftd7LtrFABw4GFID9mZN+agIDdaqey1U4NW5RLby7bOch02j8RPrSQtP
        KTqpF0M+gkCE7sCeHQTPScGxCAPJKuWP/T2Xxk9rVHONfbgP9UaFMP37fW/W0INgYEmOYx
        0MR6EQms1qzi0t7s4cUwMnj75aA6oMqWPYYwkFXWQ2lSLfxYtxcfXX3CB4j1rGNpUxmnOM
        +5J1Oi3XlYw6P51/QXLvftS8uzOWlMfNROslqy9yksaFLsFqyScc1+JGHlVleA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668096193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2ekXh2GYs190EffPperJZ/U7GEy4Ue5lLOHn3cnsTY=;
        b=UIWSEc3uFNBtJFNIDDChRw/avEosrXGr8wJbKqiOCuw8HBJGUZix7GKEv6AtQEYcN/OaQw
        EMckQVr9OCZKoJDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH printk v3 33/40] printk, xen: fbfront: create/use safe
 function for forcing preferred
In-Reply-To: <Y20aBwNWT19YDeib@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-34-john.ogness@linutronix.de>
 <Y20aBwNWT19YDeib@alley>
Date:   Thu, 10 Nov 2022 17:09:12 +0106
Message-ID: <877d026blr.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-10, Petr Mladek <pmladek@suse.com> wrote:
>> +void console_force_preferred_locked(struct console *con)
>> +{
>> +	struct console *cur_pref_con;
>> +
>> +	if (!console_is_registered_locked(con))
>> +		return;
>> +
>> +	cur_pref_con = console_first();
>> +
>> +	/* Already preferred? */
>> +	if (cur_pref_con == con)
>> +		return;
>> +
>> +	hlist_del_init_rcu(&con->node);
>
> We actually should re-initialize the node only after all existing
> console list walks are finished. Se we should use here:
>
> 	hlist_del_rcu(&con->node);

hlist_del_init_rcu() only re-initializes @pprev pointer. But maybe you
are concerned that there is a window where list_unhashed() becomes true?
I agree that it should be changed to hlist_del_rcu() because there
should not be a window where this console appears unregistered.

>> +	/* Only the new head can have CON_CONSDEV set. */
>> +	WRITE_ONCE(cur_pref_con->flags, cur_pref_con->flags & ~CON_CONSDEV);
>
> As mentioned in the reply for 7th patch, I would prefer to hide this
> WRITE_ONCE into a wrapper, e.g. console_set_flag(). It might also
> check that the console_list_lock is taken...

Agreed. For v4 it will become:

console_srcu_write_flags(cur_pref_con->flags & ~CON_CONSDEV);

John
