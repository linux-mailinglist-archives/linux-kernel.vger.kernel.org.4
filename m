Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537F6624DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiKJWhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJWhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:37:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D15AB87B;
        Thu, 10 Nov 2022 14:37:30 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668119847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W2EsEvJhlAZZQPSn3pNUyWB9e4WUrObOqKYk/7OmMuc=;
        b=L0SMSt4q7jIhlzsoMg/xRFF+mS5mvQInBQrHnxfqgLft7IMQvdhT0dYdY7yePwM9Fv+G4C
        Jo7De6PJWh1b57zTUEvA/r0LIsHe+Ele14Jqom9ODT7aG/xmLKVcR6kEkUGj65//fEAUEn
        LU694e9AwzJ05OHi702f+znr9M7EsMbvzWj5bFjKIV8TV6mgQ7YRykr3ApF1NcKh2+ZLZR
        /Mme5fix7hlnZP8MTGD/Hc3n5tv9+dRIWuECLKRCUQYsHHRPQUysQApkyADc/Utz/ZXHBL
        oNUuV/8UY2GMEtRqZNNwfY5AAaqIXXvG0DR5T0VeSz3HrDewe4dlY+d0MJrS1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668119847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W2EsEvJhlAZZQPSn3pNUyWB9e4WUrObOqKYk/7OmMuc=;
        b=cR6YDafDK7z9RudGpmOn+Lr/YsZxGTyyB4YVYSNXVaaNOgu+QC1ESLllubJrkI6jh2NdsI
        K/UxS8kYMw8BavCA==
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
In-Reply-To: <Y200WG6q4z0JGYBc@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-34-john.ogness@linutronix.de>
 <Y20aBwNWT19YDeib@alley> <877d026blr.fsf@jogness.linutronix.de>
 <Y200WG6q4z0JGYBc@alley>
Date:   Thu, 10 Nov 2022 23:43:26 +0106
Message-ID: <87mt8ywi55.fsf@jogness.linutronix.de>
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
>>>> +	/* Only the new head can have CON_CONSDEV set. */
>>>> +	WRITE_ONCE(cur_pref_con->flags, cur_pref_con->flags & ~CON_CONSDEV);
>>>
>>> As mentioned in the reply for 7th patch, I would prefer to hide this
>>> WRITE_ONCE into a wrapper, e.g. console_set_flag(). It might also
>>> check that the console_list_lock is taken...
>> 
>> Agreed. For v4 it will become:
>> 
>> console_srcu_write_flags(cur_pref_con, cur_pref_con->flags & ~CON_CONSDEV);
>
> I am happy that your are going to introduce an API for this.
>
> Just to be sure. The _srcu_ in the name means that the write
> will use WRITE_ONCE() so that it can be read safely in SRCU
> context using READ_ONCE(). Do I get it correctly, please?

Yes.

> I expect that the counter part will be console_srcu_read_flags().
> I like the name. It is better than _unsafe_ that I proposed earlier.

Since the only flag that is ever checked in this way is CON_ENABLED, I
was planning on calling it console_srcu_is_enabled(). But I suppose I
could have it be: (console_srcu_read_flags() & CON_ENABLED). That would
keep it more abstract in case anyone should want to read other flag bits
under SRCU.

There are only 4 call sites that need this, so I suppose we don't need a
special _is_enabled() variant. Thanks for the suggestion!

John
