Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D3E6A61AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjB1VoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjB1VoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:44:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7593757E;
        Tue, 28 Feb 2023 13:42:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67259B80E65;
        Tue, 28 Feb 2023 21:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF876C433D2;
        Tue, 28 Feb 2023 21:41:25 +0000 (UTC)
Date:   Tue, 28 Feb 2023 16:41:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uros Bizjak <ubizjak@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <20230228164124.77c126d2@gandalf.local.home>
In-Reply-To: <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
References: <20230228155121.3416-1-ubizjak@gmail.com>
        <Y/5mguXPPqdP3MZF@google.com>
        <20230228160324.2a7c1012@gandalf.local.home>
        <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
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

On Tue, 28 Feb 2023 13:29:11 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> All well and good, but the stall-warning code is nowhere near a fastpath.
> 
> Is try_cmpxchg() considered more readable in this context?


-	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
+	    try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {

It's basically the same :-/

But looking at this use case, I'd actually NAK it, as it is misleading.

As try_cmpxchg() is used to get rid of the updating of the old value. As in
the ring buffer code we had:

void ring_buffer_record_off(struct trace_buffer *buffer)
{
	unsigned int rd;
	unsigned int new_rd;

	do {
		rd = atomic_read(&buffer->record_disabled);
		new_rd = rd | RB_BUFFER_OFF;
	} while (!atomic_cmpxchg(&buffer->record_disabled, &rd, new_rd) != rd);
}

and the try_cmpxchg() converted it to:

void ring_buffer_record_off(struct trace_buffer *buffer)
{
	unsigned int rd;
	unsigned int new_rd;

	rd = atomic_read(&buffer->record_disabled);
	do {
		new_rd = rd | RB_BUFFER_OFF;
	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
}

Which got rid of the need to constantly update the rd variable (cmpxchg
will load rax with the value read, so it removes the need for an extra
move).

But in your case, we don't need to update js, in which case the
try_cmpxchg() does.

The patch that Uros sent me for the ring buffer code also does some of
that, which I feel is wrong.

So with that, I would nack the patch.

-- Steve
