Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A24865493F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLVX2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiLVX2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:28:15 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Dec 2022 15:28:13 PST
Received: from second.openwall.net (second.openwall.net [193.110.157.125])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6847C1AA0B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 15:28:13 -0800 (PST)
Received: (qmail 10063 invoked from network); 22 Dec 2022 23:21:31 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 22 Dec 2022 23:21:31 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 59670AB3A4; Fri, 23 Dec 2022 00:21:12 +0100 (CET)
Date:   Fri, 23 Dec 2022 00:21:12 +0100
From:   Solar Designer <solar@openwall.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     oss-security@lists.openwall.com,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat correctly
Message-ID: <20221222232112.GA29438@openwall.com>
References: <Y6SJDbKBk471KE4k@p183> <Y6TUJcr/IHrsTE0W@codewreck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6TUJcr/IHrsTE0W@codewreck.org>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 07:03:17AM +0900, Dominique Martinet wrote:
> Alexey Dobriyan wrote on Thu, Dec 22, 2022 at 07:42:53PM +0300:
> > --- a/man5/proc.5
> > +++ b/man5/proc.5
> > @@ -2092,6 +2092,11 @@ Strings longer than
> >  .B TASK_COMM_LEN
> >  (16) characters (including the terminating null byte) are silently truncated.
> >  This is visible whether or not the executable is swapped out.
> > +
> > +Note that \fIcomm\fP can contain space and closing parenthesis characters. 
> > +Parsing /proc/${pid}/stat with split() or equivalent, or scanf(3) isn't
> > +reliable. The correct way is to locate closing parenthesis with strrchr(')')
> > +from the end of the buffer and parse integers from there.
> 
> That's still not enough unless new lines are escaped, which they aren't:
> 
> $ echo -n 'test) 0 0 0
> ' > /proc/$$/comm
> $ cat /proc/$$/stat
> 71076 (test) 0 0 0
> ) S 71075 71076 71076 34840 71192 4194304 6623 6824 0 0 10 3 2 7 20 0 1 0 36396573 15208448 2888 18446744073709551615 94173281726464 94173282650929 140734972513568 0 0 0 65536 3686404 1266761467 1 0 0 17 1 0 0 0 0 0 94173282892592 94173282940880 94173287231488 140734972522071 140734972522076 140734972522076 140734972526574 0
> 
> The silver lining here is that comm length is rather small (16) so we
> cannot emulate full lines and a very careful process could notice that
> there are not enough fields after the last parenthesis... So just look
> for the last closing parenthesis in the next line and try again?

No, just don't treat this file's content as a line (nor as several
lines) - treat it as a string that might contain new line characters.

The ps command from procps-ng seems to manage, e.g. for your test "ps c"
prints:

29394 pts/3    S      0:00 test) 0 0 0?

where the question mark is what it substitutes for the non-printable
character (the new line character).  I didn't check whether the process
name it prints comes from /proc/$$/stat or /proc/$$/status, though (per
strace, it reads both).

> But, really, I just don't see how this can practically be said to be parsable...

This format certainly makes it easier to get a parser wrong than to get
it right.

I agree the above man page edit is not enough, and should also mention
the caveat that this shouldn't be read in nor parsed as a line.

Also, the Linux kernel does have problems with new lines in the comm
field elsewhere, at least in the log messages it produces:

https://github.com/lkrg-org/lkrg/issues/165

Here I looked into this in context of LKRG development, but with the
kernel itself also producing messages with comm in them the point of
only fixing LKRG's messages is moot.

Alexander

P.S. While this thread goes well so far, please note that in general
CC'ing other lists on postings to oss-security (or vice versa) is
discouraged.  With such CC's, possible follow-ups from members of those
other lists can be off-topic for oss-security - e.g., they might focus
on non-security technicalities.  Probably not this time when only a man
page is to be patched, but proposed patches to the Linux kernel often
result in lengthy discussions and multiple versions of the patch.  In
those cases, I think it's better to have separate threads and only post
summary follow-up(s) to oss-security (e.g., one message stating that a
patch was proposed and linking to the thread, and another after the
final version is merged).
