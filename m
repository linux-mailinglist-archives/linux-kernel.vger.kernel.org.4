Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7954673D788
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjFZGHk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 02:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjFZGHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:07:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EB8EE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:07:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DAF660C89
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B683C433C8;
        Mon, 26 Jun 2023 06:07:34 +0000 (UTC)
Date:   Mon, 26 Jun 2023 02:07:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sunliming <sunliming@kylinos.cn>
Subject: Re: [GIT PULL] tracing: user_event fix for 6.4
Message-ID: <20230626020731.299d0b10@rorschach.local.home>
In-Reply-To: <CAHk-=wirKv866nP=v3uBf0TTvaPxfSvAQUJfL2KB-NZboBVUaQ@mail.gmail.com>
References: <20230623152926.128aa568@gandalf.local.home>
        <CAHk-=whmnhEY6s1USY+hHX5+31orf7U_TxXvx+Y89xhL-Ydvzg@mail.gmail.com>
        <20230623220959.6461cc02@rorschach.local.home>
        <20230624135056.263e0ba9@rorschach.local.home>
        <CAHk-=wirKv866nP=v3uBf0TTvaPxfSvAQUJfL2KB-NZboBVUaQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2023 16:04:32 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The fact that your explanation is "we have that bug in other places"
> does *not* make me any happier.

Actually it's just the behavior inside the kernel. I just wrote a quick
program to see the behavior of /sys/kernel/tracing/trace_marker, and
yeah, it actually returns an error when writing if the ring buffer is
disabled.

I was trying to imitate the internal behavior in the kernel, but I
shouldn't have, as we control all the instances of that.

Now testing the other user space interface, it does behave the way you
described (something I implemented years ago!). So I will drop this
version of the patch.

From the code for trace_marker:

        if (unlikely(!event))
                /* Ring buffer disabled, return as if not open for write */
                return -EBADF;


sunliming's original patch had it return an error. I'll have him redo
that one, because the current behavior is still wrong as it returns as
if it wrote something when it did not.

 https://lore.kernel.org/all/20230608011554.1181097-2-sunliming@kylinos.cn/

We were the ones to tell him not to return an error, so I take the
blame on that. But if we are going to return an error, I rather follow
what trace_marker does and return -EBADF and not -EFAULT.

sunliming,

Care to send a v3 that returns -EBADF instead?

Thanks,

-- Steve
