Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D51765C3A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjACQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjACQNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:13:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA891144A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:13:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BFDC767DD0;
        Tue,  3 Jan 2023 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672762393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DzotSgXKbC1Lf8cxAwofd6uv/PEEKKBQjf5L6vWri8U=;
        b=k1vCHa2PH/oATzLAsmqtdJ1yc4KaQl2+NkG5W8F8j+z5GGhalfydRdvdsQhJGIv4txoeYl
        4wuJasWTO/R6sKYHLBziXHJ6ekUbtd7EhQJqEXqPNOvd4MEZvkVr2p0rNrDwDOy34pl5i9
        NxY/cbcUYltgd7imuI1iY3rc/yqt9NA=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 936E82C141;
        Tue,  3 Jan 2023 16:13:13 +0000 (UTC)
Date:   Tue, 3 Jan 2023 17:13:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: introduce
 console_prepend_dropped() for dropped messages
Message-ID: <Y7RUF1zhmJEJKWl3@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-7-john.ogness@linutronix.de>
 <Y7MEDmP1zqWblj0N@alley>
 <87y1qjdimw.fsf@jogness.linutronix.de>
 <Y7QtusGlIX3AU+TN@alley>
 <87o7rfd96w.fsf@jogness.linutronix.de>
 <Y7Q4u9ICptw0RnXb@alley>
 <87fscrd5os.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fscrd5os.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-01-03 16:06:03, John Ogness wrote:
> On 2023-01-03, Petr Mladek <pmladek@suse.com> wrote:
> >> Actually, I would like to rename all of those limit macros to something
> >> that makes more sense for the new code base:
> >> 
> >> CONSOLE_EXT_LOG_MAX -> CONSOLE_MESSAGE_MAX
> >> 
> >> CONSOLE_LOG_MAX     -> SYSLOG_MESSAGE_MAX
> >
> > Heh, we actually do not need this. The size of @scratchbuf
> > might be LOG_LINE_MAX/PRINTK_RECORD_MAX. The scratch buffer
> > is newly used only to read the plain message. The prefixes
> > are added to @outbuf.
> >
> >> LOG_LINE_MAX        -> PRINTK_RECORD_MAX
> 
> The scratch buffer would become PRINTK_RECORD_MAX, but we still need
> SYSLOG_MESSAGE_MAX for the kmalloc's syslog buffers.

I see.

> Unless you think it is OK to kmalloc 8KB instead of 1KB for the
> syslog calls. Then yes, we do not need SYSLOG_MESSAGE_MAX.

IMHO, it is acceptable and even correct. syslog uses the same
prefixes as console. It would make sense to use the same
buffers for formatting.

That said, 8kB looks non-necessary big to me.

It seems that it comes from devkmsg interface, see the commit
d43ff430f434d862db59582 ("printk: guard the amount written
per line by devkmsg_read()"). It was supposed to include
the message, the extended prefix and dictionary, where

   + message is limited by LOG_LINE_MAX
   + prefix includes few well defined fields (should be < 128B)
   + dictionary comes from dev_printk() => ( < 128B as well)

I believe that 2kB or 4kB would be perfectly fine.

Best Regards,
Petr
