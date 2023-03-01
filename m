Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9226A7468
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCAToC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAToA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:44:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3572FCFE;
        Wed,  1 Mar 2023 11:43:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED53614B3;
        Wed,  1 Mar 2023 19:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648FEC433D2;
        Wed,  1 Mar 2023 19:43:57 +0000 (UTC)
Date:   Wed, 1 Mar 2023 14:43:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <20230301144355.338c62de@gandalf.local.home>
In-Reply-To: <CAFULd4YPP_5koKN5ZbdgOueXcpUgap97UkaxxyzzGcQ=GEV__Q@mail.gmail.com>
References: <20230228155121.3416-1-ubizjak@gmail.com>
        <Y/5mguXPPqdP3MZF@google.com>
        <20230228160324.2a7c1012@gandalf.local.home>
        <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
        <20230228164124.77c126d2@gandalf.local.home>
        <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
        <20230228190846.79b06089@gandalf.local.home>
        <CAFULd4aY3Y8tyLN70oebZDagBebvH0erwRxKDaEX8L83Xo8gYw@mail.gmail.com>
        <20230301113813.4f16a689@gandalf.local.home>
        <CAFULd4aWZ+fvVZ+MEt6JD1rFaQZeO5DDWAHtPKOrx8R8DETFBw@mail.gmail.com>
        <20230301135201.59771b73@gandalf.local.home>
        <CAFULd4YPP_5koKN5ZbdgOueXcpUgap97UkaxxyzzGcQ=GEV__Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 20:18:11 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

> If we want to put the definition in generic headers, then we also need
> to define acquire/release/relaxed and 64bit variants. ATM, we have two
> sites that require this definition and I think that for now we could
> live with two instances of the same definition in two separate
> subsystems. But this would definitely be a good future addition. There
> is some code in the form of
> 
> if (cmpxchg (ptr, 0, 1) == 0)
> 
> that can not be converted to try_cmpxchg, but can use cmpxchg_success.

And even modify code that uses temp variables. For example, where you
modified the ring buffer code to use try_cmpxchg(), I could convert your:

static int rb_head_page_replace(struct buffer_page *old,
				struct buffer_page *new)
{
	unsigned long *ptr = (unsigned long *)&old->list.prev->next;
	unsigned long val;

	val = *ptr & ~RB_FLAG_MASK;
	val |= RB_PAGE_HEAD;

	return try_cmpxchg(ptr, &val, (unsigned long)&new->list);
}

Into just:

static int rb_head_page_replace(struct buffer_page *old,
				struct buffer_page *new)
{
	unsigned long *ptr = (unsigned long *)&old->list.prev->next;
	unsigned long val;

	val = *ptr & ~RB_FLAG_MASK;

	return cmpxchg_success(ptr, val | RB_PAGE_HEAD, (unsigned long)&new->list);
}

-- Steve
