Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933DD65D0B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjADKdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjADKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:33:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AFC95BE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:33:51 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9938D49C6;
        Wed,  4 Jan 2023 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672828430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9MENpgKWJUeBtkqg/AW3kRkJNgM5Dwvt7M9Yj1nczok=;
        b=Wx8W3ShVeasimMMdLVr9V5fl/IvH9lMKnqBIbkM2qXA75Q7WAa8ocbSn8Yb0w1O8j9u1lp
        S+2fat15tgzH751Er0pLDgwwpgr/YXuH3cWghUq/aPvHJPZforeHcxy/2DQuzr2RQ45KdS
        92ZtALyY+BSaYKsB9JkZOmZeLvol3mk=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 549532C141;
        Wed,  4 Jan 2023 10:33:50 +0000 (UTC)
Date:   Wed, 4 Jan 2023 11:33:49 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: introduce
 console_prepend_dropped() for dropped messages
Message-ID: <Y7VWDUUQ4f4EX/8v@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-7-john.ogness@linutronix.de>
 <Y7MEDmP1zqWblj0N@alley>
 <87y1qjdimw.fsf@jogness.linutronix.de>
 <Y7QtusGlIX3AU+TN@alley>
 <87o7rfd96w.fsf@jogness.linutronix.de>
 <Y7Q4u9ICptw0RnXb@alley>
 <87fscrd5os.fsf@jogness.linutronix.de>
 <Y7RUF1zhmJEJKWl3@alley>
 <874jt6fz46.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jt6fz46.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-01-04 10:12:01, John Ogness wrote:
> On 2023-01-03, Petr Mladek <pmladek@suse.com> wrote:
> >> Unless you think it is OK to kmalloc 8KB instead of 1KB for the
> >> syslog calls. Then yes, we do not need SYSLOG_MESSAGE_MAX.
> >
> > IMHO, it is acceptable and even correct. syslog uses the same
> > prefixes as console. It would make sense to use the same
> > buffers for formatting.
> >
> > That said, 8kB looks non-necessary big to me.
> >
> > It seems that it comes from devkmsg interface, see the commit
> > d43ff430f434d862db59582 ("printk: guard the amount written
> > per line by devkmsg_read()"). It was supposed to include
> > the message, the extended prefix and dictionary, where
> >
> >    + message is limited by LOG_LINE_MAX
> >    + prefix includes few well defined fields (should be < 128B)
> >    + dictionary comes from dev_printk() => ( < 128B as well)
> >
> > I believe that 2kB or 4kB would be perfectly fine.
> 
> The main issue is multi-line records. Normal messages become _much_
> larger than extended messages in this case because they add a prefix per
> '\n', whereas extended messages just use "\x0a". Extended messages
> really could only end up being significantly longer than normal messages
> if there are many non-printable characters in the message. But AFAIK
> non-printables are not really used in printk messages.

Right.

> So IMHO it does not make sense that normal messages are limited to 1KB
> but extended messages can use 8KB. I agree that a universal limit of 2KB
> for normal/extended/syslog would be a nice compromise. Normal messages
> will have more space available and it will reduce the overall static
> buffer usage. It would mean that syslog calls will kmalloc 2KB instead
> of 1KB, but I expect that should be acceptable since, generally
> speaking, overall we are reducing memory usage.

I agree that 2kB are a good compromise and the allocation should be acceptable.

Best Regards,
Petr
