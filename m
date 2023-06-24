Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDD073C64D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 04:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjFXCKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 22:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFXCKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 22:10:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157C1273E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 19:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F9CA61B97
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30893C433C8;
        Sat, 24 Jun 2023 02:10:02 +0000 (UTC)
Date:   Fri, 23 Jun 2023 22:09:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sunliming <sunliming@kylinos.cn>
Subject: Re: [GIT PULL] tracing: user_event fix for 6.4
Message-ID: <20230623220959.6461cc02@rorschach.local.home>
In-Reply-To: <CAHk-=whmnhEY6s1USY+hHX5+31orf7U_TxXvx+Y89xhL-Ydvzg@mail.gmail.com>
References: <20230623152926.128aa568@gandalf.local.home>
        <CAHk-=whmnhEY6s1USY+hHX5+31orf7U_TxXvx+Y89xhL-Ydvzg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 16:21:36 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 23 Jun 2023 at 12:29, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Before user events become an ABI, fix the return value of the write
> > operation when tracing is disabled. It should not return an error, but
> > simply report it wrote zero bytes. Just like any other write operation
> > that doesn't write data but does not "fail".  
> 
> This makes no sense.
> 
> A write() returning 0 means "Disk full". It's most definitely an
> error, and a failure.
> 

OK, I shouldn't have said that it was like other disk write options. I
was thinking more of writing to something that uses a buffer like
snprintf() which returns the number of bytes written.

> But zero is not a particularly _good_ failure code. At least not
> unless your tracing disk is full. Is it?

It's not a failure. It means that the buffer is disabled. This is more
in line to what the kernel trace events do when tracing is disabled,
the writes just return zero. That is, you do not want to retry.

> 
> If tracing is disabled, and you write something to it, I would expect
> to get a valid and reasonable error code back. Something like EINVAL
> or EIO or something to show "you did something wrong".
> 
> I do not at all understand the sentence
> 
>    "When user_events are disabled, its write operation should return zero"
> 
> as an "explanation" for this, and my immediate reaction is "Really?
> Why? That makes no sense".


So basically the way tracing is done is that something can enable the
event (that will then do the write) but if the trace buffer writes are
disabled, the writes should just be dropped. This is how it currently
works in the kernel, and we were trying to make it the same in user
space.

The code that does the write is basically something being monitored by
something else that will tell it to start writing. But that something
else could have the buffer disabled for writes. The use case for this
is to disable the buffer, enable all the trace events you care about,
and then enabled the buffer which is the same as enabling all events at
the same time to get a more coherent trace.

But we don't want the writes to return errors when the buffer is
disabled. The writes should just be dropped. An error code means
something isn't connected properly, but a zero return just means
everything is connected properly, but it is not ready to accept content
yet.

-- Steve
