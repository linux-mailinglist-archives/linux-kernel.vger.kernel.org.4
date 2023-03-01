Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB51A6A640A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCAAJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAAI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:08:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FC49002;
        Tue, 28 Feb 2023 16:08:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46322B80ED7;
        Wed,  1 Mar 2023 00:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D634BC433EF;
        Wed,  1 Mar 2023 00:08:47 +0000 (UTC)
Date:   Tue, 28 Feb 2023 19:08:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <20230228190846.79b06089@gandalf.local.home>
In-Reply-To: <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
References: <20230228155121.3416-1-ubizjak@gmail.com>
        <Y/5mguXPPqdP3MZF@google.com>
        <20230228160324.2a7c1012@gandalf.local.home>
        <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
        <20230228164124.77c126d2@gandalf.local.home>
        <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
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

On Tue, 28 Feb 2023 18:30:14 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > But looking at this use case, I'd actually NAK it, as it is misleading.  
> 
> I'm trying to parse this. You are saying it is misleading, because it
> updates js when it doesn't need to?

Correct.

> 
> > As try_cmpxchg() is used to get rid of the updating of the old value. As in
> > the ring buffer code we had:
> >
> > void ring_buffer_record_off(struct trace_buffer *buffer)
> > {
> >         unsigned int rd;
> >         unsigned int new_rd;
> >
> >         do {
> >                 rd = atomic_read(&buffer->record_disabled);
> >                 new_rd = rd | RB_BUFFER_OFF;
> >         } while (!atomic_cmpxchg(&buffer->record_disabled, &rd, new_rd) != rd);  
> 
> Hear you actually meant "rd" as the second parameter without the & ?

Yes, I cut and pasted the updated code and incorrectly try to revert it in
this example :-p

> 
> > }
> >
> > and the try_cmpxchg() converted it to:
> >
> > void ring_buffer_record_off(struct trace_buffer *buffer)
> > {
> >         unsigned int rd;
> >         unsigned int new_rd;
> >
> >         rd = atomic_read(&buffer->record_disabled);
> >         do {
> >                 new_rd = rd | RB_BUFFER_OFF;
> >         } while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
> > }
> >
> > Which got rid of the need to constantly update the rd variable (cmpxchg
> > will load rax with the value read, so it removes the need for an extra
> > move).  
> 
> So that's a good thing?

Yes. For looping, try_cmpxchg() is the proper function to use. But in the
RCU case (and other cases in the ring-buffer patch) there is no loop, and
no need to modify the "old" variable.

> 
> >
> > But in your case, we don't need to update js, in which case the
> > try_cmpxchg() does.  
> 
> Right, it has lesser value here but I'm curious why you feel it also
> doesn't belong in that ring buffer loop you shared (or did you mean,
> it does belong there but not in other ftrace code modified by Uros?).

The ring buffer patch had more than one change, where half the updates were
fine, and half were not.

-- Steve
