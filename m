Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875AF66B3FD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjAOUzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjAOUzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:55:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A24513539;
        Sun, 15 Jan 2023 12:55:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3192B80C75;
        Sun, 15 Jan 2023 20:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A746C433D2;
        Sun, 15 Jan 2023 20:54:59 +0000 (UTC)
Date:   Sun, 15 Jan 2023 15:54:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        fweisbec@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v2 rcu/dev 2/2] rcu: Disable laziness if lazy-tracking
 says so
Message-ID: <20230115155455.0fb66c12@rorschach.local.home>
In-Reply-To: <20230112005223.2329802-2-joel@joelfernandes.org>
References: <20230112005223.2329802-1-joel@joelfernandes.org>
        <20230112005223.2329802-2-joel@joelfernandes.org>
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

On Thu, 12 Jan 2023 00:52:23 +0000
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

>  
>  static void
> -__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
> +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>  {
>  	static atomic_t doublefrees;
>  	unsigned long flags;
>  	struct rcu_data *rdp;
> -	bool was_alldone;
> +	bool was_alldone, lazy;

I'm curious to why the the extra variable.

>  
>  	/* Misaligned rcu_head! */
>  	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> @@ -2622,6 +2622,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
>  	kasan_record_aux_stack_noalloc(head);
>  	local_irq_save(flags);
>  	rdp = this_cpu_ptr(&rcu_data);
> +	lazy = lazy_in && !rcu_async_should_hurry();

Wouldn't just having:

	lazy = lazy && !rcu_async_should_hurry();

be sufficient?

-- Steve

>  
>  	/* Add the callback to our list. */
>  	if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
> -- 
