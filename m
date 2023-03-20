Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073886C18D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjCTP1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjCTP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:27:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A0937546;
        Mon, 20 Mar 2023 08:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1221CCE12FA;
        Mon, 20 Mar 2023 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3BCC4339E;
        Mon, 20 Mar 2023 15:20:19 +0000 (UTC)
Date:   Mon, 20 Mar 2023 11:20:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list:TRACING),
        linux-trace-kernel@vger.kernel.org (open list:TRACING),
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix rcu_torture_read ftrace event
Message-ID: <20230320112015.2271da9c@gandalf.local.home>
In-Reply-To: <20230306122744.236790-1-douglas.raillard@arm.com>
References: <20230306122744.236790-1-douglas.raillard@arm.com>
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


[ Wondering why this didn't get picked up in v6.3-rc3, I see that the
  maintainers of RCU were not Cc'd :-( ]

This is a bug that will cause unwanted results. I have a patch that will not
let the kernel build when code like this is added.

  https://patchwork.kernel.org/project/linux-trace-kernel/patch/20230309221302.642e82d9@gandalf.local.home/

( The kernel robot even failed when applying the above patch, because it
  caught the code that this patch fixes )

On Mon,  6 Mar 2023 12:27:43 +0000
Douglas RAILLARD <douglas.raillard@arm.com> wrote:

> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Fix the rcutorturename field so that its size is correctly reported in
> the text format embedded in trace.dat files. As it stands, it is
> reported as being of size 1:

And that the offsets of the following fields will be incorrect as well.

> 
>     field:char rcutorturename[8];   offset:8;       size:1; signed:0;
> 

Please add:

Cc: stable@vger.kernel.org
Fixes: 04ae87a52074e ("ftrace: Rework event_create_dir()")

Thanks,

-- Steve

> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  include/trace/events/rcu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 90b2fb0292cb..012fa0d171b2 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -768,7 +768,7 @@ TRACE_EVENT_RCU(rcu_torture_read,
>  	TP_ARGS(rcutorturename, rhp, secs, c_old, c),
>  
>  	TP_STRUCT__entry(
> -		__field(char, rcutorturename[RCUTORTURENAME_LEN])
> +		__array(char, rcutorturename, RCUTORTURENAME_LEN)
>  		__field(struct rcu_head *, rhp)
>  		__field(unsigned long, secs)
>  		__field(unsigned long, c_old)

