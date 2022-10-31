Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F151F613D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJaSPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJaSPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:15:47 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976D565C6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:15:46 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id c26so2670139uak.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/nznu592QecLrPw8CafP0xh5EXfjZ+sQg+B1NGtxhZY=;
        b=oPh/dMCiE+bm1dCTeQbPmsoIIQFSr3txBEeoAJnjUjV96S3kFHI0x5JQ50Iy2zTMzz
         m+5b9wgk3aQjgWqH59jA6OoJkdyYMc1KAjqL93qGUkO9fBHXjoWQfIa9oZ67Czn89jIT
         6fds2aUqV88BluVe9V+Mw79zWcqgVDmivXgNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nznu592QecLrPw8CafP0xh5EXfjZ+sQg+B1NGtxhZY=;
        b=5HV6SKS0WWGtYnve85CqOlfuLBNAr3ZA8E4U2Bakmjyr5ZEa3xcuIMbGUfeqsJfzCg
         yQ/sxDl7JOvEKfCUVpY4JiowQ/fTz87ngHNzldD44tiWriFYCx20Wu9orEGFQwvDj+Z+
         gkxhVq302kxosBN8IquV9TPId+Hc56sV/g/PfJVmRrY9QjR0Dh8IOCqUtxKafVM9xJe7
         1wzuXg7oJl1nxmzPZU7OxN4v5c07OfbBM/1gm2+oYHzI/QufjZfrpBwhQ2yVZkZpgiKN
         BnoNAcj1DyJBnBdJCMZYsX4c3/3m+QP4NyyafuC+BQfYezyttFnKuPIHm8ms43DQI9FW
         H9+g==
X-Gm-Message-State: ACrzQf1UXTnH3yXgOeIe3G8ody5bQERRpIlf33lRD05CVirvU/T7IdVh
        icXjqUyGhQTyipLLoUMqOkCma1jfZR5HCB6qIklKe60RE+g9/A==
X-Google-Smtp-Source: AMsMyM4g8phefyWmQkFPh5wyolVyCwQB9wiryhWSP7vHR8z1ezS2B89Dyn5mCi2eh4wItY1zhe8cXlZe6F7Q8Pr6dyM=
X-Received: by 2002:ab0:6918:0:b0:3ea:cad4:4de2 with SMTP id
 b24-20020ab06918000000b003eacad44de2mr3993951uas.46.1667240145574; Mon, 31
 Oct 2022 11:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221019225144.2500095-13-paulmck@kernel.org> <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
 <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1> <Y1ZtyjxKCcV0Hfjn@pc636>
 <Y1aDy3maaO39ClSU@pc636> <Y1ahs83258Lok9+O@google.com> <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1a8ei1h7SzyYZx9@pc636> <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1xIY77sFTyxgAsU@google.com> <Y1/LwKz60iU2izOZ@pc636>
In-Reply-To: <Y1/LwKz60iU2izOZ@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 31 Oct 2022 14:15:33 -0400
Message-ID: <CAEXW_YTmtm2yb0MVvNV9C1jPEs=5K9PaEFsWEG7pAmPAyWJ_qQ@mail.gmail.com>
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use call_rcu_flush()
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 9:21 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Fri, Oct 28, 2022 at 09:23:47PM +0000, Joel Fernandes wrote:
> > On Mon, Oct 24, 2022 at 09:48:19AM -0700, Paul E. McKenney wrote:
> > > On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
> > > > >
> > > > > You guys might need to agree on the definition of "good" here.  Or maybe
> > > > > understand the differences in your respective platforms' definitions of
> > > > > "good".  ;-)
> > > > >
> > > > Indeed. Bad is when once per-millisecond infinitely :) At least in such use
> > > > workload a can detect a power delta and power gain. Anyway, below is a new
> > > > trace where i do not use "flush" variant for the kvfree_rcu():
> > > >
> > > > <snip>
> > > > 1. Home screen swipe:
[...]
> > > > 2. App launches:
[...]
> > > > <snip>
> > > >
> > > > it is much more better. But. As i wrote earlier there is a patch that i have submitted
> > > > some time ago improving kvfree_rcu() batching:
> > > >
> > > > <snip>
> > > > commit 51824b780b719c53113dc39e027fbf670dc66028
> > > > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Date:   Thu Jun 30 18:33:35 2022 +0200
> > > >
> > > >     rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
> > > >
> > > >     Currently the monitor work is scheduled with a fixed interval of HZ/20,
> > > >     which is roughly 50 milliseconds. The drawback of this approach is
> > > >     low utilization of the 512 page slots in scenarios with infrequence
> > > >     kvfree_rcu() calls.  For example on an Android system:
> > > > <snip>
> > > >
> > > > The trace that i posted was taken without it.
> > >
> > > And if I am not getting too confused, that patch is now in mainline.
> > > So it does make sense to rely on it, then.  ;-)
> >
> > Vlad's patch to change the KFREE_DRAIN_JIFFIES to 5 seconds seems reasonable
> > to me. However, can we unify KFREE_DRAIN_JIFFIES and LAZY_FLUSH_JIFFIES ?
> >
> This is very good.
>
> Below is a plot that i have taken during one use-case. It is about three
> apps usage in parallel. It was done by running "monkey" test:
>
> wget ftp://vps418301.ovh.net/incoming/monkey_3_apps_slab_usage_5_minutes.png
>
> i set up three apps as usage scenario: Google Chrome, YoTube and Camera.
> I logged the Slab metric from the /proc/meminfo. Sampling rate is 0.1 second.
>
> Please have a look at results. It reflects what i am saying. non-flush
> kvfree RCU variant makes a memory usage higher. What is not acceptable
> for our mobile devices and workloads.

That does look higher, though honestly about ~5%. But that's just the
effect of more "laziness". The graph itself does not show a higher
number of shrinker invocations, in fact I think shrinker invocations
are not happening much that's why the slab holds more memory. The
system may not be under memory pressure?

Anyway, I agree with your point of view and I think my concern does
not even occur with the latest patch on avoiding RCU that I posted
[1], so I come in peace.

[1] https://lore.kernel.org/rcu/20221029132856.3752018-1-joel@joelfernandes.org/

I am going to start merging all the lazy patches to ChromeOS 5.10 now
including your kfree updates, except for [1] while we discuss it.
