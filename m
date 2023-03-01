Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F466A758E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCAUqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAUqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:46:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C712B43445;
        Wed,  1 Mar 2023 12:46:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86A53B81126;
        Wed,  1 Mar 2023 20:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3717EC433EF;
        Wed,  1 Mar 2023 20:46:43 +0000 (UTC)
Date:   Wed, 1 Mar 2023 15:46:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <20230301154641.695778bf@gandalf.local.home>
In-Reply-To: <20230301203645.GG2948950@paulmck-ThinkPad-P17-Gen-1>
References: <20230228160324.2a7c1012@gandalf.local.home>
        <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
        <20230228164124.77c126d2@gandalf.local.home>
        <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
        <20230228190846.79b06089@gandalf.local.home>
        <CAFULd4aY3Y8tyLN70oebZDagBebvH0erwRxKDaEX8L83Xo8gYw@mail.gmail.com>
        <20230301113813.4f16a689@gandalf.local.home>
        <CAFULd4aWZ+fvVZ+MEt6JD1rFaQZeO5DDWAHtPKOrx8R8DETFBw@mail.gmail.com>
        <20230301200820.GF2948950@paulmck-ThinkPad-P17-Gen-1>
        <20230301151826.014c5977@gandalf.local.home>
        <20230301203645.GG2948950@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 12:36:45 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Some years down the road, should cmpxchg_success() be on the tip of
> the tongue of every kernel hacker, perhaps.  Or perhaps not.

A bit of a catch-22 I would say. It will only become something everyone
knows if it exists.

> 
> In the meantime, we have yet another abysmally documented atomic

Is it?

> operation that is not well known throughout the community.  And then the
> people coming across this curse everyone who had anything to do with it,
> as they search the source code, dig through assembly output, and so on
> trying to work out exactly what this thing does.
> 
> Sorry, but no way.
> 
> Again, unless there is some sort of forward-progress argument or
> similar convincing argument.

Speaking of forward progress...

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/atomic_t.txt#n316

Anyway, I'm guessing this will not become part of rcu any time soon. But
for the ring buffer, I would happily take it.

-- Steve
