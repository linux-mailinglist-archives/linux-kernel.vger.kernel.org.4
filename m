Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF30E5E9B57
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiIZH7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiIZH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:58:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7396B63C0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:54:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664178876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NKhc8qFzuT7oDQPl2tzoXxQ/g8SoOYHWBX8Uw/Wsd50=;
        b=v9FTBr3EuhPm2Jwmd5X3M0K/acEkHtVcDz1OBdSFY5EjKENEaH90IxjyHomZy22Qsps1nl
        bzuXC3M0jlbGgarN/QCD8d1cfij3fnPCtRgsXS7i4+faexNWkI7n3yig1zioeJUSAnq+Yd
        ks74rJVvZni/cZH6cL0Hh5H9OdLV+Iw3trgeJAeFpvvCMouFJmpp4LjViCRckR0csDDltS
        FtJsYzJ5Z+M1ZKsC64tAdhThoH7o10/PQcbtRtCdcwux38CBjvunnHlLVbs4NXuUaNlFqa
        sFZJF5P9fknPyXi+wjJHG1DghDd0WFqrVK+EuVXGYaDbLJncDLlFCr9N1aCHJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664178876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NKhc8qFzuT7oDQPl2tzoXxQ/g8SoOYHWBX8Uw/Wsd50=;
        b=upHGNdMZLwWXlLY4p6BkuV5IeciHUtWKnMnqr0DfpcMFbD3it4R3xHMF7Q0LOT0hW6CvH+
        KtJ1O/piM2cK4ADw==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 18/18] printk: Handle dropped message smarter
In-Reply-To: <YzEoYPSC5Qf2aL92@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-19-john.ogness@linutronix.de>
 <YzEoYPSC5Qf2aL92@google.com>
Date:   Mon, 26 Sep 2022 10:00:36 +0206
Message-ID: <87leq6d0zn.fsf@jogness.linutronix.de>
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

On 2022-09-26, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> On (22/09/24 02:10), John Ogness wrote:
>> +/**
>> + * cons_print_dropped - Print 'dropped' message if required
>> + * @desc:	Pointer to the output descriptor
>> + *
>> + * Prints the 'dropped' message info the output buffer if @desc->dropped is
>> + * not 0 and the regular format is requested. Extended format does not
>> + * need this message because it prints the sequence numbers.
>> + *
>> + * In regular format the extended message buffer is not in use.
>> + * So print into it at the beginning and move the resulting string
>> + * just in front of the regular text buffer so that the message can
>> + * be printed in one go.
>> + *
>> + * In case of a message this returns with @desc->outbuf and @desc->len
>> + * updated. If no message is required then @desc is not modified.
>> + */
>> +static void cons_print_dropped(struct cons_outbuf_desc *desc)
>> +{
>> +	struct cons_text_buf *txtbuf = desc->txtbuf;
>> +	size_t len;
>> +
>> +	if (!desc->dropped || desc->extmsg)
>> +		return;
>> +
>> +	if (WARN_ON_ONCE(desc->outbuf != txtbuf->text))
>> +		return;
>> +
>> +	/* Print it into ext_text which is unused */
>> +	len = snprintf(txtbuf->ext_text, DROPPED_TEXT_MAX,
>> +		       "** %lu printk messages dropped **\n", desc->dropped);
>> +	desc->dropped = 0;
>> +
>> +	/* Copy it just below text so it goes out with one write */
>> +	memcpy(txtbuf->text - len, txtbuf->ext_text, len);
>> +
>> +	/* Update the descriptor */
>> +	desc->len += len;
>> +	desc->outbuf -= len;
>
> Oh, hmm. This does not look to me as a simplification. Quite
> the opposite, moving cons_text_buf::text pointer to point to
> cons_text_buf::text - strlen("... dropped messages...") looks
> somewhat fragile.

It relies on @ext_text and @text being packed together, which yes, may
be fragile. As an alternative we could memcpy the message text (@text)
to the end of the dropped message text. There would be enough room.

Generally speaking, the dropped text will be less text to copy. But
since dropped messages are rare anyway, it might be worth copying more
data so that the code is not fragile. It would also allow us to remove
the __no_randomize_layout in "struct cons_text_buf".

If the end of cons_print_dropped was changed to:

        memcpy(txtbuf->ext_text + len, txtbuf->text, desc->len);
        desc->len += len;
        desc->outbuf = txtbuf->ext_text;

Would that be OK for you?

> Is printing 'dropped' and outbuf messages in one go such an
> important feature?

I think it is a nice simplification. With the cons_text_buf, it makes it
quite easy to implement.

John
