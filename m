Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45A769BE61
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 04:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBSDU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 22:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBSDUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 22:20:54 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8DF13D7E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 19:20:53 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id q12so1654184ljp.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 19:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JS7iyyJ3Wgclpy8Qa16AfhpmzDvAtuJ71qOlxQJZgys=;
        b=sjBUzB3yCo+GolbRUXprbeQKZpaewJcEYXfvB4qOGpc1jJMk9U+xdl+XPbK+gagM6T
         vKnjhE0Z4uR0kf6YEWMjKSjxh/rlX2a66hekdxiCbh6HORktGWJT9NKlKbCwlRNWX/RM
         CV4cfrSOIEU5/YECR1tE/yinzBanyIomHiUyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JS7iyyJ3Wgclpy8Qa16AfhpmzDvAtuJ71qOlxQJZgys=;
        b=UmoXqsVJpmQt2bKj6q6RlhsnRvZkOENZaWervxvJKozJ2jh7D68Q+AuRky2QS9FVvp
         T1wzTHPY6sWcGydt1gRJ+KB9rQGoiwkiSRTPe+SRvnKaZzjbkv9gA/Al3nNG/W3sHX56
         qzLI4lpoUZs0Z+MrLLx2E4tJdJZ4AdJu1Z2kyeUmFUYSQDXKSgWquH7XMFLBWnJIdI9j
         yuUHZHi94jVGthkfPujPBXkrFMf/JaAlhy3UGEMsKU+SEDHRp1dbbgoudvTlliuWeADs
         RFGBzCLVqvmZ3qt+vE5ZRHplv9ygE362gb4LBzDIxZhwadTYvoNnCoMVZD66QE9ui0oR
         olNg==
X-Gm-Message-State: AO0yUKUOngCzBkzCAuG/2A3vMoRGhJSZmoXOifqrJMJQwsxcWpRdrf3p
        5bjpHVFCroM1OWZwodtWIaaSLHjbfh+VYODNfSs3OQ==
X-Google-Smtp-Source: AK7set/I+ZbYpS26OILuuLJTMtDRT/AVXyXyn86t6rAmGYBqJE7wegvxdpli9fIH7caIzlnpNwLZ7g5/1vp4kKO/Jh0=
X-Received: by 2002:a2e:b4b4:0:b0:293:39fe:b712 with SMTP id
 q20-20020a2eb4b4000000b0029339feb712mr284535ljm.3.1676776851298; Sat, 18 Feb
 2023 19:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu> <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com> <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com> <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
 <Y+hWAksfk4C0M2gB@rowland.harvard.edu> <CAEXW_YQ3fvFDNi9wG5w4Zqkbda8SUByOnM6y6MXQpxT9oQw8xQ@mail.gmail.com>
 <20230218192123.GC2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230218192123.GC2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 18 Feb 2023 22:20:39 -0500
Message-ID: <CAEXW_YT-wMxQUXzB0hinCf-f7d7+cG3cALF55ehDe1b4aYob3Q@mail.gmail.com>
Subject: Re: Current LKMM patch disposition
To:     paulmck@kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 2:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, Feb 18, 2023 at 01:13:59AM -0500, Joel Fernandes wrote:
> > Hi Alan,
> >
> > On Sat, Feb 11, 2023 at 9:59 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > [...]
> > >
> > > Would you like to post a few examples showing some of the most difficult
> > > points you encountered?  Maybe explanation.txt can be improved.
> >
> > One additional feedback I wanted to mention, regarding this paragraph
> > under "WARNING":
> > ===========
> > The protections provided by READ_ONCE(), WRITE_ONCE(), and others are
> > not perfect; and under some circumstances it is possible for the
> > compiler to undermine the memory model. Here is an example. Suppose
> > both branches of an "if" statement store the same value to the same
> > location:
> > r1 = READ_ONCE(x);
> > if (r1) {
> > WRITE_ONCE(y, 2);
> > ... /* do something */
> > } else {
> > WRITE_ONCE(y, 2);
> > ... /* do something else */
> > }
> > ===========
> >
> > I tried lots of different compilers with varying degrees of
> > optimization, in all cases I find that the conditional instruction
> > always appears in program order before the stores inside the body of
> > the conditional. So I am not sure if this is really a valid concern on
> > current compilers, if not - could you provide an example of a compiler
> > and options that cause it?
> >
> > In any case, if it is a theoretical concern, it could be clarified
> > that this is a theoretical possibility in the text.  And if it is a
> > real/practical concern, then it could be mentioned the specific
> > compiler/arch this was seen in.
>
> I could be misremembering, but I believe that this reordering has been
> seen in the past.
>

Thank you! And I also confirmed putting a barrier() in the branch
body, also "cures" the optimization... I did not know compilers
optimize so aggressively..

 - Joel
