Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD765F0F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjAEQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjAEQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:17:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB1E4C724
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 08:17:13 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D787A17829;
        Thu,  5 Jan 2023 16:17:04 +0000 (UTC)
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8BE172C146;
        Thu,  5 Jan 2023 16:17:04 +0000 (UTC)
Date:   Thu, 5 Jan 2023 17:17:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 6/8] printk: introduce
 console_prepend_dropped() for dropped messages
Message-ID: <Y7b4AND0DRs7jPW9@alley>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <20230105103735.880956-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105103735.880956-7-john.ogness@linutronix.de>
X-Spamd-Bar: +++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=fail (smtp-out1.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.39 / 50.00];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.20)[suse.com];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         RCPT_COUNT_FIVE(0.00)[5];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         R_DKIM_NA(0.20)[];
         RCVD_COUNT_TWO(0.00)[2];
         MIME_TRACE(0.00)[0:+]
X-Spam-Score: 5.39
X-Rspamd-Queue-Id: D787A17829
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-05 11:43:33, John Ogness wrote:
> Currently "dropped messages" are separately printed immediately
> before printing the printk message. Since normal consoles are
> now using an output buffer that is much larger than previously,
> the "dropped message" could be prepended to the printk message
> and then output everything in a single write() call.
> 
> Introduce a helper function console_prepend_dropped() to prepend
> an existing message with a "dropped message". This simplifies
> the code by allowing all message formatting to be handled
> together and then only requires a single write() call to output
> the full message. And since this helper does not require any
> locking, it can be used in the future for other console printing
> contexts as well.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

A comment below.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2724,6 +2699,52 @@ static void __console_unlock(void)
>  	up_console_sem();
>  }
>  
> +/*
> + * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message". This
> + * is achieved by shifting the existing message over and inserting the dropped
> + * message.
> + *
> + * @pmsg is the printk message to prepend.
> + *
> + * @dropped is the dropped count to report in the dropped message.
> + *
> + * If the message text in @pmsg->pbufs->outbuf does not have enough space for
> + * the dropped message, the message text will be sufficiently truncated.
> + *
> + * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
> + */
> +static void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
> +{
> +	struct printk_buffers *pbufs = pmsg->pbufs;
> +	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
> +	const size_t outbuf_sz = sizeof(pbufs->outbuf);
> +	char *scratchbuf = &pbufs->scratchbuf[0];
> +	char *outbuf = &pbufs->outbuf[0];
> +	size_t len;
> +
> +	len = snprintf(scratchbuf, scratchbuf_sz,
> +		       "** %lu printk messages dropped **\n", dropped);
> +
> +	/*
> +	 * Make sure outbuf is sufficiently large before prepending.
> +	 * Keep at least the prefix when the message must be truncated.
> +	 * It is a rather theoretical problem when someone tries to
> +	 * use a minimalist buffer.
> +	 */
> +	if (WARN_ON_ONCE(len + PREFIX_MAX >= outbuf_sz))
> +		return;

I guess that this will always trigger the compiler warning
when CONFIG_PRINTK is disabled. See the report for v3 at
https://lore.kernel.org/r/202301052114.vvN3wQoH-lkp@intel.com

Hmm, we might want to fix this warning so that it does not break
build with -Werror.

IMHO, the proper solution would be to define this function only when
CONFIG_PRINTK is defined. But it might require bigger changes
and define many more console functions only when CONFIG_PRINTK
is defined. This is out-of-scope of this patchset.

I wonder if the following would work as an "intermediate" workaround:

	if (!IS_ENABLED(CONFIG_PRINTK) ||
	    WARN_ON_ONCE(len + PREFIX_MAX >= outbuf_sz))
		return;


Best Regards,
Petr
