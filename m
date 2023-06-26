Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163B173E041
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjFZNNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjFZNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:13:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1545CB9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:13:06 -0700 (PDT)
Date:   Mon, 26 Jun 2023 15:13:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687785184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJ4Di89KqvgxUq7+UJZlhQS8x66yPkUdMBNqO/L1Rec=;
        b=fgyoaiRnwPpzjij3YonvglSVuPKoz7tB3jQL5S2xPWD9go0IqdjyIJM5VK+Xz4tS0jJxTI
        ReAkJ5oDzqXxNggzgyJS+M9Tfbx8t0kUWB3xaDftWRbpBhT5InNws4U5cdxcwj/GdqV0TO
        7UVq5i/DuT0/FAAkWfefQ8Y+VljTvfmoQmaFoAL+HysHyZVtQqGgq1E//aXWGI+zOgdOYY
        onS7Ch5mEyw7jX1SY25gM+FMwNLGjpqj3ygYpEyYNVvQYdu3IM3bEvJuZIg2uHzUSl8UEl
        hrzC0wFRLAD1tqjYQ1c6Fki3akiex2AnDCqwvkUwvu2fDvQQsaQQoRyyIclfqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687785184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJ4Di89KqvgxUq7+UJZlhQS8x66yPkUdMBNqO/L1Rec=;
        b=/JKRY25+CV9oEwP8w1J9orRkTduJ2mTQKJYT8OIYSOx7TZY4KzUNdO0991I2iFRgkPYOg/
        cqKj0QPwj7wNfhAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Message-ID: <20230626131302.JsFNvwps@linutronix.de>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de>
 <0a0c768c-227d-c0cd-1b91-5a884d161c1b@I-love.SAKURA.ne.jp>
 <20230626104831.GT4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230626104831.GT4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-26 12:48:31 [+0200], Peter Zijlstra wrote:
>=20
> Don't be like that... just hate on prink like the rest of us. In fact,
> i've been patching out the actual printk code for years because its
> unusable garbage.

:)

> Will this actually still be a problem once all the fancy printk stuff
> lands? That shouldn't do synchronous prints except to 'atomic' consoles
> by default IIRC.

The fancy printk stuff should have synchronous printing in emergency
situations and threaded printing by default. But then I hear John saying
that there might be push back because atomic consoles may not be
available everywhere=E2=80=A6

Anyway, the requirement for the deadlock to trigger, that Tetsuo Handa
is concerned here:
- lockdep enabled
- console and tty in use.
- tty_insert_flip_string_and_push_buffer() on one CPU with
  tty_port::lock acquired followed with a memory allocation blocking on
  read_seqbegin(&zonelist_update_seq) due the writer
- memory hotplug =3D> __build_all_zonelists() acquiring
  write_seqlock(&zonelist_update_seq) and now lockdep creates a splat.
  This is accounted for if the lockdep annotation comes first (1/2 of
  the series). But the unlock annotation of the seq unlock operation may
  still create a splat so a possibility for a deadlock remains.

The requirement is _high_ and it hardly justifies ugly code.

Sebastian
