Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F5D66B423
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjAOVZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjAOVZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:25:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3A2144A4;
        Sun, 15 Jan 2023 13:25:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B45FBCE0C4C;
        Sun, 15 Jan 2023 21:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90613C433D2;
        Sun, 15 Jan 2023 21:25:07 +0000 (UTC)
Date:   Sun, 15 Jan 2023 16:25:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        fweisbec@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and
 suspend
Message-ID: <20230115162504.08ef72b0@rorschach.local.home>
In-Reply-To: <20230112005223.2329802-1-joel@joelfernandes.org>
References: <20230112005223.2329802-1-joel@joelfernandes.org>
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

On Thu, 12 Jan 2023 00:52:22 +0000
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> -- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -144,8 +144,45 @@ bool rcu_gp_is_normal(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_gp_is_normal);
>  
> -static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
> +static atomic_t rcu_async_hurry_nesting = ATOMIC_INIT(1);
> +/*
> + * Should call_rcu() callbacks be processed with urgency or are
> + * they OK being executed with arbitrary delays?
> + */
> +bool rcu_async_should_hurry(void)
> +{
> +	return !IS_ENABLED(CONFIG_RCU_LAZY) ||
> +	       atomic_read(&rcu_async_hurry_nesting);
> +}
> +EXPORT_SYMBOL_GPL(rcu_async_should_hurry);
> +
> +/**
> + * rcu_async_hurry - Make future async RCU callbacks not lazy.
> + *
> + * After a call to this function, future calls to call_rcu()
> + * will be processed in a timely fashion.
> + */
> +void rcu_async_hurry(void)
> +{
> +	if (IS_ENABLED(CONFIG_RCU_LAZY))
> +		atomic_inc(&rcu_async_hurry_nesting);
> +}
> +EXPORT_SYMBOL_GPL(rcu_async_hurry);
>  

Where do you plan on calling these externally, as they are being
marked exported?

If you allow random drivers to enable this, I can see something
enabling it and hitting an error path that causes it to never disable
it.

I wouldn't have EXPORT_SYMBOL_GPL() unless you really know that it is
needed externally. In fact, is this really needed outside of the RCU
subsystem?

-- Steve


> +/**
> + * rcu_async_relax - Make future async RCU callbacks lazy.
> + *
> + * After a call to this function, future calls to call_rcu()
> + * will be processed in a lazy fashion.
> + */
> +void rcu_async_relax(void)
> +{
> +	if (IS_ENABLED(CONFIG_RCU_LAZY))
> +		atomic_dec(&rcu_async_hurry_nesting);
> +}
> +EXPORT_SYMBOL_GPL(rcu_async_relax);
> +
> +static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
