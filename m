Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F055FA194
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJJQH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJJQHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:07:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCCD2C7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:07:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0888A1F91B;
        Mon, 10 Oct 2022 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665418042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Dpv3pp/cMCr8DV605wKdnaAFOw2tNw2Yu9T2b2jb1M=;
        b=pEeP09Htm0edHdjNdQi+4i6fnKU6U6vR2uIzVk/bvqMT2+mRHLaZhAHMQ8WoreUXe7vXwu
        B2ecnd3q+1Njlss115C/JtoEjlyvve8Tp11UszHL7PxQROPdTWdfDHpcqabE1fpCsoqsjz
        G9KvatXN4bJPoXvm90KQunw2nPmav4s=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B6E4B2C141;
        Mon, 10 Oct 2022 16:07:21 +0000 (UTC)
Date:   Mon, 10 Oct 2022 18:07:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 18/18] printk: Handle dropped message smarter
Message-ID: <Y0RDNjyYh0BpDiIQ@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-19-john.ogness@linutronix.de>
 <YzEoYPSC5Qf2aL92@google.com>
 <87leq6d0zn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leq6d0zn.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-09-26 10:00:36, John Ogness wrote:
> On 2022-09-26, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > On (22/09/24 02:10), John Ogness wrote:
> >> +/**
> >> + * cons_print_dropped - Print 'dropped' message if required
> >> + * @desc:	Pointer to the output descriptor
> >> + *
> >> + * Prints the 'dropped' message info the output buffer if @desc->dropped is
> >> + * not 0 and the regular format is requested. Extended format does not
> >> + * need this message because it prints the sequence numbers.
> >> + *
> >> + * In regular format the extended message buffer is not in use.
> >> + * So print into it at the beginning and move the resulting string
> >> + * just in front of the regular text buffer so that the message can
> >> + * be printed in one go.
> >> + *
> >> + * In case of a message this returns with @desc->outbuf and @desc->len
> >> + * updated. If no message is required then @desc is not modified.
> >> + */
> >> +static void cons_print_dropped(struct cons_outbuf_desc *desc)
> >> +{
> >> +	struct cons_text_buf *txtbuf = desc->txtbuf;
> >> +	size_t len;
> >> +
> >> +	if (!desc->dropped || desc->extmsg)
> >> +		return;
> >> +
> >> +	if (WARN_ON_ONCE(desc->outbuf != txtbuf->text))
> >> +		return;
> >> +
> >> +	/* Print it into ext_text which is unused */
> >> +	len = snprintf(txtbuf->ext_text, DROPPED_TEXT_MAX,
> >> +		       "** %lu printk messages dropped **\n", desc->dropped);
> >> +	desc->dropped = 0;
> >> +
> >> +	/* Copy it just below text so it goes out with one write */
> >> +	memcpy(txtbuf->text - len, txtbuf->ext_text, len);
> >> +
> >> +	/* Update the descriptor */
> >> +	desc->len += len;
> >> +	desc->outbuf -= len;
> >
> > Oh, hmm. This does not look to me as a simplification. Quite
> > the opposite, moving cons_text_buf::text pointer to point to
> > cons_text_buf::text - strlen("... dropped messages...") looks
> > somewhat fragile.
> 
> It relies on @ext_text and @text being packed together, which yes, may
> be fragile.

Yes, it is a nasty hack ;-)

I suggest to increase CONSOLE_LOG_MAX to 2048,
define LOG_LINE_MAX as 1024, and use the buffer for both
dropped message and normal message.

It would simplify the code. Also it would make enough
space for more potential line headers needed by more
lines in one record.

It would require moving the normal message to make a space for
the dropped messages. But the dropping should be rare. And we
do a lot of moving in record_print_text() anyway.

I think that I was against increasing the buffer size some time ago.
I was worried about small devices. But I think that the patch
just increased the buffer size without any bug report so that
the justification was weak.

But simplifying the code looks like a good justification to me.
And I really like the removal of the extra buffer.

Best Regards,
Petr
